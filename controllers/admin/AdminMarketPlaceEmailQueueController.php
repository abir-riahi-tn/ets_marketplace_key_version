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
 * Class AdminMarketPlaceEmailQueueController
 * @property Ets_marketplace $module;
 */
class AdminMarketPlaceEmailQueueController extends ModuleAdminController
{
    /** @var Ets_marketplace */
    public $module;
    public function __construct()
    {
       parent::__construct();
       $this->context= Ets_marketplace::getContextStatic();
       $this->bootstrap = true;
    }
    public function init()
    {
        parent::init();
        $this->module->ajax = (int)Tools::getValue('ajax') ? 1 : 0;
    }
    public function postProcess()
    {
        parent::postProcess();
        if(Tools::isSubmit('submitSendMail') && ($id_ets_mp_mailqueue = (int)Tools::getValue('id_ets_mp_mailqueue')) && Validate::isLoadedObject($mailQueueObj = new Ets_mp_mailqueue($id_ets_mp_mailqueue)))
        {
            $this->submitSendMail($mailQueueObj);
        }
        if(Tools::isSubmit('submitBulkSend') && ($ids = Tools::getValue('bulk_action_selected_mail_queues')) && Ets_marketplace::validateArray($ids,'isUnsignedId'))
        {
            $ok = true;
            foreach($ids as $id)
            {
                $mailQueueObj = new Ets_mp_mailqueue($id);
                if(!$this->submitSendMail($mailQueueObj,true))
                {
                    $this->context->cookie->__set('_error_message', sprintf($this->module->l('Sent email failed', 'AdminMarketPlaceEmailQueueController'),$mailQueueObj->id));
                    $ok =false;
                    break;
                }
            }
            if($ok)
                $this->context->cookie->__set('_success', $this->module->l('Sent email successfully', 'AdminMarketPlaceEmailQueueController'));
            $this->context->cookie->write();
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailQueue', true));
        }
        if(Tools::isSubmit('del') && ($id_ets_mp_mailqueue =(int)Tools::getValue('id_ets_mp_mailqueue')) && Validate::isLoadedObject($mailQueue = new Ets_mp_mailqueue($id_ets_mp_mailqueue)))
        {
            if($mailQueue->delete())
            {
                $this->context->cookie->__set('_success', $this->module->l('Delete email successfully', 'AdminMarketPlaceEmailQueueController'));
            }
            else
            {
                $this->context->cookie->__set('_error_message', $this->module->l('Deleted email failed', 'AdminMarketPlaceEmailQueueController'));
            }
            $this->context->cookie->write();
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailQueue', true));

        }
        if(Tools::isSubmit('submitBulkDelete') && ($ids = Tools::getValue('bulk_action_selected_mail_queues')) && Ets_marketplace::validateArray($ids,'isUnsignedId'))
        {
            if(Ets_mp_mailqueue::deleteSelected($ids))
                $this->context->cookie->__set('_success', $this->module->l('Delete email successfully', 'AdminMarketPlaceEmailQueueController'));
            else
                $this->context->cookie->__set('_error_message', $this->module->l('Deleted email failed', 'AdminMarketPlaceEmailQueueController'));
            $this->context->cookie->write();
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailQueue', true));
        }
    }

    public function initContent()
    {
        parent::initContent();
    }
    public function renderList()
    {
        $this->module->getContent();
        $this->context->smarty->assign(
            array(
                'ets_mp_body_html'=> $this->displayMailQueue(),
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
    public function displayMailQueue()
    {
        $fields_list = array(
            'input_box' => array(
                'title' => '',
                'width' => 40,
                'type' => 'text',
                'strip_tag'=> false,
            ),
            'id_ets_mp_mailqueue' => array(
                'title' => $this->module->l('Queue ID', 'AdminMarketPlaceEmailQueueController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'subject' => array(
                'title' => $this->module->l('Subject', 'AdminMarketPlaceEmailQueueController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),  
            'content' => array(
                'title' => $this->module->l('Content', 'AdminMarketPlaceEmailQueueController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false,
            ),      
            'email' => array(
                'title'=> $this->module->l('Email', 'AdminMarketPlaceEmailQueueController'),
                'type' => 'text',
                'filter' => true,
                'sort' => true,
            ),
            'sending_time' => array(
                'title' => $this->module->l('Trying time', 'AdminMarketPlaceEmailQueueController'),
                'type'=> 'date',
                'sort' => true,
                'filter' => true,
            ),
            'date_add' => array(
                'title' => $this->module->l('Queue at', 'AdminMarketPlaceEmailQueueController'),
                'type'=> 'date',
                'sort' => true,
                'filter' => true,
            ),
        );
        $filter = '';
        $show_resset = false;
        if(($id_ets_mp_mailqueue = Tools::getValue('id_ets_mp_mailqueue'))!='' && Validate::isCleanHtml($id_ets_mp_mailqueue))
        {
            $filter .= ' AND q.id_ets_mp_mailqueue='.(int)$id_ets_mp_mailqueue;
            $show_resset = true;
        }
        if(($subject=Tools::getValue('subject'))!='' && Validate::isCleanHtml($subject))
        {
            $filter .= ' AND q.subject LIKE "%'.pSQL($subject).'%"';
            $show_resset = true;
        }
        if(($content=Tools::getValue('content'))!='' && Validate::isCleanHtml($content))
        {
            $filter .= ' AND q.content LIKE "%'.pSQL($content).'%"';
            $show_resset = true;
        }
        if(($email = Tools::getValue('email'))!='' && Validate::isCleanHtml($email))
        {
            $filter .= ' AND q.email LIKE "%'.pSQL($email).'%"';
            $show_resset = true;
        }
        if(($sending_time_min = Tools::getValue('sending_time_min'))!='' && Validate::isDate($sending_time_min))
        {
            $filter .= ' AND q.sending_time >= "'.pSQL($sending_time_min).' 00:00:00"';
            $show_resset = true;
        }
        if(($sending_time_max = Tools::getValue('sending_time_max'))!='' && Validate::isDate($sending_time_max))
        {
            $filter .= ' AND q.sending_time <= "'.pSQL($sending_time_max).' 23:59:59"';
            $show_resset = true;
        }
        if(($date_add_min = Tools::getValue('date_add_min'))!='' && Validate::isDate($date_add_min))
        {
            $filter .= ' AND q.date_add >= "'.pSQL($date_add_min).' 00:00:00"';
            $show_resset = true;
        }
        if(($date_add_max = Tools::getValue('date_add_max'))!='' && Validate::isDate($date_add_max))
        {
            $filter .= ' AND q.date_add <= "'.pSQL($date_add_max).' 23:59:59"';
            $show_resset = true;
        }
        $sort = "";
        $sort_type=Tools::getValue('sort_type','asc');
        $sort_value = Tools::getValue('sort','id_ets_mp_mailqueue');
        if($sort_value)
        {
            switch ($sort_value) {
                case 'id_ets_mp_mailqueue':
                    $sort .=' q.id_ets_mp_mailqueue';
                    break;
                case 'subject':
                    $sort .=' q.subject';
                    break;
                case 'content':
                    $sort .=' q.content';
                    break;
                case 'email':
                    $sort .=' q.email';
                    break;
                case 'sending_time':
                    $sort .=' q.sending_time';
                    break;
                case 'date_add':
                    $sort .=' q.date_add';
                    break;
            }
            if($sort && $sort_type && in_array($sort_type,array('asc','desc')))
                $sort .= ' '.$sort_type;
        }
        //Paggination
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page = 1;
        $totalRecords = (int)Ets_mp_mailqueue::getMailQueuesByFilter($filter,$sort,0,0,true);
        $paggination = new Ets_mp_paggination_class();
        $paggination->total = $totalRecords;
        $paggination->url = $this->context->link->getAdminLink('AdminMarketPlaceEmailQueue').'&page=_page_'.$this->module->getFilterParams($fields_list,'mail_queue');
        $paggination->limit = (int)Tools::getValue('paginator_mail_queue_select_limit',20);
        $paggination->name ='mail_queue';
        $totalPages = ceil($totalRecords / $paggination->limit);
        if($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $start = $paggination->limit * ($page - 1);
        if($start < 0)
            $start = 0;
        $mail_queues = Ets_mp_mailqueue::getMailQueuesByFilter($filter,$sort,$start,$paggination->limit,false);
        if($mail_queues)
        {
            foreach($mail_queues as &$mail_queue)
            {
                $mail_queue['input_box'] = Ets_mp_defines::displayText('','input','','bulk_action_selected-mail-queue'.$mail_queue['id_ets_mp_mailqueue'],'','','','bulk_action_selected_mail_queues[]',$mail_queue['id_ets_mp_mailqueue'],'checkbox');
                preg_match("/<"."body[^>]*>(.*?)<\/body>/is", $mail_queue['content'], $matches);
                if(isset($matches[1]))
                    $mail_queue['content'] = trim(strip_tags($matches[1]));
                else
                    $mail_queue['content'] = trim(strip_tags($mail_queue['content']));
            }
        }
        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)', 'AdminMarketPlaceEmailQueueController');
        $paggination->style_links = $this->module->l('links', 'AdminMarketPlaceEmailQueueController');
        $paggination->style_results = $this->module->l('results', 'AdminMarketPlaceEmailQueueController');
        $listData = array(
            'name' => 'mail_queue',
            'actions' => array('send_mail','delete'),
            'icon' => 'icon-rule',
            'currentIndex' => $this->context->link->getAdminLink('AdminMarketPlaceEmailQueue').($paggination->limit!=20 ? '&paginator_mail_queue_select_limit='.$paggination->limit:''),
            'postIndex' => $this->context->link->getAdminLink('AdminMarketPlaceEmailQueue'),
            'identifier' => 'id_ets_mp_mailqueue',
            'show_toolbar' => true,
            'show_action' => true,
            'show_add_new' => false,
            'show_bulk_action' => true,
            'link_new' => false,
            'title' => $this->module->l('Mail queues', 'AdminMarketPlaceEmailQueueController'),
            'fields_list' => $fields_list,
            'field_values' => $mail_queues,
            'paggination' => $paggination->render(),
            'filter_params' => $this->module->getFilterParams($fields_list,'mail_queue'),
            'show_reset' =>$show_resset,
            'totalRecords' => $totalRecords,
            'sort'=> $sort_value,
            'sort_type' => $sort_type,
        );            
        return  $this->module->renderList($listData);
    }
    public function getBodyContent($html)
    {
        $d = new DOMDocument;
        $mock = new DOMDocument;
        $d->loadHTML($html);
        $body = $d->getElementsByTagName('body')->item(0);
        foreach ($body->childNodes as $child){
            $mock->appendChild($mock->importNode($child, true));
        }
        
        return $mock->saveHTML();
    }

    public function submitSendMail($mailQueueObj,$multi=false)
    {
        $mailQueueObj->sending_time = date('Y-m-d H:i:s');
        $mailQueueObj->update();
        $mailTracking =  Ets_mp_mailtraciking::getMailtrackingByQueue($mailQueueObj->id);
        $mailTracking->id_customer = $mailQueueObj->id_customer;
        $mailTracking->id_employee = $mailQueueObj->id_employee;
        $mailTracking->customer_name = $mailQueueObj->customer_name;
        $mailTracking->queue_date = $mailQueueObj->date_add;
        $mailTracking->subject = $mailQueueObj->subject;
        $mailTracking->content = $mailQueueObj->content;
        $mailTracking->date_add = date('Y-m-d H:i:s');
        $mailTracking->email = $mailQueueObj->email;
        $mailTracking->status = 'time_out';
        if($mailTracking->id)
            $mailTracking->update();
        else
            $mailTracking->add();
        if($mailTracking->id)
        {
            $ok = $mailQueueObj->sendMail(false,$mailTracking->id);
            if($ok)
            {
                $mailTracking->status ='success';
                $mailQueueObj->delete();
            }
            else
            {
                $mailTracking->status ='failed';
            }
            $mailTracking->update();
            if($ok)
            {
                if($multi)
                    return true;
                if(Tools::isSubmit('ajax'))
                {
                    die(
                        json_encode(
                            array(
                                'success' => $this->module->l('Sent email successfully', 'AdminMarketPlaceEmailQueueController'),
                            )
                        )
                    );
                }
                else
                {
                    $this->context->cookie->__set('success', $this->module->l('Sent email successfully', 'AdminMarketPlaceEmailQueueController'));
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailQueue', true));
                }
            }
            else
            {
                if($multi)
                    return false;
                if(Tools::isSubmit('ajax'))
                {
                    die(
                        json_encode(
                            array(
                                'errors' => $this->module->l('Sent email failed', 'AdminMarketPlaceEmailQueueController'),
                            )
                        )
                    );
                }
                else
                {
                    $this->context->cookie->__set('error_message', $this->module->l('Sent email failed', 'AdminMarketPlaceEmailQueueController'));
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailQueue', true));
                }
            }
        }
    }
}
