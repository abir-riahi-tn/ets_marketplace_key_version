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
 * Class AdminMarketPlaceRatingsController
 * @property \Ets_marketplace $module
 */
class AdminMarketPlaceRatingsController extends ModuleAdminController
{
    public function __construct()
    {
        parent::__construct();
        $this->context = Ets_marketplace::getContextStatic();
        $this->bootstrap = true;
    }
    public function renderList()
    {
        $this->module->getContent();
        $this->context->smarty->assign(
            array(
                'ets_mp_body_html' => $this->_renderRatings(),
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
    public function postProcess()
    {
        parent::postProcess();
        if (Tools::isSubmit('approve') && ($id_comment = Tools::getValue('id_comment')) && Validate::isUnsignedId($id_comment)) {
            if (Module::isInstalled('productcomments')) {
                if (!Ets_mp_product::getProductComment($id_comment))
                    $this->module->_errors[] = $this->module->l('Review is not valid', 'AdminMarketPlaceRatingsController');
                else {
                    Ets_mp_product::updateStatusProductComment($id_comment, 1);
                    $this->context->cookie->__set('success_message', $this->module->l('Approved successfully', 'AdminMarketPlaceRatingsController'));
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceRatings'));
                }
            } elseif (Module::isInstalled('ets_reviews')) {
                /* @phpstan-ignore-next-line */
                $productComment = new EtsRVProductComment($id_comment);
                if (!Validate::isLoadedObject($productComment))
                    $this->module->_errors[] = $this->module->l('Review is not valid', 'AdminMarketPlaceRatingsController');
                else {
                    /* @phpstan-ignore-next-line */
                    $productComment->validate = 1;
                    /* @phpstan-ignore-next-line */
                    if ($productComment->update()) {
                        $this->context->cookie->__set('success_message', $this->module->l('Approved successfully', 'AdminMarketPlaceRatingsController'));
                        Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceRatings'));
                    } else
                        $this->module->_errors[] = $this->module->l('An error occurred while saving the review', 'AdminMarketPlaceRatingsController');
                }
            }
        }
        if (Tools::isSubmit('del') && ($id_comment = (int)Tools::getValue('id_comment')) && Validate::isUnsignedId($id_comment)) {
            if (Module::isInstalled('productcomments')) {
                if (!Ets_mp_product::getProductComment($id_comment))
                    $this->module->_errors[] = $this->module->l('Review is not valid', 'AdminMarketPlaceRatingsController');
                else {
                    Ets_mp_product::deleteProductComment($id_comment);
                    $this->context->cookie->__set('success_message', $this->module->l('Deleted successfully', 'AdminMarketPlaceRatingsController'));
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceRatings'));
                }
            } elseif (Module::isInstalled('ets_reviews')) {
                /* @phpstan-ignore-next-line */
                $productComment = new EtsRVProductComment($id_comment);
                if (!Validate::isLoadedObject($productComment))
                    $this->module->_errors[] = $this->module->l('Review is not valid', 'AdminMarketPlaceRatingsController');
                else {
                    /* @phpstan-ignore-next-line */
                    if ($productComment->delete()) {
                        $this->context->cookie->__set('success_message', $this->module->l('Deleted successfully', 'AdminMarketPlaceRatingsController'));
                        Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceRatings'));
                    } else
                        $this->module->_errors[] = $this->module->l('An error occurred while deleting the review', 'AdminMarketPlaceRatingsController');
                }
            }
        }
    }
    public function _renderRatings()
    {
        if (!Module::isInstalled('productcomments') && !Module::isInstalled('ets_reviews'))
            return $this->module->displayWarning($this->module->l('You have to install the native module "Product Comments" of PrestaShop or "Trusted Reviews - Product reviews, ratings, Q&A" module of PrestaHero', 'AdminMarketPlaceRatingsController'));
        $fields_list = array(
            'id_comment' => array(
                'title' => $this->module->l('ID', 'AdminMarketPlaceRatingsController'),
                'width' => 40,
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'review' => array(
                'title' => $this->module->l('Review', 'AdminMarketPlaceRatingsController'),
                'type' => 'text',
                'strip_tag' => false,
                'sort' => false,
                'filter' => false,
            ),
            'grade' => array(
                'title' => $this->module->l('Ratings', 'AdminMarketPlaceRatingsController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false,
            ),
            'name' => array(
                'title' => $this->module->l('Product', 'AdminMarketPlaceRatingsController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false
            ),
            'shop_name' => array(
                'title' => $this->module->l('Shop', 'AdminMarketPlaceRatingsController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false
            ),
            'validate' => array(
                'title' => $this->module->l('Status', 'AdminMarketPlaceRatingsController'),
                'type' => 'active',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false,
                'filter_list' => array(
                    'id_option' => 'active',
                    'value' => 'title',
                    'list' => array(
                        0 => array(
                            'active' => 1,
                            'title' => $this->module->l('Enabled', 'AdminMarketPlaceRatingsController')
                        ),
                        1 => array(
                            'active' => 0,
                            'title' => $this->module->l('Disabled', 'AdminMarketPlaceRatingsController')
                        )
                    )
                )
            ),
            'date_add' => array(
                'title' => $this->module->l('Time of publication', 'AdminMarketPlaceRatingsController'),
                'type' => 'date',
                'sort' => true,
                'filter' => true,
                'class' => 'text-center'
            ),
        );
        //Filter
        $validate = true;
        if (Module::isInstalled('productcomments')) {
            if (!Configuration::get('PRODUCT_COMMENTS_MODERATE'))
                $validate = false;
        } elseif (Module::isInstalled('ets_reviews')) {
            if (!Configuration::get('ETS_RV_MODERATE'))
                $validate = false;
        }
        if (!$validate)
            unset($fields_list['validate']);
        $show_resset = false;
        $filter = "";
        $having = "";
        $id_comment = Tools::getValue('id_comment');
        $approve = (int)Tools::getValue('approve');
        if ($id_comment && !Tools::isSubmit('del') && !$approve) {
            if (Validate::isUnsignedId($id_comment)) {
                if (Module::isInstalled('ets_reviews'))
                    $filter .= ' AND pc.id_ets_rv_product_comment="' . (int)$id_comment . '"';
                else
                    $filter .= ' AND pc.id_product_comment="' . (int)$id_comment . '"';
            }
            $show_resset = true;
        }
        if (($name = Tools::getValue('name')) || $name != '') {
            if (Validate::isCleanHtml($name))
                $filter .= ' AND pl.name LIKE "%' . pSQL($name) . '%"';
            $show_resset = true;
        }
        if (($shop_name = Tools::getValue('shop_name')) || $shop_name != '') {
            if (Validate::isCleanHtml($shop_name))
                $filter .= ' AND seller_lang.shop_name LIKE "%' . pSQL($shop_name) . '%"';
            $show_resset = true;
        }
        if (($grade = Tools::getValue('grade')) || $grade != '') {
            if (Validate::isInt((int)$grade))
                $filter .= ' AND pc.grade ="' . (int)$grade . '"';
            $show_resset = true;
        }
        if (($validate = trim(Tools::getValue('validate'))) || $validate != '') {
            if (Validate::isInt((int)$validate))
                $filter .= ' AND pc.validate="' . (int)$validate . '"';
            $show_resset = true;
        }
        if (($date_add_min = Tools::getValue('date_add_min')) || $date_add_min != '') {
            if (Validate::isDate($date_add_min))
                $filter .= ' AND pc.date_add >= "' . pSQL($date_add_min) . '"';
            $show_resset = true;
        }
        if (($date_add_max = Tools::getValue('date_add_max')) || $date_add_max != '') {
            if (Validate::isDate($date_add_max))
                $filter .= ' AND pc.date_add <= "' . pSQL($date_add_max) . '"';
            $show_resset = true;
        }
        if ($validate && !Configuration::get('ETS_MP_SELLER_DISPLAY_REVIEWS_WAITING'))
            $filter .= ' AND pc.validate=1';
        //Sort
        $sort = "";
        $sort_type = Tools::getValue('sort_type', 'desc');
        $sort_value = Tools::getValue('sort', 'id_comment');
        if ($sort_value) {
            switch ($sort_value) {
                case 'id_comment':
                    $sort .= 'id_comment';
                    break;
                case 'name':
                    $sort .= 'pl.name';
                    break;
                case 'shop_name':
                    $sort .= 'seller_lang.shop_name';
                    break;
                case 'grade':
                    $sort .= 'pc.grade';
                    break;
                case 'validate':
                    $sort .= 'pc.validate';
                    break;
                case 'date_add':
                    $sort .= 'pc.date_add';
                    break;
            }
            if ($sort && $sort_type && in_array($sort_type, array('asc', 'desc')))
                $sort .= ' ' . trim($sort_type);
        }
        //Paggination
        $page = (int)Tools::getValue('page');
        if ($page <= 0)
            $page = 1;
        $totalRecords = (int)Ets_mp_seller::getListProductComments($filter, $having, 0, 0, '', true);
        $paggination = new Ets_mp_paggination_class();
        $paggination->total = $totalRecords;
        $paggination->url = $this->context->link->getAdminLink('AdminMarketPlaceRatings') . '&page=_page_' . $this->module->getFilterParams($fields_list, 'mp_ratings');
        $paggination->limit =  (int)Tools::getValue('paginator_rating_select_limit', 20);
        $paggination->name = 'rating';
        $totalPages = ceil($totalRecords / $paggination->limit);
        if ($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $start = $paggination->limit * ($page - 1);
        if ($start < 0)
            $start = 0;
        $productComments = Ets_mp_seller::getListProductComments($filter, $having, $start, $paggination->limit, $sort, false);
        if ($productComments) {
            foreach ($productComments as &$productComment) {
                if (Tools::strlen($productComment['content']) > 135) {
                    $productComment['content'] = Tools::substr($productComment['content'], 0, 135) . '...';
                }
                $productComment['review'] = Ets_mp_defines::displayText($productComment['title'], 'b', 'ets_mp_commentreview') . Ets_mp_defines::displayText('', 'br') . $productComment['content'];
                $productComment['grade'] = $productComment['grade'] . '/5';
                $productComment['child_view_url'] = $this->context->link->getAdminLink('AdminModules') . '&configure=' . (Module::isInstalled('productcomments') ? 'productcomments' : 'ets_reviews');
                $productComment['name'] = Ets_mp_defines::displayText($productComment['name'], 'a', '', '', $this->context->link->getProductLink($productComment['id_product']), '_blank');
                $productComment['shop_name'] = Ets_mp_defines::displayText($productComment['shop_name'], 'a', '', '', $this->module->getShopLink(array('id_seller' => $productComment['id_seller'])), '_blank');
                $productComment['action_edit'] = false;
                $productComment['action_delete'] = true;
                if ($validate && !$productComment['validate'])
                    $productComment['action_approve'] = true;
            }
        }
        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)', 'ratings');
        $paggination->style_links = 'links';
        $paggination->style_results = 'results';
        $listData = array(
            'name' => 'mp_ratings',
            'actions' => array('view', 'approve_review', 'delete'),
            'currentIndex' => $this->context->link->getAdminLink('AdminMarketPlaceRatings') . ($paggination->limit != 20 ? '&paginator_rating_select_limit=' . $paggination->limit : ''),
            'postIndex' => $this->context->link->getAdminLink('AdminMarketPlaceRatings'),
            'identifier' => 'id_comment',
            'show_toolbar' => true,
            'show_action' => true,
            'title' => $this->module->l('Ratings', 'AdminMarketPlaceRatingsController'),
            'fields_list' => $fields_list,
            'field_values' => $productComments,
            'paggination' => $paggination->render(),
            'filter_params' => $this->module->getFilterParams($fields_list, 'mp_ratings'),
            'show_reset' => $show_resset,
            'totalRecords' => $totalRecords,
            'sort' => $sort_value,
            'show_add_new' =>  false,
            'sort_type' => $sort_type,
        );
        return $this->module->renderList($listData);
    }
}
