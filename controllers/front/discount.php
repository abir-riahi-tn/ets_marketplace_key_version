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
 * Class Ets_MarketPlaceDiscountModuleFrontController
 * @property \Ets_mp_seller $seller;
 * @property \Ets_marketplace $module;
 */
class Ets_MarketPlaceDiscountModuleFrontController extends ModuleFrontController
{
    public $seller;
    public $_errors = array();
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
        if(!$this->context->customer->isLogged() || !($this->seller = $this->module->_getSeller(true)) )
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        if(!$this->module->_checkPermissionPage($this->seller))
            die($this->module->l('You do not have permission to access this page','discount'));
        if(!Configuration::get('ETS_MP_SELLER_CAN_CREATE_VOUCHER'))
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        $id_cart_rule = (int)Tools::getValue('id_cart_rule');
        if($id_cart_rule && Validate::isUnsignedId($id_cart_rule) && !Tools::isSubmit('ets_mp_submit_mp_discount'))
        {
            if(!$this->seller->checkHasCartRule($id_cart_rule))
                Tools::redirect($this->context->link->getModuleLink($this->module->name,'discount',array('list'=>true)));
        }
        if(Tools::isSubmit('del') && $id_cart_rule && Validate::isUnsignedId($id_cart_rule))
        {
            $cartRule = new CartRule($id_cart_rule);
            if(!Validate::isLoadedObject($cartRule) && !$this->seller->checkHasCartRule($id_cart_rule))
                $this->_errors[] = $this->module->l('Discount is not valid','discount');
            elseif($cartRule->delete())
            {
                $this->context->cookie->__set('success_message', $this->module->l('Updated successfully','discount'));
                Tools::redirect($this->context->link->getModuleLink($this->module->name,'discount',array('list'=>true)));
            }
            else
                $this->_errors[] = $this->module->l('An error occurred while deleting the discount','discount');
        }
        if(Tools::isSubmit('submitSaveCartRule'))
        {
            $languages = Language::getLanguages(false);
            $id_lang_default = Configuration::get('PS_LANG_DEFAULT');
            $name_default = Tools::getValue('name_'.$id_lang_default);
            if(!$name_default)
                $this->_errors[] = $this->module->l('Name is required','discount');
            foreach($languages as $language)
            {
                if(($name= Tools::getValue('name_'.$id_lang_default)) && !Validate::isCleanHtml($name))
                    $this->_errors[] = $this->module->l('Name is not valid in','discount').' '.$language['iso_code'];
            }
            if(!($reduction_product = Tools::getValue('reduction_product')))
                $this->_errors[] = $this->module->l('Product is required','discount');
            elseif(!Validate::isInt((int)$reduction_product))
                $this->_errors[] = $this->module->l('Product is not valid','discount');
            elseif(($product = new Product($reduction_product)) && (!Validate::isLoadedObject($product) || !$this->seller->checkHasProduct($reduction_product)))
                $this->_errors[] = $this->module->l('Product is not valid','discount');
            if(!($date_from = Tools::getValue('date_from')))
                $this->_errors[]=$this->module->l('Available from is required','discount');
            elseif(!Validate::isDate($date_from))
                $this->_errors[] = $this->module->l('Available from is not valid','discount');
            if(!($date_to = Tools::getValue('date_to')))
                $this->_errors[]=$this->module->l('Available to is required','discount');
            elseif(!Validate::isDate($date_to))
                $this->_errors[] = $this->module->l('Available to is not valid','discount');
            if(!($code = Tools::getvalue('code')))
                $this->_errors[] = $this->module->l('Code is required','discount');
            elseif(!Validate::isCleanHtml($code))
                $this->_errors[] = $this->module->l('Code is not valid','discount');
            if(($decscription = Tools::getValue('description')) && !Validate::isCleanHtml($decscription))
                $this->_errors[] = $this->module->l('Description is not valid','discount');
            if(($highlight = Tools::getValue('highlight')) && !Validate::isInt((int)$highlight))
                $this->_errors[] = $this->module->l('Highlight is not valid','discount');
            if(($partial_use = Tools::getValue('partial_use')) && !Validate::isInt((int)$partial_use))
                $this->_errors[] = $this->module->l('Partial use is not valid','discount');
            if(($priority = Tools::getValue('priority')) && !Validate::isInt((int)$priority))
                $this->_errors[] = $this->module->l('Priority is not valid','discount');
            if(($active = Tools::getValue('active')) && !Validate::isInt((int)$active))
                $this->_errors[] = $this->module->l('Active is not valid','discount');
            if(($id_customer = Tools::getValue('id_customer')) && (!Validate::isUnsignedId($id_customer) || !Validate::isLoadedObject(new Customer($id_customer))))
                $this->_errors[] = $this->module->l('Customer is not valid','discount');
            if(($minimum_amount = Tools::getValue('minimum_amount')) && !Validate::isFloat($minimum_amount))
                $this->_errors[] = $this->module->l('Minimum amount is not valid','discount');
            if(($minimum_amount_tax = Tools::getValue('minimum_amount_tax')) && !Validate::isInt((int)$minimum_amount_tax))
                $this->_errors[] = $this->module->l('Minimum amount tax is not valid','discount');
            if(($minimum_amount_shipping = Tools::getValue('minimum_amount_shipping')) && !Validate::isInt((int)$minimum_amount_shipping))
                $this->_errors[] = $this->module->l('Minimum amount shipping is not valid','discount');
            if(($minimum_amount_currency = Tools::getValue('minimum_amount_currency')) && !Validate::isInt((int)$minimum_amount_currency))
                $this->_errors[] = $this->module->l('Minimum amount currency is not valid','discount');
            if(($quantity = Tools::getValue('quantity')) && !Validate::isInt((int)$quantity))
                $this->_errors[] = $this->module->l('Quantity is not valid','discount');
            if(($quantity_per_user = Tools::getValue('quantity_per_user')) && !Validate::isInt((int)$quantity_per_user))
                $this->_errors[] = $this->module->l('Quantity per user is not valid','discount');
            if(($free_shipping = Tools::getValue('free_shipping')) && !Validate::isBool($free_shipping))
                $this->_errors[] = $this->module->l('Free shipping is not valid','discount');
            $apply_discount = Tools::getValue('apply_discount');
            $reduction_percent = Tools::getValue('reduction_percent');
            $reduction_amount = Tools::getValue('reduction_amount');
            $reduction_tax = Tools::getValue('reduction_tax');
            $reduction_currency = Tools::getValue('reduction_currency');
            if($apply_discount=='percent')
            {
                if(!$reduction_percent)
                    $this->_errors[] = $this->module->l('Value is required','discount');
                elseif(!Validate::isFloat($reduction_percent))
                    $this->_errors[] = $this->module->l('Value is not valid','discount');
            }
            elseif($apply_discount=='amount')
            {
                if(!$reduction_amount)
                    $this->_errors[] = $this->module->l('Value is required','discount');
                elseif(!Validate::isFloat($reduction_amount))
                    $this->_errors[] = $this->module->l('Value is not valid', 'discount');
                if($reduction_currency && !Validate::isUnsignedId($reduction_currency))
                    $this->_errors[] = $this->module->l('Reduction currency is not valid','discount');
                if($reduction_tax && !Validate::isUnsignedId($reduction_tax))
                    $this->_errors[] = $this->module->l('Reduction tax is not valid','discount');
            }    
            $fields = CartRule::$definition['fields'];
            if($fields)
            {
                foreach($fields as $key=>$field)
                {
                    if(!isset($field['lang']) && isset($field['validate']) && ($validate = $field['validate']) && method_exists('Validate',$validate))
                    {
                        $field_value = Tools::getValue($key);
                        if(trim($field_value) && !Validate::$validate($field_value))
                            $this->_errors[] = Tools::ucfirst(str_replace('_',' ',$key)).' '.$this->module->l('is not valid','discount');
                    }
                }
            }
            foreach($languages as $language)
            {
                if(($name = trim(Tools::getValue('name_'.$language['id_lang']))) && !Validate::isCleanHtml($name))
                {
                    $this->_errors[] = $this->module->l('Name is not valid in','discount').' '. $language['iso_code'];
                }
            }
            if($code && CartRule::getIdByCode($code)!=$id_cart_rule)
                $this->_errors[] = $this->module->l('Code is exist','discount');
            if($id_cart_rule)
            {
                $cartRule = new CartRule($id_cart_rule);
                if(!Validate::isLoadedObject($cartRule) || !$this->seller->checkHasCartRule($id_cart_rule))
                    $this->_errors[] = $this->module->l('Discount is not valid','discount');
            }
            else
                $cartRule = new CartRule();
            if(!$this->_errors)
            {
                if($languages)
                {
                    foreach($languages as $language)
                    {
                        $name = Tools::getValue('name_'.$language['id_lang']);
                        $cartRule->name[$language['id_lang']] = $name ? :$name_default;
                    }
                }
                $cartRule->description = $decscription;
                $cartRule->code = $code;
                $cartRule->highlight = (bool)$highlight;
                $cartRule->partial_use = (bool)$partial_use;
                $cartRule->priority = (int)$priority;
                $cartRule->active = (bool)$active;
                $cartRule->id_customer = (int)$id_customer;
                $cartRule->date_from = $date_from ;
                $cartRule->date_to = $date_to;
                $cartRule->minimum_amount = (float)$minimum_amount;
                $cartRule->minimum_amount_tax = (bool)$minimum_amount_tax;
                $cartRule->minimum_amount_shipping = (bool)$minimum_amount_shipping;
                $cartRule->minimum_amount_currency = (bool)$minimum_amount_currency;
                $cartRule->quantity = (int)$quantity;
                $cartRule->quantity_per_user = (int)$quantity_per_user;
                $cartRule->free_shipping = (bool)$free_shipping;
                if($apply_discount=='percent')
                {
                    $cartRule->reduction_percent = (float)$reduction_percent;
                    $cartRule->reduction_amount =0;
                }
                elseif($apply_discount=='amount')
                {
                    $cartRule->reduction_percent=0;
                    $cartRule->reduction_amount = (float)$reduction_amount;
                    $cartRule->reduction_currency = (int)$reduction_currency;
                    $cartRule->reduction_tax = (bool)$reduction_tax;
                }
                else
                {
                    $cartRule->reduction_amount = 0;
                    $cartRule->reduction_percent = 0;
                }
                $cartRule->reduction_product= (int)$reduction_product;
                $cartRule->product_restriction=true;
                if(!$cartRule->id)
                {
                    if($cartRule->add(true,true))
                    {
                        Ets_mp_seller::afterAddRule($cartRule);
                        $this->seller->addCartRule($cartRule->id);
                        $this->context->cookie->__set('success_message', $this->module->l('Added successfully','discount'));
                    }
                    else
                        $this->_errors[] = $this->module->l('An error occurred while saving the discount','discount');
                }
                else
                {
                    if($cartRule->update(true))
                    {
                        Ets_mp_seller::afterAddRule($cartRule);
                        $this->context->cookie->__set('success_message', $this->module->l('Updated successfully','discount'));
                    }
                    else
                        $this->_errors[] = $this->module->l('An error occurred while saving the discount','discount');
                }
                if(!$this->_errors)
                    Tools::redirect($this->context->link->getModuleLink($this->module->name,'discount',array('list'=>true)));
                
            }
            
        }
        if(Tools::isSubmit('change_enabled') && ($id_cart_rule = Tools::getValue('id_cart_rule')) && Validate::isUnsignedId($id_cart_rule))
        {
            $cartRule = new CartRule($id_cart_rule);
            if(!Validate::isLoadedObject($cartRule) || !$this->seller->checkHasCartRule($id_cart_rule))
                die(
                    json_encode(
                        array(
                            'errors' => $this->module->l('Discount is not valid','discount'),
                        )
                    )
                );
            $change_enabled = (int)Tools::getValue('change_enabled');
            $cartRule->active = $change_enabled ? true:false;
            if($cartRule->update())
            {
                if($change_enabled)
                {
                    die(
                        json_encode(
                            array(
                                'href' => $this->context->link->getModuleLink($this->module->name,'discount',array('id_cart_rule'=> $id_cart_rule,'change_enabled'=>0,'field'=>'active')),
                                'title' => $this->module->l('Click to disable','discount'),
                                'success' => $this->module->l('Updated successfully','discount'),
                                'enabled' => 1,
                            )
                        )  
                    );
                }
                else
                {
                    die(
                        json_encode(
                            array(
                                'href' => $this->context->link->getModuleLink($this->module->name,'discount',array('id_cart_rule'=> $id_cart_rule,'change_enabled'=>1,'field'=>'active')),
                                'title' => $this->module->l('Click to enable','discount'),
                                'success' => $this->module->l('Updated successfully','discount'),
                                'enabled' => 0,
                            )
                        )  
                    );
                }
            }
            else
            {
                die(
                    json_encode(
                        array(
                            'errors' => $this->module->l('An error occurred while saving the discount','discount'),
                        )
                    )
                );
            }
            
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
            $this->setTemplate('module:'.$this->module->name.'/views/templates/front/discount.tpl');      
        else        
            $this->setTemplate('discount_16.tpl'); 
    }
    public function _initContent()
    {
        $id_cart_rule = (int)Tools::getValue('id_cart_rule');
        if(Tools::isSubmit('addnew') || (Tools::isSubmit('editmp_discount') && $id_cart_rule && Validate::isUnsignedId($id_cart_rule)))
            return  $this->renderCartRuleForm();
        else
        {
            $fields_list = array(
                'id_cart_rule' => array(
                    'title' => $this->module->l('ID','discount'),
                    'width' => 40,
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true,
                ),
                'name' => array(
                    'title' => $this->module->l('Name','discount'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true
                ),
                'discount' => array(
                    'title' => $this->module->l('Discount','discount'),
                    'type' => 'text',
                    'sort' => true,
                ),
                'priority' => array(
                    'title' => $this->module->l('Priority','discount'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true
                ),
                'code' => array(
                    'title' => $this->module->l('Code','discount'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true
                ),
                'quantity' => array(
                    'title' => $this->module->l('Quantity','discount'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true
                ),
                'active' => array(
                    'title' => $this->module->l('Status','discount'),
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
                                'title' => $this->module->l('Yes','discount')
                            ),
                            1 => array(
                                'active' => 0,
                                'title' => $this->module->l('No','discount')
                            )
                        )
                    )
                ),
            );
            //Filter
            $show_resset = false;
            $filter = "";
            if($id_cart_rule && Validate::isUnsignedId($id_cart_rule) && !Tools::isSubmit('del'))
            {
                $filter .= ' AND cr.id_cart_rule="'.(int)$id_cart_rule.'"';
                $show_resset = true;
            }
            if(($name = Tools::getValue('name')) || $name!='')
            {
                if(Validate::isCleanHtml($name))
                    $filter .=' AND crl.name LIKE "%'.pSQL($name).'%"';
                $show_resset = true;
            }
            if(($priority = trim(Tools::getValue('priority'))) || $priority!='')
            {
                if(Validate::isInt((int)$priority))
                    $filter .=' AND cr.priority = "'.(int)$priority.'"';
                $show_resset = true;
            }
            if(($code = trim(Tools::getValue('code'))) || $code!='')
            {
                if(Validate::isCleanHtml($code))
                    $filter .=' AND cr.code LIKE "%'.pSQL($code).'%"';
                $show_resset = true;
            }
            if(($quantity = trim(Tools::getValue('quantity'))) || $quantity!='')
            {
                if(Validate::isInt((int)$quantity))
                    $filter .=' AND cr.quantity = "'.(int)$quantity.'%"';
                $show_resset = true;
            }
            if(($active = trim(Tools::getValue('active'))) || $active!='')
            {
                if(Validate::isInt((int)$active))
                    $filter .= ' AND cr.active="'.(int)$active.'"';
                $show_resset=true;
            }
            //Sort
            $sort = "";
            $sort_type=Tools::getValue('sort_type');
            $sort_value = Tools::getValue('sort');
            if($sort_value)
            {
                switch ($sort_value) {
                    case 'id_cart_rule':
                        $sort .='cr.id_cart_rule';
                        break;
                    case 'name':
                        $sort .='crl.name';
                        break;
                    case 'code':
                        $sort .= 'cr.code';
                        break;
                    case 'quantity':
                        $sort .= 'cr.quantity';
                        break;
                    case 'shop_name':
                        $sort .= 'r.shop_name';
                        break;
                    case 'priority':
                        $sort .= 'cr.priority';
                        break;
                    case 'discount':
                        $sort .= 'discount';
                        break;
                    case 'active':
                        $sort .='cr.active';
                        break;
                }
                if($sort && $sort_type && in_array($sort_type,array('acs','desc')))
                    $sort .= ' '.trim($sort_type);  
            }
            //Paggination
            $page = (int)Tools::getValue('page');
            if($page<=0)
                $page = 1;
            $totalRecords = (int) $this->seller->getDiscounts($filter,0,0,'',true);
            $paggination = new Ets_mp_paggination_class();            
            $paggination->total = $totalRecords;
            $paggination->url =$this->context->link->getModuleLink($this->module->name,'discount',array('list'=>true, 'page'=>'_page_')).$this->module->getFilterParams($fields_list,'mp_discount');
            if($limit = (int)Tools::getValue('paginator_discount_select_limit'))
                $this->context->cookie->__set('paginator_discount_select_limit', $limit);
            $paggination->limit = $this->context->cookie->__get('paginator_discount_select_limit') ? : 10;
            $paggination->name ='discount';
            $paggination->num_links =5;
            $totalPages = ceil($totalRecords / $paggination->limit);
            if($page > $totalPages)
                $page = $totalPages;
            $paggination->page = $page;
            $start = $paggination->limit * ($page - 1);
            if($start < 0)
                $start = 0;
            $discounts = $this->seller->getDiscounts($filter, $start,$paggination->limit,$sort,false);
            if($discounts)
            {
                foreach($discounts as &$discount)
                    if($discount['reduction_amount']!=0)
                        $discount['discount'] = Ets_marketplace::displayPrice($discount['discount'],new Currency((int)Configuration::get('PS_CURRENCY_DEFAULT')));
                    elseif($discount['reduction_percent']!=0)
                        $discount['discount']= number_format(Tools::ps_round($discount['discount'],2),2).'%';
                    else
                        $discount['discount'] ='--';
            }
            $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)','discount');
            $paggination->style_links = $this->module->l('links','discount');
            $paggination->style_results = $this->module->l('results','discount');
            $listData = array(
                'name' => 'mp_discount',
                'actions' => array('view', 'delete'),
                'currentIndex' => $this->context->link->getModuleLink($this->module->name,'discount',array('p'=>1)).($paggination->limit!=10 ? '&paginator_discount_select_limit='.$paggination->limit:''),
                'postIndex' => $this->context->link->getModuleLink($this->module->name,'discount',array('p'=>1)),
                'identifier' => 'id_cart_rule',
                'show_toolbar' => true,
                'show_action' => true,
                'title' => $this->module->l('Discounts','discount'),
                'fields_list' => $fields_list,
                'field_values' => $discounts,
                'paggination' => $paggination->render(),
                'filter_params' => $this->module->getFilterParams($fields_list,'mp_discount'),
                'show_reset' =>$show_resset,
                'totalRecords' => $totalRecords,
                'sort'=> $sort_value,
                'show_add_new'=> true,
                'link_new' => $this->context->link->getModuleLink($this->module->name,'discount',array('addnew'=>1)),
                'sort_type' => $sort_type,
            );  
            $html = '';
            if($this->context->cookie->__get('success_message'))
            {
                $html = Ets_mp_defines::displayText('<'.'svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"'.'>'.'<'.'path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/'.'>'.'<'.'/svg'.'>'.$this->context->cookie->__get('success_message'),'div','alert alert-success');
                $this->context->cookie->__set('success_message', '');
            }
            if($this->_errors){
                $output = '';
                if (is_array($this->_errors)) {
                    foreach ($this->_errors as $msg) {
                        $output .= $msg . '<'.'br/'.'>';
                    }
                } else {
                    $output .= $this->_errors;
                }
                $html = Ets_mp_defines::displayText('<'.'svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/'.'>'.'<'.'/svg'.'>'.$output,'div','alert alert-error');
            }
            return $html.$this->module->renderList($listData);
        }
    }
    public function renderCartRuleForm()
    {
        $cart_rule = new CartRule();
        if(($id_cart_rule = (int)Tools::getValue('id_cart_rule')) && Validate::isUnsignedId($id_cart_rule))
        {
            if($this->seller->id_customer == Ets_mp_seller::getIDCustomerSellerByIDCartRule($id_cart_rule))
            {
                $cart_rule = new CartRule($id_cart_rule);
                if($cart_rule->id_customer)
                {
                    $this->context->smarty->assign(
                        array(
                            'customer_cart_rule' => new Customer($cart_rule->id_customer),
                        )
                    );  
                }
            }
            else
                Tools::redirect($this->context->link->getPageLink('my-account'));
        }
        $languages = Language::getLanguages(true);
        $valueFieldPost= array();
        $fields = CartRule::$definition['fields'];
        if($fields)
        {
            foreach($fields as $key=>$field)
            {
                if(!isset($field['lang']))
                {
                    $valueFieldPost[$key] = Tools::getValue($key,$cart_rule->{$key});
                }
            }
        }
        foreach(Language::getLanguages(true) as $language)
        {
            $valueFieldPost['name'][$language['id_lang']] = Tools::getValue('name_'.(int)$language['id_lang'],isset($cart_rule->name[$language['id_lang']]) ? $cart_rule->name[$language['id_lang']]:'');
        }
        if($cart_rule->id)
        {
            if($cart_rule->reduction_percent!=0)
            {
                $apply_discount = Tools::getValue('apply_discount','percent');
                $valueFieldPost['apply_discount'] = $apply_discount;
            }
            elseif($cart_rule->reduction_amount!=0)
            {
                $apply_discount = Tools::getValue('apply_discount','amount');
                $valueFieldPost['apply_discount'] = $apply_discount;
            }
            else
            {
                $apply_discount = Tools::getValue('apply_discount','off');
                $valueFieldPost['apply_discount'] = $apply_discount;
            }
        }
        else
        {
            $apply_discount  = Tools::getValue('apply_discount','percent');
            $valueFieldPost['apply_discount'] = $apply_discount;
        }
        if(($reduction_product = (int)Tools::getValue('reduction_product',$cart_rule->reduction_product)) && Validate::isUnsignedId($reduction_product))
        {
            $valueFieldPost['product']= new Product($reduction_product,false,$this->context->language->id);
        }
        if(($id_customer = (int)Tools::getValue('id_customer',$cart_rule->id_customer)) && Validate::isUnsignedId($id_customer))
        {
            $valueFieldPost['customer'] = new Customer($id_customer);
        }
        
        $this->context->smarty->assign(array(
            'valueFieldPost'=>$valueFieldPost,
            'languages' => $languages,
            'id_lang_default' => Configuration::get('PS_LANG_DEFAULT'),
        ));
        $currentFormTab = Tools::getValue('currentFormTab','informations');
        $this->context->smarty->assign(
            array(
                'currentFormTab' =>in_array($currentFormTab,array('informations','conditions','actions')) ?  $currentFormTab:'informations',
                'html_informations' => $this->_renderInformations(),
                'html_conditions' => $this->_renderConditions(),
                'html_actions' => $this->_renderActions(),
                'id_cart_rule' => $id_cart_rule,
                'ets_mp_url_search_customer' => $this->context->link->getModuleLink($this->module->name,'ajax',array('ajaxSearchCustomer'=>1)),
                'ets_mp_url_search_product' => $this->context->link->getModuleLink($this->module->name,'ajax',array('ajaxSearchProduct'=>1,'disableCombination'=>1)),
            )
        );
        $html = '';
        if($this->_errors){
            $output = '';
            if (is_array($this->_errors)) {
                foreach ($this->_errors as $msg) {
                    $output .= $msg . '<'.'br/'.'>';
                }
            } else {
                $output .= $this->_errors;
            }
            $html = Ets_mp_defines::displayText('<'.'svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/'.'>'.'<'.'/svg'.'>'.$output,'div','alert alert-error');
        }

        return $html.$this->module->displayTpl('cart_rule/form.tpl');
    }
    public function _renderInformations()
    {
        $fields = array(
            array(
                'type' => 'text',
                'name' => 'name',
                'label' => $this->module->l('Name','discount'),  
                'lang' => true,
                'required' => true, 
            ),
            array(
                'type' => 'textarea',
                'name' => 'description',
                'label' => $this->module->l('Description','discount'),  
            ),
            array(
                'type' => 'text',
                'name' => 'code',
                'label' => $this->module->l('Code','discount'),
                'suffix' => Ets_mp_defines::displayText(Ets_mp_defines::displayText('','i','fa fa-random').$this->module->l('Generate','discount'),'a','btn btn-default','','javascript:ets_cart_rulegencode(8);'),
                'required' => true,
                'desc' => $this->module->l('This is the code users should enter to apply the voucher to a cart. Either create your own code or generate one by clicking on Generate button','discount'),
            ),
            array(
                'type' => 'switch',
                'name' =>'highlight',
                'label' => $this->module->l('Highlight','discount'),
                'desc' => $this->module->l('If the discount is not yet in the cart, it will be displayed in the cart summary','discount'),
            ),
            array(
                'type' => 'switch',
                'name' =>'partial_use',
                'label' => $this->module->l('Partial use','discount'),
                'desc' => $this->module->l('Only applicable if the discount value is greater than the cart total. If you do not allow partial use, the discount value will be lowered to the total order amount. If you allow partial use, however, a new discount will be created with the remainder','discount'),
            ),
            array(
                'type' => 'text',
                'name' => 'priority',
                'label' => $this->module->l('Priority','discount'),
                'desc' => $this->module->l('Discount codes are applied by priority. A discount code with a priority of "1" will be processed before a discount code with priority of "2"','discount'),
            ),
            array(
                'type' => 'switch',
                'name' => 'active',
                'label' => $this->module->l('Status','discount'),
            )
        );
        $this->context->smarty->assign(
            array(
                'fields' => $fields,
            )
        );
        return $this->module->displayTpl('form.tpl');
    }
    public function _renderConditions()
    {
        $fields = array(
            'customer'=>array(
                'type' => 'custom_form',
                'html_form' => $this->module->displayTpl('cart_rule/customer.tpl')
            ),
            'products'=>array(
                'type' =>'input_group',
                'label' =>$this->module->l('Valid','products'),
                'required' => true,
                'inputs' => array(
                    array(
                        'type'=> 'date',
                        'name'=>'date_from',
                        'label'=> '',
                        'col' => 'col-lg-6',
                        'group_addon' => $this->module->l('From','discount'),
                        'suffix' => Ets_mp_defines::displayText('<'.'svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/'.'>'.'<'.'/svg'.'>','i'),
                    ),
                    array(
                        'type'=> 'date',
                        'name'=>'date_to',
                        'label'=> '',
                        'col' => 'col-lg-6',
                        'group_addon' => $this->module->l('To','discount'),
                        'suffix' => Ets_mp_defines::displayText('<'.'svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/'.'>'.'<'.'/svg'.'>','i'),
                    ),
                ),
            ),
            'minimum_amount' => array(
                'type' => 'input_group',
                'label' => $this->module->l('Minimum amount','discount'),
                'desc' => $this->module->l('You can choose a minimum amount for the cart either with or without the taxes and shipping.','discount'),
                'inputs' => array(
                    array(
                        'type' =>'text',
                        'name' =>'minimum_amount',
                        'col' => 'col-lg-3'
                    ),
                    array(
                        'type' =>'select',
                        'name' =>'minimum_amount_currency',
                        'col'=> 'col-lg-2',
                        'values' => array(
                            'query' => Currency::getCurrencies(),
                            'id'=>'id_currency',
                            'name' =>'iso_code'
                        ),
                    ),
                    array(
                        'type' =>'select',
                        'name' =>'minimum_amount_tax',
                        'col'=> 'col-lg-3',
                        'values' => array(
                            'query' => array(
                                array(
                                    'name' => $this->module->l('Tax excluded','discount'),
                                    'id'=>0,
                                ),
                                array(
                                    'name' => $this->module->l('Tax included','discount'),
                                    'id'=>1,
                                )
                            ),
                            'id'=>'id',
                            'name' =>'name'
                        ),
                    ),
                    array(
                        'type' =>'select',
                        'name' =>'minimum_amount_shipping',
                        'col'=> 'col-lg-3',
                        'values' => array(
                            'query' => array(
                                array(
                                    'name' => $this->module->l('Shipping excluded','discount'),
                                    'id'=>0,
                                ),
                                array(
                                    'name' => $this->module->l('Shipping included','discount'),
                                    'id'=>1,
                                )
                            ),
                            'id'=>'id',
                            'name' =>'name'
                        ),
                    )
                )
            ),
            'quantity'=>array(
                'type'=> 'text',
                'name'=>'quantity',
                'label' => $this->module->l('Total available','discount'),
                'desc' => $this->module->l('The discount code will be applied to the first X users only. X is the number you entered.','discount'),
            ),
            'quantity_per_user' => array(
                'type'=> 'text',
                'name'=>'quantity_per_user',
                'label' => $this->module->l('Total available for each user','discount'),
                'desc' => $this->module->l('A customer will only be able to use the discount code Y time(s). Y is the number you entered.','discount'), 
            ),
        );
        if(!Configuration::get('ETS_MP_SELLER_LIMIT_USER_CODE'))
        {
            unset($fields['customer']);
        }
        $this->context->smarty->assign(
            array(
                'fields' => $fields,
            )
        );
        return $this->module->displayTpl('form.tpl');
    }
    public function _renderActions()
    {
        $fields = array(
            array(
                'type'=>'switch',
                'name' =>'free_shipping',
                'label' => $this->module->l('Free shipping','discount'),
            ),
            array(
                'type'=>'radio',
                'name' =>'apply_discount',
                'label' =>$this->module->l('Apply a discount','discount'),
                'values' => array(
                    array(
                        'name' =>$this->module->l('Percent (%)','discount'),
                        'id'=>'percent',
                    ),
                    array(
                        'name' =>$this->module->l('Amount','discount'),
                        'id'=>'amount',
                    ),
                    array(
                        'name' =>$this->module->l('None','discount'),
                        'id'=>'off',
                    )
                ),
            ),
            array(
                'type' =>'text',
                'name'=> 'reduction_percent',
                'label'=> $this->module->l('Value','discount'),
                'desc' => $this->module->l('Does not apply to the shipping costs','discount'),
                'group_addon' =>'%',
                'form_group_class' => 'apply_discount reduction_percent',
                'required' => true,
            ),
            array(
                'type' => 'input_group',
                'label' => $this->module->l('Amount','discount'),
                'form_group_class' => 'apply_discount reduction_amount',
                'required' => true,
                'inputs' => array(
                    array(
                        'type' =>'text',
                        'name' =>'reduction_amount',
                        'col' => 'col-lg-4'
                    ),
                    array(
                        'type' =>'select',
                        'name' =>'reduction_currency',
                        'col'=> 'col-lg-4',
                        'values' => array(
                            'query' => Currency::getCurrencies(),
                            'id'=>'id_currency',
                            'name' =>'iso_code'
                        ),
                    ),
                    array(
                        'type' =>'select',
                        'name' =>'reduction_tax',
                        'col'=> 'col-lg-4',
                        'values' => array(
                            'query' => array(
                                array(
                                    'name' => $this->module->l('Tax excluded','discount'),
                                    'id'=>0,
                                ),
                                array(
                                    'name' => $this->module->l('Tax included','discount'),
                                    'id'=>1,
                                )
                            ),
                            'id'=>'id',
                            'name' =>'name'
                        ),
                    ),
                )
            ),
            array(
                'type' => 'custom_form',
                'html_form' => $this->module->displayTpl('cart_rule/product.tpl')
            ),
        );
        $this->context->smarty->assign(
            array(
                'fields' => $fields,
            )
        );
        return $this->module->displayTpl('form.tpl');
    }
 }
