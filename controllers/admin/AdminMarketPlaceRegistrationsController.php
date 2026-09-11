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
 * Class AdminMarketPlaceRegistrationsController
 * @property \Ets_marketplace $module
 */
class AdminMarketPlaceRegistrationsController extends ModuleAdminController
{
    /**
     * Minimum number of characters of the secret key required to approve an application
     */
    const SECRET_KEY_MIN_LENGTH = 62;

    /**
     * Maximum number of characters of the secret key, matching the size of the database column
     */
    const SECRET_KEY_MAX_LENGTH = 255;

    public function __construct()
    {
        parent::__construct();
        $this->context = Ets_marketplace::getContextStatic();
        $this->bootstrap = true;
    }
    public function initContent()
    {
        parent::initContent();
        if (Tools::isSubmit('ajax'))
            $this->renderList();
    }
    public function renderList()
    {
        $this->module->getContent();
        $this->context->smarty->assign(
            array(
                'ets_mp_body_html' => $this->renderSellersRegistration(),
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
    private function deleteRegistration($id_registration)
    {
        $registration = new Ets_mp_registration($id_registration);
        if (Validate::isLoadedObject($registration) && $registration->delete()) {
            $this->context->cookie->__set('success_message', $this->module->l('Deleted successfully', 'AdminMarketPlaceRegistrationsController'));
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceRegistrations') . '&list=true');
        } else
            $this->module->_errors[] = $this->module->l('An error occurred while deleting the Application', 'AdminMarketPlaceRegistrationsController');
    }
    /**
     * An application can only be approved when the administrator provides a secret key
     * of at least self::SECRET_KEY_MIN_LENGTH characters.
     *
     * @return bool
     */
    private function checkSecretKey()
    {
        $secret_key = trim(Tools::getValue('secret_key'));
        $error = '';
        if (Tools::strlen($secret_key) < self::SECRET_KEY_MIN_LENGTH) {
            $error = sprintf(
                $this->module->l('The secret key is required to approve an application and must contain at least %d characters', 'AdminMarketPlaceRegistrationsController'),
                self::SECRET_KEY_MIN_LENGTH
            );
        } elseif (Tools::strlen($secret_key) > self::SECRET_KEY_MAX_LENGTH) {
            $error = sprintf(
                $this->module->l('The secret key cannot contain more than %d characters', 'AdminMarketPlaceRegistrationsController'),
                self::SECRET_KEY_MAX_LENGTH
            );
        } elseif (!Validate::isCleanHtml($secret_key)) {
            $error = $this->module->l('The secret key contains invalid characters', 'AdminMarketPlaceRegistrationsController');
        }
        if (!$error) {
            return true;
        }
        if (Tools::isSubmit('ajax')) {
            die(json_encode(
                    array(
                        'errors' => $error,
                    )
                ));
        }
        $this->module->_errors[] = $error;
        return false;
    }
    /**
     * Saves the secret key of an application without changing its status.
     * Used by the "Edit" button next to the secret key field.
     */
    private function saveSecretKey($id_registration)
    {
        $registration = new Ets_mp_registration($id_registration);
        if (!Validate::isLoadedObject($registration)) {
            $error = $this->module->l('An error occurred while saving the secret key', 'AdminMarketPlaceRegistrationsController');
            if (Tools::isSubmit('ajax')) {
                die(json_encode(
                        array(
                            'errors' => $error,
                        )
                    ));
            }
            $this->module->_errors[] = $error;
            return;
        }
        if (!$this->checkSecretKey()) {
            return;
        }
        $registration->secret_key = trim(Tools::getValue('secret_key'));
        if ($registration->update()) {
            $success = $this->module->l('Secret key saved successfully', 'AdminMarketPlaceRegistrationsController');
            if (Tools::isSubmit('ajax')) {
                die(json_encode(
                        array(
                            'success' => $success,
                            'secret_key' => $registration->secret_key,
                        )
                    ));
            }
            $this->context->cookie->__set('success_message', $success);
        } else {
            $error = $this->module->l('An error occurred while saving the secret key', 'AdminMarketPlaceRegistrationsController');
            if (Tools::isSubmit('ajax')) {
                die(json_encode(
                        array(
                            'errors' => $error,
                        )
                    ));
            }
            $this->module->_errors[] = $error;
        }
    }
    private function saveStatusRegistration($id_registration)
    {
        $registration = new Ets_mp_registration($id_registration);
        $seller = Ets_mp_seller::_getSellerByIdCustomer($registration->id_customer);
        $active_old = $registration->active;
        if ($seller) {
            die(json_encode(
                    array(
                        'errors' => $this->module->l('Seller created', 'AdminMarketPlaceRegistrationsController'),
                    )
                ));
        }
        $active_registration = (int)Tools::getValue('active_registration');
        if ($active_registration == 1 && !$this->checkSecretKey()) {
            return;
        }
        $registration->active = $active_registration;
        if ($active_registration == 1) {
            $registration->secret_key = trim(Tools::getValue('secret_key'));
        }
        if ((!$reason = Tools::getValue('reason')) || Validate::isCleanHtml($reason))
            $registration->reason = $reason;
        if ((!$comment = Tools::getValue('comment')) || Validate::isCleanHtml($comment))
            $registration->comment = $comment;
        if (Validate::isLoadedObject($registration) &&  $registration->update()) {
            if ($registration->active != $active_old) {
                if (Configuration::get('ETS_MP_EMAIL_SELLER_APPLICATION_APPROVED_OR_DECLINED')) {
                    $data = array(
                        '{seller_name}' => $registration->seller_name,
                        '{application_declined_reason}' => $reason,
                    );
                    if ($registration->active == 1) {
                        $subjects = array(
                            'translation' => $this->module->l('Application has been approved', 'AdminMarketPlaceRegistrationsController'),
                            'origin' => 'Application has been approved',
                            'specific' => 'registration'
                        );
                        Ets_marketplace::sendMail('to_seller_application_approved', $data, $registration->seller_email, $subjects, $registration->seller_name);
                    } else {
                        $subjects = array(
                            'translation' => $this->module->l('Application has been declined', 'AdminMarketPlaceRegistrationsController'),
                            'origin' => 'Application has been declined',
                            'specific' => 'registration'
                        );
                        Ets_marketplace::sendMail('to_seller_application_declined', $data, $registration->seller_email, $subjects, $registration->seller_name);
                    }
                }
            }
            if (Tools::isSubmit('ajax')) {
                die(json_encode(
                        array(
                            'success' => $this->module->l('Updated status successfully', 'AdminMarketPlaceRegistrationsController'),
                            'status' => $registration->active ? Ets_mp_defines::displayText($this->module->l('Approved', 'AdminMarketPlaceRegistrationsController'), 'span', 'ets_mp_status approved') : Ets_mp_defines::displayText($this->module->l('Declined', 'AdminMarketPlaceRegistrationsController'), 'span', 'ets_mp_status declined'),
                            'id_seller' => $registration->id,
                            'seller' => false,
                        )
                    ));
            }
            $this->context->cookie->__set('success_message', $this->module->l('Updated status successfully', 'AdminMarketPlaceRegistrationsController'));
        } else
            $this->module->_errors[] = $this->module->l('An error occurred while saving the application', 'AdminMarketPlaceRegistrationsController');
    }
    private function displayListRegistration()
    {
        $page = (int)Tools::getValue('page');
        if ($page <= 0)
            $page = 1;
        $sort_type = Tools::getValue('sort_type', 'desc');
        $sort_value = Tools::getValue('sort', 'id_registration');
        $limit = (int)Tools::getValue('paginator_registration_select_limit', 20);
        if (!Tools::isSubmit('ets_mp_submit_ets_registration') && $page == 1 && $sort_type == 'desc' && $sort_value == 'id_registration') {
            $cacheID = $this->module->_getCacheId(array('applications', $limit));
        } else
            $cacheID = null;
        if (!$cacheID || !$this->module->isCached('admin/base_list.tpl', $cacheID)) {
            $fields_list = array(
                'id' => array(
                    'title' => $this->module->l('ID', 'AdminMarketPlaceRegistrationsController'),
                    'width' => 40,
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true,
                ),
                'seller_name' => array(
                    'title' => $this->module->l('Customer name', 'AdminMarketPlaceRegistrationsController'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                ),
                'seller_email' => array(
                    'title' => $this->module->l('Customer email', 'AdminMarketPlaceRegistrationsController'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true
                ),
                'message_to_administrator' => array(
                    'title' => $this->module->l('Introduction', 'AdminMarketPlaceRegistrationsController'),
                    'type' => 'text',
                ),
                'active' => array(
                    'title' => $this->module->l('Status', 'AdminMarketPlaceRegistrationsController'),
                    'type' => 'select',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                    'filter_list' => array(
                        'id_option' => 'active',
                        'value' => 'title',
                        'list' => array(
                            0 => array(
                                'active' => 1,
                                'title' => $this->module->l('Approved', 'AdminMarketPlaceRegistrationsController')
                            ),
                            1 => array(
                                'active' => 0,
                                'title' => $this->module->l('Declined', 'AdminMarketPlaceRegistrationsController')
                            ),
                            2 => array(
                                'active' => -1,
                                'title' => $this->module->l('Pending', 'AdminMarketPlaceRegistrationsController'),
                            )
                        )
                    )
                ),
            );
            //Filter
            $show_resset = false;
            $filter = "";
            if (Tools::isSubmit('ets_mp_submit_ets_registration')) {
                if (($id = Tools::getValue('id')) && !Tools::isSubmit('saveStatusRegistration') && !Tools::isSubmit('del')) {
                    if (Validate::isUnsignedId($id))
                        $filter .= ' AND r.id_registration="' . (int)$id . '"';
                    $show_resset = true;
                }
                if (($seller_name = trim(Tools::getValue('seller_name'))) || $seller_name != '') {
                    if (Validate::isCleanHtml($seller_name))
                        $filter .= ' AND CONCAT(customer.firstname," ",customer.lastname) LIKE "%' . pSQL($seller_name) . '%"';
                    $show_resset = true;
                }
                if (($category_name = Tools::getValue('category_name')) || $category_name != '') {
                    if (Validate::isGenericName($category_name))
                        $filter .= ' AND scl.name LIKE "%' . pSQL($category_name) . '%"';
                    $show_resset = false;
                }
                if (($seller_email = trim(Tools::getValue('seller_email'))) || $seller_email != '') {
                    if (Validate::isCleanHtml($seller_email))
                        $filter .= ' AND customer.email LIKE "%' . pSQL($seller_email) . '%"';
                    $show_resset = true;
                }
                if (($shop_name = trim(Tools::getValue('shop_name'))) || $shop_name != '') {
                    if (Validate::isCleanHtml($shop_name))
                        $filter .= ' AND r.shop_name LIKE "%' . pSQL($shop_name) . '%"';
                    $show_resset = true;
                }
                if (($shop_description = trim(Tools::getValue('shop_description'))) || $shop_description != '') {
                    if (Validate::isCleanHtml($shop_description))
                        $filter .= ' AND r.shop_description = "%' . pSQL($shop_description) . '%"';
                    $show_resset = true;
                }
                if (($active = trim(Tools::getValue('active'))) || $active != '') {
                    if (Validate::isInt((int)$active))
                        $filter .= ' AND r.active="' . (int)$active . '"';
                    $show_resset = true;
                }
            }
            //Sort
            $sort = "";
            if ($sort_value) {
                switch ($sort_value) {
                    case 'id':
                        $sort .= ' r.id_registration';
                        break;
                    case 'seller_name':
                        $sort .= ' seller_name';
                        break;
                    case 'seller_email':
                        $sort .= ' seller_email';
                        break;
                    case 'shop_name':
                        $sort .= 'r.shop_name';
                        break;
                    case 'shop_description':
                        $sort .= 'r.shop_description';
                        break;
                    case 'category_name':
                        $sort .= 'scl.name';
                        break;
                    case 'active':
                        $sort .= 'r.active';
                        break;
                }
                if ($sort && $sort_type && in_array($sort_type, array('acs', 'desc')))
                    $sort .= ' ' . $sort_type;
            }
            //Paggination
            $totalRecords = (int)Ets_mp_registration::_getRegistrations($filter, $sort, 0, 0, true);;
            $paggination = new Ets_mp_paggination_class();
            $paggination->total = $totalRecords;
            $paggination->url = $this->context->link->getAdminLink('AdminMarketPlaceRegistrations') . '&page=_page_' . $this->module->getFilterParams($fields_list, 'ets_registration');
            $paggination->limit = $limit;
            $paggination->name = 'registration';
            $totalPages = ceil($totalRecords / $paggination->limit);
            if ($page > $totalPages)
                $page = $totalPages;
            $paggination->page = $page;
            $start = $paggination->limit * ($page - 1);
            if ($start < 0)
                $start = 0;
            $sellers_registration = Ets_mp_registration::_getRegistrations($filter, $sort, $start, $paggination->limit, false);
            if ($sellers_registration) {
                foreach ($sellers_registration as &$seller) {
                    $seller['child_view_url'] = $this->context->link->getAdminLink('AdminMarketPlaceRegistrations') . '&viewets_registration=1&id_registration=' . $seller['id_registration'];
                    $seller['status'] = $seller['active'];
                    if ($seller['active'] == -1)
                        $seller['active'] = Ets_mp_defines::displayText($this->module->l('Pending', 'AdminMarketPlaceRegistrationsController'), 'span', 'ets_mp_status pending');
                    elseif ($seller['active'] == 0)
                        $seller['active'] = Ets_mp_defines::displayText($this->module->l('Declined', 'AdminMarketPlaceRegistrationsController'), 'span', 'ets_mp_status declined');
                    elseif ($seller['active'] == 1) {
                        $seller['active'] = Ets_mp_defines::displayText($this->module->l('Approved', 'AdminMarketPlaceRegistrationsController'), 'span', 'ets_mp_status approved');
                    }
                    $seller['seller_name'] = Ets_mp_defines::displayText($seller['seller_name'], 'a', '', '', $this->module->getLinkCustomerAdmin($seller['id_customer']));
                    $seller['has_seller'] = Ets_mp_seller::_getSellerByIdCustomer($seller['id_customer']) ? true : false;
                }
            }
            $paggination->text = $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)', 'AdminMarketPlaceRegistrationsController');
            $paggination->style_links = $this->module->l('links', 'AdminMarketPlaceRegistrationsController');
            $paggination->style_results = $this->module->l('results', 'AdminMarketPlaceRegistrationsController');
            $listData = array(
                'name' => 'ets_registration',
                'actions' => array('approve_registration', 'decline_registration'),
                'icon' => 'icon-sellers_registration',
                'currentIndex' => $this->context->link->getAdminLink('AdminMarketPlaceRegistrations') . ($paggination->limit != 20 ? '&paginator_registration_select_limit=' . $paggination->limit : ''),
                'postIndex' => $this->context->link->getAdminLink('AdminMarketPlaceRegistrations'),
                'identifier' => 'id_registration',
                'show_toolbar' => true,
                'show_action' => true,
                'title' => $this->module->l('Applications', 'AdminMarketPlaceRegistrationsController'),
                'fields_list' => $fields_list,
                'field_values' => $sellers_registration,
                'paggination' => $paggination->render(),
                'filter_params' => $this->module->getFilterParams($fields_list, 'ets_registration'),
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
    public function renderSellersRegistration()
    {
        $id_registration = (int)Tools::getValue('id_registration');
        if (Tools::isSubmit('del') && ($id_registration = Tools::getValue('id_registration')) && Validate::isUnsignedId($id_registration)) {
            $this->deleteRegistration($id_registration);
        }
        if (!Tools::isSubmit('ets_mp_submit_ets_registration') &&  Tools::isSubmit('saveStatusRegistration') && ($id_registration = Tools::getValue('id_registration')) && Validate::isUnsignedId($id_registration)) {
            $this->saveStatusRegistration($id_registration);
        }
        if (!Tools::isSubmit('ets_mp_submit_ets_registration') && Tools::isSubmit('submitSecretKey') && ($id_registration = Tools::getValue('id_registration')) && Validate::isUnsignedId($id_registration)) {
            $this->saveSecretKey($id_registration);
        }
        if (Tools::isSubmit('viewets_registration') && $id_registration && Validate::isUnsignedId($id_registration) && Validate::isLoadedObject(new Ets_mp_registration($id_registration))) {
            return $this->renderFormSellersRegistration();
        }
        return $this->displayListRegistration();
    }
    public function renderFormSellersRegistration()
    {
        $id_registration = (int)Tools::getValue('id_registration');
        $registration = new Ets_mp_registration($id_registration);
        if (Validate::isLoadedObject($registration)) {
            $this->context->smarty->assign(
                array(
                    'registration' => $registration,
                    'customer' => new Customer($registration->id_customer),
                    'link' => $this->context->link,
                    'has_seller' => Ets_mp_seller::_getSellerByIdCustomer($registration->id_customer) ? true : false,
                    'link_customer' => $this->module->getLinkCustomerAdmin($registration->id_customer),
                    'secret_key_min_length' => self::SECRET_KEY_MIN_LENGTH,
                    'shop_category' => ($registration->id_shop_category && Validate::isLoadedObject($shop_category = new Ets_mp_shop_category($registration->id_shop_category, $this->context->language->id))) ? $shop_category : false,
                )
            );
            return $this->context->smarty->fetch(_PS_MODULE_DIR_ . 'ets_marketplace/views/templates/hook/shop/registration_detail.tpl');
        }
        return '';
    }
}
