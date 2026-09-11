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
 * Class AdminMarketPlaceEmailSettingsController
 * @property \Ets_marketplace $module
 */
class AdminMarketPlaceEmailSettingsController extends ModuleAdminController
{
    public $_errors = [];
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
    public function _checkFormBeforeSubmit()
    {
        $languages = Language::getLanguages(false);
        if($settings = Ets_mp_defines::getInstance()->getFieldConfig('email_settings'))
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
                                $this->module->_errors[] =  $config['label'].' '.$this->module->l('is not valid in ', 'AdminMarketPlaceEmailSettingsController').$lang['iso_code'];
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
                            $this->module->_errors[] = $config['label'].' '. $this->module->l('is not valid', 'AdminMarketPlaceEmailSettingsController');
                        unset($validate);
                    }
                }

            }
        }
        $emails = Tools::getValue('ETS_MP_EMAIL_ADMIN_NOTIFICATION');
        if($emails)
        {
            $emails = array_map('trim',explode(',',$emails));
            foreach($emails as $email)
            {
                if(!trim($email) || !Validate::isEmail($email))
                {
                    $this->module->_errors[] = $this->module->l('Email addresses to receive notifications are not valid', 'AdminMarketPlaceEmailSettingsController');
                    break;
                }
            }
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
        if($settings = Ets_mp_defines::getInstance()->getFieldConfig('email_settings'))
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
                                $this->_errors[] = $this->module->l('Unable to upload file', 'AdminMarketPlaceEmailSettingsController');
                            elseif (!ImageManager::resize($temp_name,dirname(__FILE__).'/views/img/'.$file_name, 30,30, $type))
                                $this->_errors[] = $this->module->l('An error occurred during the image upload process.', 'AdminMarketPlaceEmailSettingsController');
                            else
                            {
                                $file_old = Configuration::get($config['name']);
                                Configuration::updateValue($config['name'],$file_name);
                                if($file_old && file_exists(dirname(__FILE__).'/views/img/'.$file_old))
                                    @unlink(dirname(__FILE__).'/views/img/'.$file_old);
                            }
                        }
                    }
                    else
                    {
                        Configuration::updateValue($config['name'],$config_value,true);
                    }
                }

            }
            if(!$this->module->_errors)
                $this->context->cookie->__set('success_message', $this->module->l('Updated successfully', 'AdminMarketPlaceEmailSettingsController'));
        }
    }
    public function renderList()
    {
        $this->module->getContent();
        $this->context->smarty->assign(
            array(
                'ets_mp_body_html'=> $this->renderMailSettings(),
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
    public function renderMailSettings()
    {
        $languages = Language::getLanguages(false);
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->module->l('Email settings', 'AdminMarketPlaceEmailSettingsController'),
                    'icon' => 'icon-settings'
                ),
                'input' => array(),
                'submit' => array(
                    'title' => $this->module->l('Save', 'AdminMarketPlaceEmailSettingsController'),
                )
            ),
        );
        $configs = Ets_mp_defines::getInstance()->getFieldConfig('email_settings');
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
        }
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
        $helper->currentIndex = $this->context->link->getAdminLink('AdminMarketPlaceEmailSettings', false);
        $helper->token = Tools::getAdminTokenLite('AdminMarketPlaceEmailSettings');
        $language = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->tpl_vars = array(
            'base_url' => $this->context->shop->getBaseURL(),
            'language' => array(
                'id_lang' => $language->id,
                'iso_code' => $language->iso_code
            ),
            'fields_value' => $fields,
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
            'isConfigForm' => true,
            'link_base' => $this->module->getBaseLink(),
        );
        return $helper->generateForm(array($fields_form));
    }
}
