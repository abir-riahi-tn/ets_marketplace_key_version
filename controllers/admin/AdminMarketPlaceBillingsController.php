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
 * Class AdminMarketPlaceBillingsController
 * @property \Ets_marketplace $module
 */
class AdminMarketPlaceBillingsController extends ModuleAdminController
{
    public function init()
    {
       parent::init();
       $this->bootstrap = true;
       if(Tools::isSubmit('dowloadpdf') && ($id_billing = Tools::getValue('id_ets_mp_seller_billing')) && Validate::isUnsignedId($id_billing))
       {
            $billing = new Ets_mp_billing($id_billing);
            if(Validate::isLoadedObject($billing))
            {
                $pdf = new PDF($billing,'BillingPdf', Ets_marketplace::getContextStatic()->smarty);
                $pdf->render(true);
            }
            else
                $this->module->_errors[] = $this->module->l('Billing is not valid', 'AdminMarketPlaceBillingsController');
       }
       if(Tools::isSubmit('saveBilling'))
       {
            $date_to = Tools::getValue('date_to');
            $date_from = Tools::getValue('date_from');
            if(!($id_seller =Tools::getValue('id_seller')))
            {
                $this->module->_errors[] = $this->module->l('Seller is required', 'AdminMarketPlaceBillingsController');
            }
            elseif(!Validate::isUnsignedId($id_seller) || !Validate::isLoadedObject(Ets_mp_seller::_getSellerByIdCustomer($id_seller)))
                $this->module->_errors[] = $this->module->l('Seller is not valid', 'AdminMarketPlaceBillingsController');
            if(!($amount = Tools::getValue('amount')))
                $this->module->_errors[] = $this->module->l('Amount is required', 'AdminMarketPlaceBillingsController');
            elseif(!Validate::isPrice($amount))
                $this->module->_errors[] = $this->module->l('Amount is not valid', 'AdminMarketPlaceBillingsController');
            if(($note=Tools::getValue('note')) && !Validate::isCleanHtml($note))
                $this->module->_errors[] = $this->module->l('Description is not valid', 'AdminMarketPlaceBillingsController');
            if($date_from && !Validate::isDate($date_from))
                $this->module->_errors[] = $this->module->l('"From" date is not valid', 'AdminMarketPlaceBillingsController');
            if($date_to && !Validate::isDate($date_to))
                $this->module->_errors[] = $this->module->l('"To" date is not valid', 'AdminMarketPlaceBillingsController');
            if($date_to && $date_from && Validate::isDate($date_to) && Validate::isDate($date_from) && strtotime($date_from) > strtotime($date_to))
                $this->module->_errors[] = $this->module->l('"From" date must be smaller than "To" date', 'AdminMarketPlaceBillingsController'); 
            $active = (int)Tools::getValue('active') ? 1:0;
            if(!$this->module->_errors)
            {
                $billing = new Ets_mp_billing();
                $billing->id_customer = (int)$id_seller;
                $billing->amount = (float)$amount;
                $billing->amount_tax = (float)$amount;
                $billing->note = $note;
                $billing->date_from = $date_from;
                $billing->date_to = $date_to;
                $billing->active= (int)$active;
                $billing->id_employee = $this->context->employee->id;
                $billing->used=1;
                if($billing->add())
                {
                    $this->context->cookie->__set('success_message', $this->module->l('Added successfully', 'AdminMarketPlaceBillingsController'));
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceBillings'));
                }
                else
                    $this->module->_errors[] = $this->module->l('An error occurred while saving the billing', 'AdminMarketPlaceBillingsController');
            }
       }
    }
    public function initContent()
    {
        parent::initContent();
        if(Tools::isSubmit('search_seller'))
        {
            if(($query = Tools::getValue('q')) && Validate::isCleanHtml($query))
            {

                $sellers = Ets_mp_seller::getSellerByQuery($query,false);
                if($sellers)
                {
                    foreach($sellers as $seller)
                    {
                        echo $seller['id_customer'].'|'.$seller['seller_name'].'|'.$seller['email']."\n";
                    }
                }
            }
            die();            
        }
    }
    public function renderList()
    {
        $this->module->getContent();
        if(Tools::isSubmit('addnewbillng'))
        {
            $this->context->smarty->assign(
                array(
                    'ets_mp_body_html'=> $this->renderFromBilling(),
                    'ets_link_search_seller' => $this->context->link->getAdminLink('AdminMarketPlaceBillings').'&search_seller=1',
                )
            );
        }
        else
        {
            $this->context->smarty->assign(
                array(
                    'ets_mp_body_html'=> $this->module->renderBilling(),
                )
            );
        }
        
        $html ='';
        if($this->context->cookie->__get('success_message'))
        {
            $html .= $this->module->displayConfirmation($this->context->cookie->__get('success_message'));
            $this->context->cookie->__set('success_message', '');
        }
        if($this->module->_errors){
            $output = '';
            foreach ($this->module->_errors as $msg) {
                $output .= $msg . '<'.'br/'.'>';
            }
            $html = Ets_mp_defines::displayText('<'.'svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/'.'>'.'<'.'/svg'.'>'.$output,'div','alert alert-error');
        }
        return $html.$this->module->display($this->module->getLocalPath(), 'admin.tpl');
    }
    public function renderFromBilling()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->module->l('Add membership', 'AdminMarketPlaceBillingsController'),
                    'icon' =>'icon-billing',
                ),
                'input' => array(
                    array(
                        'type'=>'hidden',
                        'name' => 'id_seller',
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Seller name', 'AdminMarketPlaceBillingsController'),
                        'name' => 'seller_name',
                        'search'=> true,
                        'required' => true,
                        'suffix' => Ets_mp_defines::displayText('','i','fa fa-search'),
                        'col'=>8,
                        'form_group_class' => 'form_search_seller',
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Amount', 'AdminMarketPlaceBillingsController'),
                        'name' => 'amount',
                        'suffix' => $this->context->currency->iso_code,
                        'col'=>8,
                        'required' => true,
                        'form_group_class' => 'form_amount',
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->module->l('Status', 'AdminMarketPlaceBillingsController'),
                        'name' => 'active',
                        'col'=>8,
                        'form_group_class' => 'form_status',
                        'options' => array(
                            'query' => array(
                                array(
                                    'id_option'=>0,
                                    'name'=>$this->module->l('Pending', 'AdminMarketPlaceBillingsController'),
                                ),
                                array(
                                    'id_option'=>1,
                                    'name'=>$this->module->l('Paid', 'AdminMarketPlaceBillingsController'),
                                ),
                            ),
                            'id' => 'id_option',
                            'name' => 'name'
                        ),
                    ),
                    array(
                        'type' => 'date',
                        'label' => $this->module->l('Available from', 'AdminMarketPlaceBillingsController'),
                        'name' => 'date_from',
                        'form_group_class' => 'form_available_from',
                        'col'=>8
                    ),
                    array(
                        'type' => 'date',
                        'label' => $this->module->l('Available to', 'AdminMarketPlaceBillingsController'),
                        'name' => 'date_to',
                        'form_group_class' => 'form_available_to',
                        'col'=>8
                    ),
                    array(
                        'type' =>'textarea',
                        'label' => $this->module->l('Description', 'AdminMarketPlaceBillingsController'),
                        'name' => 'note',
                        'form_group_class' => 'form_description',
                        'col'=>8
                    ),
                ),
                'submit' => array(
                    'title' => $this->module->l('Save', 'AdminMarketPlaceBillingsController'),
                ),
                'buttons' => array(
                    array(
                        'href' =>Tools::isSubmit('viewseller') ? $this->context->link->getAdminLink('AdminMarketPlaceSellers'): $this->context->link->getAdminLink('AdminMarketPlaceBillings', true),
                        'icon'=>'process-icon-cancel',
                        'title' => $this->module->l('Cancel', 'AdminMarketPlaceBillingsController'),
                    )
                ),
            ),
        );
        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = 'ets_mp_seller_billing';
        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $this->fields_form = array();
        $helper->module = $this->module;
        $helper->identifier = 'id_ets_mp_seller_billing';
        $helper->submit_action = 'saveBilling';
        $helper->currentIndex = Tools::isSubmit('viewseller') ? $this->context->link->getAdminLink('AdminMarketPlaceSellers',false).'&addnewbillng=1': $this->context->link->getAdminLink('AdminMarketPlaceBillings', false).'&addnewbillng=1';
        $helper->token = Tools::isSubmit('viewseller') ? Tools::getAdminTokenLite('AdminMarketPlaceSellers'): Tools::getAdminTokenLite('AdminMarketPlaceBillings');
        $language = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->tpl_vars = array(
            'base_url' => $this->context->shop->getBaseURL(),
            'language' => array(
                'id_lang' => $language->id,
                'iso_code' => $language->iso_code
            ),

            'PS_ALLOW_ACCENTED_CHARS_URL', (int)Configuration::get('PS_ALLOW_ACCENTED_CHARS_URL'),
            'fields_value' => $this->getBillingFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
            'image_baseurl' => '',
            'link' => $this->context->link,
            'cancel_url' => $this->context->link->getAdminLink('AdminMarketPlaceSellers', true),
        );
        return $helper->generateForm(array($fields_form));
    }
    public function getBillingFieldsValues()
    {
        if(($id_customer= (int)Tools::getValue('id_seller')) && Validate::isUnsignedId($id_customer))
            $seller = Ets_mp_seller::_getSellerByIdCustomer($id_customer);
        else
            $seller = new Ets_mp_seller();
        $fields = array(
            'id_seller' =>$seller->id_customer,
            'seller_name' => $seller->id ? $seller->seller_name.' ('.$seller->seller_email.')':'',
            'amount'=> Tools::getValue('amount'),
            'active' => Tools::getValue('active'),
            'date_from'=> Tools::getValue('date_from'),
            'date_to' => Tools::getValue('date_to'),
            'note' => Tools::getValue('note'),
        );
        return $fields;
    }
}
