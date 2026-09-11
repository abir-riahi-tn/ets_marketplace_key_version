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
 * Class Ets_MarketPlaceVacationModuleFrontController
 * @property Ets_marketplace $module
 * @property Ets_mp_seller $seller
 */
class Ets_MarketPlaceVacationModuleFrontController extends ModuleFrontController
{
    public $_errors= array();
    public $_success ='';
    public $seller;
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
        if(!Configuration::get('ETS_MP_VACATION_MODE_FOR_SELLER'))
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        if(!$this->context->customer->isLogged() || !($this->seller = $this->module->_getSeller(true)) )
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        if(!$this->module->_checkPermissionPage($this->seller))
            die($this->module->l('You do not have permission to access this page','vacation'));
        $valueFieldPost = array();
        $languages = Language::getLanguages(false);
        if(Tools::isSubmit('submitSaveVacationSeller'))
        {
            $id_lang_default = (int)Configuration::get('PS_LANG_DEFAULT');
            $vacation_mode = (int)Tools::getValue('vacation_mode');
            $vacation_type = Tools::getValue('vacation_type');
            $date_vacation_start = trim(Tools::getValue('date_vacation_start'));
            $date_vacation_end = trim(Tools::getValue('date_vacation_end'));
            if(!in_array($vacation_type,array('show_notifications','disable_product','disable_product_and_show_notifications','disable_shopping','disable_shopping_and_show_notifications')))
                $this->_errors[] = $this->module->l('Vacation mode type is not valid','vacation');
            $valueFieldPost['vacation_type'] = $vacation_type;
            $valueFieldPost['vacation_mode'] = $vacation_mode;
            if($vacation_mode)
            {
                $vacation_notifications_default = Tools::getValue('vacation_notifications_'.$id_lang_default);
                $vacation_notifications = array();
                if(Tools::strpos($vacation_type,'show_notifications')!==false && !$vacation_notifications_default)
                    $this->_errors[] = $this->module->l('Notification is required','vacation');
                foreach($languages as $language)
                {
                    if(($vacation_notifications[$language['id_lang']] = Tools::getValue('vacation_notifications_'.$language['id_lang'],$this->seller->vacation_notifications[$language['id_lang']])) && Tools::strpos($vacation_type,'show_notifications')!==false && !Validate::isCleanHtml($vacation_notifications[$language['id_lang']]))
                        $this->_errors[] =sprintf($this->module->l('Notification is not valid in %s','vacation'),$language['iso_code']);
                }
            }
            if($date_vacation_start && !Validate::isDate($date_vacation_start))
            {
                $this->_errors[] = $this->module->l('Vacation start date is not valid','vacation');
            }
            if($date_vacation_end && !Validate::isDate($date_vacation_end))
            {
                $this->_errors[] = $this->module->l('Vacation end date is not valid','vacation');
            }
            if($date_vacation_end && $date_vacation_start && strtotime($date_vacation_start) >= strtotime($date_vacation_end))
            {
                $this->_errors[] = $this->module->l('The vacation end date must be greater than the vacation start date','vacation');
            }
            foreach($languages as $language)
            {
                $valueFieldPost['vacation_notifications'][$language['id_lang']] = Tools::getValue('vacation_notifications_'.$language['id_lang'],$this->seller->vacation_notifications[$language['id_lang']]);
            }
            if(!$this->_errors)
            {
                $this->seller->vacation_mode = (int)$vacation_mode;
                if($this->seller->vacation_mode)
                {
                    $this->seller->vacation_type = $vacation_type;
                    $this->seller->date_vacation_start = $date_vacation_start;
                    $this->seller->date_vacation_end = $date_vacation_end;
                    if(Tools::strpos($vacation_type,'show_notifications')!==false)
                    {
                        foreach($languages as $language)
                        {
                            /* @phpstan-ignore-next-line */
                            $this->seller->vacation_notifications[$language['id_lang']] = $vacation_notifications[$language['id_lang']] ? : $vacation_notifications_default;
                        }
                    }
                }
                if($this->seller->update())
                    $this->_success = $this->module->l('Updated successfully','vaccation');
                else
                    $this->_errors[] = $this->module->l('An error occurred while saving', 'vacation'); 
            }
            
        }
        else
        {
            $valueFieldPost['vacation_type'] = $this->seller->vacation_type;
            $valueFieldPost['vacation_mode'] = $this->seller->vacation_mode;
            foreach($languages as $language)
            {
                $valueFieldPost['vacation_notifications'][$language['id_lang']] = $this->seller->vacation_notifications[$language['id_lang']] ? :$this->module->l('The seller is currently on vacation. This shop will come back later','vacation');
            }
        }
        
        $this->context->smarty->assign(
            array(
                'valueFieldPost' => $valueFieldPost,
            )
        );
    }
    public function initContent()
	{
		parent::initContent();
        if(isset($this->context->cookie->_success) && $this->context->cookie->_success )
        {
            $this->_success = $this->context->cookie->_success;
            $this->context->cookie->_success='';
        }
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
                'path' => $this->module->getBreadCrumb(),
                'breadcrumb' => $this->module->is17 ? $this->module->getBreadCrumb() : false, 
                'html_content' => $this->_initContent(),
                '_errors' => $this->_errors ? Ets_mp_defines::displayText('<'.'svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/'.'>'.'<'.'/svg'.'>'.$output,'div','alert alert-error'):'',
                '_success' => $this->_success ? Ets_mp_defines::displayText('<'.'svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"'.'>'.'<'.'path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/'.'>'.'<'.'/svg'.'>'.$this->_success,'p','alert alert-success'):'',
            )
        );
        if($this->module->is17)
            $this->setTemplate('module:'.$this->module->name.'/views/templates/front/vacation.tpl');      
        else        
            $this->setTemplate('vacation_16.tpl'); 
    }
    public function _initContent()
    {
        $this->context->smarty->assign(
            array(
                'seller' => $this->seller,
                'languages' => Language::getLanguages(false),
                'id_lang_default' => (int)Configuration::get('PS_LANG_DEFAULT')
            )
        );
        return $this->module->displayTpl('shop/vacation.tpl');
    }
 }
