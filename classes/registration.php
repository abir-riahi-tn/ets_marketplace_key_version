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
class Ets_mp_registration extends ObjectModel
{
    protected static $instance;
    public $id_customer;
    public $id_shop;
    public $id_shop_category;
	public $shop_name;
    public $shop_description;
	public $shop_address;
    public $shop_phone;
    public $vat_number;
    public $shop_logo;
    public $shop_banner;
    public $banner_url;
    public $link_facebook;
    public $link_instagram;
    public $link_google;
    public $link_twitter;
    public $latitude;
    public $longitude;
    public $message_to_administrator;
    public $reason;
    public $comment;
    public $secret_key;
    public $active;
    public $date_add;
    public $date_upd;
    public $seller_email;
    public $seller_name;
    public $id_language;
    public static $definition = array(
		'table' => 'ets_mp_registration',
		'primary' => 'id_registration',
		'multilang' => false,
		'fields' => array(
			'id_customer' => array('type' => self::TYPE_INT),
            'id_shop' => array('type' => self::TYPE_INT, 'validate' => 'isunsignedInt'), 
            'id_shop_category' => array('type' => self::TYPE_INT, 'validate' => 'isunsignedInt'), 
            'shop_name' =>	array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'),            
            'shop_description' =>	array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'),
            'shop_address'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'), 
            'shop_phone'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'), 
            'vat_number'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'), 
            'shop_logo'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'), 
            'shop_banner'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'), 
            'banner_url'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'), 
            'link_facebook'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'), 
            'link_instagram'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'), 
            'link_google'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'), 
            'link_twitter'  => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'),
            'message_to_administrator' => array('type' =>   self::TYPE_STRING,'validate' => 'isCleanHtml'),   
            'latitude' => array('type'=>self::TYPE_FLOAT),
            'longitude' => array('type'=>self::TYPE_FLOAT),
            'active' => array('type'=> self::TYPE_INT),
            'reason' => array('type'=>self::TYPE_STRING),
            'comment' => array('type'=>self::TYPE_STRING),
            'secret_key' => array('type'=>self::TYPE_STRING, 'validate' => 'isCleanHtml', 'size' => 255),
            'date_add' =>	array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'),
            'date_upd' =>	array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml'),    
        )
	);
    public	function __construct($id_item = null, $id_lang = null, $id_shop = null)
	{
		parent::__construct($id_item, $id_lang, $id_shop);
        $customer = new Customer($this->id_customer);
        $this->seller_email = $customer->email;
        $this->seller_name = $customer->firstname.' '.$customer->lastname;
        $this->id_language = $customer->id;
	}
    public static function getInstance()
    {
        if (!isset(self::$instance)) {
            self::$instance = new Ets_mp_registration();
        }
        return self::$instance;
    }
    protected static $_registration;
    static public function _getRegistration($id_customer=0, $use_cache=true)
    {
        if(!isset(self::$_registration[$id_customer]) || !$use_cache)
        {
            $context = Ets_marketplace::getContextStatic();
            if($id_registration = Db::getInstance()->getValue('SELECT id_registration FROM `'._DB_PREFIX_.'ets_mp_registration` WHERE id_customer="'.($id_customer ? (int)$id_customer : (int)$context->customer->id).'" AND id_shop="'.(int)$context->shop->id.'"'))
            {
                self::$_registration[$id_customer] = new Ets_mp_registration($id_registration);
            }
            else
                self::$_registration[$id_customer] = false;
        }
        return self::$_registration[$id_customer];

    }
    static public function _getRegistrations($filter='',$sort='',$start=0,$limit=10,$total=false)
    {
        if($total)
        {
            $sql = 'SELECT COUNT(*) FROM `'._DB_PREFIX_.'ets_mp_registration` r
                LEFT JOIN `'._DB_PREFIX_.'customer` customer ON (r.id_customer=customer.id_customer)
                LEFT JOIN `'._DB_PREFIX_.'ets_mp_shop_category` sc ON (r.id_shop_category = sc.id_ets_mp_shop_category)
                LEFT JOIN `'._DB_PREFIX_.'ets_mp_shop_category_lang` scl ON (scl.id_ets_mp_shop_category = sc.id_ets_mp_shop_category AND scl.id_lang="'.(int)Ets_marketplace::getContextStatic()->language->id.'")
            WHERE r.id_shop="'.(int)Ets_marketplace::getContextStatic()->shop->id.'" '.(string)$filter;
            return Db::getInstance()->getValue($sql); 
        }
        $sql = 'SELECT r.*,r.id_registration as id,CONCAT(customer.firstname," ", customer.lastname) as seller_name,customer.email as seller_email,scl.name as category_name FROM `'._DB_PREFIX_.'ets_mp_registration` r
            LEFT JOIN `'._DB_PREFIX_.'customer` customer ON (r.id_customer=customer.id_customer)
            LEFT JOIN `'._DB_PREFIX_.'ets_mp_shop_category` sc ON (r.id_shop_category = sc.id_ets_mp_shop_category)
            LEFT JOIN `'._DB_PREFIX_.'ets_mp_shop_category_lang` scl ON (scl.id_ets_mp_shop_category = sc.id_ets_mp_shop_category AND scl.id_lang="'.(int)Ets_marketplace::getContextStatic()->language->id.'")
        WHERE r.id_shop="'.(int)Ets_marketplace::getContextStatic()->shop->id.'" '.(string)$filter. ''
        .($sort ? ' ORDER BY '.pSQL($sort): ' ORDER BY r.id_registration DESC')
        .' LIMIT '.(int)$start.','.(int)$limit.'';
        return Db::getInstance()->executeS($sql);
    }
    private function _clearcache()
    {
        /** @var Ets_marketplace $marketplace */
        $marketplace = Module::getInstanceByName('ets_marketplace');
        $marketplace->_clearCache('*',$marketplace->_getCacheId('dashboard',false));
        $marketplace->_clearCache('*',$marketplace->_getCacheId('applications',false));
    }
    public function delete()
    {
        $result = parent::delete();
        if($result)
        {
            if($this->shop_logo && !Db::getInstance()->getRow('SELECT * FROM `'._DB_PREFIX_.'ets_mp_seller` WHERE shop_logo="'.pSQL($this->shop_logo).'"'))
            {
                if(file_exists(_PS_IMG_DIR_.'mp_seller/'.$this->shop_logo))
                    @unlink(_PS_IMG_DIR_.'mp_seller/'.$this->shop_logo);
            }
            $this->_clearcache();
        }
        return $result;
    }
    public function update($null_values = false)
    {
        if(parent::update($null_values))
        {
            $this->_clearcache();
            return true;
        }
        return false;
    }
    public function add($auto_date = true, $null_values = false)
    {
        if(parent::add($auto_date, $null_values))
        {
            $this->_clearcache();
            return true;
        }
        return false;
    }
    public static function getTotalRegistrations()
    {
        return Db::getInstance()->getValue('
                    SELECT COUNT(*) FROM `'._DB_PREFIX_.'ets_mp_registration` r
                    LEFT JOIN `'._DB_PREFIX_.'ets_mp_seller` s ON (r.id_customer=s.id_customer) 
                    WHERE s.id_seller is null AND r.active=-1 AND r.id_shop="'.(int)Ets_marketplace::getContextStatic()->shop->id.'"');
    }
    public static function updateStatusManager($active)
    {
        return Db::getInstance()->execute('UPDATE `'._DB_PREFIX_.'ets_mp_seller_manager` SET active="'.(int)$active.'" WHERE email="'.pSQL(Ets_marketplace::getContextStatic()->customer->email).'"');
    }
    public static function getRegistrationByEmail($email)
    {
        return Db::getInstance()->getRow('SELECT * FROM `'._DB_PREFIX_.'ets_mp_registration` WHERE seller_email="'.pSQL($email).'"');
    }
}
