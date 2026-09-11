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
 * Class AdminMarketPlaceEmailLogController
 * @property Ets_marketplace $module
 */
class AdminMarketPlaceEmailLogController extends ModuleAdminController
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
        if(Tools::isSubmit('del') && ($id_ets_mp_maillog =(int)Tools::getValue('id_ets_mp_maillog')) && Validate::isLoadedObject($mailLog = new Ets_mp_maillog($id_ets_mp_maillog)))
        {
            if($mailLog->delete())
            {
                $this->context->cookie->__set('_success', $this->module->l('Deleted mail successfully', 'AdminMarketPlaceEmailLogController'));
            }
            else
            {
                $this->context->cookie->__set('_error_message', $this->module->l('Deleted email failed', 'AdminMarketPlaceEmailLogController'));
            }
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailLog', true));
            $this->context->cookie->write();
        }
        if(Tools::isSubmit('submitBulkDelete') && ($ids = Tools::getValue('bulk_action_selected_mail_logs')) && Ets_marketplace::validateArray($ids,'isUnsignedId'))
        {
            if(Ets_mp_maillog::deleteSelected($ids))
                $this->context->cookie->__set('_success', $this->module->l('Deleted mail successfully', 'AdminMarketPlaceEmailLogController'));
            else
                $this->context->cookie->__set('_error_message', $this->module->l('Deleted email failed', 'AdminMarketPlaceEmailLogController'));
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailLog', true));
            $this->context->cookie->write();
        }
        if(Tools::isSubmit('deleteAllLog'))
        {
            if(Ets_mp_maillog::deleteAll())
                $this->context->cookie->__set('_success', $this->module->l('Deleted mail successfully', 'AdminMarketPlaceEmailLogController'));
            else
                $this->context->cookie->__set('_error_message', $this->module->l('Deleted email failed', 'AdminMarketPlaceEmailLogController'));
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminMarketPlaceEmailLog', true));
            $this->context->cookie->write();
        }
        if(Tools::isSubmit('ajax') && Tools::isSubmit('viewLog') && ($id_ets_mp_maillog= (int)Tools::getValue('id_ets_mp_maillog')))
        {
            $this->viewMaillog($id_ets_mp_maillog);
        }
    }
    public function renderList()
    {
        $this->module->getContent();
        $this->context->smarty->assign(
            array(
                'ets_mp_body_html'=> Tools::isSubmit('viewLog') && ($id_ets_mp_maillog= (int)Tools::getValue('id_ets_mp_maillog')) ? $this->viewMaillog($id_ets_mp_maillog) : $this->displayMailLog(),
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
    public function displayMailLog()
    {
        $fields_list = array(
            'input_box' => array(
                'title' => '',
                'width' => 40,
                'type' => 'text',
                'strip_tag'=> false,
            ),
            'id_ets_mp_maillog' => array(
                'title' => $this->module->l('ID', 'AdminMarketPlaceEmailLogController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'id_ets_mp_mailqueue' => array(
                'title' => $this->module->l('Queue ID', 'AdminMarketPlaceEmailLogController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'subject' => array(
                'title' => $this->module->l('Subject', 'AdminMarketPlaceEmailLogController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'content' => array(
                'title' => $this->module->l('Content', 'AdminMarketPlaceEmailLogController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false,
            ),
            'customer_name' => array(
                'title' => $this->module->l('Customer', 'AdminMarketPlaceEmailLogController'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag'=> false,
            ),
            'status'=> array(
                'title' => $this->module->l('Execute status', 'AdminMarketPlaceEmailLogController'),
                'type' => 'select',
                'sort' => false,
                'filter' => true,
                'strip_tag'=>false,
                'filter_list' => array(
                    'id_option' => 'active',
                    'value' => 'title',
                    'list' => array(
                        array(
                            'active' => 'success',
                            'title' => $this->module->l('Success', 'AdminMarketPlaceEmailLogController'),
                        ),
                        array(
                            'active' => 'failed',
                            'title' => $this->module->l('Failed', 'AdminMarketPlaceEmailLogController')
                        ),
                        array(
                            'active'=>'time_out',
                            'title' => $this->module->l('Time out', 'AdminMarketPlaceEmailLogController')
                        ),
                    )
                )
            ),
            'date_add' => array(
                'title' => $this->module->l('Sent time', 'AdminMarketPlaceEmailLogController'),
                'type'=> 'date',
                'sort' => true,
                'filter' => true,
            ),
        );
        $filter = '';
        $show_resset = false;
        if(($id_ets_mp_maillog = Tools::getValue('id_ets_mp_maillog'))!='' && Validate::isCleanHtml($id_ets_mp_maillog))
        {
            $filter .= ' AND l.id_ets_mp_maillog='.(int)$id_ets_mp_maillog;
            $show_resset = true;
        }
        if(($id_ets_mp_mailqueue = Tools::getValue('id_ets_mp_mailqueue'))!='' && Validate::isCleanHtml($id_ets_mp_mailqueue))
        {
            $filter .= ' AND l.id_ets_mp_mailqueue='.(int)$id_ets_mp_mailqueue;
            $show_resset = true;
        }
        if(($version=Tools::getValue('version'))!='' && Validate::isCleanHtml($version))
        {
            $filter .= ' AND l.version LIKE "%'.pSQL($version).'%"';
            $show_resset = true;
        }
        if(($subject=Tools::getValue('subject'))!='' && Validate::isCleanHtml($subject))
        {
            $filter .= ' AND l.subject LIKE "%'.pSQL($subject).'%"';
            $show_resset = true;
        }
        if(($content=Tools::getValue('content'))!='' && Validate::isCleanHtml($content))
        {
            $filter .= ' AND l.content = "'.pSQL($content).'"';
            $show_resset = true;
        }
        if(($customer_name=Tools::getValue('customer_name'))!='' && Validate::isCleanHtml($customer_name))
        {
            $filter .= ' AND (l.customer_name LIKE "%'.pSQL($customer_name).'%" OR l.email LIKE "%'.pSQL($customer_name).'%" )';
            $show_resset = true;
        }
        if(($product_name=Tools::getValue('product_name'))!='' && Validate::isCleanHtml($product_name))
        {
            $filter .= ' AND l.product_name like "%'.pSQL($product_name).'%"';
            $show_resset = true;
        }
        if(($date_add_min = Tools::getValue('date_add_min'))!='' && Validate::isDate($date_add_min))
        {
            $filter .= ' AND l.date_add >= "'.pSQL($date_add_min).' 00:00:00"';
            $show_resset = true;
        }
        if(($date_add_max = Tools::getValue('date_add_max'))!='' && Validate::isDate($date_add_max))
        {
            $filter .= ' AND l.date_add <= "'.pSQL($date_add_max).' 23:59:59"';
            $show_resset = true;
        }
        if(($status = Tools::getValue('status'))!='' && Validate::isCleanHtml($status))
        {
            $filter .= ' AND l.status = "'.pSQL($status).'"';
            $show_resset = true;
        }
        $sort = "";
        $sort_type=Tools::getValue('sort_type','asc');
        $sort_value = Tools::getValue('sort','id_ets_mp_maillog');
        if($sort_value)
        {
            switch ($sort_value) {
                case 'id_ets_mp_maillog':
                    $sort .=' l.id_ets_mp_maillog';
                    break;
                case 'id_ets_mp_mailqueue':
                    $sort .=' l.id_ets_mp_mailqueue';
                    break;
                case 'subject':
                    $sort .=' l.subject';
                    break;
                case 'content':
                    $sort .=' l.content';
                    break;
                case 'customer_name':
                    $sort .=' l.customer_name';
                    break;
                case 'status':
                    $sort .=' l.status';
                    break;
                case 'version':
                    $sort .=' l.version';
                    break;
                case 'queue_date':
                    $sort .=' l.queue_date';
                    break;
                case 'date_add':
                    $sort .=' l.date_add';
                    break;
            }
            if($sort && $sort_type && in_array($sort_type,array('asc','desc')))
                $sort .= ' '.$sort_type;
        }
        //Paggination
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page = 1;
        $totalRecords = (int)Ets_mp_maillog::getMailLogs($filter,$sort,0,0,true);
        $paggination = new Ets_mp_paggination_class();
        $paggination->total = $totalRecords;
        $paggination->url = $this->context->link->getAdminLink('AdminMarketPlaceEmailLog').'&page=_page_'.$this->module->getFilterParams($fields_list,'mail_log');
        $paggination->limit = (int)Tools::getValue('paginator_mail_log_select_limit',20);
        $paggination->name ='mail_log';
        $totalPages = ceil($totalRecords / $paggination->limit);
        if($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $start = $paggination->limit * ($page - 1);
        if($start < 0)
            $start = 0;
        $mail_logs = Ets_mp_maillog::getMailLogs($filter,$sort,$start,$paggination->limit,false);
        if($mail_logs)
        {
            foreach($mail_logs as &$mail_log)
            {
                $mail_log['input_box'] = Ets_mp_defines::displayText('','input','','bulk_action_selected-mail-log'.$mail_log['id_ets_mp_maillog'],'','','','bulk_action_selected_mail_logs[]',$mail_log['id_ets_mp_maillog'],'checkbox');
                preg_match("/"."<"."body[^>]*".">(.*?)"."<\/body>/is", $mail_log['content'], $matches);
                if(isset($matches[1]) && $matches[1])
                    $mail_log['content'] = trim(strip_tags($matches[1]));
                if($mail_log['status']=='time_out')
                    $mail_log['status'] =Ets_mp_defines::displayText($this->module->l('Time out', 'AdminMarketPlaceEmailLogController'),'span','ets_mp_status timeout');
                else
                    $mail_log['status'] = $mail_log['status']=='success' ? Ets_mp_defines::displayText($this->module->l('Success', 'AdminMarketPlaceEmailLogController'),'span','ets_mp_status success') : Ets_mp_defines::displayText($this->module->l('Failed', 'AdminMarketPlaceEmailLogController'),'span','ets_mp_status failed');
                $mail_log['customer_name'] = Ets_mp_defines::displayText($mail_log['customer_name'],'a',null,null,Ets_marketplace::getContextStatic()->link->getAdminLink('AdminCustomers').'&id_customer='.(int)$mail_log['id_customer'].'&viewcustomer').Tools::nl2br("\n".$mail_log['email']);
                $mail_log['child_view_url'] = $this->context->link->getAdminLink('AdminMarketPlaceEmailLog').'&viewLog=1&id_ets_mp_maillog='.$mail_log['id_ets_mp_maillog'];
            }
        }
        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)', 'AdminMarketPlaceEmailLogController');
        $paggination->style_links = $this->module->l('links', 'AdminMarketPlaceEmailLogController');
        $paggination->style_results = $this->module->l('results', 'AdminMarketPlaceEmailLogController');
        $listData = array(
            'name' => 'mail_log',
            'actions' => array('view','delete'),
            'icon' => 'icon-rule',
            'currentIndex' => $this->context->link->getAdminLink('AdminMarketPlaceEmailLog').($paggination->limit!=20 ? '&paginator_mail_log_select_limit='.$paggination->limit:''),
            'postIndex' => $this->context->link->getAdminLink('AdminMarketPlaceEmailLog'),
            'identifier' => 'id_ets_mp_maillog',
            'show_toolbar' => true,
            'show_action' => true,
            'show_add_new' => false,
            'link_new' => false,
            'title' => $this->module->l('Mail logs', 'AdminMarketPlaceEmailLogController'),
            'fields_list' => $fields_list,
            'field_values' => $mail_logs,
            'paggination' => $paggination->render(),
            'filter_params' => $this->module->getFilterParams($fields_list,'mail_log'),
            'show_reset' =>$show_resset,
            'totalRecords' => $totalRecords,
            'sort'=> $sort_value,
            'sort_type' => $sort_type,
            'show_bulk_action'=>true,
            'link_delete_all' => $this->context->link->getAdminLink('AdminMarketPlaceEmailLog').'&deleteAllLog=1',
        );
        return  $this->module->renderList($listData);
    }
    public function viewMaillog($id_ets_mp_maillog)
    {
        $mailLog = new Ets_mp_maillog($id_ets_mp_maillog);
        if(Validate::isLoadedObject($mailLog))
        {
            $lang = new Language($mailLog->id_lang);
            if(!Validate::isLoadedObject($lang))
                $lang = $this->context->language;
            if(file_exists(dirname(__FILE__).'/../../mails/'.$lang->iso_code.'/queue_mail.html'));
            {
                if (false !== Configuration::get('PS_LOGO_MAIL') &&
                    file_exists(_PS_IMG_DIR_ . Configuration::get('PS_LOGO_MAIL'))
                ) {
                    $logo =  Configuration::get('PS_LOGO_MAIL');
                } else {
                    if (file_exists(_PS_IMG_DIR_ . Configuration::get('PS_LOGO'))) {
                        $logo = Configuration::get('PS_LOGO');
                    } else {
                        $logo ='';
                    }
                }
                if($logo)
                    $PS_SHOP_LOGO = Ets_marketplace::getContextStatic()->link->getMediaLink(_PS_IMG_.$logo);
                else
                    $PS_SHOP_LOGO ='';
                $mail_content = Tools::file_get_contents(dirname(__FILE__).'/../../mails/'.$lang->iso_code.'/queue_mail.html');
                $mail_content = str_replace(
                    array(
                        '{content_html}',
                        '{shop_logo}',
                        '{shop_name}',
                        '{shop_url}'
                    ),
                    array(
                        $mailLog->content,
                        $PS_SHOP_LOGO,
                        Configuration::get('PS_SHOP_NAME'),
                        Ets_marketplace::getContextStatic()->link->getPageLink('index')
                    ),
                    $mail_content
                );
                if(Tools::isSubmit('ajax'))
                {
                    die(
                        json_encode(
                            array(
                                'mail_content' =>$mail_content,
                                'subject' => $mailLog->subject,
                                'title' => $this->module->l('Mail logs', 'AdminMarketPlaceEmailLogController'),
                            )
                        )
                    );
                }
                return $mail_content;

            }
        }
    }
}
