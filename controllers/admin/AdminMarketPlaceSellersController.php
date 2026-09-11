<?php
/**
 * Copyright ETS Software Technology Co., Ltd
 *
 * NOTICE OF LICENSE
 *
 * This file is not open source! Each license that you purchased is only available for 1 website only.
 * If you want to use this file on more websites (or projects), you need to purchase additional licenses.
 * You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future.
 *
 * @author ETS Software Technology Co., Ltd
 * @copyright  ETS Software Technology Co., Ltd
 * @license    Valid for 1 website (or project) for each purchase of license
 */

if (!defined('_PS_VERSION_')) {
    exit;
}
/**
 * Class AdminMarketPlaceSellersController
 * @property \Ets_marketplace $module
 */
class AdminMarketPlaceSellersController extends ModuleAdminController
{
    public function __construct()
    {
        parent::__construct();
        $this->context = Ets_marketplace::getContextStatic();
        $this->bootstrap = true;
    }
    public function initContent()
    {
        parent::initContent();
        if (Tools::isSubmit('viewCustomer') && ($id_customer = (int)Tools::getValue('id_customer'))) {
            $link = $this->module->getLinkCustomerAdmin($id_customer, false);
            if (Tools::isSubmit('viewseller') && ($id_seller = (int)Tools::getValue('id_seller')))
                $link .= '&viewseller=1&id_seller=' . ($id_seller);
            Tools::redirectAdmin($link);
        }
    }
    private function getMapSeller($id_seller)
    {
        $params = array(
            'all' => (int)Tools::getValue('all'),
            'radius' => (int)Tools::getValue('radius', 100),
            'latitude' => (float)Tools::getValue('latitude'),
            'longitude' => (float)Tools::getValue('longitude'),
        );
        Ets_mp_seller::getMaps($id_seller, false, $params);
    }
    private function actionDeleteLogo($id_seller)
    {
        $seller = new Ets_mp_seller($id_seller);
        $shop_logo = $seller->shop_logo;
        $seller->shop_logo = '';
        if ($seller->update(true)) {
            if ($shop_logo && file_exists(_PS_IMG_DIR_ . 'mp_seller/' . $shop_logo))
                @unlink(_PS_IMG_DIR_ . 'mp_seller/' . $shop_logo);
            $this->context->cookie->__set('success_message', $this->module->l('Deleted logo successfully', 'AdminMarketPlaceSellersController'));
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceSellers') . '&editets_seller=1&id_seller=' . $seller->id);
        }
    }
    private function actionDeletebanner($id_seller)
    {
        $id_lang = (int)Tools::getValue('id_lang');
        if (Validate::isUnsignedId($id_lang) && Validate::isLoadedObject(new Language($id_lang))) {
            $seller = new Ets_mp_seller($id_seller);
            $shop_banner = isset($seller->shop_banner[$id_lang]) ? $seller->shop_banner[$id_lang] : '';
            $seller->shop_banner[$id_lang] = '';
            if ($seller->update(true)) {
                if ($shop_banner && !in_array($shop_banner, $seller->shop_banner) && file_exists(_PS_IMG_DIR_ . 'mp_seller/' . $shop_banner))
                    @unlink(_PS_IMG_DIR_ . 'mp_seller/' . $shop_banner);
                $this->context->cookie->__set('success_message', $this->module->l('Deleted banner successfully', 'AdminMarketPlaceSellersController'));
                Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceSellers') . '&editets_seller=1&id_seller=' . $seller->id);
            }
        }
    }
    private function actionSaveStatusSeller($id_seller)
    {
        $seller = new Ets_mp_seller($id_seller);
        $active_old = $seller->active;
        $error = '';
        $active_seller = (int)Tools::getValue('active_seller');
        $reason = Tools::getValue('reason');
        if ($active_seller == 0 || $active_seller == -3) {
            $seller->active = (int)$active_seller;
            $seller->reason = $reason;
            if ($reason && !Validate::isCleanHtml($reason))
                $error = $this->module->l('Reason is not valid', 'AdminMarketPlaceSellersController');
        } else {
            $date_from = Tools::getValue('date_from');
            $date_to = Tools::getValue('date_to');
            if ($date_from && !Validate::isDate($date_from) && $date_to && !Validate::isDate($date_to))
                $error = $this->module->l('"From" date and "To" date are not valid', 'AdminMarketPlaceSellersController');
            elseif ($date_from && !Validate::isDate($date_from))
                $error = $this->module->l('"From" date is not valid', 'AdminMarketPlaceSellersController');
            elseif ($date_to && !Validate::isDate($date_to))
                $error = $this->module->l('"To" date is not valid', 'AdminMarketPlaceSellersController');
            elseif ($date_to && $date_from && strtotime($date_from) >= strtotime($date_to))
                $error = $this->module->l('"From" date must be smaller than "To" date', 'AdminMarketPlaceSellersController');
            $seller->date_from = $date_from;
            $seller->date_to = $date_to;
            if ((!$seller->date_from || strtotime($seller->date_from) <= strtotime(date('Y-m-d'))) && (!$seller->date_to || strtotime($seller->date_to) >= strtotime(date('Y-m-d')))) {
                $seller->active = 1;
                $seller->mail_expired = 0;
                $seller->mail_going_to_be_expired = 0;
            } else {
                $seller->active = -2;
                $seller->payment_verify = -1;
            }
        }
        $seller->date_upd = date('Y-m-d H:i:s');
        if ($error) {
            if (Tools::isSubmit('ajax')) {
                die(json_encode(
                        array(
                            'errors' => $error
                        )
                    ));
            }
        } else {
            if ($seller->update(true)) {
                if ($seller->active != $active_old && $seller->active == -2) {
                    $fee_type = $seller->getFeeType();
                    if ($fee_type != 'no_fee') {
                        $billing = new Ets_mp_billing();
                        $billing->id_customer = $seller->id_customer;
                        $billing->amount = (float)$seller->getFeeAmount();
                        $billing->amount_tax = $this->module->getFeeIncludeTax($billing->amount, $seller);
                        $billing->active = 0;
                        $billing->date_from = $seller->date_to;
                        if ($fee_type == 'monthly_fee')
                            $billing->date_to = date("Y-m-d H:i:s", strtotime($seller->date_to . "+1 month"));
                        elseif ($fee_type == 'quarterly_fee')
                            $billing->date_to = date("Y-m-d H:i:s", strtotime($seller->date_to . "+3 month"));
                        elseif ($fee_type == 'yearly_fee')
                            $billing->date_to = date("Y-m-d H:i:s", strtotime($seller->date_to . "+1 year"));
                        else
                            $billing->date_to = '';
                        $billing->fee_type = $fee_type;
                        if ($billing->add(true, true)) {
                            $seller->id_billing = $billing->id;
                            $seller->update();
                        }
                    }
                }
                if ((int)$seller->active == 1)
                    $status = Ets_mp_defines::displayText($this->module->l('Active', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status actived');
                elseif ((int)$seller->active == -2)
                    $status = Ets_mp_defines::displayText($this->module->l('Expired', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status expired');
                elseif ((int)$seller->active == 0)
                    $status = Ets_mp_defines::displayText($this->module->l('Disabled', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status disabled');
                /* @phpstan-ignore-next-line */
                elseif ((int)$seller->active == -3)
                    $status = Ets_mp_defines::displayText($this->module->l('Declined payment', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status declined');
                else
                    $status = '';

                if (isset($billing) && $billing->id)
                    $payment_verify = Ets_mp_defines::displayText($this->module->l('Pending', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status awaiting_payment');
                else
                    $payment_verify = '';
                if ($seller->date_from || $seller->date_to)
                    $date_approved = ($seller->date_from && $seller->date_from != '0000-00-00' ? $this->module->l('from', 'AdminMarketPlaceSellersController') . ' ' . Tools::displayDate($seller->date_from, false) : '') . ' ' . ($seller->date_to && $seller->date_to != '0000-00-00' ? $this->module->l('to', 'AdminMarketPlaceSellersController') . ' ' . Tools::displayDate($seller->date_to) : '');
                else
                    $date_approved = $this->module->l('unlimited', 'AdminMarketPlaceSellersController');
                if (Tools::isSubmit('ajax')) {
                    die(json_encode(
                            array(
                                'success' => $this->module->l('Updated successfully', 'AdminMarketPlaceSellersController'),
                                'status' => $status,
                                'active' => $seller->active,
                                'id_seller' => $seller->id,
                                'date_approved' => $date_approved,
                                'payment_verify' => $payment_verify,
                            )
                        ));
                }
            } else {
                if (Tools::isSubmit('ajax')) {
                    die(json_encode(
                            array(
                                'errors' => $this->module->l('Update failed', 'AdminMarketPlaceSellersController'),
                            )
                        ));
                }
            }
        }
    }
    private function actionDeleteSeller($id_seller)
    {
        $seller = new Ets_mp_seller($id_seller);
        if (Validate::isLoadedObject($seller) && $seller->delete()) {
            $this->context->cookie->__set('success_message', $this->module->l('Deleted shop successfully', 'AdminMarketPlaceSellersController'));
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceSellers') . '&list=true');
        }
    }
    private function actionDeleteProduct($id_seller)
    {
        $seller = new Ets_mp_seller($id_seller);
        if (Validate::isLoadedObject($seller) && $seller->deleteProducts()) {
            $this->context->cookie->__set('success_message', $this->module->l('Deleted products successfully', 'AdminMarketPlaceSellersController'));
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceSellers') . '&list=true');
        }
    }
    private function actionDelcommissions($id_seller)
    {
        $seller = new Ets_mp_seller($id_seller);
        if (Validate::isLoadedObject($seller) && $seller->deleteCommissions()) {
            $this->context->cookie->__set('success_message', $this->module->l('Deleted commissions successfully', 'AdminMarketPlaceSellersController'));
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceSellers') . '&list=true');
        }
    }
    private function actionDelAllData($id_seller)
    {
        $seller = new Ets_mp_seller($id_seller);
        if (Validate::isLoadedObject($seller) && $seller->delete(true)) {
            $this->context->cookie->__set('success_message', $this->module->l('Deleted shop and all data successfully', 'AdminMarketPlaceSellersController'));
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceSellers') . '&list=true');
        }
    }
    public function postProcess()
    {
        parent::postProcess();
        if (Tools::isSubmit('getmapseller') && ($id_seller = Tools::getValue('id_seller')) && Validate::isUnsignedId($id_seller)) {
            $this->getMapSeller($id_seller);
        }
        if (Tools::isSubmit('deletelogo') && ($id_seller = Tools::getValue('id_seller')) && Validate::isUnsignedId($id_seller)) {
            $this->actionDeleteLogo($id_seller);
        }
        if (Tools::isSubmit('deletebanner') && ($id_seller = Tools::getValue('id_seller')) && Validate::isUnsignedId($id_seller)) {
            $this->actionDeletebanner($id_seller);
        }
        if (Tools::isSubmit('saveStatusSeller') && ($id_seller = (int)Tools::getValue('seller_id')) && Validate::isUnsignedId($id_seller)) {
            $this->actionSaveStatusSeller($id_seller);
        }
        if (Tools::isSubmit('del') && ($id_seller = (int)Tools::getValue('id_seller'))) {
            $type = Tools::getValue('type');
            if ($type && !in_array($type, array('commission', 'usage')))
                $type = 'commission';
            if (($id_commission = (int)Tools::getValue('id_commission'))) {
                if ($type == 'commission')
                    $this->module->submitCommissions($id_commission);
                else
                    $this->module->submitCommistionUsage($id_commission);
            } else
                $this->actionDeleteSeller($id_seller);
        }
        if (Tools::isSubmit('delproducts') && ($id_seller = (int)Tools::getValue('id_seller'))) {
            $this->actionDeleteProduct($id_seller);
        }
        if (Tools::isSubmit('delcommissions') && ($id_seller = (int)Tools::getValue('id_seller'))) {
            $this->actionDelcommissions($id_seller);
        }
        if (Tools::isSubmit('delall') && ($id_seller = (int)Tools::getValue('id_seller'))) {
            $this->actionDelAllData($id_seller);
        }
    }
    public function renderList()
    {
        $this->module->getContent();
        $this->context->smarty->assign(
            array(
                'ets_mp_body_html' => $this->renderSellers(),
            )
        );
        $html = '';
        if ($this->context->cookie->__get('success_message')) {
            $html .= $this->module->displayConfirmation($this->context->cookie->__get('success_message'));
            $this->context->cookie->__set('success_message', '');
        }
        if ($this->module->_errors)
            $html .= $this->module->displayError($this->module->_errors);
        return $html . $this->module->display(_PS_MODULE_DIR_ . $this->module->name . DIRECTORY_SEPARATOR . $this->module->name . '.php', 'admin.tpl');
    }
    private function displayListSellers()
    {
        $limit = (int)Tools::getValue('paginator_seller_select_limit', 20);
        $page = (int)Tools::getValue('page');
        if ($page <= 0)
            $page = 1;
        $sort_type = Tools::getValue('sort_type', 'desc');
        $sort_value = Tools::getValue('sort', 'id_seller');
        if (!Tools::isSubmit('ets_mp_submit_ets_seller') && $page == 1 && $sort_type == 'desc' && $sort_value == 'id_seller') {
            $cacheID = $this->module->_getCacheId(array('shops', $limit));
        } else
            $cacheID = null;
        if (!$cacheID || !$this->module->isCached('admin/base_list.tpl', $cacheID)) {
            $fields_list = array(
                'id_seller' => array(
                    'title' => $this->module->l('ID', 'AdminMarketPlaceSellersController'),
                    'width' => 40,
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true,
                ),
                'shop_name' => array(
                    'title' => $this->module->l('Shop name', 'AdminMarketPlaceSellersController'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                ),
                'seller_name' => array(
                    'title' => $this->module->l('Seller name & email', 'AdminMarketPlaceSellersController'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                ),
                'reference' => array(
                    'title' => $this->module->l('Invoice ref', 'AdminMarketPlaceSellersController'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true
                ),
                'payment_status' => array(
                    'title' => $this->module->l('Payment status', 'AdminMarketPlaceSellersController'),
                    'type' => 'select',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                    'filter_list' => array(
                        'id_option' => 'active',
                        'value' => 'title',
                        'list' => array(
                            array(
                                'active' => -1,
                                'title' => $this->module->l('Canceled', 'AdminMarketPlaceSellersController')
                            ),
                            array(
                                'active' => 0,
                                'title' => $this->module->l('Pending', 'AdminMarketPlaceSellersController')
                            ),
                            array(
                                'active' => 1,
                                'title' => $this->module->l('Paid', 'AdminMarketPlaceSellersController')
                            ),
                        )
                    )
                ),
                'date_from' => array(
                    'title' => $this->module->l('Available from', 'AdminMarketPlaceSellersController'),
                    'type' => 'date',
                    'sort' => true,
                    'filter' => true
                ),
                'date_to' => array(
                    'title' => $this->module->l('Available to', 'AdminMarketPlaceSellersController'),
                    'type' => 'date',
                    'sort' => true,
                    'filter' => true
                ),
                'total_reported' => array(
                    'title' => $this->module->l('Reported', 'AdminMarketPlaceSellersController'),
                    'type' => 'int',
                    'sort' => true,
                    'class' => 'text-center',
                    'filter' => true
                ),
                'group_name' => array(
                    'title' => $this->module->l('Shop group', 'AdminMarketPlaceSellersController'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true,
                ),
                'category_name' => array(
                    'title' => $this->module->l('Shop category', 'AdminMarketPlaceSellersController'),
                    'type' => 'select',
                    'sort' => true,
                    'filter' => true,
                    'filter_list' => array(
                        'id_option' => 'id_ets_mp_shop_category',
                        'value' => 'name',
                        'list' => Ets_mp_shop_category::getShopCategories(' AND c.active=1', 0, false),
                    )
                ),
                'active' => array(
                    'title' => $this->module->l('Shop status', 'AdminMarketPlaceSellersController'),
                    'type' => 'select',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                    'filter_list' => array(
                        'id_option' => 'active',
                        'value' => 'title',
                        'list' => array(
                            array(
                                'active' => -4,
                                'title' => $this->module->l('Vacation', 'AdminMarketPlaceSellersController')
                            ),
                            array(
                                'active' => -3,
                                'title' => $this->module->l('Declined payment', 'AdminMarketPlaceSellersController')
                            ),
                            array(
                                'active' => -2,
                                'title' => $this->module->l('Expired', 'AdminMarketPlaceSellersController')
                            ),
                            array(
                                'active' => -1,
                                'title' => $this->module->l('Pending', 'AdminMarketPlaceSellersController')
                            ),
                            array(
                                'active' => 1,
                                'title' => $this->module->l('Active', 'AdminMarketPlaceSellersController')
                            ),
                            array(
                                'active' => 0,
                                'title' => $this->module->l('Disabled', 'AdminMarketPlaceSellersController')
                            ),
                        )
                    )
                ),
            );
            //Filter
            $show_resset = false;
            $filter = '';
            if (Tools::isSubmit('ets_mp_submit_ets_seller')) {
                if (($id_seller = Tools::getValue('id_seller')) && !Tools::isSubmit('del') && !Tools::isSubmit('delproducts') && !Tools::isSubmit('delcommissions') && !Tools::isSubmit('delall')) {
                    if (Validate::isUnsignedId($id_seller))
                        $filter .= ' AND s.id_seller="' . (int)$id_seller . '"';
                    $show_resset = true;
                }
                if (($seller_name = trim(Tools::getValue('seller_name'))) || $seller_name != '') {
                    if (Validate::isCleanHtml($seller_name))
                        $filter .= ' AND (CONCAT(customer.firstname," ", customer.lastname) LIKE "%' . pSQL($seller_name) . '%" OR customer.email LIKE "%' . pSQL($seller_name) . '%" )';
                    $show_resset = true;
                }
                if (($seller_email = trim(Tools::getValue('seller_email'))) || $seller_email != '') {
                    if (Validate::isCleanHtml($seller_email))
                        $filter .= ' AND customer.email LIKE "%' . pSQL($seller_email) . '%"';
                    $show_resset = true;
                }
                if (($shop_name = trim(Tools::getValue('shop_name'))) || $shop_name != '') {
                    if (Validate::isCleanHtml($shop_name))
                        $filter .= ' AND sl.shop_name LIKE "%' . pSQL($shop_name) . '%"';
                    $show_resset = true;
                }
                if (($shop_description = trim(Tools::getValue('shop_description'))) || $shop_description != '') {
                    if (Validate::isCleanHtml($shop_description))
                        $filter .= ' AND sl.shop_description = "%' . pSQL($shop_description) . '%"';
                    $show_resset = true;
                }
                if (($active = trim(Tools::getValue('active'))) || $active !== '') {
                    if (Validate::isInt((int)$active)) {
                        if ($active == -4)
                            $filter .= ' AND s.vacation_mode=1';
                        else
                            $filter .= ' AND s.active="' . (int)$active . '"';
                    }
                    $show_resset = true;
                }
                if (($payment_status = trim(Tools::getValue('payment_status'))) || $payment_status !== '') {
                    if (Validate::isInt((int)$payment_status))
                        $filter .= ' AND b.active="' . (int)$payment_status . '"';
                    $show_resset = true;
                }
                if (($reference = trim(Tools::getValue('reference'))) || $reference !== '') {
                    if (Validate::isCleanHtml($reference))
                        $filter .= ' AND b.reference like "%' . pSQL($reference) . '%"';
                    $show_resset = true;
                }
                if (($date_from_min = trim(Tools::getValue('date_from_min'))) || $date_from_min != '') {
                    if (Validate::isDate($date_from_min))
                        $filter .= ' AND s.date_from >= "' . pSQL($date_from_min) . ' 00:00:00"';
                    $show_resset = true;
                }
                if (($date_from_max = trim(Tools::getValue('date_from_max'))) || $date_from_max != '') {
                    if (Validate::isDate($date_from_max))
                        $filter .= ' AND s.date_from <= "' . pSQL($date_from_max) . ' 23:59:59"';
                    $show_resset = true;
                }
                if (($date_to_min = trim(Tools::getValue('date_to_min'))) || $date_to_min != '') {
                    if (Validate::isDate($date_to_min))
                        $filter .= ' AND s.date_to >="' . pSQL($date_to_min) . ' 00:00:00"';
                    $show_resset = true;
                }
                if (($date_to_max = trim(Tools::getValue('date_to_max'))) || $date_to_max != '') {
                    if (Validate::isDate($date_to_max))
                        $filter .= ' AND s.date_to <="' . pSQL($date_to_max) . ' 23:59:59"';
                    $show_resset = true;
                }
                if (($total_reported_min = trim(Tools::getValue('total_reported_min'))) || $total_reported_min != '') {
                    if (Validate::isInt((int)$total_reported_min))
                        $filter .= ' AND seller_report.total_reported >= ' . (int)$total_reported_min;
                    $show_resset = true;
                }
                if (($total_reported_max = trim(Tools::getValue('total_reported_max'))) || $total_reported_max != '') {
                    if (Validate::isInt((int)$total_reported_max))
                        $filter .= ' AND seller_report.total_reported <= ' . (int)$total_reported_max;
                    $show_resset = true;
                }
                if (($group_name = trim(Tools::getValue('group_name'))) || $group_name != '') {
                    if (Validate::isCleanHtml($group_name))
                        $filter .= ' AND seller_group_lang.name like "' . pSQL($group_name) . '"';
                    $show_resset = true;
                }
                if (($category_name = trim(Tools::getValue('category_name'))) || $category_name != '') {
                    if (Validate::isInt((int)$category_name))
                        $filter .= ' AND s.id_shop_category ="' . (int)$category_name . '"';
                    $show_resset = true;
                }
            }
            //Sort
            $sort = "";
            if ($sort_value) {
                switch ($sort_value) {
                    case 'id_seller':
                        $sort .= ' s.id_seller';
                        break;
                    case 'customer_name':
                        $sort .= ' customer_name';
                        break;
                    case 'seller_name':
                        $sort .= ' seller_name';
                        break;
                    case 'seller_email':
                        $sort .= ' seller_email';
                        break;
                    case 'reference':
                        $sort .= 'b.reference';
                        break;
                    case 'payment_status':
                        $sort .= 'b.active';
                        break;
                    case 'shop_name':
                        $sort .= 'sl.shop_name';
                        break;
                    case 'shop_description':
                        $sort .= 'sl.shop_description';
                        break;
                    case 'active':
                        $sort .= 's.active';
                        break;
                    case 'date_from':
                        $sort .= 's.date_from';
                        break;
                    case 'date_to':
                        $sort .= 's.date_to';
                        break;
                    case 'total_reported':
                        $sort .= 'seller_report.total_reported';
                        break;
                    case 'group_name':
                        $sort .= 'seller_group_lang.name';
                        break;
                    case 'category_name':
                        $sort .= 'scl.name';
                        break;
                }
                if ($sort && $sort_type && in_array($sort_type, array('asc', 'desc')))
                    $sort .= ' ' . $sort_type;
            }
            //Paggination
            $totalRecords = (int)Ets_mp_seller::_getSellers($filter, $sort, 0, 0, true);
            $paggination = new Ets_mp_paggination_class();
            $paggination->total = $totalRecords;
            $paggination->url = Ets_marketplace::getContextStatic()->link->getAdminLink('AdminMarketPlaceSellers') . '&page=_page_' . $this->module->getFilterParams($fields_list, 'ets_seller');
            $paggination->limit = $limit;
            $paggination->name = 'seller';
            $totalPages = ceil($totalRecords / $paggination->limit);
            if ($page > $totalPages)
                $page = $totalPages;
            $paggination->page = $page;
            $start = $paggination->limit * ($page - 1);
            if ($start < 0)
                $start = 0;
            $sellers = Ets_mp_seller::_getSellers($filter, $sort, $start, $paggination->limit, false);
            if ($sellers) {
                foreach ($sellers as &$seller) {
                    $seller['status_val'] = $seller['active'];
                    $seller['child_view_url'] = Ets_marketplace::getContextStatic()->link->getAdminLink('AdminMarketPlaceSellers') . '&viewseller=1&id_seller=' . (int)$seller['id_seller'];
                    if ($seller['vacation_mode'] == 1) {
                        $seller['active'] = Ets_mp_defines::displayText($this->module->l('Vacation', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status vacation');
                    } else {
                        if ($seller['active'] == -1)
                            $seller['active'] = Ets_mp_defines::displayText($this->module->l('Pending', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status pending');
                        elseif ($seller['active'] == 0)
                            $seller['active'] = Ets_mp_defines::displayText($this->module->l('Disabled', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status disabled');
                        elseif ($seller['active'] == 1)
                            $seller['active'] = Ets_mp_defines::displayText($this->module->l('Active', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status actived');
                        elseif ($seller['active'] == -2)
                            $seller['active'] = Ets_mp_defines::displayText($this->module->l('Expired', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status expired');
                        elseif ($seller['active'] == -3)
                            $seller['active'] = Ets_mp_defines::displayText($this->module->l('Declined payment', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status declined');
                    }
                    if ($seller['id_billing']) {
                        if ($seller['payment_status'] == -1)
                            $seller['payment_status'] = Ets_mp_defines::displayText($this->module->l('Canceled', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status canceled');
                        elseif ($seller['payment_status'] == 0)
                            $seller['payment_status'] = Ets_mp_defines::displayText($this->module->l('Pending', 'AdminMarketPlaceSellersController') . ($seller['seller_confirm'] ? ' (' . $this->module->l('Seller confirmed', 'AdminMarketPlaceSellersController') . ')' : ''), 'span', 'ets_mp_status pending');
                        elseif ($seller['payment_status'] == 1)
                            $seller['payment_status'] = Ets_mp_defines::displayText($this->module->l('Paid', 'AdminMarketPlaceSellersController'), 'span', 'ets_mp_status purchased');
                    } else
                        $seller['payment_status'] = '--';
                    $seller['seller_name'] = Ets_mp_defines::displayText($seller['seller_name'], 'a', '', '', $this->module->getLinkCustomerAdmin($seller['id_customer'])) . Ets_mp_defines::displayText('', 'br') . $seller['seller_email'];
                }
            }
            $paggination->text = $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)', 'AdminMarketPlaceSellersController');
            $paggination->style_links = $this->module->l('links', 'AdminMarketPlaceSellersController');
            $paggination->style_results = $this->module->l('results', 'AdminMarketPlaceSellersController');
            $listData = array(
                'name' => 'ets_seller',
                'actions' => array('view', 'edit', 'delete_shop', 'delete_product', 'delete_commission', 'delete_all'),
                'icon' => 'icon-sellers',
                'currentIndex' => Ets_marketplace::getContextStatic()->link->getAdminLink('AdminMarketPlaceSellers') . ($paggination->limit != 20 ? '&paginator_seller_select_limit=' . $paggination->limit : ''),
                'postIndex' => Ets_marketplace::getContextStatic()->link->getAdminLink('AdminMarketPlaceSellers'),
                'identifier' => 'id_seller',
                'show_toolbar' => true,
                'show_action' => true,
                'title' => $this->module->l('Shops', 'AdminMarketPlaceSellersController'),
                'fields_list' => $fields_list,
                'field_values' => $sellers,
                'paggination' => $paggination->render(),
                'filter_params' => $this->module->getFilterParams($fields_list, 'ets_seller'),
                'show_reset' => $show_resset,
                'totalRecords' => $totalRecords,
                'sort' => $sort_value,
                'sort_type' => $sort_type,
            );
            $this->context->smarty->assign(
                array(
                    'list_content' => $this->module->renderList($listData),
                )
            );
        }
        return $this->module->display($this->module->getLocalPath(), 'admin/base_list.tpl', $cacheID);
    }
    public function renderSellers()
    {
        if (Tools::isSubmit('viewseller') && ($id_seller = (int)Tools::getValue('id_seller'))) {
            return $this->renderInfoSeller($id_seller);
        }
        if (Tools::isSubmit('editets_seller') && ($id_seller = (int)Tools::getValue('id_seller'))) {
            return $this->_renderFormSeller($id_seller);
        }
        return $this->displayListSellers();
    }
    public function renderInfoSeller($id_seller)
    {
        if (!Validate::isLoadedObject(new Ets_mp_seller($id_seller)))
            Tools::redirect($this->context->link->getAdminLink('AdminMarketPlaceSellers'));
        $errors = array();
        $amount = (float)Tools::getValue('amount', false);
        $action = Tools::getValue('action', false);
        $reason = Tools::getValue('reason', false);
        $active_seller = (int)Tools::getValue('active_seller');
        if (Tools::isSubmit('saveStatusSeller') && ($id_seller = Tools::getValue('id_seller')) && Validate::isUnsignedId($id_seller)) {
            $seller = new Ets_mp_seller($id_seller);
            $date_from = Tools::getValue('date_from');
            $date_to = Tools::getValue('date_to');
            if ($date_from && !Validate::isDate($date_from))
                $errors[] = $this->module->l('"From" date is not valid', 'AdminMarketPlaceSellersController');
            if ($date_to && !Validate::isDate($date_to))
                $errors[] = $this->module->l('"To" date is not valid', 'AdminMarketPlaceSellersController');
            if ($date_from && $date_to && Validate::isDate($date_from) && Validate::isDate($date_to) && strtotime($date_from) >= strtotime($date_to))
                $errors[] = $this->module->l('"From" date must be smaller than "To" date', 'AdminMarketPlaceSellersController');
            if ($reason && !Validate::isCleanHtml($reason))
                $errors[] = $this->module->l('Reason is not valid', 'AdminMarketPlaceSellersController');
            if (!$errors) {
                $seller->date_from = $date_from;
                $seller->date_to = $date_to;
                $active_old = $seller->active;
                if (!$active_seller) {
                    if ($seller->active == -1)
                        $seller->active = -3;
                    else
                        $seller->active = 0;
                } else {
                    if ((!$seller->date_from || strtotime($seller->date_from) <= strtotime(date('Y-m-d'))) && (!$seller->date_to || strtotime($seller->date_to) >= strtotime(date('Y-m-d'))))
                        $seller->active = 1;
                    else {
                        $seller->active = -2;
                        if ($seller->getFeeType() != 'no_fee')
                            $seller->payment_verify = -1;
                        else
                            $seller->payment_verify = 0;
                    }
                }
                $seller->reason = $reason;
                if ($seller->update(true)) {
                    if ($seller->active != $active_old && $seller->active == -2) {
                        $fee_type = $seller->getFeeType();
                        if ($fee_type != 'no_fee') {
                            $billing = new Ets_mp_billing();
                            $billing->id_seller = $seller->id;
                            $billing->amount = (float)$seller->getFeeAmount();
                            $billing->amount_tax = $this->module->getFeeIncludeTax($billing->amount, $seller);
                            $billing->active = 0;
                            $billing->date_from = $seller->date_to;
                            if ($fee_type == 'monthly_fee')
                                $billing->date_to = date("Y-m-d H:i:s", strtotime($seller->date_to . "+1 month"));
                            elseif ($fee_type == 'quarterly_fee')
                                $billing->date_to = date("Y-m-d H:i:s", strtotime($seller->date_to . "+3 month"));
                            elseif ($fee_type == 'yearly_fee')
                                $billing->date_to = date("Y-m-d H:i:s", strtotime($seller->date_to . "+1 year"));
                            else
                                $billing->date_to = '';
                            $billing->fee_type = $fee_type;
                            if ($billing->add(true, true)) {
                                if ($fee_type != 'no_fee') {
                                    $seller->id_billing = $billing->id;
                                    $seller->update();
                                }
                            }
                        }
                    }
                    if (Tools::isSubmit('ajax')) {
                        die(json_encode(
                                array(
                                    'success' => $this->module->l('Updated seller successfully', 'AdminMarketPlaceSellersController'),
                                    'seller_active' => $seller->active,
                                )
                            ));
                    } else {
                        $this->context->cookie->__set('success_message', $this->module->l('Updated seller successfully', 'AdminMarketPlaceSellersController'));
                    }
                } else
                    $errors[] = $this->module->l('Update failed', 'AdminMarketPlaceSellersController');
            }
            if ($errors) {
                if (Tools::isSubmit('ajax')) {
                    die(json_encode(
                            array(
                                'errors' => $this->module->displayError($errors),
                            )
                        ));
                }
            }
        }
        $seller = new Ets_mp_seller($id_seller, $this->context->language->id);
        $customer_seller = new Customer($seller->id_customer);
        if (Tools::isSubmit('add_commission_by_admin') || Tools::isSubmit('deduct_commission_by_admin')) {
            if (!$amount) {
                $errors[] = $this->module->l('Amount is required', 'AdminMarketPlaceSellersController');
            } elseif (!Validate::isPrice((string)$amount)) {
                if ($action == 'deduct')
                    $errors[] = $this->module->l('The commission is not enough to deduct', 'AdminMarketPlaceSellersController');
                else
                    $errors[] = $this->module->l('Amount must be a decimal', 'AdminMarketPlaceSellersController');
            }
            if (!$errors) {
                if ($action == 'deduct') {
                    $totalCommistionCanUse = $seller->getTotalCommission(1) - $seller->getToTalUseCommission(1);
                    if ($totalCommistionCanUse < $amount)
                        $errors[] = $this->module->l('Remaining commission is not enough to deduct.', 'AdminMarketPlaceSellersController');
                    else {
                        $commission_usage = new Ets_mp_commission_usage();
                        $commission_usage->amount = $amount;
                        $commission_usage->status = 1;
                        $commission_usage->id_customer = $seller->id_customer;
                        $commission_usage->date_add = date('Y-m-d H:i:s');
                        $commission_usage->deleted = 0;
                        $commission_usage->note = $reason;
                        $commission_usage->id_currency = $this->context->currency->id;
                        $commission_usage->id_shop = $this->context->shop->id;
                        if ($commission_usage->add(true, true))
                            $this->context->cookie->__set('success_message', $this->module->l('Deducted successfully', 'AdminMarketPlaceSellersController'));
                    }
                } else {
                    $commisstion = new Ets_mp_commission();
                    $commisstion->commission = $amount;
                    $commisstion->id_shop = $this->context->shop->id;
                    $commisstion->id_customer = $seller->id_customer;
                    $commisstion->status = 1;
                    $commisstion->note = $reason;
                    $commisstion->add();
                    $this->context->cookie->__set('success_message', $this->module->l('Added successfully', 'AdminMarketPlaceSellersController'));
                }
            }
        }
        if ($seller->latitude != 0 && $seller->longitude != 0) {
            $default_country = new Country((int)Tools::getCountry());
            if (($map_key = Configuration::get('ETS_MP_GOOGLE_MAP_API')))
                $key = 'key=' . $map_key . '&';
            else
                $key = '';
            $link_map_google = 'http' . ((Configuration::get('PS_SSL_ENABLED') && Configuration::get('PS_SSL_ENABLED_EVERYWHERE')) ? 's' : '') . '://maps.googleapis.com/maps/api/js?' . $key . 'region=' . Tools::substr($default_country->iso_code, 0, 2);
            $this->context->smarty->assign(
                array(
                    'link_map_google' => $link_map_google,
                )
            );
        }
        $this->context->smarty->assign(
            array(
                'seller' => $seller,
                'seller_billing' => $seller->id_billing ? new Ets_mp_billing($seller->id_billing) : false,
                'customer' => $customer_seller,
                'link_customer' => $this->module->getLinkCustomerAdmin($customer_seller->id),
                'link' => $this->context->link,
                'currency' => $this->context->currency,
                'amount' => $errors ? $amount : '',
                'action' => $errors ? $action : '',
                'reason' => $errors ? $reason : '',
                'history_billings' => $this->module->renderBilling($seller->id_customer),
                'history_commissions' => $this->module->renderCommission($seller->id_customer),
                'base_link' => $this->module->getBaseLink(),
                'shop_category' => ($seller->id_shop_category && Validate::isLoadedObject($shop_category = new Ets_mp_shop_category($seller->id_shop_category, $this->context->language->id))) ? $shop_category : false,
            )
        );
        $html = '';
        if ($errors)
            $html .= $this->module->displayError($errors);
        return $html . $this->context->smarty->fetch(_PS_MODULE_DIR_ . 'ets_marketplace/views/templates/hook/seller_info.tpl');
    }

    public function _renderFormSeller($id_seller)
    {
        $html = '';
        if (Tools::isSubmit('saveSeller') && $id_seller && Validate::isUnsignedId($id_seller) && Validate::isLoadedObject(new Ets_mp_seller($id_seller))) {
            $errors = array();
            $valueFieldPost = array();
            $this->module->submitSaveSeller($id_seller, $errors, true, $valueFieldPost);
            if ($errors)
                $html .= $this->module->displayError($errors);
        }
        if ($id_seller && Validate::isUnsignedId($id_seller))
            $seller = new Ets_mp_seller($id_seller);
        else
            $seller = new Ets_mp_seller();
        if ($seller->active == -1) {
            $status = array(
                'query' => array(
                    array(
                        'id_option' => -1,
                        'name' => $this->module->l('Pending', 'AdminMarketPlaceSellersController'),
                    ),
                    array(
                        'id_option' => 1,
                        'name' => $this->module->l('Active', 'AdminMarketPlaceSellersController'),
                    ),
                    array(
                        'id_option' => 0,
                        'name' => $this->module->l('Disabled', 'AdminMarketPlaceSellersController'),
                    ),
                    array(
                        'id_option' => -3,
                        'name' => $this->module->l('Declined', 'AdminMarketPlaceSellersController'),
                    ),
                ),
                'id' => 'id_option',
                'name' => 'name'
            );
        } else
            $status = array(
                'query' => array(
                    array(
                        'id_option' => '1',
                        'name' => $this->module->l('Activate', 'AdminMarketPlaceSellersController'),
                    ),
                    array(
                        'id_option' => 0,
                        'name' => $this->module->l('Disabled', 'AdminMarketPlaceSellersController'),
                    ),
                ),
                'id' => 'id_option',
                'name' => 'name'
            );
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->module->l('Edit shop', 'AdminMarketPlaceSellersController'),
                    'icon' => 'icon-sellers',
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Seller name', 'AdminMarketPlaceSellersController'),
                        'name' => 'seller_name',
                        'required' => true,
                        'disabled' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Seller email', 'AdminMarketPlaceSellersController'),
                        'name' => 'seller_email',
                        'disabled' => true,
                        'required' => true,
                    ),
                    array(
                        'type' => 'text',
                        'name' => 'shop_phone',
                        'label' => $this->module->l('Shop phone', 'AdminMarketPlaceSellersController'),
                        'required' => true,
                    ),
                    array(
                        'type' => 'text',
                        'name' => 'shop_name',
                        'label' => $this->module->l('Shop name', 'AdminMarketPlaceSellersController'),
                        'lang' => true,
                        'required' => true,
                    ),
                    array(
                        'type' => 'textarea',
                        'label' => $this->module->l('Shop description', 'AdminMarketPlaceSellersController'),
                        'name' => 'shop_description',
                        'lang' => true,
                        'required' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Shop address', 'AdminMarketPlaceSellersController'),
                        'name' => 'shop_address',
                        'lang' => true,
                        'required' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Latitude', 'AdminMarketPlaceSellersController'),
                        'name' => 'latitude',
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Longitude', 'AdminMarketPlaceSellersController'),
                        'name' => 'longitude',
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('VAT number', 'AdminMarketPlaceSellersController'),
                        'name' => 'vat_number',
                    ),
                    array(
                        'type' => 'textarea',
                        'label' => $this->module->l('Live Chat embed code', 'AdminMarketPlaceSellersController'),
                        'name' => 'code_chat',
                        'desc' => $this->module->l('Enter here embed code of live chat service such as intercom.com, zendesk.com, etc. ', 'AdminMarketPlaceSellersController'),
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->module->l('Shop group', 'AdminMarketPlaceSellersController'),
                        'name' => 'id_group',
                        'options' => array(
                            'query' => array_merge(array(array('id_group' => 0, 'name' => '--')), Ets_mp_seller_group::_getSellerGroups()),
                            'id' => 'id_group',
                            'name' => 'name'
                        ),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Commission rate', 'AdminMarketPlaceSellersController'),
                        'name' => 'commission_rate',
                        'suffix' => '%',
                        'col' => 3,
                        'desc' => $this->module->l('If you leave this field blank, the default value', 'AdminMarketPlaceSellersController') . ' ' . Tools::ps_round($seller->getCommissionRate(true), 2) . $this->module->l('% will be applied', 'AdminMarketPlaceSellersController')
                    ),
                    array(
                        'type' => 'switch',
                        'label' => $this->module->l('Enable commission by category', 'AdminMarketPlaceSellersController'),
                        'name' => 'enable_commission_by_category',
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->module->l('Yes', 'AdminMarketPlaceSellersController')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->module->l('No', 'AdminMarketPlaceSellersController')
                            )
                        ),
                    ),
                    array(
                        'name' => 'category_commission_rate',
                        'label' => $this->module->l('Commission rate by categories', 'AdminMarketPlaceSellersController'),
                        'type' => 'tre_categories',
                        'form_group_class' => 'category_commission_rate',
                        'tree' => $this->module->displayFormCategoryCommissionRate($id_seller ?: -1, 0),
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->module->l('Auto approve products submitted by this seller', 'AdminMarketPlaceSellersController'),
                        'name' => 'auto_enabled_product',
                        'options' => array(
                            'query' => array(
                                array(
                                    'id_option' => 'default',
                                    'name' => $this->module->l('Default (base on general config)', 'AdminMarketPlaceSellersController'),
                                ),
                                array(
                                    'id_option' => 'yes',
                                    'name' => $this->module->l('Auto approve', 'AdminMarketPlaceSellersController'),
                                ),
                                array(
                                    'id_option' => 'no',
                                    'name' => $this->module->l('Manually approve by admin', 'AdminMarketPlaceSellersController'),
                                ),
                            ),
                            'id' => 'id_option',
                            'name' => 'name'
                        ),
                    ),

                    array(
                        'type' => 'file',
                        'label' => $this->module->l('Logo', 'AdminMarketPlaceSellersController'),
                        'name' => 'shop_logo',
                        'required' => true,
                        'image' => $seller->shop_logo ? Ets_mp_defines::displayText('', 'img', 'ets_mp_shoplogo', '', '', '', $this->module->getBaseLink() . '/img/mp_seller/' . $seller->shop_logo) : false,
                        'desc' => sprintf($this->module->l('Recommended size: 250x250 px. Accepted formats: jpg, png, gif. Limit %sMb', 'AdminMarketPlaceSellersController'), Configuration::get('PS_ATTACHMENT_MAXIMUM_SIZE')),
                    ),
                    array(
                        'type' => 'file_lang',
                        'label' => $this->module->l('Shop banner', 'AdminMarketPlaceSellersController'),
                        'name' => 'shop_banner',
                        'imageType' => 'banner',
                        'desc' => sprintf($this->module->l('Recommended size: 1170x170 px. Accepted formats: jpg, png, gif. Limit %sMb', 'AdminMarketPlaceSellersController'), Configuration::get('PS_ATTACHMENT_MAXIMUM_SIZE')),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Banner URL', 'AdminMarketPlaceSellersController'),
                        'name' => 'banner_url',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Facebook link', 'AdminMarketPlaceSellersController'),
                        'name' => 'link_facebook',
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Google link', 'AdminMarketPlaceSellersController'),
                        'name' => 'link_google',
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Instagram link', 'AdminMarketPlaceSellersController'),
                        'name' => 'link_instagram',
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('X link', 'AdminMarketPlaceSellersController'),
                        'name' => 'link_twitter',
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->module->l('Shop category', 'AdminMarketPlaceSellersController'),
                        'name' => 'id_shop_category',
                        'options' => array(
                            'query' => array_merge(array(array('id_ets_mp_shop_category' => 0, 'name' => '--')), Ets_mp_shop_category::getShopCategories(' AND c.active=1', 0, false)),
                            'id' => 'id_ets_mp_shop_category',
                            'name' => 'name'
                        ),
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->module->l('Status', 'AdminMarketPlaceSellersController'),
                        'name' => 'active',
                        'options' => $status,
                    ),
                    array(
                        'type' => 'date',
                        'label' => $this->module->l('Available from', 'AdminMarketPlaceSellersController'),
                        'name' => 'date_from',
                        'form_group_class' => 'seller_date',
                    ),
                    array(
                        'type' => 'date',
                        'label' => $this->module->l('Available to', 'AdminMarketPlaceSellersController'),
                        'name' => 'date_to',
                        'form_group_class' => 'seller_date',
                    ),
                    array(
                        'type' => 'textarea',
                        'label' => $this->module->l('Reason', 'AdminMarketPlaceSellersController'),
                        'name' => 'reason',
                        'form_group_class' => 'seller_reason',
                    ),
                ),
                'submit' => array(
                    'title' => $this->module->l('Save', 'AdminMarketPlaceSellersController'),
                ),
                'buttons' => array(
                    array(
                        'href' => $this->context->link->getAdminLink('AdminMarketPlaceSellers', true),
                        'icon' => 'process-icon-cancel',
                        'title' => $this->module->l('Cancel', 'AdminMarketPlaceSellersController'),
                    )
                ),
            ),
        );
        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $this->fields_form = array();
        $helper->module = $this->module;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'saveSeller';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminMarketPlaceSellers', false) . '&editets_seller=1&id_seller=' . (int)$id_seller;
        $helper->token = Tools::getAdminTokenLite('AdminMarketPlaceSellers');
        $language = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->tpl_vars = array(
            'base_url' => $this->context->shop->getBaseURL(),
            'language' => array(
                'id_lang' => $language->id,
                'iso_code' => $language->iso_code
            ),

            'PS_ALLOW_ACCENTED_CHARS_URL',
            (int)Configuration::get('PS_ALLOW_ACCENTED_CHARS_URL'),
            'fields_value' => $this->getSellerFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
            'image_baseurl' => _PS_IMG_ . 'mp_seller/',
            'link' => $this->context->link,
            'cancel_url' => $this->context->link->getAdminLink('AdminMarketPlaceSellers', true),
            'banner_del_link' => $this->context->link->getAdminLink('AdminMarketPlaceSellers') . '&editets_seller=1&id_seller=' . (int)$id_seller . '&deletebanner=1',
        );
        $fields_form['form']['input'][] = array('type' => 'hidden', 'name' => 'id_seller');
        return $html . $helper->generateForm(array($fields_form));
    }

    public function getSellerFieldsValues()
    {
        $fields = array();
        $id_seller = (int)Tools::getValue('id_seller');
        $languages = Language::getLanguages(false);
        $seller = new Ets_mp_seller($id_seller);
        $fields['seller_name'] = Tools::getValue('seller_name', $seller->seller_name);
        $fields['seller_email'] = Tools::getValue('seller_email', $seller->seller_email);
        $fields['vat_number'] = Tools::getValue('seller_email', $seller->vat_number);
        $fields['shop_phone'] = Tools::getValue('shop_phone', $seller->shop_phone);
        $fields['active'] = Tools::getValue('active', $seller->active);
        $fields['id_seller'] = $id_seller;
        $fields['reason'] = Tools::getValue('reason', $seller->reason);
        $fields['commission_rate'] = Tools::getValue('commission_rate', $seller->commission_rate);
        $fields['code_chat'] = Tools::getValue('code_chat', $seller->code_chat);
        $fields['date_from'] = Tools::getValue('date_from', $seller->date_from);
        $fields['date_to'] = Tools::getValue('date_to', $seller->date_to);
        $fields['auto_enabled_product'] = Tools::getValue('auto_enabled_product', $seller->auto_enabled_product);
        $fields['link_facebook'] = Tools::getValue('link_facebook', $seller->link_facebook);
        $fields['link_google'] = Tools::getValue('link_google', $seller->link_google);
        $fields['link_instagram'] = Tools::getValue('link_instagram', $seller->link_instagram);
        $fields['link_twitter'] = Tools::getValue('link_twitter', $seller->link_twitter);
        $fields['id_shop_category'] = Tools::getValue('id_shop_category', $seller->id_shop_category);
        $latitude = Tools::getValue('latitude', $seller->latitude);
        $fields['latitude'] = $latitude != 0 ? $latitude : '';
        $longitude = Tools::getValue('longitude', $seller->longitude);
        $fields['longitude'] = $longitude != 0 ? $longitude : '';
        $fields['id_group'] = Tools::getValue('id_group', $seller->id_group);
        $fields['enable_commission_by_category'] = Tools::getValue('enable_commission_by_category', $seller->enable_commission_by_category);
        if ($languages) {
            foreach ($languages as $language) {
                $fields['shop_name'][$language['id_lang']] = Tools::getValue('shop_name_' . $language['id_lang'], $seller->shop_name[$language['id_lang']]);
                $fields['shop_description'][$language['id_lang']] = Tools::getValue('shop_description_' . $language['id_lang'], $seller->shop_description[$language['id_lang']]);
                $fields['shop_address'][$language['id_lang']] = Tools::getValue('shop_address_' . $language['id_lang'], $seller->shop_address[$language['id_lang']]);
                $fields['shop_banner'][$language['id_lang']] = $seller->shop_banner[$language['id_lang']];
                $fields['banner_url'][$language['id_lang']] = Tools::getValue('banner_url_' . $language['id_lang'], $seller->banner_url[$language['id_lang']]);
            }
        }
        return $fields;
    }
}
