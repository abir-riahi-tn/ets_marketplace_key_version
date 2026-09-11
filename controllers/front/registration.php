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
 * Class Ets_MarketPlaceRatingsModuleFrontController
 * @property \Ets_mp_seller $seller
 * @property \Ets_marketplace $module
 */
class Ets_MarketPlaceRegistrationModuleFrontController extends ModuleFrontController
{
    public $_success = '';
    public $_errors = array();
    public $_warning = '';
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
        if($this->module->_getSeller())
            Tools::redirect($this->context->link->getPageLink('my-account'));
        if(!Ets_mp_seller::checkGroupCustomer())
        {
            if(!$this->context->customer->isLogged())
            {
                if(!Configuration::get('ETS_MP_REQUIRE_REGISTRATION'))
                    Tools::redirect($this->context->link->getPageLink('authentication',null,null,['back'=>$this->context->link->getModuleLink($this->module->name,'myseller')]));
                else
                    Tools::redirect($this->context->link->getPageLink('authentication',null,null,['back'=>$this->context->link->getModuleLink($this->module->name,'registration')]));
            }
            else
                Tools::redirect($this->context->link->getPageLink('my-account'));
        }
        elseif(!Configuration::get('ETS_MP_ENABLED') || !Configuration::get('ETS_MP_REQUIRE_REGISTRATION'))
        {
            Tools::redirect($this->context->link->getPageLink('my-account'));
        }

        if(Tools::isSubmit('submitDeclinceManageShop'))
        {
            Ets_mp_registration::updateStatusManager(0);
            $this->_warning = $this->module->l('You have declined the shop management invitation. How about registering for your own shop?','registration');
        }
        if(Tools::isSubmit('submitApproveManageShop'))
        {
            Ets_mp_registration::updateStatusManager(1);
        }
        if(($registration=Ets_mp_registration::_getRegistration()))
        {
            if($registration->active==-1)
            {
                $message= Configuration::get('ETS_MP_MESSAGE_SUBMITTED',$this->context->language->id)?:$this->module->l('Your application has been submitted successfully. Our team are reviewing the application, and we will get back to you as soon as possible','registration');
                $this->_success = $this->module->_replaceTag($message);
            }
            elseif($registration->active==1)
                Tools::redirect($this->context->link->getModuleLink($this->module->name,'create'));
            elseif($registration->active==0)
            {
                $message = Configuration::get('ETS_MP_MESSAGE_APPLICATION_DECLINED',$this->context->language->id)?:$this->module->l('Sorry! Your application has been declined.
Reason: [application_declined_reason]
');
                $this->_warning = str_replace(array('[application_declined_reason]',"\n"),array($registration->reason,Ets_mp_defines::displayText('','br')),$message);
            }
        }
        else
        {
           if(Configuration::get('ETS_MP_REGISTRATION_FIELDS') || !$this->context->customer->isLogged())
           {
               if(Tools::isSubmit('submitSeller'))
               {
                    $seller_fields = array(
                        'seller_name' => $this->module->l('Seller name','registration'),
                        'seller_email' => $this->module->l('Seller email','registration'),
                        'shop_name' => $this->module->l('Shop name','registration'),
                        'shop_description' => $this->module->l('Shop description','registration'),
                        'shop_address' => $this->module->l('Shop address','registration'),
                        'vat_number' => $this->module->l('VAT number','registration'),
                        'shop_phone' => $this->module->l('Phone number','registration'),
                        'shop_logo' => $this->module->l('Shop logo','registration'),
                        'shop_banner' => $this->module->l('Shop banner','registration'),
                        'banner_url' => $this->module->l('Banner URL','registration'),
                        'link_facebook' => $this->module->l('Facebook link','registration'),
                        'link_instagram' => $this->module->l('Instagram link','registration'),
                        'link_google' => $this->module->l('Google link','registration'),
                        'link_twitter' => $this->module->l('X link','registration'),
                        'latitude' => $this->module->l('Latitude','registration'),
                        'longitude' => $this->module->l('Longitude','registration'),
                        'message_to_administrator' => $this->module->l('Introduction','registration'),
                        'id_shop_category' => $this->module->l('Shop category', 'registration'),
                    );
                    $fields = explode(',',Configuration::get('ETS_MP_REGISTRATION_FIELDS'));
                    $fields_validate = explode(',',Configuration::get('ETS_MP_REGISTRATION_FIELDS_VALIDATE'));
                    foreach($fields as $field)
                    {
                        if(!$this->context->customer->isLogged() && ($field=='seller_name' || $field=='seller_email'))
                            continue;
                        $field_value = Tools::getValue($field);
                        if($field!='0')
                        {
                            if(in_array($field,$fields_validate))
                            {
                                if(($field!='shop_logo' && $field!='shop_banner' && $field!='id_shop_category' && !$field_value) || (($field=='shop_logo' || $field=='shop_banner') && !$_FILES[$field]['name']))
                                    $this->_errors[] = sprintf($this->module->l('%s is required','registration'),$seller_fields[$field]);
                                elseif($field=='id_shop_category')
                                {
                                    $totalCategory  = Ets_mp_shop_category::getShopCategories(' AND c.active=1',0,0,'',true);
                                    if($totalCategory && !$field_value)
                                        $this->_errors[] = sprintf($this->module->l('%s is required','registration'),$seller_fields[$field]);
                                }
                            }
                            if(in_array($field,array('link_facebook','link_google','link_instagram','link_twitter','banner_url')))
                            {
                                if($field_value && !Ets_marketplace::isLink($field_value))
                                    $this->_errors[] = sprintf($this->module->l('%s is not valid','registration'),$seller_fields[$field]);
                            }
                            elseif(in_array($field,array('latitude','longitude')))
                            {
                                if($field_value && !Validate::isCoordinate($field_value))
                                    $this->_errors[] =  sprintf($this->module->l('%s is not valid','registration'),$seller_fields[$field]);
                            }
                            elseif($field!='shop_logo' && $field!='shop_banner' && $field!='shop_phone' && $field!='shop_name' && $field_value && !Validate::isCleanHtml($field_value))
                                $this->_errors[] = sprintf($this->module->l('%s is not valid','registration'),$seller_fields[$field]);
                            elseif($field=='seller_email' && $field_value && !Validate::isEmail($field_value))
                                $this->_errors[] = $this->module->l('Email is not valid','registration');
                            elseif($field=='seller_email' && $field_value && (Ets_mp_registration::getRegistrationByEmail($field_value) || Ets_mp_seller::getSellerByEmail($field_value)))
                            {
                                $this->_errors[] = $this->module->l('The email is already used, please choose another one','registration');
                            }
                            elseif($field=='shop_phone' && $field_value && !Validate::isPhoneNumber($field_value))
                                $this->_errors[] = $this->module->l('Phone number is not valid','registration');
                            elseif($field=='shop_name' && $field_value && !Validate::isGenericName($field_value))
                                $this->_errors[] = $this->module->l('Shop name is not valid','registration');
                            elseif($field=='vat_number' && $field_value && !Validate::isGenericName($field_value))
                                $this->_errors[] = $this->module->l('VAT number is not valid','registration');
                        }
                        
                    }
                    if(!$this->context->customer->isLogged())
                    {
                        $first_name = Tools::getValue('first_name');
                        if(!$first_name)
                            $this->_errors[] = $this->module->l('First name is required','registration');
                        elseif(!Validate::isCustomerName($first_name))
                            $this->_errors[] = $this->module->l('First name is not valid','registration');
                        $last_name = Tools::getValue('last_name');
                        if(!$last_name)
                            $this->_errors[] = $this->module->l('Last name is required','registration');
                        elseif(!Validate::isCustomerName($last_name))
                            $this->_errors[] = $this->module->l('Last name is not valid','registration');
                        $email = Tools::getValue('email');
                        if(!$email)
                            $this->_errors[] = $this->module->l('Email is required','registration');
                        elseif(!Validate::isEmail($email))
                            $this->_errors[] = $this->module->l('Email is not valid','registration');
                        elseif(Customer::customerExists($email, false, true))
                            $this->_errors[] = $this->module->l('The email is already used, please choose another one or sign in','registration');
                        $password= Tools::getValue('password');
                        if(!$password)
                            $this->_errors[] = $this->module->l('Password is required','registration');
                        if(method_exists('Validate','isPasswd') && !Ets_mp_defines::isPasswd($password))
                        {
                            $this->_errors[] =$this->module->l('Email is invalid','registration');
                        }
                        elseif($error = $this->checkPasswd($password))
                        {
                            $this->_errors[] = $error;
                        }
                    }
                    if(!$this->_errors && !$this->context->customer->isLogged())
                    {
                        $customer = new Customer();
                        $customer->firstname = $first_name;
                        $customer->lastname = $last_name;
                        $customer->email = $email;
                        $customer->passwd = md5(_COOKIE_KEY_.$password);
                        $customer->is_guest = false;
                        $customer->id_gender =1;
                        if($customer->add())
                        {
                            $customer->cleanGroups();
                            $customer->addGroups(array((int)Configuration::get('PS_CUSTOMER_GROUP')));
                            /* @phpstan-ignore-next-line */
                            if(method_exists($this->context,'updateCustomer'))
                                $this->context->updateCustomer($customer);
                            else
                                $this->updateContext($customer);
                        }
                        else
                            $this->_errors[] = $this->module->l('Creating guest customer failed','registration');
                    }
                    if(!$this->_errors)
                    {
                        $seller = new Ets_mp_registration();
                        $seller->id_customer = $this->context->customer->id;
                        $seller->id_shop = $this->context->shop->id;
                        $seller->date_add = date('Y-m-d H:i:s');
                        $seller->date_upd = date('Y-m-d H:i:s');
                        $seller->active=-1;
                        foreach($fields as $field)
                        {
                            if($field!='shop_logo' && $field!='shop_banner')
                            {
                                $field_value = Tools::getValue($field);
                                if(!$field_value && $field=='seller_name')
                                    $seller->seller_name = $this->context->customer->firstname.' '.$this->context->customer->lastname;
                                if(!$field_value && $field=='seller_email')
                                    $seller->seller_name = $this->context->customer->email;
                                $seller->{$field} = Validate::isCleanHtml($field_value) ? $field_value :'';
                            }
                            else
                                $seller->{$field} = $this->module->uploadFile($field,$this->_errors);
                            
                        }
                        if(!$this->_errors)
                        {
                            if($seller->add())
                            {
                                $message = Configuration::get('ETS_MP_MESSAGE_SUBMITTED',$this->context->language->id)?:$this->module->l('Your application has been submitted successfully. Our team are reviewing the application, and we will get back to you as soon as possible','registration');
                                $this->_success = $this->module->_replaceTag($message);
                                if(Configuration::get('ETS_MP_EMAIL_ADMIN_APPLICATION_REQUEST'))
                                {
                                    $this->context->smarty->assign(
                                        array(
                                            'seller_fields' => $seller_fields,
                                            'submit_fields' => $fields,
                                            'seller_email' => $this->context->customer->email,
                                            'submit_values' => Tools::getAllValues(),
                                        )
                                    );
                                    $datas = array(
                                        '{seller_name}' => $this->context->customer->firstname.' '.$this->context->customer->lastname,
                                        '{seller_application_content}' => $this->module->displayTpl('seller_application_content.tpl'),
                                        '{seller_application_content_txt}' => $this->module->displayTpl('seller_application_content_txt.tpl'),
                                    );
                                    $subjects = array(
                                        'translation' => $this->module->l('New application','registration'),
                                        'origin'=>'New application',
                                        'specific'=>'registration'
                                    );
                                    Ets_marketplace::sendMail('to_admin_new_seller_application',$datas,'',$subjects);
                                    
                                }
                            }
                            else
                            {
                                $this->_errors[] = $this->module->l('Registration failed','registration');
                                if($seller->shop_logo && file_exists(_PS_IMG_DIR_.'mp_seller/'.$seller->shop_logo))
                                    @unlink(_PS_IMG_DIR_.'mp_seller/'.$seller->shop_logo);
                                if($seller->shop_banner && file_exists(_PS_IMG_DIR_.'mp_seller/'.$seller->shop_banner))
                                    @unlink(_PS_IMG_DIR_.'mp_seller/'.$seller->shop_banner);
                            }
                        }
                        else
                        {
                            if($seller->shop_logo && file_exists(_PS_IMG_DIR_.'mp_seller/'.$seller->shop_logo))
                                @unlink(_PS_IMG_DIR_.'mp_seller/'.$seller->shop_logo);
                            if($seller->shop_banner && file_exists(_PS_IMG_DIR_.'mp_seller/'.$seller->shop_banner))
                                @unlink(_PS_IMG_DIR_.'mp_seller/'.$seller->shop_banner);
                            
                        }
                        
                    }
               } 
            }
            elseif(!Ets_mp_manager::getManagerByEmail($this->context->customer->email))
            {
                $seller = new Ets_mp_registration();
                $seller->id_customer = $this->context->customer->id;
                $seller->id_shop = $this->context->shop->id;
                $seller->date_add = date('Y-m-d H:i:s');
                $seller->date_upd = date('Y-m-d H:i:s');
                $seller->active=-1;
                if($seller->add())
                {
                    $message= Configuration::get('ETS_MP_MESSAGE_SUBMITTED',$this->context->language->id)?:$this->module->l('Your application has been submitted successfully. Our team are reviewing the application, and we will get back to you as soon as possible','registration');
                    $this->_success = $this->module->_replaceTag($message);
                    if(Configuration::get('ETS_MP_EMAIL_ADMIN_APPLICATION_REQUEST'))
                    {
                        $message_to_administrator = Tools::getValue('message_to_administrator');
                        $shop_phone = Tools::getValue('shop_phone');
                        $shop_address = Tools::getValue('shop_address');
                        $shop_description = Tools::getValue('shop_description');
                        $datas = array(
                            '{seller_name}' => $this->context->customer->firstname.' '.$this->context->customer->lastname,
                            '{seller_email}' => $this->context->customer->email,
                            '{shop_description}' => Validate::isCleanHtml($shop_description) ? :'',
                            '{shop_address}' => Validate::isAddress($shop_address) ? $shop_address :'',
                            '{shop_phone}' => Validate::isPhoneNumber($shop_phone) ? $shop_phone :'',
                            '{message}' => Validate::isCleanHtml($message_to_administrator) ? $message_to_administrator :'',
                        );
                        $subjects = array(
                            'translation' => $this->module->l('New application','registration'),
                            'origin'=> 'New application',
                            'specific'=>'registration'
                        );
                        Ets_marketplace::sendMail('to_admin_new_seller_application',$datas,'',$subjects);
                        
                    }
                }
                else
                    $this->_errors[] = $this->module->l('Registration failed','registration');
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
            $this->setTemplate('module:'.$this->module->name.'/views/templates/front/registration.tpl');      
        else        
            $this->setTemplate('registration_16.tpl'); 
    }
    public function _initContent()
    {
        if($id_group = (int)Configuration::get('ETS_MP_SELLER_GROUP_DEFAULT'))
        {
            $group = new Ets_mp_seller_group($id_group);
            if(!$group->use_fee_global && $group->fee_type)
            {
                $fee_type = $group->fee_type;
                $fee_amount = $group->fee_amount;
            }
            else
            {
                $fee_type = Configuration::get('ETS_MP_SELLER_FEE_TYPE');
                $fee_amount = Configuration::get('ETS_MP_SELLER_FEE_AMOUNT');
            }
        }
        else
        {
            $fee_type = Configuration::get('ETS_MP_SELLER_FEE_TYPE');
            $fee_amount = Configuration::get('ETS_MP_SELLER_FEE_AMOUNT');
        }
        if($fee_type=='no_fee')
            $fee_amount = 0;
        if(($manager = Ets_mp_manager::getManagerByEmail($this->context->customer->email)) && ($seller = Ets_mp_seller::_getSellerByIdCustomer($manager['id_customer'],$this->context->language->id)))
        {
            $customer_seller = new Customer($seller->id_customer);
            $manager_shop = array(
                'firstname' => $customer_seller->firstname,
                'lastname' => $customer_seller->lastname,
                'shop_name' => $seller->shop_name,
                'active' => $manager['active'],
            );
        }
        $address = new Address((int)Address::getFirstCustomerAddressId($this->context->customer->id));
        $this->context->smarty->assign(
            array(
                'register_customer' => $this->context->customer,
                'ETS_MP_REGISTRATION_FIELDS' => explode(',',Configuration::get('ETS_MP_REGISTRATION_FIELDS')),
                'ETS_MP_REGISTRATION_FIELDS_VALIDATE' => explode(',',Configuration::get('ETS_MP_REGISTRATION_FIELDS_VALIDATE')),
                'ETS_MP_MESSAGE_INVITE' =>Tools::nl2br(str_replace('[fee_amount]',Ets_marketplace::displayPrice($this->module->getFeeIncludeTax($fee_amount),new Currency((int)Configuration::get('PS_CURRENCY_DEFAULT'))).' ('.$this->module->l('Tax incl','registration').')',Configuration::get('ETS_MP_MESSAGE_INVITE',$this->context->language->id))),
                'seller' => Ets_mp_registration::_getRegistration(0,Tools::isSubmit('submitSeller') ? false : true),
                'manager_shop' => isset($manager_shop) ? $manager_shop : false,
                'shop_categories' => Ets_mp_shop_category::getShopCategories(' AND c.active=1',0,false),
                'number_phone' => $address->phone ? : $address->phone_mobile,
                'isLogged' =>$this->context->customer->isLogged(),
                'vat_number' => $address->vat_number,
            )
        );
        $output = '';
        if (is_array($this->_errors)) {
            foreach ($this->_errors as $msg) {
                $output .= $msg . '<'.'br/'.'>';
            }
        } else {
            $output .= $this->_errors;
        }
        return ($this->_warning ? Ets_mp_defines::displayText('<'.'svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/'.'>'.'<'.'/svg'.'>'.$this->_warning,'p','alert alert-warning') : '')
            .($this->_errors ? Ets_mp_defines::displayText('<'.'svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/'.'>'.'<'.'/svg'.'>'.$output,'p','alert alert-error'): '')
            .($this->_success ? Ets_mp_defines::displayText('<'.'svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"'.'>'.'<'.'path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/'.'>'.'<'.'/svg'.'>'.$this->_success,'p','alert alert-success'): '')
            .$this->module->displayTpl('registration.tpl');
    }
    public function checkPasswd($passwd)
    {
        if ($passwd && version_compare(_PS_VERSION_, '8.0.0', '>=')) {
            if (Validate::isAcceptablePasswordLength($passwd) === false) {
                return sprintf($this->module->l('Password must be between %d and %d characters long','order'),Configuration::get(PrestaShop\PrestaShop\Core\Security\PasswordPolicyConfiguration::CONFIGURATION_MINIMUM_LENGTH),Configuration::get(PrestaShop\PrestaShop\Core\Security\PasswordPolicyConfiguration::CONFIGURATION_MAXIMUM_LENGTH));
            }
            if (Validate::isAcceptablePasswordScore($passwd) === false) {
                $wordingsForScore = [
                    $this->module->l('Very weak','registration'),
                    $this->module->l('Weak','registration'),
                    $this->module->l('Average','registration'),
                    $this->module->l('Strong','registration'),
                    $this->module->l('Very strong','registration'),
                ];
                return sprintf($this->module->l('The minimum score must be: %s','registration'),$wordingsForScore[(int) Configuration::get(PrestaShop\PrestaShop\Core\Security\PasswordPolicyConfiguration::CONFIGURATION_MINIMUM_SCORE)]);
            }
        }
        return '';
    }
    protected function updateContext(Customer $customer)
    {
        $customer->logged = true;
        $this->context->customer = $customer;
        $this->context->cookie->__set('id_customer', (int)$customer->id);
        $this->context->cookie->__set('customer_lastname', $customer->lastname);
        $this->context->cookie->__set('customer_firstname', $customer->firstname);
        $this->context->cookie->__set('passwd', $customer->passwd);
        $this->context->cookie->__set('logged', true);
        $this->context->cookie->__set('email', $customer->email);
        $this->context->cookie->__set('is_guest', $customer->is_guest);
        $this->context->cart->secure_key = $customer->secure_key;
        $this->context->cart->id_customer = $customer->id;
        $this->context->cookie->write();
        $this->context->cart->update();
        $customer->update();
    }
}
