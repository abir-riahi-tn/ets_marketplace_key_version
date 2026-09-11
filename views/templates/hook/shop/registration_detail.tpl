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
<div class="panel ets_mp-panel">
    <div class="panel-header">
        <h3 class="panel-title">{l s='Application info' mod='ets_marketplace'}
        </h3>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-lg-6">
                <div class="form-horizontal">
                    <div class="row">
						<label class="control-label col-lg-4 col-sm-6"><b>{l s='Full name' mod='ets_marketplace'}</b></label>
						<div class="col-lg-8 col-sm-6">
							<p class="form-control-static"> <a href="{$link_customer|escape:'html':'UTF-8'}" title="{l s='View customer' mod='ets_marketplace'}" target="_blank">{if $registration->seller_name}{$registration->seller_name|escape:'html':'UTF-8'}{else}{$customer->firstname|escape:'html':'UTF-8'}&nbsp;{$customer->lastname|escape:'html':'UTF-8'}{/if}</a></p>
						</div>
					</div>
                    <div class="row">
                        <label class="control-label col-lg-4 col-sm-6"><b>{l s='Email' mod='ets_marketplace'}</b></label>
                        <div class="col-lg-8 col-sm-6">
                            <p class="form-control-static">{if $registration->seller_email}{$registration->seller_email|escape:'html':'UTF-8'}{else}{$customer->email|escape:'html':'UTF-8'}{/if}</p>
                        </div>
                    </div>
                    <div class="row">
						<label class="control-label col-lg-4 col-sm-6"><b>{l s='Registration date' mod='ets_marketplace'}</b></label>
						<div class="col-lg-8 col-sm-6">
							<p class="form-control-static">{dateFormat date=$registration->date_add full=1}</p>
						</div>
					</div>
                    <div class="row">
                        <label class="control-label col-lg-4 col-sm-6"><b>{l s='Status' mod='ets_marketplace'}</b></label>
                        <div class="col-lg-8 col-sm-6">
                            <div class="registration-status">
                                {if $registration->active==0}
                                    <span class="ets_mp_status disabled">{l s='Declined' mod='ets_marketplace'}</span>
                                {elseif $registration->active==1}
                                    <span class="ets_mp_status approved">{l s='Approved' mod='ets_marketplace'}</span>
                                {elseif $registration->active==-1}
                                    <span class="ets_mp_status pending">{l s='Pending' mod='ets_marketplace'}</span>
                                {/if}
                            </div>
                            <br />
                            {literal}
                            <style>
                                .ets_mp_secret_key_wrapper{max-width:520px;margin-bottom:15px;}
                                .ets_mp_secret_key_wrapper.has-error input{border-color:#c9564b;}
                                .ets_mp_secret_key_wrapper .help-block{font-style:italic;}
                                .ets_mp_secret_key_wrapper .ets_mp_secret_key_buttons{margin-top:8px;}
                                .ets_mp_secret_key_wrapper .ets_mp_secret_key_counter{font-weight:bold;font-style:normal;}
                                .ets_mp_secret_key_wrapper .ets_mp_secret_key_message{color:#c9564b;margin-top:4px;}
                            </style>
                            {/literal}
                            <div class="form-group ets_mp_secret_key_wrapper">
                                <label class="control-label" for="ets_mp_secret_key"><b>{l s='Secret key' mod='ets_marketplace'}</b></label>
                                <input type="text" class="form-control ets_mp_secret_key_input" id="ets_mp_secret_key" name="secret_key" value="{$registration->secret_key|default:''|escape:'html':'UTF-8'}" autocomplete="off" />
                                <p class="help-block ets_mp_secret_key_help">{l s='Required to approve this application. The secret key must contain at least' mod='ets_marketplace'} {$secret_key_min_length|intval} {l s='characters' mod='ets_marketplace'}. <span class="ets_mp_secret_key_counter"></span></p>
                                <div class="ets_mp_secret_key_message" style="display:none"></div>
                                <div class="ets_mp_secret_key_buttons">
                                    <span class="btn btn-default ets_mp_secret_key_save" data-id="{$registration->id|intval}">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg> {l s='Edit' mod='ets_marketplace'}
                                    </span>
                                </div>
                            </div>
                            <script type="text/javascript">
                                var ets_mp_registration_secret_key_min = {$secret_key_min_length|intval};
                                var ets_mp_registration_secret_key_error = '{l s='The secret key is required to approve an application and must contain at least' mod='ets_marketplace' js=1} {$secret_key_min_length|intval} {l s='characters' mod='ets_marketplace' js=1}';
                            </script>
                            <span class="btn btn-default ets_mp_status approved action_approve_registration" data-id="{$registration->id|intval}" {if $registration->active==1} style="display:none;" {/if}>
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Approve' mod='ets_marketplace'}
                            </span>
                            <div class="approve_registration_form" style="display:none">
                                <div class="ets_mp_close_popup" title="Close">{l s='Close' mod='ets_marketplace'}</div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">{l s='Status' mod='ets_marketplace'}</label>
                                    <div class="col-lg-9">
                                        <span class="ets_mp_status approved">{l s='Approve' mod='ets_marketplace'}</span>
                                    </div>
                                </div>
                                {*
                                <div class="form-group">
                                    <label class="control-label col-lg-3">{l s='Comment' mod='ets_marketplace'}</label>
                                    <div class="col-lg-9">
                                        <textarea name="comment"></textarea>
                                    </div>
                                </div>
                                *}
                                <input name="active_registration" value="1" type="hidden" />
                                <input name="saveStatusRegistration" value="1" type="hidden" />
                                <input name="id_registration" value="{$registration->id|intval}" type="hidden" />
                                <div class="panel_footer form-group">
                                    <div class="control-label col-lg-3"></div>
                                    <div class="col-lg-9">
                                        <button type="submit" value="1" name="saveStatusRegistration" class="btn btn-default saveStatusRegistration">
                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                        </button>
                                    </div>
                                </div>           
                            </div>
                            <span class="btn btn-default approve_registration ets_mp_status declined" {if $registration->active==0 || ($registration->active==1 && $has_seller)} style="display:none;" {/if}>
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Decline' mod='ets_marketplace'}
                            </span>
                            <div class="approve_registration_form" style="display:none">
                                <div class="ets_mp_close_popup" title="Close">{l s='Close' mod='ets_marketplace'}</div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">{l s='Status' mod='ets_marketplace'}</label>
                                    <div class="col-lg-9">
                                        <span class="ets_mp_status declined">{l s='Decline' mod='ets_marketplace'}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">{l s='Reason' mod='ets_marketplace'}</label>
                                    <div class="col-lg-9">
                                        <textarea name="reason"></textarea>
                                    </div>
                                </div>
                                <input name="active_registration" value="0" type="hidden" />
                                <input name="saveStatusRegistration" value="1" type="hidden" />
                                <input name="id_registration" value="{$registration->id|intval}" type="hidden" />
                                <div class="panel_footer form-group">
                                    <div class="control-label col-lg-3"></div>
                                    <div class="col-lg-9">
                                        <button type="submit" value="1" name="saveStatusRegistration" class="btn btn-default saveStatusRegistration">
                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                        </button>
                                    </div>
                                </div>           
                            </div>
                            <a class="btn btn-default ets_mk_register_delete" onclick="return confirm('{l s='Do you want to delete this item?' mod='ets_marketplace'}');" href="{$link->getAdminLink('AdminMarketPlaceRegistrations')|escape:'html':'UTF-8'}&id_registration={$registration->id|intval}&del=yes">
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                                {l s='Delete' mod='ets_marketplace'}
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-horizontal">
                    {if $registration->shop_name}
                        <div class="row">
        					<label class="control-label col-lg-4 col-sm-6"><b>{l s='Shop name' mod='ets_marketplace'}</b></label>
        					<div class="col-lg-8 col-sm-6">
        						<p class="form-control-static"> {$registration->shop_name|escape:'html':'UTF-8'}</p>
        					</div>
        				</div>
                    {/if}
                    {if $registration->shop_description}
                        <div class="row">
        					<label class="control-label col-lg-4 col-sm-6"><b>{l s='Shop description' mod='ets_marketplace'}</b></label>
        					<div class="col-lg-8 col-sm-6">
        						<p class="form-control-static"> {$registration->shop_description|nl2br nofilter}</p>
        					</div>
        				</div>
                    {/if}
                    {if $registration->shop_phone}
                        <div class="row">
        					<label class="control-label col-lg-4 col-sm-6"><b>{l s='Shop phone number' mod='ets_marketplace'}</b></label>
        					<div class="col-lg-8 col-sm-6">
        						<p class="form-control-static"> {$registration->shop_phone|escape:'html':'UTF-8'}</p>
        					</div>
        				</div>
                    {/if}
                    {if $registration->shop_address}
                        <div class="row">
        					<label class="control-label col-lg-4 col-sm-6"><b>{l s='Shop address' mod='ets_marketplace'}</b></label>
        					<div class="col-lg-8 col-sm-6">
                                <div class="form-control-static">{$registration->shop_address|nl2br nofilter}</div>
        					</div>
        				</div>
                    {/if}
                    {if $registration->vat_number}
                        <div class="row">
        					<label class="control-label col-lg-4 col-sm-6"><b>{l s='VAT number' mod='ets_marketplace'}</b></label>
        					<div class="col-lg-8 col-sm-6">
                                <div class="form-control-static">{$registration->vat_number|escape:'html':'UTF-8'}</div>
        					</div>
        				</div>
                    {/if}
                    {if $registration->message_to_administrator}
                        <div class="row">
        					<label class="control-label col-lg-4 col-sm-6"><b>{l s='Introduction' mod='ets_marketplace'}</b></label>
        					<div class="col-lg-8 col-sm-6">
        						<p class="form-control-static"> {$registration->message_to_administrator|nl2br nofilter}</p>
        					</div>
        				</div>
                    {/if}
                    {if isset($shop_category) && $shop_category}
                        <div class="row">
                            <label class="control-label col-lg-4 col-sm-6"><b>{l s='Shop category' mod='ets_marketplace'}</b></label>
                            <div class="col-lg-8 col-sm-6">
                                <p class="form-control-static">{$shop_category->name|escape:'html':'UTF-8'}</p>
                            </div>
                        </div>
                    {/if}
                    {if $registration->shop_logo}
                        <div class="row form-group">
        					<label class="control-label col-lg-4 col-sm-6"><b>{l s='Logo' mod='ets_marketplace'}</b></label>
        					<div class="col-lg-8 col-sm-6">
                                {if $registration->shop_logo}
        						  <img src="../img/mp_seller/{$registration->shop_logo|escape:'html':'UTF-8'}" style="width:80px;" />
                                {/if}
        					</div>
        				</div>
                    {/if}
                    {if $registration->shop_banner}
                        <div class="row form-group">
        					<label class="control-label col-lg-4 col-sm-6"><b>{l s='Banner' mod='ets_marketplace'}</b></label>
        					<div class="col-lg-8 col-sm-6">
                                {if $registration->shop_banner}
        						  <img class="seller_shop_banner" src="../img/mp_seller/{$registration->shop_banner|escape:'html':'UTF-8'}"/>
                                {/if}
        					</div>
        				</div>
                    {/if}
                    {if $registration->link_facebook || $registration->link_google || $registration->link_instagram || $registration->link_twitter}
                        <div class="row">
        					<label class="control-label col-lg-4 col-sm-6"><b>{l s='Social' mod='ets_marketplace'}</b></label>
        					<div class="col-lg-8 col-sm-6 seller-social">
                                {if $registration->link_facebook}
                                    <a class="facebook" href="{$registration->link_facebook|escape:'html':'UTF-8'}" target="_blank"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1343 12v264h-157q-86 0-116 36t-30 108v189h293l-39 296h-254v759h-306v-759h-255v-296h255v-218q0-186 104-288.5t277-102.5q147 0 228 12z"/></svg></a>
                                {/if}
                                {if $registration->link_google}
                                    <a class="google" href="{$registration->link_google|escape:'html':'UTF-8'}" target="_blank">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M896 786h725q12 67 12 128 0 217-91 387.5t-259.5 266.5-386.5 96q-157 0-299-60.5t-245-163.5-163.5-245-60.5-299 60.5-299 163.5-245 245-163.5 299-60.5q300 0 515 201l-209 201q-123-119-306-119-129 0-238.5 65t-173.5 176.5-64 243.5 64 243.5 173.5 176.5 238.5 65q87 0 160-24t120-60 82-82 51.5-87 22.5-78h-436v-264z"/></svg>
                                    </a>
                                {/if}
                                {if $registration->link_instagram}
                                    <a class="instagram" href="{$registration->link_instagram|escape:'html':'UTF-8'}" target="_blank">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 896q0-106-75-181t-181-75-181 75-75 181 75 181 181 75 181-75 75-181zm138 0q0 164-115 279t-279 115-279-115-115-279 115-279 279-115 279 115 115 279zm108-410q0 38-27 65t-65 27-65-27-27-65 27-65 65-27 65 27 27 65zm-502-220q-7 0-76.5-.5t-105.5 0-96.5 3-103 10-71.5 18.5q-50 20-88 58t-58 88q-11 29-18.5 71.5t-10 103-3 96.5 0 105.5.5 76.5-.5 76.5 0 105.5 3 96.5 10 103 18.5 71.5q20 50 58 88t88 58q29 11 71.5 18.5t103 10 96.5 3 105.5 0 76.5-.5 76.5.5 105.5 0 96.5-3 103-10 71.5-18.5q50-20 88-58t58-88q11-29 18.5-71.5t10-103 3-96.5 0-105.5-.5-76.5.5-76.5 0-105.5-3-96.5-10-103-18.5-71.5q-20-50-58-88t-88-58q-29-11-71.5-18.5t-103-10-96.5-3-105.5 0-76.5.5zm768 630q0 229-5 317-10 208-124 322t-322 124q-88 5-317 5t-317-5q-208-10-322-124t-124-322q-5-88-5-317t5-317q10-208 124-322t322-124q88-5 317-5t317 5q208 10 322 124t124 322q5 88 5 317z"/></svg>
                                    </a>
                                {/if} 
                                {if $registration->link_twitter}
                                    <a class="twitter" href="{$registration->link_twitter|escape:'html':'UTF-8'}" target="_blank">
                                        <svg width="14" height="14" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z"/></svg>
                                    </a>
                                {/if}
                            </div>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
        <a class="btn btn-default" href="{$link->getAdminLink('AdminMarketPlaceRegistrations')|escape:'html':'UTF-8'}" title="">
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1203 544q0 13-10 23l-393 393 393 393q10 10 10 23t-10 23l-50 50q-10 10-23 10t-23-10l-466-466q-10-10-10-23t10-23l466-466q10-10 23-10t23 10l50 50q10 10 10 23z"/></svg> {l s='Back' mod='ets_marketplace'}
        </a>
    </div>
</div>