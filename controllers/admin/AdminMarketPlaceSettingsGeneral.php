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
 * Class AdminMarketPlaceSettingsGeneralController
 * @property \Ets_marketplace $module
 */
class AdminMarketPlaceSettingsGeneralController extends ModuleAdminController
{
    public function __construct()
    {
       parent::__construct();
       $this->context= Ets_marketplace::getContextStatic();
       $this->bootstrap = true;
       
    }
    public function postProcess()
    {
        parent::postProcess();
        if(Tools::isSubmit('saveConfig'))
        {
            if($this->_checkFormBeforeSubmit())
            {
                $this->_saveFromSettings();
            }
        }
    }
    public function initContent()
    {
        parent::initContent();
        if($this->ajax)
        {
            $this->renderList();
        }
    }
    public function renderList()
    {
        $this->module->getContent();
        $this->context->smarty->assign(
            array(
                'ets_mp_body_html'=> $this->_renderSettings(),
            )
        );
        $html ='';
        if($this->context->cookie->__get('success_message'))
        {
            $html .= $this->module->displayConfirmation($this->context->cookie->__get('success_message'));
            $this->context->cookie->__set('success_message', '');
        }
        if($this->module->_errors)
            $html .= $this->module->displayError($this->module->_errors);
        return $html.$this->module->display(_PS_MODULE_DIR_.$this->module->name.DIRECTORY_SEPARATOR.$this->module->name.'.php', 'admin.tpl');
    }
    public function _renderSettings()
    {
        $languages = Language::getLanguages(false);
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->module->l('General', 'AdminMarketPlaceSettingsGeneral'),
                    'icon' => 'icon-settings'
                ),
                'input' => array(),
                'submit' => array(
                    'title' => $this->module->l('Save', 'AdminMarketPlaceSettingsGeneral'),
                )
            ),
        );
        $configs = Ets_mp_defines::getInstance()->getFieldConfig('settings', true, !Tools::isSubmit('saveConfig'));
        $fields = array();
        foreach($configs as $config)
        {
            $fields_form['form']['input'][] = $config;
            if($config['type']!='checkbox' && $config['type']!='categories' && $config['type']!='tre_categories')
            {
                if(isset($config['lang']) && $config['lang'])
                {
                    foreach($languages as $language)
                    {
                        $fields[$config['name']][$language['id_lang']] = Tools::getValue($config['name'].'_'.$language['id_lang'],Configuration::get($config['name'],$language['id_lang']));
                    }

                }
                else
                    $fields[$config['name']] = Tools::getValue($config['name'],Configuration::get($config['name']));
            }
            else
                $fields[$config['name']] = Tools::isSubmit('saveConfig') ?  Tools::getValue($config['name']) : explode(',',Configuration::get($config['name']));
            $fields['ETS_MP_REGISTRATION_FIELDS_VALIDATE'] = Tools::isSubmit('saveConfig') ? Tools::getValue('ETS_MP_REGISTRATION_FIELDS_VALIDATE') : explode(',',Configuration::get('ETS_MP_REGISTRATION_FIELDS_VALIDATE'));
            $fields['ETS_MP_CONTACT_FIELDS_VALIDATE'] = Tools::isSubmit('saveConfig') ? Tools::getValue('ETS_MP_CONTACT_FIELDS_VALIDATE') : explode(',',Configuration::get('ETS_MP_CONTACT_FIELDS_VALIDATE'));
        }
        $fields_form['form']['input'][]= array(
            'name' =>'current_tab',
            'type' => 'hidden',
        );
        $current_tab = (string)Tools::getValue('current_tab','conditions');
        if(!in_array($current_tab,array('conditions','application','memberships','seller_settings','map_settings','commission_status','email_settings','message','contact_form','home_page','seller_seo','product_page')))
            $current_tab='conditions';
        $fields['current_tab'] = $current_tab;
        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $this->fields_form = array();
        $helper->module = $this->module;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'saveConfig';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminMarketPlaceSettingsGeneral', false);
        $helper->token = Tools::getAdminTokenLite('AdminMarketPlaceSettingsGeneral');
        $language = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->tpl_vars = array(
            'base_url' => $this->context->shop->getBaseURL(),
            'language' => array(
                'id_lang' => $language->id,
                'iso_code' => $language->iso_code
            ),
            'fields_value' => $fields,
            'languages' => $this->context->controller->getLanguages(),
            'configTabs' => Ets_mp_defines::getInstance()->getFieldConfig('configTabs'),
            'id_language' => $this->context->language->id,
            'isConfigForm' => true,
            'link_base' => $this->module->getBaseLink(),
            'current_tab' => $current_tab,
            'image_baseurl' => $this->module->getPathUri(),
        );
        return $helper->generateForm(array($fields_form));
    }
    public function _checkFormBeforeSubmit()
    {
        $languages = Language::getLanguages(false);
        $id_lang_default = Configuration::get('PS_LANG_DEFAULT');
        $ETS_MP_SELLER_GROUP = Tools::getValue('ETS_MP_SELLER_GROUPS');
        if(!$ETS_MP_SELLER_GROUP)
            $this->module->_errors[] = $this->module->l('Applicable customer group is required', 'AdminMarketPlaceSettingsGeneral');
        elseif(!Ets_marketplace::validateArray($ETS_MP_SELLER_GROUP,'isInt'))
            $this->module->_errors[] = $this->module->l('Applicable customer group is not valid', 'AdminMarketPlaceSettingsGeneral');
        $ETS_MP_SELLER_FEE_TYPE = Tools::getValue('ETS_MP_SELLER_FEE_TYPE');
        if(!in_array($ETS_MP_SELLER_FEE_TYPE,array('no_fee','pay_once','monthly_fee','quarterly_fee','yearly_fee')))
            $this->module->l('Fee amount is not valid', 'AdminMarketPlaceSettingsGeneral');
        elseif($ETS_MP_SELLER_FEE_TYPE!='no_fee')
        {
            $ETS_MP_SELLER_FEE_AMOUNT = Tools::getValue('ETS_MP_SELLER_FEE_AMOUNT');
            if(trim($ETS_MP_SELLER_FEE_AMOUNT)=='')
                $this->module->_errors[] = $this->module->l('Fee amount is required', 'AdminMarketPlaceSettingsGeneral');
            elseif(!Validate::isUnsignedFloat($ETS_MP_SELLER_FEE_AMOUNT))
                $this->module->_errors[] = $this->module->l('Fee amount is not valid', 'AdminMarketPlaceSettingsGeneral');
        }
        $ETS_MP_SELLER_PAYMENT_INFORMATION_default = Tools::getValue('ETS_MP_SELLER_PAYMENT_INFORMATION_'.$id_lang_default);
        if(!$ETS_MP_SELLER_PAYMENT_INFORMATION_default)
            $this->module->_errors[] = $this->module->l('Payment information of the marketplace manager is required', 'AdminMarketPlaceSettingsGeneral');
        $ETS_MP_SELLER_ALLOWED_INFORMATION_SUBMISSION = Tools::getValue('ETS_MP_SELLER_ALLOWED_INFORMATION_SUBMISSION');
        if(!$ETS_MP_SELLER_ALLOWED_INFORMATION_SUBMISSION)
            $this->module->_errors[] = $this->module->l('"Allow seller to submit this information" is required', 'AdminMarketPlaceSettingsGeneral');
        elseif(!Ets_marketplace::validateArray($ETS_MP_SELLER_ALLOWED_INFORMATION_SUBMISSION))
            $this->module->_errors[] = $this->module->l('"Allow seller to submit this information" is not valid', 'AdminMarketPlaceSettingsGeneral');
        $ETS_MP_SELLER_CAN_CHANGE_ORDER_STATUS = (int)Tools::getValue('ETS_MP_SELLER_CAN_CHANGE_ORDER_STATUS');
        $ETS_MP_SELLER_ALLOWED_STATUSES = Tools::getValue('ETS_MP_SELLER_ALLOWED_STATUSES');
        if($ETS_MP_SELLER_CAN_CHANGE_ORDER_STATUS)
        {
            if(!$ETS_MP_SELLER_ALLOWED_STATUSES)
                $this->module->_errors[] = $this->module->l('"Select order status that seller can update" is required', 'AdminMarketPlaceSettingsGeneral');
            elseif(!Ets_marketplace::validateArray($ETS_MP_SELLER_ALLOWED_STATUSES))
                $this->module->_errors[] = $this->module->l('"Select order status that seller can update" is not valid', 'AdminMarketPlaceSettingsGeneral');
        }
        $ETS_MP_SELLER_PRODUCT_TYPE_SUBMIT = Tools::getValue('ETS_MP_SELLER_PRODUCT_TYPE_SUBMIT');
        if(!$ETS_MP_SELLER_PRODUCT_TYPE_SUBMIT)
            $this->module->_errors[] = $this->module->l('Type of product is required.', 'AdminMarketPlaceSettingsGeneral');
        elseif(!Ets_marketplace::validateArray($ETS_MP_SELLER_PRODUCT_TYPE_SUBMIT))
            $this->module->_errors[] = $this->module->l('Type of product is not valid.', 'AdminMarketPlaceSettingsGeneral');
        $ETS_MP_ENABLE_CAPTCHA = (int)Tools::getValue('ETS_MP_ENABLE_CAPTCHA');
        if($ETS_MP_ENABLE_CAPTCHA)
        {
            $ETS_MP_ENABLE_CAPTCHA_FOR = Tools::getValue('ETS_MP_ENABLE_CAPTCHA_FOR');
            if(!$ETS_MP_ENABLE_CAPTCHA_FOR)
                $this->module->_errors[] = $this->module->l('"Enable captcha for" is required', 'AdminMarketPlaceSettingsGeneral');
            elseif(!Ets_marketplace::validateArray($ETS_MP_ENABLE_CAPTCHA_FOR))
                $this->module->_errors[] = $this->module->l('"Enable captcha for" is not valid', 'AdminMarketPlaceSettingsGeneral');
            $ETS_MP_ENABLE_CAPTCHA_TYPE = (string)Tools::getValue('ETS_MP_ENABLE_CAPTCHA_TYPE');
            if($ETS_MP_ENABLE_CAPTCHA_TYPE=='google_v2')
            {
                $ETS_MP_ENABLE_CAPTCHA_SITE_KEY2 = Tools::getValue('ETS_MP_ENABLE_CAPTCHA_SITE_KEY2');
                if(!$ETS_MP_ENABLE_CAPTCHA_SITE_KEY2)
                    $this->module->_errors[] = $this->module->l('Site key is required', 'AdminMarketPlaceSettingsGeneral');
                elseif(!Validate::isCleanHtml($ETS_MP_ENABLE_CAPTCHA_SITE_KEY2))
                    $this->module->_errors[] = $this->module->l('Site key is not valid', 'AdminMarketPlaceSettingsGeneral');
                $ETS_MP_ENABLE_CAPTCHA_SECRET_KEY2 = Tools::getValue('ETS_MP_ENABLE_CAPTCHA_SECRET_KEY2');
                if(!$ETS_MP_ENABLE_CAPTCHA_SECRET_KEY2)
                    $this->module->_errors[] = $this->module->l('Secret key is required', 'AdminMarketPlaceSettingsGeneral');
                elseif(!Validate::isCleanHtml($ETS_MP_ENABLE_CAPTCHA_SECRET_KEY2))
                    $this->module->_errors[] = $this->module->l('Secret key is not valid', 'AdminMarketPlaceSettingsGeneral');
            }
            elseif($ETS_MP_ENABLE_CAPTCHA_TYPE=='google_v3')
            {
                $ETS_MP_ENABLE_CAPTCHA_SITE_KEY3 = Tools::getValue('ETS_MP_ENABLE_CAPTCHA_SITE_KEY3');
                if(!$ETS_MP_ENABLE_CAPTCHA_SITE_KEY3)
                    $this->module->_errors[] = $this->module->l('Site key is required', 'AdminMarketPlaceSettingsGeneral');
                elseif(!Validate::isCleanHtml($ETS_MP_ENABLE_CAPTCHA_SITE_KEY3))
                    $this->module->_errors[] = $this->module->l('Site key is not valid', 'AdminMarketPlaceSettingsGeneral');
                $ETS_MP_ENABLE_CAPTCHA_SECRET_KEY3 = Tools::getValue('ETS_MP_ENABLE_CAPTCHA_SECRET_KEY3');
                if(!$ETS_MP_ENABLE_CAPTCHA_SECRET_KEY3)
                    $this->module->_errors[] = $this->module->l('Secret key is required', 'AdminMarketPlaceSettingsGeneral');
                elseif(!Validate::isCleanHtml($ETS_MP_ENABLE_CAPTCHA_SECRET_KEY3))
                    $this->module->_errors[] = $this->module->l('Secret key is not valid', 'AdminMarketPlaceSettingsGeneral');
            }
            else
                $this->module->_errors[] = $this->module->l('Captcha is not valid', 'AdminMarketPlaceSettingsGeneral');
        }
        $ETS_MP_ENABLE_MAP = (int)Tools::getValue('ETS_MP_ENABLE_MAP');
        $ETS_MP_SEARCH_ADDRESS_BY_GOOGLE = (int)Tools::getValue('ETS_MP_SEARCH_ADDRESS_BY_GOOGLE');
        $ETS_MP_GOOGLE_MAP_API = Tools::getValue('ETS_MP_GOOGLE_MAP_API');
        if($ETS_MP_ENABLE_MAP && $ETS_MP_SEARCH_ADDRESS_BY_GOOGLE)
        {
            if(!$ETS_MP_GOOGLE_MAP_API)
                $this->module->_errors[] = $this->module->l('Google map API key is required', 'AdminMarketPlaceSettingsGeneral');
            elseif(!Validate::isCleanHtml($ETS_MP_GOOGLE_MAP_API))
                $this->module->_errors[] = $this->module->l('Google map API key is not valid', 'AdminMarketPlaceSettingsGeneral');
        }
        $ETS_MP_EDIT_PRODUCT_APPROVE_REQUIRED = (int)Tools::getValue('ETS_MP_EDIT_PRODUCT_APPROVE_REQUIRED');
        $ETS_MP_SELLER_PRODUCT_APPROVE_REQUIRED = (int)Tools::getValue('ETS_MP_SELLER_PRODUCT_APPROVE_REQUIRED');
        $ETS_MP_FIELD_PRODUCT_APPROVE_REQUIRED = Tools::getValue('ETS_MP_FIELD_PRODUCT_APPROVE_REQUIRED',array());
        if($ETS_MP_FIELD_PRODUCT_APPROVE_REQUIRED && !Ets_marketplace::validateArray($ETS_MP_FIELD_PRODUCT_APPROVE_REQUIRED))
            $this->module->_errors[] = $this->module->l('"Seller needs admin\'s approval to edit these product information fields" is not valid', 'AdminMarketPlaceSettingsGeneral');
        if($ETS_MP_EDIT_PRODUCT_APPROVE_REQUIRED && $ETS_MP_SELLER_PRODUCT_APPROVE_REQUIRED && !$ETS_MP_FIELD_PRODUCT_APPROVE_REQUIRED)
            $this->module->_errors[] = $this->module->l('"Sellers need admin\'s approval to edit these product information fields" is required', 'AdminMarketPlaceSettingsGeneral');
        if($settings = Ets_mp_defines::getInstance()->getFieldConfig('settings'))
        {
            foreach($settings as $config)
            {
                $name = $config['name'];
                if(isset($config['lang']) && $config['lang'])
                {
                    if((isset($config['validate']) && $config['validate'] && method_exists('Validate',$config['validate'])))
                    {
                        $validate = $config['validate'];
                        foreach($languages as $lang)
                        {
                            if(($value = trim(Tools::getValue($name.'_'.$lang['id_lang']))) && !Validate::$validate($value))
                                $this->module->_errors[] =  $config['label'].' '.$this->module->l('is not valid in ', 'AdminMarketPlaceSettingsGeneral').$lang['iso_code'];
                        }
                        unset($validate);
                    }
                }
                else
                {
                    if((isset($config['validate']) && $config['validate'] && method_exists('Validate',$config['validate'])))
                    {
                        $validate = $config['validate'];
                        $value = trim(Tools::getValue($name));
                        if($value && !Validate::$validate($value))
                            $this->module->_errors[] = $config['label'].' '. $this->module->l('is not valid', 'AdminMarketPlaceSettingsGeneral');
                        unset($validate);
                    }
                }

            }
        }
        $ETS_MP_APPLICABLE_CATEGORIES = (string)Tools::getValue('ETS_MP_APPLICABLE_CATEGORIES');
        $ETS_MP_SELLER_CATEGORIES = Tools::getValue('ETS_MP_SELLER_CATEGORIES');

        if($ETS_MP_APPLICABLE_CATEGORIES=='specific_product_categories' && (!$ETS_MP_SELLER_CATEGORIES || !is_array($ETS_MP_SELLER_CATEGORIES) || !Ets_marketplace::validateArray($ETS_MP_SELLER_CATEGORIES,'isInt') ))
            $this->module->_errors[] = $this->module->l('Categories are required', 'AdminMarketPlaceSettingsGeneral');
        if($ETS_MP_ENABLE_MAP && isset($_FILES['ETS_MP_GOOGLE_MAP_LOGO']['name']) && $_FILES['ETS_MP_GOOGLE_MAP_LOGO']['name'])
        {
            $this->module->validateFile($_FILES['ETS_MP_GOOGLE_MAP_LOGO']['name'],$_FILES['ETS_MP_GOOGLE_MAP_LOGO']['size'],$this->module->_errors,array('jpeg','jpg','png','gif'));
        }
        $ETS_MP_DISPLAY_FOLLOWED_SHOP = (int)Tools::getValue('ETS_MP_DISPLAY_FOLLOWED_SHOP');
        $ETS_MP_DISPLAY_NUMBER_SHOP = (int)Tools::getValue('ETS_MP_DISPLAY_NUMBER_SHOP');
        if($ETS_MP_DISPLAY_FOLLOWED_SHOP && !$ETS_MP_DISPLAY_NUMBER_SHOP)
            $this->module->_errors[] = $this->module->l('"Number of shops to display" is required', 'AdminMarketPlaceSettingsGeneral');
        $ETS_MP_DISPLAY_PRODUCT_FOLLOWED_SHOP = (int)Tools::getValue('ETS_MP_DISPLAY_PRODUCT_FOLLOWED_SHOP');
        $ETS_MP_DISPLAY_NUMBER_PRODUCT_FOLLOWED_SHOP = (int)Tools::getValue('ETS_MP_DISPLAY_NUMBER_PRODUCT_FOLLOWED_SHOP');
        if($ETS_MP_DISPLAY_PRODUCT_FOLLOWED_SHOP && !$ETS_MP_DISPLAY_NUMBER_PRODUCT_FOLLOWED_SHOP)
            $this->module->_errors[] = $this->module->l('"Number of followed products to display on homepage" is required', 'AdminMarketPlaceSettingsGeneral');
        $ETS_MP_DISPLAY_PRODUCT_TRENDING_SHOP = (int)Tools::getValue('ETS_MP_DISPLAY_PRODUCT_TRENDING_SHOP');
        if($ETS_MP_DISPLAY_PRODUCT_TRENDING_SHOP)
        {
            $ETS_MP_TRENDING_PERIOD_SHOP = (int)Tools::getValue('ETS_MP_TRENDING_PERIOD_SHOP');
            if(!$ETS_MP_TRENDING_PERIOD_SHOP)
                $this->module->_errors[] = $this->module->l('Trending period is required', 'AdminMarketPlaceSettingsGeneral');
            $ETS_MP_DISPLAY_NUMBER_PRODUCT_TRENDING_SHOP = (int)Tools::getValue('ETS_MP_DISPLAY_NUMBER_PRODUCT_TRENDING_SHOP');
            if(!$ETS_MP_DISPLAY_NUMBER_PRODUCT_TRENDING_SHOP)
                $this->module->_errors[] = $this->module->l('"Number of trending products to display" is required', 'AdminMarketPlaceSettingsGeneral');
        }
        $ETS_MP_DISPLAY_TOP_SHOP = (int)Tools::getValue('ETS_MP_DISPLAY_TOP_SHOP');
        $ETS_MP_SELLER_MAXIMUM_UPLOAD = trim(Tools::getValue('ETS_MP_SELLER_MAXIMUM_UPLOAD'));
        if($ETS_MP_SELLER_MAXIMUM_UPLOAD!='' && (int)$ETS_MP_SELLER_MAXIMUM_UPLOAD==0)
            $this->module->_errors[] = $this->module->l('"Maximum number of uploadable products" is not valid', 'AdminMarketPlaceSettingsGeneral');
        if($ETS_MP_DISPLAY_TOP_SHOP && !$this->module->_errors)
        {
            $ETS_MP_DISPLAY_NUMBER_TOP_SHOP = (int)Tools::getValue('ETS_MP_DISPLAY_NUMBER_TOP_SHOP');
            if(!$ETS_MP_DISPLAY_NUMBER_TOP_SHOP)
                $this->module->_errors[] = $this->module->l('Number of shops to display is required', 'AdminMarketPlaceSettingsGeneral');
        }
        $ETS_MP_DISPLAY_OTHER_PRODUCT = (int)Tools::getValue('ETS_MP_DISPLAY_OTHER_PRODUCT');
        if($ETS_MP_DISPLAY_OTHER_PRODUCT && !$this->module->_errors)
        {
            $ETS_MP_DISPLAY_NUMBER_OTHER_PRODUCT = (int)Tools::getValue('ETS_MP_DISPLAY_NUMBER_OTHER_PRODUCT');
            if(!$ETS_MP_DISPLAY_NUMBER_OTHER_PRODUCT)
                $this->module->_errors[] = $this->module->l('"Number of other products to display" is required', 'AdminMarketPlaceSettingsGeneral');
        }
        if($this->module->_errors)
            return false;
        else
            return true;
    }
    public function _saveFromSettings()
    {
        $languages = Language::getLanguages(false);
        $id_language_default = Configuration::get('PS_LANG_DEFAULT');
        if($settings = Ets_mp_defines::getInstance()->getFieldConfig('settings'))
        {
            foreach($settings as $config)
            {
                $config_value = Tools::getValue($config['name']);
                if($config['type']=='checkbox' || $config['type']=='categories'|| $config['type']=='tre_categories')
                {
                    if(!is_array($config_value))
                        $config_value = array();
                    Configuration::updateValue($config['name'],$config_value ? implode(',',$config_value) :'' );
                }
                else
                {
                    if(!Validate::isCleanHtml($config_value))
                        $config_value='';
                    if(isset($config['lang']) && $config['lang'])
                    {
                        $values = array();
                        $config_value_lang_default = Tools::getValue($config['name'].'_'.$id_language_default);
                        if(!Validate::isCleanHtml($config_value_lang_default))
                            $config_value_lang_default='';
                        foreach($languages as $language)
                        {
                            $config_value_lang = Tools::getValue($config['name'].'_'.$language['id_lang']);
                            if(!Validate::isCleanHtml($config_value_lang))
                                $config_value_lang='';
                            $values[$language['id_lang']] = $config_value_lang ? $config_value_lang : $config_value_lang_default;
                        }
                        Configuration::updateValue($config['name'],$values,true);
                    }
                    elseif($config['type']=='file')
                    {
                        if(isset($_FILES[$config['name']]['name']) && isset($_FILES[$config['name']]['name']) && isset($_FILES[$config['name']]['tmp_name']) && $_FILES[$config['name']]['tmp_name'])
                        {
                            $type = Tools::strtolower(Tools::substr(strrchr($_FILES[$config['name']]['name'], '.'), 1));
                            $file_name = Tools::passwdGen(12).'.'.$type;
                            $temp_name = tempnam(_PS_TMP_IMG_DIR_, 'PS');
                            if (!$temp_name || !move_uploaded_file($_FILES[$config['name']]['tmp_name'], $temp_name))
                                $this->module->_errors[] = $this->module->l('Unable to upload file', 'AdminMarketPlaceSettingsGeneral');
                            elseif (!ImageManager::resize($temp_name,dirname(__FILE__).'/../../views/img/'.$file_name, 30,30, $type))
                                $this->module->_errors[] = $this->module->l('An error occurred during the image upload process.', 'AdminMarketPlaceSettingsGeneral');
                            else
                            {
                                $file_old = Configuration::get($config['name']);
                                Configuration::updateValue($config['name'],$file_name);
                                if($file_old && file_exists(dirname(__FILE__).'/../../views/img/'.$file_old))
                                    @unlink(dirname(__FILE__).'/../../views/img/'.$file_old);
                            }
                        }
                    }
                    else
                    {
                        Configuration::updateValue($config['name'],$config_value,true);
                    }
                }

            }
            $ETS_MP_CONTACT_FIELDS_VALIDATE = Tools::getValue('ETS_MP_CONTACT_FIELDS_VALIDATE',array());
            if(!is_array($ETS_MP_CONTACT_FIELDS_VALIDATE) || !Ets_marketplace::validateArray($ETS_MP_CONTACT_FIELDS_VALIDATE))
                $ETS_MP_CONTACT_FIELDS_VALIDATE=array();
            $ETS_MP_REGISTRATION_FIELDS_VALIDATE = Tools::getValue('ETS_MP_REGISTRATION_FIELDS_VALIDATE',array());
            if(!is_array($ETS_MP_REGISTRATION_FIELDS_VALIDATE) || !Ets_marketplace::validateArray($ETS_MP_REGISTRATION_FIELDS_VALIDATE))
                $ETS_MP_REGISTRATION_FIELDS_VALIDATE = array();
            Configuration::updateValue('ETS_MP_REGISTRATION_FIELDS_VALIDATE',implode(',',array_map('pSQL',$ETS_MP_REGISTRATION_FIELDS_VALIDATE)));
            Configuration::updateValue('ETS_MP_CONTACT_FIELDS_VALIDATE',implode(',',array_map('pSQL',$ETS_MP_CONTACT_FIELDS_VALIDATE)));
            if(!$this->module->_errors)
            {
                $this->context->cookie->__set('success_message', $this->module->l('Updated successfully', 'AdminMarketPlaceSettingsGeneral'));
                $this->module->_clearCache('*',$this->module->_getCacheId('trendings',false));
                $this->module->_clearCache('*',$this->module->_getCacheId('product_seller_follow',false));
                $this->module->_clearCache('*',$this->module->_getCacheId('seller_follow',false));
                $this->module->_clearCache('*',$this->module->_getCacheId('products_other',false));
                $this->module->_clearCache('*',$this->module->_getCacheId('products_seller_other',false));
            }
        }
    }
}
