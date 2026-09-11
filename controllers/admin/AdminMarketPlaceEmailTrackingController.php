<?php
/**
 * 2007-2022 ETS-Soft
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
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please contact us for extra customization service at an affordable price
 *
 *  @author ETS-Soft < etssoft.jsc@gmail.com >
 *  @copyright  2007-2022 ETS-Soft
 *  @license    EUPL
 *  International Registered Trademark & Property of ETS-Soft
 */

if (!defined('_PS_VERSION_')) { exit; }
/**
 * Class AdminMarketPlaceEmailTrackingController
 * @property Ets_marketplace $module;
 */
class AdminMarketPlaceEmailTrackingController extends ModuleAdminController
{
    /** @var Ets_marketplace */
    public $module;
    public function __construct()
    {
        parent::__construct();
        $this->context= Ets_marketplace::getContextStatic();
        $this->bootstrap = true;
    }
    public function postProcess()
    {
        parent::postProcess();
        if(Tools::isSubmit('del') && ($id_ets_mp_mailtraciking =(int)Tools::getValue('id_ets_mp_mailtraciking')) && Validate::isLoadedObject($mailTracking = new Ets_mp_mailtraciking($id_ets_mp_mailtraciking)))
        {
            if($mailTracking->delete())
            {
                $this->context->cookie->__set('_success', $this->module->l('Deleted mail tracking succesfully', 'AdminMarketPlaceEmailTrackingController'));
            }
            else
            {
                $this->context->cookie->__set('_error_message', $this->module->l('Deleted mail tracking failed', 'AdminMarketPlaceEmailTrackingController'));
            }
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailTracking', true));
            $this->context->cookie->write();
        }
        if(Tools::isSubmit('submitBulkDelete') && ($ids = Tools::getValue('bulk_action_selected_mail_trackings')) && Ets_marketplace::validateArray($ids,'isUnsignedId'))
        {
            if(Ets_mp_mailtraciking::deleteSelected($ids))
                $this->context->cookie->__set('_success', $this->module->l('Delete selected mail tracking successfully', 'AdminMarketPlaceEmailTrackingController'));
            else
                $this->context->cookie->__set('_error_message', $this->module->l('Deleted mail tracking failed', 'AdminMarketPlaceEmailTrackingController'));
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailTracking', true));
            $this->context->cookie->write();
        }
    }
    public function renderList()
    {
        $this->module->getContent();
        $this->context->smarty->assign(
            array(
                'ets_mp_body_html'=> $this->displayMailTracking(),
            )
        );
        $html ='';
        if($this->context->cookie->__get('_success'))
        {
            $html .= $this->module->displayConfirmation($this->context->cookie->__get('_success'));
            $this->context->cookie->__set('_success', '');
        }
        if($this->context->cookie->__get('_error_message'))
            $html .= $this->module->displayError($this->context->cookie->__get('_error_message'));
        return $html.$this->module->display($this->module->getLocalPath(), 'admin.tpl');
    }
    public function displayMailTracking()
    {
        $fields_list = array(
            'input_box' => array(
                'title' => '',
                'width' => 40,
                'type' => 'text',
                'strip_tag'=> false,
            ),
            'id_ets_mp_mailtraciking' => array(
                'title' => $this->module->l('ID', 'AdminMarketPlaceEmailTrackingController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'customer_name' => array(
                'title' => $this->module->l('Customer', 'AdminMarketPlaceEmailTrackingController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag'=> false,
            ),
            'subject' => array(
                'title' => $this->module->l('Subject', 'AdminMarketPlaceEmailTrackingController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'content' => array(
                'title' => $this->module->l('Content', 'AdminMarketPlaceEmailTrackingController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false,
            ),
            'status'=> array(
                'title' => $this->module->l('Execute status', 'AdminMarketPlaceEmailTrackingController'),
                'type' => 'select',
                'sort' => false,
                'filter' => true,
                'strip_tag'=>false,
                'filter_list' => array(
                    'id_option' => 'active',
                    'value' => 'title',
                    'list' => array(
                        array(
                            'active' => 'read',
                            'title' => $this->module->l('Read', 'AdminMarketPlaceEmailTrackingController'),
                        ),
                        array(
                            'active' => 'success',
                            'title' => $this->module->l('Delivered', 'AdminMarketPlaceEmailTrackingController'),
                        ),
                        array(
                            'active' => 'failed',
                            'title' => $this->module->l('Failed', 'AdminMarketPlaceEmailTrackingController')
                        ),
                        array(
                            'active' =>'time_out',
                            'title' => $this->module->l('Time out', 'AdminMarketPlaceEmailTrackingController'),
                        )
                    )
                )
            ),
            'queue_date' => array(
                'title' => $this->module->l('Queue date', 'AdminMarketPlaceEmailTrackingController'),
                'type'=> 'date',
                'sort' => true,
                'filter' => true,
            ),
            'date_add' => array(
                'title' => $this->module->l('Sent date', 'AdminMarketPlaceEmailTrackingController'),
                'type'=> 'date',
                'sort' => true,
                'filter' => true,
            ),
        );
        $filter = '';
        $show_resset = false;
        if(($id_ets_mp_mailtraciking = Tools::getValue('id_ets_mp_mailtraciking'))!='' && Validate::isCleanHtml($id_ets_mp_mailtraciking))
        {
            $filter .= ' AND m.id_ets_mp_mailtraciking='.(int)$id_ets_mp_mailtraciking;
            $show_resset = true;
        }
        if(($customer_name=Tools::getValue('customer_name'))!='' && Validate::isCleanHtml($customer_name))
        {
            $filter .= ' AND (m.customer_name LIKE "%'.pSQL($customer_name).'%" OR m.email LIKE "%'.pSQL($customer_name).'%" )';
            $show_resset = true;
        }
        if(($status = Tools::getValue('status'))!='' && Validate::isCleanHtml($status))
        {
            $filter .= ' AND m.status = "'.pSQL($status).'"';
            $show_resset = true;
        }
        if(($subject=Tools::getValue('subject'))!='' && Validate::isCleanHtml($subject))
        {
            $filter .= ' AND m.subject LIKE "%'.pSQL($subject).'%"';
            $show_resset = true;
        }
        if(($content=Tools::getValue('content'))!='' && Validate::isCleanHtml($content))
        {
            $filter .= ' AND m.content LIKE "%'.pSQL($content).'%"';
            $show_resset = true;
        }
        if(($queue_date_min = Tools::getValue('queue_date_min'))!='' && Validate::isDate($queue_date_min))
        {
            $filter .= ' AND m.queue_date >= "'.pSQL($queue_date_min).' 00:00:00"';
            $show_resset = true;
        }
        if(($queue_date_max = Tools::getValue('queue_date_max'))!='' && Validate::isDate($queue_date_max))
        {
            $filter .= ' AND m.queue_date <= "'.pSQL($queue_date_max).' 23:59:59"';
            $show_resset = true;
        }
        if(($date_add_min = Tools::getValue('date_add_min'))!='' && Validate::isDate($date_add_min))
        {
            $filter .= ' AND m.date_add >= "'.pSQL($date_add_min).' 00:00:00"';
            $show_resset = true;
        }
        if(($date_add_max = Tools::getValue('date_add_max'))!='' && Validate::isDate($date_add_max))
        {
            $filter .= ' AND m.date_add <= "'.pSQL($date_add_max).' 23:59:59"';
            $show_resset = true;
        }
        $sort = "";
        $sort_type=Tools::getValue('sort_type','desc');
        $sort_value = Tools::getValue('sort','id_ets_mp_mailtraciking');
        if($sort_value)
        {
            switch ($sort_value) {
                case 'id_ets_mp_mailtraciking':
                    $sort .=' m.id_ets_mp_mailtraciking';
                    break;
                case 'customer_name':
                    $sort .=' m.customer_name';
                    break;
                case 'status':
                    $sort .=' m.status';
                    break;
                case 'subject':
                    $sort .=' m.subject';
                    break;
                case 'content':
                    $sort .=' m.content';
                    break;
                case 'queue_date':
                    $sort .=' m.queue_date';
                    break;
                case 'date_add':
                    $sort .=' m.date_add';
                    break;
            }
            if($sort && $sort_type && in_array($sort_type,array('asc','desc')))
                $sort .= ' '.$sort_type;
        }
        //Paggination
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page = 1;
        $totalRecords = (int)Ets_mp_mailtraciking::getMailTrackings($filter,$sort,0,0,true);
        $paggination = new Ets_mp_paggination_class();
        $paggination->total = $totalRecords;
        $paggination->url = $this->context->link->getAdminLink('AdminMarketPlaceEmailTracking').'&page=_page_'.$this->module->getFilterParams($fields_list,'mail_tracking');
        $paggination->limit = (int)Tools::getValue('paginator_mail_tracking_select_limit',20);
        $paggination->name ='mail_tracking';
        $totalPages = ceil($totalRecords / $paggination->limit);
        if($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $start = $paggination->limit * ($page - 1);
        if($start < 0)
            $start = 0;
        $mail_trackings = Ets_mp_mailtraciking::getMailTrackings($filter,$sort,$start,$paggination->limit,false);
        if($mail_trackings)
        {

            foreach($mail_trackings as &$mail_tracking)
            {
                $mail_tracking['input_box'] = Ets_mp_defines::displayText('','input','','bulk_action_selected-mail-tracking'.$mail_tracking['id_ets_mp_mailtraciking'],'','','','bulk_action_selected_mail_trackings[]',$mail_tracking['id_ets_mp_mailtraciking'],'checkbox');
                preg_match("/<"."body[^>]*>(.*?)<\/body>/is", $mail_tracking['content'], $matches);
                if(isset($matches[1]) && $matches[1])
                    $mail_tracking['content'] = trim(strip_tags($matches[1]));
                if($mail_tracking['status']=='read')
                    $mail_tracking['status'] = Ets_mp_defines::displayText($this->module->l('Read', 'AdminMarketPlaceEmailTrackingController'),'span','ets_mp_status read');
                elseif($mail_tracking['status']=='success')
                    $mail_tracking['status'] = Ets_mp_defines::displayText($this->module->l('Delivered', 'AdminMarketPlaceEmailTrackingController'),'span','ets_mp_status success');
                elseif($mail_tracking['status']=='time_out')
                    $mail_tracking['status'] = Ets_mp_defines::displayText($this->module->l('Time out', 'AdminMarketPlaceEmailTrackingController'),'span','ets_mp_status timeout');
                else
                    $mail_tracking['status'] = Ets_mp_defines::displayText($this->module->l('Failed', 'AdminMarketPlaceEmailTrackingController'),'span','ets_mp_status failed');
                $mail_tracking['customer_name'] = Ets_mp_defines::displayText($mail_tracking['customer_name'],'a',null,null,Ets_marketplace::getContextStatic()->link->getAdminLink('AdminCustomers').'&id_customer='.(int)$mail_tracking['id_customer'].'&viewcustomer').Tools::nl2br("\n".$mail_tracking['email']);
            }
        }
        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)', 'AdminMarketPlaceEmailTrackingController');
        $paggination->style_links = $this->module->l('links', 'AdminMarketPlaceEmailTrackingController');
        $paggination->style_results = $this->module->l('results', 'AdminMarketPlaceEmailTrackingController');
        $listData = array(
            'name' => 'mail_tracking',
            'actions' => array('delete'),
            'icon' => 'icon-rule',
            'currentIndex' => $this->context->link->getAdminLink('AdminMarketPlaceEmailTracking').($paggination->limit!=20 ? '&paginator_mail_tracking_select_limit='.$paggination->limit:''),
            'postIndex' => $this->context->link->getAdminLink('AdminMarketPlaceEmailTracking'),
            'identifier' => 'id_ets_mp_mailtraciking',
            'show_toolbar' => true,
            'show_action' => true,
            'show_add_new' => false,
            'link_new' => false,
            'title' => $this->module->l('Mail trackings', 'AdminMarketPlaceEmailTrackingController'),
            'fields_list' => $fields_list,
            'field_values' => $mail_trackings,
            'paggination' => $paggination->render(),
            'filter_params' => $this->module->getFilterParams($fields_list,'mail_tracking'),
            'show_reset' =>$show_resset,
            'totalRecords' => $totalRecords,
            'sort'=> $sort_value,
            'sort_type' => $sort_type,
            'show_bulk_action'=>true,
        );
        return  $this->module->renderList($listData);
    }
}
