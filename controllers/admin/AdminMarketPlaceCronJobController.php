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
 * Class AdminMarketPlaceCronJobController
 * @property \Ets_marketplace $module
 */
class AdminMarketPlaceCronJobController extends ModuleAdminController
{
    public function __construct()
    {
       parent::__construct();
       $this->context= Ets_marketplace::getContextStatic();
       $this->bootstrap = true;
    }
    public function init()
    {
        parent::init();
        if(Tools::isSubmit('submitCronjob'))
            $this->module->_runCronJob();
    }
    public function postProcess()
    {
        parent::postProcess();
        if(Tools::isSubmit('ETS_MP_SAVE_CRONJOB_LOG'))
        {
            $ETS_MP_SAVE_CRONJOB_LOG = (int)Tools::getValue('ETS_MP_SAVE_CRONJOB_LOG') ? 1 :0;
            Configuration::updateGlobalValue('ETS_MP_SAVE_CRONJOB_LOG',$ETS_MP_SAVE_CRONJOB_LOG);
            die(
                json_encode(
                    array(
                        'success' => $this->module->l('Updated successfully', 'AdminMarketPlaceCronJobController'),
                    )
                )
            );
        }
        if(Tools::isSubmit('etsmpSubmitClearLog'))
        {
            if(file_exists(_PS_ETS_MARKETPLACE_LOG_DIR_.'ets_merketplace.log'))
                @unlink(_PS_ETS_MARKETPLACE_LOG_DIR_.'ets_merketplace.log');
            die(
                json_encode(
                    array(
                        'success' => $this->module->l('Clear log successfully', 'AdminMarketPlaceCronJobController'),
                    )
                )
            );
        }
        if(Tools::isSubmit('submitCronjobSettings'))
        {
            $token = trim(Tools::getValue('ETS_MP_CRONJOB_TOKEN'));
            $ETS_MP_CRONJOB_EMAILS = trim(Tools::getValue('ETS_MP_CRONJOB_EMAILS'));
            $ETS_MP_CRONJOB_MAX_TRY = trim(Tools::getValue('ETS_MP_CRONJOB_MAX_TRY'));
            $ETS_MP_ENABLED_LOG_MAIL = (int)Tools::getValue('ETS_MP_ENABLED_LOG_MAIL') ? 1:0;
            if(!$token)
                $this->module->_errors[] = $this->module->l('Cronjob secure token is required', 'AdminMarketPlaceCronJobController');
            elseif(!Validate::isCleanHtml($token))
                $this->module->_errors[] = $this->module->l('Cronjob secure token is not valid', 'AdminMarketPlaceCronJobController');
            if($ETS_MP_CRONJOB_EMAILS=='')
                $this->module->_errors[] = $this->module->l('Mail queue step is required', 'AdminMarketPlaceCronJobController');
            elseif(!Validate::isUnsignedInt($ETS_MP_CRONJOB_EMAILS) || $ETS_MP_CRONJOB_EMAILS==0)
                $this->module->_errors[] = $this->module->l('Mail queue step is not valid', 'AdminMarketPlaceCronJobController');
            if($ETS_MP_CRONJOB_MAX_TRY=='')
                $this->module->_errors[] = $this->module->l('Mail queue max-trying times is required', 'AdminMarketPlaceCronJobController');
            elseif(!Validate::isUnsignedInt($ETS_MP_CRONJOB_MAX_TRY) || $ETS_MP_CRONJOB_MAX_TRY==0)
                $this->module->_errors[] = $this->module->l('Mail queue max-trying times is not valid', 'AdminMarketPlaceCronJobController');
            if(!$this->module->_errors)
            {
                Configuration::updateGlobalValue('ETS_MP_CRONJOB_TOKEN',$token);
                Configuration::updateGlobalValue('ETS_MP_CRONJOB_EMAILS',$ETS_MP_CRONJOB_EMAILS);
                Configuration::updateGlobalValue('ETS_MP_CRONJOB_MAX_TRY',$ETS_MP_CRONJOB_MAX_TRY);
                Configuration::updateGlobalValue('ETS_MP_ENABLED_LOG_MAIL',$ETS_MP_ENABLED_LOG_MAIL);
                $this->context->cookie->__set('success_message',$this->module->l('Updated successfully', 'AdminMarketPlaceCronJobController'));
                Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceCronJob'));
            }
        }
    }
    public function renderList()
    {
        $this->module->getContent();
        $this->context->smarty->assign(
            array(
                'ets_mp_body_html'=> $this->_renderCronjob(),
            )
        );
        $html ='';
        if($this->context->cookie->__get('success_message'))
        {
            $html .= $this->module->displayConfirmation($this->context->cookie->__get('success_message'));
            $this->context->cookie->__set('success_message','');
        }
        if($this->module->_errors)
            $html .= $this->module->displayError($this->module->_errors);
        return $html.$this->module->display(_PS_MODULE_DIR_.$this->module->name.DIRECTORY_SEPARATOR.$this->module->name.'.php', 'admin.tpl');
    }
    public function _renderCronjob()
    {
        if(!Configuration::getGlobalValue('ETS_MP_CRONJOB_TOKEN'))
            Configuration::updateGlobalValue('ETS_MP_CRONJOB_TOKEN',Tools::passwdGen(12));
        $cronjob_last= '';
        $run_cronjob = false;
        if($cronjob_time = Configuration::getGlobalValue('ETS_MP_TIME_LOG_CRONJOB'))
        {
            $last_time = strtotime($cronjob_time);
            $time = strtotime(date('Y-m-d H:i:s'))-$last_time;
            if($time <= 43200 && $time)
                $run_cronjob = true;
            else
                $run_cronjob = false;
            if($time > 86400)
                $cronjob_last = Tools::displayDate($cronjob_time,true);
            elseif($time)
            {
                if($hours =floor($time/3600))
                {
                    $cronjob_last .= $hours.' '.$this->module->l('hours', 'AdminMarketPlaceCronJobController').' ';
                    $time = $time%3600;
                }
                if($minutes = floor($time/60))
                {
                    $cronjob_last .= $minutes.' '.$this->module->l('minutes', 'AdminMarketPlaceCronJobController').' ';
                    $time = $time%60;
                }
                if($time)
                    $cronjob_last .= $time.' '.$this->module->l('seconds', 'AdminMarketPlaceCronJobController').' ';
                $cronjob_last .= $this->module->l('ago', 'AdminMarketPlaceCronJobController');
            }    
        }
        $ETS_MP_CRONJOB_TOKEN = Tools::getValue('ETS_MP_CRONJOB_TOKEN',Configuration::getGlobalValue('ETS_MP_CRONJOB_TOKEN'));
        $this->context->smarty->assign(
            array(
                'dir_cronjob' => _PS_MODULE_DIR_.'ets_marketplace/cronjob.php',
                'link_conjob' => $this->module->getBaseLink().'/modules/'.$this->module->name.'/cronjob.php',
                'ETS_MP_CRONJOB_TOKEN' => $ETS_MP_CRONJOB_TOKEN,
                'ETS_MP_CRONJOB_EMAILS' => (int)Tools::getValue('ETS_MP_CRONJOB_EMAILS',Configuration::getGlobalValue('ETS_MP_CRONJOB_EMAILS')),
                'ETS_MP_CRONJOB_MAX_TRY' => (int)Tools::getValue('ETS_MP_CRONJOB_MAX_TRY',Configuration::getGlobalValue('ETS_MP_CRONJOB_MAX_TRY')),
                'ETS_MP_ENABLED_LOG_MAIL' => (int)Tools::getValue('ETS_MP_ENABLED_LOG_MAIL',Configuration::getGlobalValue('ETS_MP_ENABLED_LOG_MAIL')),
                'cronjob_log' => file_exists(_PS_ETS_MARKETPLACE_LOG_DIR_.'ets_merketplace.log') ? Tools::file_get_contents(_PS_ETS_MARKETPLACE_LOG_DIR_.'ets_merketplace.log'):'',
                'ETS_MP_SAVE_CRONJOB_LOG' => Configuration::getGlobalValue('ETS_MP_SAVE_CRONJOB_LOG'),
                'run_cronjob' => $run_cronjob,
                'php_path' => (defined('PHP_BINDIR')? PHP_BINDIR.'/' : '').'php ',
                'cronjob_last' => $cronjob_last,
            )
        );
        return $this->context->smarty->fetch(_PS_MODULE_DIR_.$this->module->name.'/views/templates/hook/cronjob.tpl');
    }
}
