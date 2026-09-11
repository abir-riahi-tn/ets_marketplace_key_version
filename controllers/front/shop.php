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
 * Class Ets_MarketPlaceShopModuleFrontController
 * @property Ets_marketplace $module
 */
class Ets_MarketPlaceShopModuleFrontController extends ModuleFrontController
{
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
        if(!Configuration::get('ETS_MP_ENABLED'))
            Tools::redirect($this->context->link->getPageLink('my-account'));
        if(Tools::isSubmit('submitunfollow') && ($id_seller = Tools::getValue('id_seller')) && Validate::isUnsignedId($id_seller) && Validate::isLoadedObject($seller = new Ets_mp_seller($id_seller)))
        {
            Ets_mp_seller::customerUnFollowSeller($this->context->customer->id,$id_seller);
            $total_follow = $seller->getTotalFollow();
            die(
                json_encode(
                    array(
                        'success' => $this->module->l('Unfollow successfully','shop'),
                        'follow'=>false,
                        'total_follow' => $total_follow,
                    )
                )
            );
        }
        if(Tools::isSubmit('submitfollow') && ($id_seller=Tools::getValue('id_seller')) && Validate::isUnsignedId($id_seller) && Validate::isLoadedObject($seller = new Ets_mp_seller($id_seller)))
        {
            Ets_mp_seller::customerFollowSeller($this->context->customer->id,$seller->id);
            $total_follow = $seller->getTotalFollow();
            die(
                json_encode(
                    array(
                        'success' => $this->module->l('Follow successfully','shop'),
                        'follow'=>true,
                        'total_follow' => $total_follow,
                    )
                )
            );
        }
        if(Tools::isSubmit('getmaps') && ($id_seller= Tools::getValue('id_seller')) && Validate::isUnsignedId($id_seller) )
        {
            $params = array(
                'all' => (int)Tools::getValue('all'),
                'radius' => (int)Tools::getValue('radius', 100),
                'latitude' =>(float)Tools::getValue('latitude'),
                'longitude' => (float)Tools::getValue('longitude'),
            );
            Ets_mp_seller::getMaps($id_seller,false,$params);
        }
    }
    public function initContent()
	{
		parent::initContent();
        if(Configuration::get('PS_REWRITING_SETTINGS') && isset($_SERVER['REQUEST_URI']) && Tools::strpos($_SERVER['REQUEST_URI'],'module/ets_marketplace'))
        {
            if(($id_seller= (int)Tools::getValue('id_seller')) && Validate::isUnsignedId($id_seller) && Validate::isLoadedObject($seller = new Ets_mp_seller($id_seller)))
                Tools::redirect($this->module->getShopLink(array('id_seller' =>$id_seller)));
            else    
                Tools::redirect($this->module->getShopLink());
        }
        $this->module->setMetas();
        $this->context->smarty->assign(
            array(
                'html_content' =>$this->_initContent(),
                'path' => $this->module->getBreadCrumb(),
                'breadcrumb' => $this->module->is17 ? $this->module->getBreadCrumb() : false, 
            )
        );
        if($this->module->is17)
            $this->setTemplate('module:'.$this->module->name.'/views/templates/front/shop.tpl');      
        else        
            $this->setTemplate('shop_16.tpl'); 
    }
    private function actionLoadMoreProduct($seller)
    {
        $filter='';
        $product_name = Tools::getValue('product_name');
        $current_tab = Tools::getValue('current_tab','all');
        if(!in_array($current_tab,array('all','new_product','best_seller','special')))
        {
            $current_tab = 'all';
        }
        $idCategories = Tools::getValue('idCategories');
        if($current_tab=='all')
        {
            if(trim($product_name) && Validate::isCatalogName($product_name))
                $filter .=' AND (pl.name LIKE "%'.pSQl($product_name).'%" OR p.reference LIKE "'.pSQL($product_name).'" OR p.id_product="'.(int)$product_name.'")';
        }
        if(trim($idCategories,',') && Validate::isCleanHtml($idCategories))
        {
            $idCategories = explode(',',trim($idCategories,','));
            $filter .=' AND cp.id_category IN ('.implode(',',array_map('intval',$idCategories)).')';
        }
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page = 1;
        $totalRecords = (int)$this->getProducts($filter,0,0,'',true);
        $paggination = new Ets_mp_paggination_class();
        $paggination->total = $totalRecords;
        $paggination->url = $this->module->getShopLink(array('id_seller'=>$seller->id,'current_tab'=>$current_tab,'page'=>'_page_'));
        $paggination->limit =  12;
        $totalPages = (int)ceil($totalRecords / $paggination->limit);
        if($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)','shop');
        $order_by = Tools::getValue('order_by');
        if($order_by)
        {
            switch ($order_by) {
                case 'position.asc':
                    $order_by= 'cp.position asc';
                    break;
                case 'name.asc':
                    $order_by = ' pl.name asc';
                    break;
                case 'name.desc':
                    $order_by =' pl.name desc';
                    break;
                case 'price.desc':
                    $order_by =' product_shop.price desc';
                    break;
                case 'price.asc':
                    $order_by =' product_shop.price asc';
                    break;
                case 'new_product':
                    $order_by =' product_shop.date_add desc';
                    break;
                case 'best_sale':
                    $order_by =' sale.quantity desc';
                    break;
                default:
                    $order_by= 'cp.position asc';
            }
        }
        else
            $order_by= 'cp.position asc';
        $this->context->smarty->assign(
            array(
                'current_page' => $page,
                'idCategories' => $idCategories ,
                'products' => $this->getProducts($filter,$page,$paggination->limit,$order_by),
                'current_tab' => $current_tab,
                'paggination' => $paggination->render(),
                'product_name' => $product_name,
                'link_load_more' => $page < $totalPages ? $this->module->getShopLink(array('id_seller'=>$seller->id,'current_tab'=>$current_tab,'page'=>$page+1)):false,
            )
        );
        if(Tools::isSubmit('load_more'))
        {
            die(json_encode(
                array(
                    'product_list'=> $this->module->displayTpl('shop/product_list.tpl'),
                    'link_load_more' => $page < $totalPages ? $this->module->getShopLink(array('id_seller'=>$seller->id,'current_tab'=>$current_tab,'page'=>$page+1)):false,
                )
            ));
        }
        elseif(Tools::isSubmit('ajax'))
        {
            die(json_encode(
                array(
                    'product_list'=> $this->module->displayTpl('shop/product_list.tpl'),
                )
            ));
        }
    }
    public function _initContent()
    {
        if(($id_seller= (int)Tools::getValue('id_seller')) && Validate::isUnsignedId($id_seller))
        {
            $seller = new Ets_mp_seller($id_seller,$this->context->language->id);
            if(Validate::isLoadedObject($seller) && $seller->active==1 && $seller->id_shop== $this->context->shop->id)
            {
                if(Tools::isSubmit('ajax') || Tools::isSubmit('load_more'))
                    $this->actionLoadMoreProduct($seller);
                else
                {
                    $filter='';
                    $product_name = Tools::getValue('product_name');
                    $current_tab = Tools::getValue('current_tab','all');
                    if(!in_array($current_tab,array('all','new_product','best_seller','special')))
                    {
                        $current_tab = 'all';
                    }
                    $idCategories = Tools::getValue('idCategories');
                    if($current_tab=='all')
                    {
                        if(trim($product_name) && Validate::isCatalogName($product_name))
                            $filter .=' AND (pl.name LIKE "%'.pSQl($product_name).'%" OR p.reference LIKE "'.pSQL($product_name).'" OR p.id_product="'.(int)$product_name.'")';
                    }
                    if(trim($idCategories,',') && Validate::isCleanHtml($idCategories))
                    {
                        $idCategories = explode(',',trim($idCategories,','));
                        $filter .=' AND cp.id_category IN ('.implode(',',array_map('intval',$idCategories)).')';
                    }
                    $page = (int)Tools::getValue('page');
                    $order_by = Tools::getValue('order_by');
                    if($page <=0)
                        $page = 1;
                    $seller_follow = ($follow = $seller->checkIsFollow()) > 0 ? 1:0;
                    $reported = $this->context->customer->isLogged() &&  $seller->CheckReported($this->context->customer->id,0) ? 1 :0;
                    if($page==1 && !$order_by && !$filter)
                        $cacheShopDetailID = $this->module->_getCacheId(array_merge(array('shop_detail'),str_split((string)$seller->id),array($current_tab,$reported,$seller_follow,date('ymd'))));
                    else
                        $cacheShopDetailID = null;
                    if(!$cacheShopDetailID || !$this->module->isCached('shop/shop.tpl',$cacheShopDetailID))
                    {
                        $this->module->_clearCache('*',$this->module->_getCacheId(array_merge(array('shop_detail'),str_split((string)$seller->id),array($current_tab,$reported,$seller_follow)),false));
                        $totalRecords = (int)$this->getProducts($filter,0,0,'',true);
                        $paggination = new Ets_mp_paggination_class();
                        $paggination->total = $totalRecords;
                        $paggination->url = $this->module->getShopLink(array('id_seller'=>$seller->id,'current_tab'=>$current_tab,'page'=>'_page_'));
                        $paggination->limit =  12;
                        $totalPages = ceil($totalRecords / $paggination->limit);
                        if($page > $totalPages)
                            $page = $totalPages;
                        $paggination->page = $page;
                        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)','shop');
                        if($order_by)
                        {
                            switch ($order_by) {
                                case 'position.asc':
                                    $order_by= 'cp.position asc';
                                    break;
                                case 'name.asc':
                                    $order_by = ' pl.name asc';
                                    break;
                                case 'name.desc':
                                    $order_by =' pl.name desc';
                                    break;
                                case 'price.desc':
                                    $order_by =' product_shop.price desc';
                                    break;
                                case 'price.asc':
                                    $order_by =' product_shop.price asc';
                                    break;
                                case 'new_product':
                                    $order_by =' product_shop.date_add desc';
                                    break;
                                case 'best_sale':
                                    $order_by =' sale.quantity desc';
                                    break;
                                default:
                                    $order_by= 'cp.position asc';
                            }
                        }
                        else
                            $order_by= 'cp.position asc';
                        $reviews = $seller->getAVGReviewProduct();

                        $total_reviews = isset($reviews['avg_grade']) ? $reviews['avg_grade']:0;
                        $count_reviews = isset($reviews['count_grade']) ? $reviews['count_grade']:0;

                        $total_messages = $seller->getTotalMessages();
                        if($total_messages)
                        {
                            $total_messages_reply = $seller->getTotalMessagesReply();
                            $response_rate = Tools::ps_round($total_messages_reply*100/$total_messages,2);
                        }
                        if(Configuration::get('ETS_MP_DISPLAY_PRODUCT_SOLD'))
                        {
                            $total_product_sold = $seller->_getTotalNumberOfProductSold();
                        }
                        if(Configuration::get('ETS_MP_ENABLE_CAPTCHA') && Configuration::get('ETS_MP_ENABLE_CAPTCHA_FOR') && $this->context->customer->isLogged())
                        {
                            $captcha_for = explode(',',Configuration::get('ETS_MP_ENABLE_CAPTCHA_FOR'));
                            if(in_array('shop_report',$captcha_for) &&  !Configuration::get('ETS_MP_NO_CAPTCHA_IS_LOGIN'))
                                $is_captcha = true;
                        }
                        if($seller->id_group && Validate::isLoadedObject($sellerGroup = new Ets_mp_seller_group($seller->id_group,$this->context->language->id)))
                        {
                            $this->context->smarty->assign(
                                array(
                                    'seller_group' => $sellerGroup,

                                )
                            );
                        }
                        $id_ets_css_sub_category = (int)Tools::getValue('id_ets_css_sub_category');
                        $this->context->smarty->assign(
                            array(
                                'seller'=>$seller,
                                'totalProducts' => $totalRecords,
                                'total_all_products' => $seller->getProducts(false,0,0,false,true,true),
                                'total_new_products' => $seller->getNewProducts(false,0,0,false,true,false,$id_ets_css_sub_category),
                                'total_best_seller_products' => $seller->getBestSellerProducts(false,false,false,false,true,false,$id_ets_css_sub_category),
                                'total_special_products' => $seller->getSpecialProducts(false,false,false,false,true,false,$id_ets_css_sub_category),
                                'total_reviews' => (int)$total_reviews,
                                'total_follow' => $seller->getTotalFollow(),
                                'total_reviews_int' => $total_reviews,
                                'count_reviews' => $count_reviews,
                                'total_products' => $seller->getProducts(false,false,false,false,true,true,false),
                                'total_product_sold' => isset($total_product_sold) ? $total_product_sold: false,
                                'link_base' => $this->module->getBaseLink(),
                                'products' => $this->getProducts($filter,$page,$paggination->limit,$order_by),
                                'current_page' => $page,
                                'link_ajax_sort_product_list'=> $this->module->getShopLink(array('id_seller'=>$seller->id)),
                                'paggination' => $paggination->render(),
                                'ajax' => Tools::isSubmit('ajax'),
                                'load_more' => Tools::isSubmit('load_more'),
                                'response_rate' => isset($response_rate) ? $response_rate :false,
                                'idCategories' => $idCategories ,
                                'current_tab' => $current_tab,
                                'product_name' => $product_name,
                                'seller_follow' => $seller_follow,
                                'link_all' => $this->module->getShopLink(array('id_seller'=>$seller->id,'current_tab'=>'all')),
                                'link_new_product' => $this->module->getShopLink(array('id_seller'=>$seller->id,'current_tab'=>'new_product')),
                                'link_best_seller' => $this->module->getShopLink(array('id_seller'=>$seller->id,'current_tab'=>'best_seller')),
                                'link_special' => $this->module->getShopLink(array('id_seller'=>$seller->id,'current_tab'=>'special')),
                                'customer_logged' => $this->context->customer->isLogged(),
                                'reported' => $reported,
                                'is_captcha' => isset($is_captcha) ? $is_captcha:false,
                                'ETS_MP_ENABLE_CAPTCHA_TYPE' => Configuration::get('ETS_MP_ENABLE_CAPTCHA_TYPE'),
                                'ETS_MP_ENABLE_CAPTCHA_SITE_KEY2' => Configuration::get('ETS_MP_ENABLE_CAPTCHA_SITE_KEY2'),
                                'ETS_MP_ENABLE_CAPTCHA_SECRET_KEY2' => Configuration::get('ETS_MP_ENABLE_CAPTCHA_SECRET_KEY2'),
                                'ETS_MP_ENABLE_CAPTCHA_SITE_KEY3' => Configuration::get('ETS_MP_ENABLE_CAPTCHA_SITE_KEY3'),
                                'ETS_MP_ENABLE_CAPTCHA_SECRET_KEY3' => Configuration::get('ETS_MP_ENABLE_CAPTCHA_SECRET_KEY3'),
                                'base_link' => $this->module->getBaseLink(),
                                'report_customer' => $this->context->customer,
                                'is_product_comment' => $this->module->is17 && Module::isInstalled('productcomments') ? true :false,
                                'product_comment_grade_url' => $this->context->link->getModuleLink('productcomments', 'CommentGrade'),
                                'link_load_more' => $page < $totalPages ? $this->module->getShopLink(array('id_seller'=>$seller->id,'current_tab'=>$current_tab,'page'=>$page+1)):false,
                            )
                        );
                        $productIds = $this->getProducts($filter,$page,$paggination->limit,$order_by,false,true);
                        $this->context->smarty->assign(
                            array(
                                'product_list'=> $this->module->displayTpl('shop/product_list.tpl'),
                                'list_categories' => $this->getBlockCategories($productIds),
                            )
                        );
                    }
                    return $this->module->displayTpl('shop/shop.tpl',$cacheShopDetailID);
                }  
            }
            else
            {
                return Ets_mp_defines::displayText('<'.'svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"'.'>'.'<'.'path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/'.'>'.'<'.'/svg'.'>'.$this->module->l('The store doesn\'t exist','shop'),'p','alert alert-warning');
            }
        }
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page =  1;
        $shop_name = Tools::getValue('shop_name');
        $filter = 'AND s.active=1 AND seller_product.total_product >0';
        if($shop_name && Validate::isGenericName($shop_name))
            $filter .=' AND sl.shop_name LIKE "%'.pSQL($shop_name).'%"'; 
        $id_shop_category = Tools::getValue('id_shop_category');
        if($id_shop_category && Validate::isInt($id_shop_category))
            $filter .= ' AND s.id_shop_category='.(int)$id_shop_category;
        if(!Tools::isSubmit('ajax') && !$shop_name && !$id_shop_category && $page==1)
            $cacheID = $this->module->_getCacheId('list_shops');
        else
            $cacheID = null;
        if(!$cacheID || !$this->module->isCached('shop/shops.tpl',$cacheID))
        {
            $totalRecords = (int)Ets_mp_seller::_getSellers($filter,'',0,0,true);
            $paggination = new Ets_mp_paggination_class();
            $paggination->total = $totalRecords;
            $paggination->url = $this->module->getShopLink(array('page'=>'_page_'));
            $paggination->limit =  8;
            $totalPages = ceil($totalRecords / $paggination->limit);
            if($page > $totalPages)
                $page = $totalPages;
            $paggination->page = $page;
            $start = $paggination->limit * ($page - 1);
            if($start < 0)
                $start = 0;
            $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)','shop');
            $paggination->style_links = $this->module->l('links','shop');
            $paggination->style_results = $this->module->l('results','shop');
            $order_by = Tools::getValue('order_by','sale.desc');
            if($order_by)
            {
                switch ($order_by) {
                    case 'sale.desc':
                        $order_by= 'seller_sale.total_sale DESC';
                        break;
                    case 'name.asc':
                        $order_by= 'sl.shop_name asc';
                        break;
                    case 'name.desc':
                        $order_by = ' sl.shop_name desc';
                        break;
                    case 'quantity.desc':
                        $order_by =' seller_product.total_product desc';
                        break;
                    case 'rate.desc':
                        $order_by =' seller_rate.total_grade desc';
                        break;
                    case 'date_add.asc':
                        $order_by =' s.date_add asc';
                        break;
                    case 'date_add.desc':
                        $order_by =' s.date_add desc';
                        break;
                    default:
                        $order_by= 'sl.shop_name asc';
                }
            }
            $sellers = Ets_mp_seller::_getSellers($filter,$order_by,$start,$paggination->limit);
            if($sellers)
            {
                foreach($sellers as &$seller)
                {
                    if($seller['shop_logo'])
                        $seller['shop_logo'] = $seller['shop_logo'];
                    $seller['link_view'] = $this->module->getShopLink(array('id_seller'=>$seller['id_seller']));
                }
            }
            if($sellers)
            {
                foreach($sellers as &$seller)
                {
                    $seller['link'] = $this->module->getShopLink(array('id_seller'=>$seller['id_seller']));
                    $seller['avg_rate_int'] = isset($seller['avg_rate']) ? (int)$seller['avg_rate'] : 0;
                    $seller['avg_rate'] = isset($seller['avg_rate']) ? Tools::ps_round($seller['avg_rate'],2):0;
                }
            }
            $this->context->smarty->assign(
                array(
                    'sellers' => $sellers,
                    'link_base' => $this->module->getBaseLink(),

                )
            );
            if(Tools::isSubmit('ajax'))
            {
                die(
                    json_encode(
                        array(
                            'shop_list'=> $this->module->displayTpl('shop/shop_list.tpl'),
                            'paggination' => $paggination->render(),
                        )
                    )
                );
            }
            else
            {
                $this->context->smarty->assign(
                    array(
                        'paggination' => $paggination->render(),
                        'shop_list'=> $this->module->displayTpl('shop/shop_list.tpl'),
                        'shop_categories' => Ets_mp_shop_category::getShopCategories(' AND c.active=1',0,false)
                    )
                );
            }
        }
        return $this->module->displayTpl('shop/shops.tpl',$cacheID);
    }
    public function getBlockCategories($productIds)
    {
        $category = new Category((int)Configuration::get('PS_HOME_CATEGORY'), $this->context->language->id);
        if(Validate::isLoadedObject($category))
        {
            $categories = Ets_mp_seller::getCategories($category,$productIds);
            $current_tab = Tools::getValue('current_tab','all');
            $this->context->smarty->assign(
                array(
                    'categories' => $categories,
                    'currentCategory' => $category->id,
                    'current_tab' => in_array($current_tab,array('all','new_product','best_seller','special')) ? $current_tab:'all',
                )
            );
            if($categories)
                return $this->module->displayTpl('shop/categories.tpl');
        }
        return false;
    }
    public function getProducts($filter='',$page = 0, $per_page = 12, $order_by = 'p.id_product desc',$total=false,$listIds = false)
    {
        if(($id_seller= (int)Tools::getValue('id_seller')) && Validate::isLoadedObject($seller = new Ets_mp_seller($id_seller,$this->context->language->id)))
        {
            $current_tab = Tools::getValue('current_tab','all');
            $id_ets_css_sub_category = (int)Tools::getValue('id_ets_css_sub_category');
            switch ($current_tab) {
                case 'all':
                    return $seller->getProducts($filter,$page,$per_page,$order_by,$total,true,$listIds);
                case 'new_product':
                    return $seller->getNewProducts($filter,$page,$per_page,$order_by,$total,$listIds,$id_ets_css_sub_category);
                case 'best_seller':
                    return $seller->getBestSellerProducts($filter,$page,$per_page,$order_by,$total,$listIds,$id_ets_css_sub_category);
                case 'special':
                    return $seller->getSpecialProducts($filter,$page,$per_page,$order_by,$total,$listIds,$id_ets_css_sub_category);
                default:
                    return $seller->getProducts($filter,$page,$per_page,$order_by,$total,$listIds,$id_ets_css_sub_category);
            } 
        }
        return array();
    }
}
