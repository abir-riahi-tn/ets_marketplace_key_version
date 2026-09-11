{*
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
*}
<script type="text/javascript">
    var expired_text ='{l s='Expired' mod='ets_marketplace' js=1}';
    var pending_text ='{l s='Pending' mod='ets_marketplace' js=1}';
    var actived_text ='{l s='Active' mod='ets_marketplace' js=1}'; 
    var disabled_text ='{l s='Disabled' mod='ets_marketplace' js=1}';
    var declined_text ='{l s='Declined' mod='ets_marketplace' js=1}';
    var reason_added_text= '{l s='Added by admin' mod='ets_marketplace' js=1}';
    var reason_deducted_text= '{l s='Deducted by admin' mod='ets_marketplace' js=1}';
</script>
{if $seller->latitude!=0 && $seller->latitude!=0}
    <div class="ets_mp_popup ets_mp_map_seller" style="display:none">
        <div class="mp_pop_table">
            <div class="mp_pop_table_cell">
                <div class="map-content">
                    <div class="ets_mp_close_popup" title="Close">Close</div>
                    <div id="map"></div>
                    <div class="store-content-select selector3" style="display:none;">
                    	<select id="locationSelect" class="form-control">
                    		<option>-</option>
                    	</select>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script type="text/javascript">
    var markers=[];
    var infoWindow = '';
    var locationSelect = '';
    var defaultLat = {$seller->latitude|floatval};
    var defaultLong = {$seller->longitude|floatval};
    var hasStoreIcon = true;
    var distance_unit = 'km';
    var img_ps_dir = '{$base_link|escape:'html':'UTF-8'}/modules/ets_marketplace/views/img/';
    var searchUrl = '{$link->getAdminLink('AdminMarketPlaceSellers') nofilter}&getmapseller=1&id_seller='+{$seller->id|intval};
    var logo_map = 'logo_map.png';
    var translation_1 = '{l s='No stores were found. Please try selecting a wider radius.' mod='ets_marketplace' js=1}';
    var translation_2 = '{l s='store found -- see details:' mod='ets_marketplace' js=1}';
    var translation_3 = '{l s='stores found -- view all results:' mod='ets_marketplace' js=1}';
    var translation_4 = '{l s='Phone:' mod='ets_marketplace' js=1}' ;
    var translation_5 = '{l s='Get directions' mod='ets_marketplace' js=1}';
    var translation_6 = '{l s='Not found' mod='ets_marketplace' js=1}';
</script>
<script src="{$link_map_google nofilter}"></script>
<script type="text/javascript" src="{$ets_mp_module_dir|escape:'html':'UTF-8'}views/js/map.js"></script>
{/if}
<div class="row display-flex-nocenter md-block ets_mp-panel"> 
    <div class="col-lg-8">
        <div class="panel">
            <div class="panel-header">
                <h3 class="panel-title">{l s='Shop info' mod='ets_marketplace'}
                </h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-horizontal label_bold">
                            {if $seller->shop_name}
                                <div class="row">
                                    <label class="control-label col-lg-4 col-sm-6">{l s='Shop name' mod='ets_marketplace'}</label>
                                    <div class="col-lg-8 col-sm-6">
                                        <p class="form-control-static">{if $seller->shop_name}<a href="{$seller->getLink()|escape:'html':'UTF-8'}" target="_blank">{$seller->shop_name|escape:'html':'UTF-8'}</a>{/if}</p>
                                    </div>
                                </div>
                            {/if}
                            <div class="row">
        						<label class="control-label col-lg-4 col-sm-6">{l s='Seller name' mod='ets_marketplace'}</label>
        						<div class="col-lg-8 col-sm-6">
        							<p class="form-control-static"> <a href="{$link_customer|escape:'html':'UTF-8'}" title="{l s='View customer' mod='ets_marketplace'}" target="_blank">{if $seller->seller_name}{$seller->seller_name|escape:'html':'UTF-8'}{else}{$customer->firstname|escape:'html':'UTF-8'}&nbsp;{$customer->lastname|escape:'html':'UTF-8'}{/if}</a></p>
        						</div>
        					</div>
                            <div class="row">
                                <label class="control-label col-lg-4 col-sm-6">{l s='Email' mod='ets_marketplace'}</label>
                                <div class="col-lg-8 col-sm-6">
                                    <p class="form-control-static">{if $seller->seller_email}{$seller->seller_email|escape:'html':'UTF-8'}{else}{$customer->email|escape:'html':'UTF-8'}{/if}</p>
                                </div>
                            </div>
                            <div class="row">
        						<label class="control-label col-lg-4 col-sm-6">{l s='Registration date' mod='ets_marketplace'}</label>
        						<div class="col-lg-8 col-sm-6">
        							<p class="form-control-static">{dateFormat date=$seller->date_add full=1}</p>
        						</div>
        					</div>
                            <div class="row">
                                <label class="control-label col-lg-4 col-sm-6">{l s='Shop status' mod='ets_marketplace'}</label>
                                <div class="col-lg-8 col-sm-6">
                                    <div class="seller-status">
                                        {if $seller->checkVacation()}
                                            <span class="ets_mp_status vacation">{l s='Vacation' mod='ets_marketplace'}</span>
                                        {else}
                                            {if $seller->active==-2}
                                                <span class="ets_mp_status expired">{l s='Expired' mod='ets_marketplace'}</span>
                                            {elseif $seller->active==-1}
                                                <span class="ets_mp_status pending">{l s='Pending' mod='ets_marketplace'}</span>
                                            {elseif $seller->active==0}
                                                <span class="ets_mp_status disabled">{l s='Disabled' mod='ets_marketplace'}</span>
                                            {elseif $seller->active==1}
                                                <span class="ets_mp_status approved">{l s='Active' mod='ets_marketplace'}</span>
                                            {elseif $seller->active==-3}
                                                <span class="ets_mp_status declined">{l s='Declined payment' mod='ets_marketplace'}</span>
                                            {/if}
                                        {/if}
                                    </div>
                                </div>
                            </div>
                            {if $seller_billing}
                                <div class="row">
                                    <label class="control-label col-lg-4 col-sm-6">{l s='Payment status' mod='ets_marketplace'}</label>
                                        <div class="col-lg-8 col-sm-6 payment_verify">
                                            {if $seller_billing}
                                                {if $seller_billing->active==0}
                                                    <span class="ets_mp_status awaiting_payment">{l s='Pending' mod='ets_marketplace'}{if $seller_billing->seller_confirm} ({l s='Seller confirmed' mod='ets_marketplace'}){/if}</span>
                                                {/if}
                                                {if $seller_billing->active==-1}
                                                    <span class="ets_mp_status deducted">{l s='Canceled' mod='ets_marketplace'}</span>
                                                {/if}
                                                {if $seller_billing->active==1}
                                                    <span class="ets_mp_status purchased">{l s='Paid' mod='ets_marketplace'}</span>
                                                {/if}
                                            {else}
                                                <span class="ets_mp_status purchased">{l s='Paid' mod='ets_marketplace'}</span>
                                            {/if}
                                        </div>
                                </div>
                            {/if}                 
                            <div class="row change_date_seller" {if $seller->active!=1} style="display:none;" {/if}>
                                <label class="control-label col-lg-4 col-sm-6">{l s='Available' mod='ets_marketplace'} </label>
                                <div class="col-lg-8 col-sm-6">
                                    <span class="date_seller_approve">                                
                                        {if ($seller->date_from && $seller->date_from!='0000-00-00') || ($seller->date_to && $seller->date_to!='0000-00-00')}
                                            {if $seller->date_from && $seller->date_from!='0000-00-00'}{l s='from' mod='ets_marketplace'} {dateFormat date=$seller->date_from full=0}{/if}
                                            {if $seller->date_to && $seller->date_to!='0000-00-00'}{l s='to' mod='ets_marketplace'} {dateFormat date=$seller->date_to full=0}{/if}                                                                                    
                                        {else}
                                            {l s='Unlimited' mod='ets_marketplace'}                                        
                                        {/if}
                                    </span>
                                    <span>
                                        <span class="btn btn-default approve_registration" data-id="{$seller->id|intval}">
                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg> {l s='Change' mod='ets_marketplace'}
                                        </span>
                                        <div class="approve_registration_form" style="display:none">
                                            <div class="ets_mp_close_popup" title="Close">{l s='Close' mod='ets_marketplace'}</div>
                                            <div class="form-group">
                                                <label class="control-label col-lg-3">{l s='Available from' mod='ets_marketplace'}</label>
                                                <div class="col-lg-9">
                                                    <div class="row">
                                                        <div class="input-group col-lg-8 ets_mp_datepicker">
                                                            <input name="date_from" value="{$seller->date_from|escape:'html':'UTF-8'}" class="" type="text" autocomplete="off" />
                                                            <span class="input-group-addon">
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-lg-3">{l s='Available to' mod='ets_marketplace'}</label>
                                                <div class="col-lg-9">
                                                    <div class="row">
                                                        <div class="input-group col-lg-8 ets_mp_datepicker">
                                                            <input name="date_to" value="{$seller->date_to|escape:'html':'UTF-8'}" class="" type="text" autocomplete="off"/>
                                                            <span class="input-group-addon">
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <input name="active_seller" value="1" type="hidden" />
                                            <input name="saveStatusSeller" value="1" type="hidden" />
                                            <input name="seller_id" value="{$seller->id|intval}" type="hidden" />
                                            <div class="panel_footer form-group">
                                                <div class="control-label col-lg-3"></div>
                                                <div class="col-lg-9">
                                                    <button type="submit" value="1" name="saveStatusSeller" class="btn btn-default saveStatusSeller">
                                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                    </button>
                                                </div>
                                            </div>           
                                        </div>
                                    </span>
                                </div>                                                                                                                
                            </div>                                                           
                            <div class="row">
                                <label class="control-label col-lg-4 col-sm-6">&nbsp;</label>
                                <div class="col-lg-8 col-sm-6">
                                <span>
                                    <span class="ets_mp_status approved btn btn-default approve_registration action_approve_seller" data-id="{$seller->id|intval}" {if $seller->active==1}style="display:none;"{/if}>
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Activate' mod='ets_marketplace'}
                                    </span>
                                    <div class="approve_registration_form" style="display:none">
                                        <div class="ets_mp_close_popup" title="Close">{l s='Close' mod='ets_marketplace'}</div>
                                        <div class="form-group">
                                            <label class="control-label col-lg-3">{l s='Status' mod='ets_marketplace'}</label>
                                            <div class="col-lg-9">
                                                <span class="ets_mp_status approved">{l s='Active' mod='ets_marketplace'}</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-lg-3">{l s='Available from' mod='ets_marketplace'}</label>
                                            <div class="col-lg-9">
                                                <div class="row">
                                                    <div class="input-group col-lg-8 ets_mp_datepicker">
                                                        <input name="date_from" value="{$seller->date_from|escape:'html':'UTF-8'}" class="" type="text" />
                                                        <span class="input-group-addon">
                                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-lg-3">{l s='Available to' mod='ets_marketplace'}</label>
                                            <div class="col-lg-9">
                                                <div class="row">
                                                    <div class="input-group col-lg-8 ets_mp_datepicker">
                                                        <input name="date_to" value="{$seller->date_to|escape:'html':'UTF-8'}" class="" type="text" />
                                                        <span class="input-group-addon">
                                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <input name="active_seller" value="1" type="hidden" />
                                        <input name="saveStatusSeller" value="1" type="hidden" />
                                        <input name="seller_id" value="{$seller->id|intval}" type="hidden" />
                                        <div class="panel_footer form-group">
                                            <div class="control-label col-lg-3"></div>
                                            <div class="col-lg-9">
                                                <button type="submit" value="1" name="saveStatusSeller" class="btn btn-default saveStatusSeller">
                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                </button>
                                            </div>
                                        </div>           
                                    </div>
                                </span>
                                <span>
                                    <span class="ets_mp_status declined btn btn-default approve_registration action_decline_seller" data-id="{$seller->id|intval}" {if $seller->active!=-1} style="display:none;"{/if}>
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Decline payment' mod='ets_marketplace'}
                                    </span>
                                    <div class="approve_registration_form" style="display:none">
                                        <div class="ets_mp_close_popup" title="Close">{l s='Close' mod='ets_marketplace'}</div>
                                        <div class="form-group">
                                            <label class="control-label col-lg-3">{l s='Status' mod='ets_marketplace'}</label>
                                            <div class="col-lg-9">
                                                <span class="ets_mp_status declined">{l s='Decline payment' mod='ets_marketplace'}</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-lg-3">{l s='Reason' mod='ets_marketplace'}</label>
                                            <div class="col-lg-9">
                                                <textarea name="reason">{$seller->reason|escape:'html':'UTF-8'}</textarea>
                                            </div>
                                        </div>
                                        <input name="active_seller" value="-3" type="hidden" />
                                        <input name="saveStatusSeller" value="1" type="hidden" />
                                        <input name="seller_id" value="{$seller->id|intval}" type="hidden" />
                                        <div class="panel_footer form-group">
                                            <div class="control-label col-lg-3"></div>
                                            <div class="col-lg-9">
                                                <button type="submit" value="1" name="saveStatusSeller" class="btn btn-default saveStatusSeller">
                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                </button>
                                            </div>
                                        </div>           
                                    </div>
                                </span>
                                <span>
                                    <span class="ets_mp_status declined btn btn-default approve_registration action_disable_seller" data-id="{$seller->id|intval}" {if $seller->active==0} style="display:none;"{/if}>
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1440 893q0-161-87-295l-754 753q137 89 297 89 111 0 211.5-43.5t173.5-116.5 116-174.5 43-212.5zm-999 299l755-754q-135-91-300-91-148 0-273 73t-198 199-73 274q0 162 89 299zm1223-299q0 157-61 300t-163.5 246-245 164-298.5 61-298.5-61-245-164-163.5-246-61-300 61-299.5 163.5-245.5 245-164 298.5-61 298.5 61 245 164 163.5 245.5 61 299.5z"/></svg> {l s='Disable' mod='ets_marketplace'}
                                    </span>
                                    <div class="approve_registration_form" style="display:none">
                                        <div class="ets_mp_close_popup" title="Close">{l s='Close' mod='ets_marketplace'}</div>
                                        <div class="form-group">
                                            <label class="control-label col-lg-3">{l s='Status' mod='ets_marketplace'}</label>
                                            <div class="col-lg-9">
                                                <span class="ets_mp_status disabled">{l s='Disable' mod='ets_marketplace'}</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-lg-3">{l s='Reason' mod='ets_marketplace'}</label>
                                            <div class="col-lg-9">
                                                <textarea name="reason">{$seller->reason|escape:'html':'UTF-8'}</textarea>
                                            </div>
                                        </div>
                                        <input name="active_seller" value="0" type="hidden" />
                                        <input name="saveStatusSeller" value="1" type="hidden" />
                                        <input name="seller_id" value="{$seller->id|intval}" type="hidden" />
                                        <div class="panel_footer form-group">
                                            <div class="control-label col-lg-3"></div>
                                            <div class="col-lg-9">
                                                <button type="submit" value="1" name="saveStatusSeller" class="btn btn-default saveStatusSeller">
                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                </button>
                                            </div>
                                        </div>           
                                    </div>
                                </span>
                                <a class="btn btn-default ets_mk_seller_delete" onclick="return confirm('{l s='Do you want to delete this item?' mod='ets_marketplace'}');" href="{$link->getAdminLink('AdminMarketPlaceSellers')|escape:'html':'UTF-8'}&id_seller={$seller->id|intval}&del=yes">
                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                                    {l s='Delete' mod='ets_marketplace'}
                                </a>
                                </div>
                            </div>
                            {if $seller->shop_address}
                                <div class="row">
                                    <label class="control-label col-lg-4 col-sm-6">{l s='Shop address' mod='ets_marketplace'}</label>
                                    <div class="col-lg-8 col-sm-6">
                                        <p class="form-control-static">{if $seller->shop_address}{$seller->shop_address|nl2br nofilter}{/if}</p>
                                    </div>
                                </div>
                            {/if}
                            {if $seller->latitude!=0 && $seller->longitude!=0}
                                <div class="row">
                                    <label class="control-label col-lg-4 col-sm-6">&nbsp;</label>
                                    <div class="col-lg-8 col-sm-6">
                                        <div class="ets_mp_map">
                                            <a class="view_map" href="#">
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 640q0-106-75-181t-181-75-181 75-75 181 75 181 181 75 181-75 75-181zm256 0q0 109-33 179l-364 774q-16 33-47.5 52t-67.5 19-67.5-19-46.5-52l-365-774q-33-70-33-179 0-212 150-362t362-150 362 150 150 362z"/></svg> {l s='View map' mod='ets_marketplace'}
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            {if $seller->shop_description}
                                <div class="row">
                                    <label class="control-label col-lg-4 col-sm-6">{l s='Shop description' mod='ets_marketplace'}</label>
                                    <div class="col-lg-8 col-sm-6">
                                        <p class="form-control-static">{if $seller->shop_description}{$seller->shop_description|nl2br nofilter}{/if}</p>
                                    </div>
                                </div>
                            {/if}
                            {if $seller->shop_phone}
                                <div class="row">
                                    <label class="control-label col-lg-4 col-sm-6">{l s='Shop phone number' mod='ets_marketplace'}</label>
                                    <div class="col-lg-8 col-sm-6">
                                        <p class="form-control-static">{if $seller->shop_phone}{$seller->shop_phone|escape:'html':'UTF-8'}{/if}</p>
                                    </div>
                                </div>
                            {/if}
                            {if isset($shop_category) && $shop_category}
                                <div class="row">
                                    <label class="control-label col-lg-4 col-sm-6">{l s='Shop category' mod='ets_marketplace'}</label>
                                    <div class="col-lg-8 col-sm-6">
                                        <p class="form-control-static">{$shop_category->name|escape:'html':'UTF-8'}</p>
                                    </div>
                                </div>
                            {/if}
                            {if $seller->vat_number}
                                <div class="row form-group">
                                    <label class="control-label col-lg-4 col-sm-6">{l s='VAT number' mod='ets_marketplace'}</label>
                                    <div class="col-lg-8 col-sm-6">
                                        <p class="form-control-static">{if $seller->vat_number}{$seller->vat_number|escape:'html':'UTF-8'}{/if}</p>
                                    </div>
                                </div>
                            {/if}
                            {if $seller->shop_logo}
                                <div class="row form-group">
                					<label class="control-label col-lg-4 col-sm-6">{l s='Logo' mod='ets_marketplace'}</label>
                					<div class="col-lg-8 col-sm-6">
                                        {if $seller->shop_logo}
                						  <img src="../img/mp_seller/{$seller->shop_logo|escape:'html':'UTF-8'}" style="width:80px" alt="{$seller->shop_name|escape:'html':'UTF-8'}" />
                                        {/if}
                					</div>
               				     </div>
                            {/if}
                            {if $seller->shop_banner}
                                <div class="row form-group">
                					<label class="control-label col-lg-4 col-sm-6">{l s='Shop banner' mod='ets_marketplace'}</label>
                					<div class="col-lg-8 col-sm-6">
                                        {if $seller->shop_banner}
                						  <img class="seller_shop_banner" src="../img/mp_seller/{$seller->shop_banner|escape:'html':'UTF-8'}" />
                                          
                                        {/if}
                					</div>
               				     </div>
                            {/if}
                            {if $seller->link_facebook || $seller->link_google || $seller->link_instagram || $seller->link_twitter}
                                <div class="row">
                					<label class="control-label col-lg-4 col-sm-6">{l s='Social' mod='ets_marketplace'}</label>
                					<div class="col-lg-8 col-sm-6 seller-social">
                                        {if $seller->link_facebook}
                                            <a class="facebook" href="{$seller->link_facebook|escape:'html':'UTF-8'}" target="_blank"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1343 12v264h-157q-86 0-116 36t-30 108v189h293l-39 296h-254v759h-306v-759h-255v-296h255v-218q0-186 104-288.5t277-102.5q147 0 228 12z"/></svg></a>
                                        {/if}
                                        {if $seller->link_google}
                                            <a class="google" href="{$seller->link_google|escape:'html':'UTF-8'}" target="_blank"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M896 786h725q12 67 12 128 0 217-91 387.5t-259.5 266.5-386.5 96q-157 0-299-60.5t-245-163.5-163.5-245-60.5-299 60.5-299 163.5-245 245-163.5 299-60.5q300 0 515 201l-209 201q-123-119-306-119-129 0-238.5 65t-173.5 176.5-64 243.5 64 243.5 173.5 176.5 238.5 65q87 0 160-24t120-60 82-82 51.5-87 22.5-78h-436v-264z"/></svg></a>
                                        {/if}
                                        {if $seller->link_instagram}
                                            <a class="instagram" href="{$seller->link_instagram|escape:'html':'UTF-8'}" target="_blank"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 896q0-106-75-181t-181-75-181 75-75 181 75 181 181 75 181-75 75-181zm138 0q0 164-115 279t-279 115-279-115-115-279 115-279 279-115 279 115 115 279zm108-410q0 38-27 65t-65 27-65-27-27-65 27-65 65-27 65 27 27 65zm-502-220q-7 0-76.5-.5t-105.5 0-96.5 3-103 10-71.5 18.5q-50 20-88 58t-58 88q-11 29-18.5 71.5t-10 103-3 96.5 0 105.5.5 76.5-.5 76.5 0 105.5 3 96.5 10 103 18.5 71.5q20 50 58 88t88 58q29 11 71.5 18.5t103 10 96.5 3 105.5 0 76.5-.5 76.5.5 105.5 0 96.5-3 103-10 71.5-18.5q50-20 88-58t58-88q11-29 18.5-71.5t10-103 3-96.5 0-105.5-.5-76.5.5-76.5 0-105.5-3-96.5-10-103-18.5-71.5q-20-50-58-88t-88-58q-29-11-71.5-18.5t-103-10-96.5-3-105.5 0-76.5.5zm768 630q0 229-5 317-10 208-124 322t-322 124q-88 5-317 5t-317-5q-208-10-322-124t-124-322q-5-88-5-317t5-317q10-208 124-322t322-124q88-5 317-5t317 5q208 10 322 124t124 322q5 88 5 317z"/></svg></a>
                                        {/if} 
                                        {if $seller->link_twitter}
                                            <a class="twitter" href="{$seller->link_twitter|escape:'html':'UTF-8'}" target="_blank">
                                                <svg width="14" height="14" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z"/></svg>
                                            </a>
                                        {/if}
                                    </div>
                                </div>
                            {/if}
                            
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-horizontal label_bold">
                            <div class="row">
                                <label class="control-label col-lg-6">
                                    {l s='Total commission balance' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='The remaining amount of commission after converting into voucher, withdrawing, paying for orders or being deducted by marketplace admin' mod='ets_marketplace'}</span>
                                    </i>
                                </label>
                                <div class="col-lg-6">
                                    {assign var='total_commission_balance' value=$seller->getTotalCommission(1)-$seller->getToTalUseCommission(1)}
                                    <p class="form-control-static" id="total_commission">{displayPrice price=$total_commission_balance}</p>
                                </div>
                            </div>
                            <div class="row">
                                <label class="control-label col-lg-6">
                                    {l s='Total commission' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Total commission money this seller has earned' mod='ets_marketplace'}</span>
                                    </i>
                                </label>
                                <div class="col-lg-6">
                                    <p class="form-control-static" id="total_commission">{displayPrice price=$seller->getTotalCommission(1)}</p>
                                </div> 
                            </div>
                            <div class="row">
								<label class="control-label col-lg-6">
                                    {l s='Withdrawn' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Total amount of commission money this seller has withdrawn' mod='ets_marketplace'}</span>
                                    </i>
                                </label>
								<div class="col-lg-6">
									<p class="form-control-static" id="total_withdrawn">{displayPrice price=$seller->getToTalUseCommission(1,false,false,true)}</p>
								</div>
							</div>
                            <div class="row">
								<label class="control-label col-lg-6">
                                    {l s='Paid for orders' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Total amount of commission money this seller has used to pay for orders' mod='ets_marketplace'}</span>
                                    </i>
                                </label>
								<div class="col-lg-6">
									<p class="form-control-static" id="total_paid_for_orders">{displayPrice price=$seller->getToTalUseCommission(1,true)}</p>
								</div>
							</div>
                            <div class="row">
								<label class="control-label col-lg-6">
                                    {l s='Converted to voucher' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Total amount of commission money this seller has used to convert into vouchers' mod='ets_marketplace'}</span>
                                    </i>
                                </label>
								<div class="col-lg-6">
									<p class="form-control-static" id="total_convert_to_voucher">{displayPrice price=$seller->getToTalUseCommission(1,false,true)}</p>
								</div>
							</div>
                            <div class="row">
								<label class="control-label col-lg-6">
                                    {l s='Total used' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Total amount of commission money this seller has withdrawn, paid for orders, converted into vouchers and commission money deducted by marketplace admin' mod='ets_marketplace'}</span>
                                    </i>
                                </label>
								<div class="col-lg-6">
									<p class="form-control-static" id="total_commission_used">{displayPrice price=$seller->getToTalUseCommission(1)}</p>
								</div>
							</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="panel">
            <div class="panel-header">
                <h3 class="panel-title">{l s='Modify seller balance' mod='ets_marketplace'}
                </h3>
            </div>
            <div class="panel-body">
                <form id="eamFormActionCommissionUser" class="form-horizontal" method="POST" action="{$link->getAdminLink('AdminMarketPlaceSellers')|escape:'html':'UTF-8'}&viewseller=1&id_seller={$seller->id|intval}">
                    <div class="form-group">
						<label class="col-lg-3 control-label">{l s='Action' mod='ets_marketplace'}</label>
						<div class="col-lg-9">
							<select name="action">
								<option value="deduct"{if $action =='deduct'} selected="selected"{/if}>{l s='Deduct' mod='ets_marketplace'}</option>
								<option value="add"{if $action =='add'} selected="selected"{/if}>{l s='Add' mod='ets_marketplace'}</option>
							</select>
						</div>
					</div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label">{l s='Amount' mod='ets_marketplace'}</label>
                        <div class="col-lg-9">
							<div class="input-group ">
								<input name="amount" value="{$amount|escape:'html':'UTF-8'}" placeholder="" class="form-control" type="text" />
								<span class="input-group-addon">{$currency->sign|escape:'html':'UTF-8'}</span>
							</div>
						</div>
                    </div>
                    <div class="form-group">
						<label class="col-lg-3 control-label">{l s='Reason' mod='ets_marketplace'}</label>
						<div class="col-lg-9">
							<textarea name="reason" class="form-control">{if $reason}{$reason|escape:'html':'UTF-8'}{else}{if $action=='add'}{l s='Added by admin' mod='ets_marketplace' js=1}{else}{l s='Deducted by admin' mod='ets_marketplace' js=1}{/if} {/if}</textarea>
						</div>
					</div>
                    <div class="form-group text-right">
						<div class="col-lg-12">
							<button type="submit" name="deduct_commission_by_admin" class="btn btn-default" {if $action=='add'}style="display: none;"{/if} ><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-768q-26 0-45 19t-19 45v128q0 26 19 45t45 19h768q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>{l s='Deduct' mod='ets_marketplace'}</button>
							<button type="submit" name="add_commission_by_admin" class="btn btn-default" {if $action!='add'}style="display: none;"{/if}><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-256v-256q0-26-19-45t-45-19h-128q-26 0-45 19t-19 45v256h-256q-26 0-45 19t-19 45v128q0 26 19 45t45 19h256v256q0 26 19 45t45 19h128q26 0 45-19t19-45v-256h256q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg> {l s='Add' mod='ets_marketplace'}</button>
						</div>
					</div>
                </form>
            </div>
        </div>
    </div>
</div>
{$history_billings nofilter}
{$history_commissions nofilter}
<div>
    <a class="btn btn-default" href="{$link->getAdminLink('AdminMarketPlaceSellers')|escape:'html':'UTF-8'}" title="">
        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1203 544q0 13-10 23l-393 393 393 393q10 10 10 23t-10 23l-50 50q-10 10-23 10t-23-10l-466-466q-10-10-10-23t10-23l466-466q10-10 23-10t23 10l50 50q10 10 10 23z"/></svg> {l s='Back' mod='ets_marketplace'}
    </a>
</div>
