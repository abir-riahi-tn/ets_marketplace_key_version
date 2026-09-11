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

if (!defined('_PS_VERSION_')) { exit; }

/**
 * Class Ets_MarketPlaceCreateModuleFrontController
 * @property \Ets_marketplace $module;
 *
 */
class Ets_MarketPlaceCreateModuleFrontController extends ModuleFrontController
{
    public $_success;
    public $_errors = array();
    public $_warning;
    public $display_column_right;
    public $display_column_left;
    public function __construct()
	{
		parent::__construct();
        $this->display_column_right=false;
        $this->display_column_left =false;
	}
    public function postProcess()
    {
        parent::postProcess();
        if(Tools::isSubmit('i_have_just_sent_the_fee') && ($seller= $this->module->_getSeller()))
        {
            $seller->confirmedPayment();
        }
        if(!$this->context->customer->isLogged() || ((!($registration = Ets_mp_registration::_getRegistration()) || $registration->active!=1) && Configuration::get('ETS_MP_REQUIRE_REGISTRATION')))
            Tools::redirect($this->context->link->getPageLink('my-account'));
        if($this->module->_getSeller())
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        if(Tools::isSubmit('submitDeclinceManageShop') && ($id_manager = Ets_mp_manager::getIDMangerByEmail($this->context->customer->email)) && Validate::isLoadedObject($manager = new Ets_mp_manager($id_manager)) )
        {
            $manager->active=0;
            $manager->update();
            $this->_warning = $this->module->l('You have declined a shop management invitation. How about registering for your own shop?','create');
        }
        if(Tools::isSubmit('submitApproveManageShop') && ($id_manager = Ets_mp_manager::getIDMangerByEmail($this->context->customer->email)) && Validate::isLoadedObject($manager = new Ets_mp_manager($id_manager)))
        {
            $manager->active=1;
            $manager->update();
        }
        if(Tools::isSubmit('submitSaveSeller'))
        {
            $valueFieldPost = array();
            $this->module->submitSaveSeller(0,$this->_errors,false,$valueFieldPost);
            if($this->context->cookie->__get('success_message'))
            {
                $this->_success = $this->context->cookie->__get('success_message');
                $this->context->cookie->__set('success_message','');
            }
            $this->context->smarty->assign(
                array(
                    'valueFieldPost' => $valueFieldPost,
                )
            );
        }
    }
    public function initContent()
	{
		parent::initContent();
        $this->context->smarty->assign(
            array(
                'path' => $this->module->getBreadCrumb(),
                'breadcrumb' => $this->module->is17 ? $this->module->getBreadCrumb() : false, 
                'html_content' => $this->_initContent(),
            )
        );
        if($this->module->is17)
            $this->setTemplate('module:'.$this->module->name.'/views/templates/front/create.tpl');      
        else        
            $this->setTemplate('create_16.tpl'); 
    }
    public function _initContent()
    {
        if(($id_manager = (int)Ets_mp_manager::getIDMangerByEmail($this->context->customer->email)) && Validate::isLoadedObject($manager = new Ets_mp_manager($id_manager)) && $manager->active!=0 )
        {
            $seller = Ets_mp_seller::_getSellerByIdCustomer($manager->id_customer,$this->context->language->id);
            $manager_shop = array(
                'firstname' => $seller->firstname,
                'lastname' => $seller->lastname,
                'shop_name' => $seller->shop_name,
                'active' => $manager->active,
            );
        }
        $address = new Address((int)Address::getFirstCustomerAddressId($this->context->customer->id));
        $output = '';
        if (is_array($this->_errors)) {
            foreach ($this->_errors as $msg) {
                $output .= $msg . '<'.'br/'.'>';
            }
        } else {
            $output .= $this->_errors;
        }
        $this->context->smarty->assign(
            array(
                'seller' => Ets_mp_registration::_getRegistration(),
                '_errors' => $this->_errors ? Ets_mp_defines::displayText('<'.'svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/'.'>'.'<'.'/svg'.'>'.$output,'div','alert alert-error'):'',
                '_success' => $this->_success ? Ets_mp_defines::displayText('<'.'svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"'.'>'.'<'.'path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/'.'>'.'<'.'/svg'.'>'.$this->_success,'p','alert alert-success'):'',
                'shop_seller' => $this->module->_getSeller(false,Tools::isSubmit('submitSaveSeller') ? false : true),
                'create_customer' => $this->context->customer,
                'path' => $this->module->getBreadCrumb(),
                'link_base' => $this->module->getBaseLink(),
                'shop_name' => $this->context->shop->name,
                'languages' => Language::getLanguages(true),
                'id_lang_default' => Configuration::get('PS_LANG_DEFAULT'),
                'manager_shop' => isset($manager_shop) ? $manager_shop :false,
                'breadcrumb' => $this->module->is17 ? $this->module->getBreadCrumb() : false, 
                'shop_categories' => Ets_mp_shop_category::getShopCategories(' AND c.active=1',0,false),
                'number_phone' => $address->phone ? : $address->phone_mobile,
                'vat_number' => $address->vat_number,
            )
        );
        return ($this->_warning ? $this->module->displayWarning($this->_warning):'').$this->module->displayTpl('create.tpl');
    }
}
