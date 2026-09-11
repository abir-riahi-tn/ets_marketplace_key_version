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

<div class="payment-setting no-border-padding">
    {if isset($errors)}
        {$errors nofilter}
    {/if}
	<form action="" method="POST" class="form-horizontal" enctype="multipart/form-data">
        <input type="hidden" name="payment_method" value="{$valuefields.payment_method|intval}"/>
		<div class="panel">
			<div class="panel-title-edit no-border" style="padding-top: 15px;padding-left: 15px; padding-right: 15px;">
				<div class="panel-title fs-16">{if $valuefields.payment_method} {l s='Edit withdrawal method' mod='ets_marketplace'} #{$valuefields.payment_method|intval}{else} {l s='Create new withdrawal method' mod='ets_marketplace'}{/if}</div>
			</div>
			<div class="panel-body">
				<div class="form-group payment-method">
				    <div class="form-group row ">
				        <label class="control-label required col-lg-3">{l s='Method name' mod='ets_marketplace'}</label>
				        <div class="col-lg-5">
				            {foreach $languages as $k=>$lang}
				            <div class="form-group row trans_field trans_field_{$lang.id_lang|escape:'html':'UTF-8'} {if $k > 0}hidden{/if}">
				                <div class="col-lg-9">
				                    <input type="text" name="payment_method_name_{$lang.id_lang|escape:'html':'UTF-8'}" value="{if isset($valuefields.title[$lang.id_lang])}{$valuefields.title[$lang.id_lang]|escape:'html':'UTF-8'}{/if}" class="form-control" />
				                </div>
				                <div class="col-lg-2">
				                    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">{$lang.iso_code|escape:'html':'UTF-8'} <span class="caret"></span></button>
				                    <ul class="dropdown-menu">
				                        {foreach $languages as $lg}
				                        <li><a href="javascript:ets_mpHideOtherLang({$lg.id_lang|escape:'html':'UTF-8'})" title="">{$lg.name|escape:'html':'UTF-8'}</a></li>
				                        {/foreach}
				                    </ul>
				                </div>
				                <div class="col-lg-1">&nbsp;</div>
				            </div>
				            {/foreach}
				        </div>
				        <div class="col-lg-4">&nbsp;</div>
				    </div>
				    <div class="form-group row ">
				        <label class="control-label col-lg-3">{l s='Fee type' mod='ets_marketplace'}</label>
				        <div class="col-lg-5">
				            <select name="payment_method_fee_type" class="form-control payment_method_fee_type">
				                <option value="FIXED" {if isset($valuefields.fee_type) && $valuefields.fee_type == 'FIXED'}selected="selected"{/if}>{l s='Fixed amount each withdrawal request' mod='ets_marketplace'}</option>
				                <option value="PERCENT" {if isset($valuefields.fee_type) && $valuefields.fee_type == 'PERCENT'}selected="selected"{/if}>{l s='Percentage based on withdrawal amount' mod='ets_marketplace'}</option>
				                <option value="NO_FEE" {if isset($valuefields.fee_type) && $valuefields.fee_type == 'NO_FEE'}selected="selected"{/if}>{l s='No fee' mod='ets_marketplace'}</option>
				            </select>
				        </div>
				    </div>
				    <div class="form-group row ">
				        <label class="control-label required col-lg-3">{l s='Fee (fixed amount)' mod='ets_marketplace'}</label>
				        <div class="col-lg-5">
				            <div class="input-group ">
				                <input type="text" name="payment_method_fee_fixed" value="{if isset($valuefields.fee_fixed)}{$valuefields.fee_fixed|escape:'html':'UTF-8'}{/if}" class="payment_method_fee_fixed" /><span class="input-group-addon">{$currency->iso_code|escape:'html':'UTF-8'}</span>
				            </div>
				        </div>
				    </div>
				    <div class="form-group row " style="display:none;">
				        <label class="control-label required col-lg-3">{l s='Fee (percentage)' mod='ets_marketplace'}</label>
				        <div class="col-lg-5">
				            <div class="input-group ">
				                <input type="text" name="payment_method_fee_percent" value="{if isset($valuefields.fee_percent)}{$valuefields.fee_percent|escape:'html':'UTF-8'}{/if}" class="payment_method_fee_percent" /><span class="input-group-addon">%</span>
				            </div>
				        </div>
				    </div>
				    <div class="form-group row ">
				        <label class="control-label col-lg-3">{l s='Description' mod='ets_marketplace'}</label>
				        <div class="col-lg-5">
				            {foreach $languages as $k=>$lang}
				            <div class="form-group row trans_field trans_field_{$lang.id_lang|escape:'html':'UTF-8'} {if $k > 0}hidden{/if}">
				                <div class="col-lg-9">
				                    <textarea name="payment_method_desc_{$lang.id_lang|escape:'html':'UTF-8'}" class="form-control">{if isset($valuefields.description[$lang.id_lang])}{$valuefields.description[$lang.id_lang]|escape:'html':'UTF-8'}{/if}</textarea>
				                </div>
				                <div class="col-lg-2">
				                    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">{$lang.iso_code|escape:'html':'UTF-8'} <span class="caret"></span></button>
				                    <ul class="dropdown-menu">
				                        {foreach $languages as $lg}
				                        <li><a href="javascript:ets_mpHideOtherLang({$lg.id_lang|escape:'html':'UTF-8'})" title="">{$lg.name|escape:'html':'UTF-8'}</a></li>
				                        {/foreach}
				                    </ul>
				                </div>
				                <div class="col-lg-1">&nbsp;</div>
				            </div>
				            {/foreach}
				        </div>
				        <div class="col-lg-4">&nbsp;</div>
				    </div>
				    <div class="form-group row ">
				        <label class="control-label col-lg-3">{l s='Estimated processing time' mod='ets_marketplace'}</label>
				        <div class="col-lg-5">
				            <div class="input-group ">
				                <input type="text" name="payment_method_estimated" value="{if isset($valuefields.estimated_processing_time)}{$valuefields.estimated_processing_time|escape:'html':'UTF-8'}{/if}" /><span class="input-group-addon">{l s='day(s)' mod='ets_marketplace'}</span>
				            </div>
				        </div>
				    </div>
                    <div class="from-group row">
                        <label class="control-label col-lg-3">{l s='Logo' mod='ets_marketplace'}</label>
                        <div class="col-lg-5">
                            {if isset($valuefields.logo) && $valuefields.logo}
                                <div class="form-group">
                                    <div id="shop_logo-images-thumbnails" class="col-lg-12">
                                        <div>
                                            <img src="{$link_base|escape:'html':'UTF-8'}/img/mp_payment/{$valuefields.logo|escape:'html':'UTF-8'}" style="width: 160px;" />
                                            <a class="btn btn-default" href="{$link_pm|escape:'html':'UTF-8'}&payment_method={$valuefields.payment_method|intval}&delete_logo=1">
												<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                                                    {l s='Delete' mod='ets_marketplace'}
                                            </a>
                                            <p></p>
                                        </div>
                                    </div>
                                </div>
                            {/if} 
                            <div class="form-group">
                                <input type="file" name="logo" />
                                <div class="help-block">{l s='Accepted formats: jpg, png, gif. Limit' mod='ets_marketplace'} {Configuration::get('PS_ATTACHMENT_MAXIMUM_SIZE')|escape:'html':'UTF-8'}Mb</div>
                            </div>
                        </div>
                    </div>
				    <div class="form-group row ">
				        <label class="control-label col-lg-3">{l s='Enable' mod='ets_marketplace'}</label>
				        <div class="col-lg-9">
				            <span class="switch prestashop-switch fixed-width-lg">
				                <input type="radio" name="payment_method_enabled" id="payment_method_enable_on" value="1" class="payment_method_enable"{if isset($valuefields.enable) && $valuefields.enable} checked="checked"{/if} />
				                <label for="payment_method_enable_on">{l s='Yes' mod='ets_marketplace'}</label>
				                <input type="radio" name="payment_method_enabled" id="payment_method_enable_off" class="payment_method_enable" value="0" {if !isset($valuefields.enable) || !$valuefields.enable} checked="checked"{/if} />
				                <label for="payment_method_enable_off">{l s='No' mod='ets_marketplace'}</label>
				                <a class="slide-button btn"></a>
				            </span>
				        </div>
				    </div>
				</div>
			</div>
            <!-- PAYMENT METHOD FILED -->
			<div class="flat" style="border-top: 1px solid #ddd; padding-top: 22px;">
				<div class="flat-heading" style="padding-left: 15px; padding-right: 15px;">
					<h3>{l s='Withdrawal method fields' mod='ets_marketplace'}</h3>
				</div>
				<div class="flat-body">
					<div class="alert alert-info"><em>{l s='You can add several input fields (Bank account number, Paypal address, etc.) to collect necessary information from customers to process their withdrawal request. Drag and drop to sort payment method fields' mod='ets_marketplace'}</em></div>
					<div class="method_fields_append" id="eam_method_fields_append">
						{if isset($payment_method_fields) && $payment_method_fields}
                            {foreach $payment_method_fields as $key=>$field}
    							<div id="paymentmethodfield_{$field.id|escape:'html':'UTF-8'}" class="form-group payment-method-field" data-id="{$field.id|escape:'html':'UTF-8'}">
    								<span data-toggle="collapse" href="#payment_method_field_{$key|escape:'html':'UTF-8'}" class="btn-pmf-collapse collapsed">{if isset($field['title'][$default_lang])}{$field['title'][$default_lang]|escape:'html':'UTF-8'}{/if} <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-256v-256q0-26-19-45t-45-19h-128q-26 0-45 19t-19 45v256h-256q-26 0-45 19t-19 45v128q0 26 19 45t45 19h256v256q0 26 19 45t45 19h128q26 0 45-19t19-45v-256h256q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg></span>
    							    <div class="group-fields collapse" id="payment_method_field_{$key|escape:'html':'UTF-8'}">
    							    	<div class="form-group row">
    								        <label class="control-label required col-lg-3">{l s='Method field title' mod='ets_marketplace'}</label>
    								        <div class="col-lg-6">
    								        	{foreach $languages as $k=>$lang}
    								            <div class="form-group row trans_field trans_field_{$lang.id_lang|escape:'html':'UTF-8'} {if $k > 0}hidden{/if}">
    								                <div class="col-lg-9">
    								                    <input type="text" name="payment_method_field[{$key|escape:'html':'UTF-8'}][title][{$lang.id_lang|escape:'html':'UTF-8'}]" value="{if isset($field['title'][$lang.id_lang])}{$field['title'][$lang.id_lang]|escape:'html':'UTF-8'}{/if}" class="form-control {if $currency->id == $lang.id_lang}required{/if}" data-error="{l s='Title of payment method field is required' mod='ets_marketplace'}" />
    								                </div>
    								                <div class="col-lg-2">
    								                    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">{$lang.iso_code|escape:'html':'UTF-8'} <span class="caret"></span></button>
    								                    <ul class="dropdown-menu">
    								                    	{foreach $languages as $lg}
    								                        <li><a href="javascript:ets_mpHideOtherLang({$lg.id_lang|escape:'html':'UTF-8'})" title="">{$lg.name|escape:'html':'UTF-8'}</a></li>
    								                        {/foreach}
    								                    </ul>
    								                </div>
    								            </div>
    								            {/foreach}
    								        </div>
    								    </div>
    								    <div class="form-group row">
    								        <label class="control-label col-lg-3">{l s='Method field type' mod='ets_marketplace'}</label>
    								        <div class="col-lg-5">
    								            <select name="payment_method_field[{$key|escape:'html':'UTF-8'}][type]" class="form-control">
    								                <option value="text" {if $field.type == 'text'}selected{/if}>{l s='Text' mod='ets_marketplace'}</option>
    								                <option value="textarea" {if $field.type == 'textarea'}selected{/if}>{l s='Textarea' mod='ets_marketplace'}</option>
    								            </select>
    								        </div>
    								    </div>
    								    <div class="form-group row">
    								        <label class="control-label col-lg-3">{l s='Description' mod='ets_marketplace'}</label>
    								        <div class="col-lg-6">
    								        	{foreach $languages as $k=>$lang}
        								            <div class="form-group row trans_field trans_field_{$lang.id_lang|escape:'html':'UTF-8'} {if $k > 0}hidden{/if}">
        								                <div class="col-lg-9">
        								                    <textarea name="payment_method_field[{$key|escape:'html':'UTF-8'}][description][{$lang.id_lang|escape:'html':'UTF-8'}]" class="form-control">{if isset($field['title'][$lang.id_lang])}{$field['description'][$lang.id_lang]|escape:'html':'UTF-8'}{/if}</textarea>
        								                </div>
        								                <div class="col-lg-2">
        								                    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">{$lang.iso_code|escape:'html':'UTF-8'} <span class="caret"></span></button>
        								                    <ul class="dropdown-menu">
        								                    	{foreach $languages as $lg}
        								                        <li><a href="javascript:ets_mpHideOtherLang({$lg.id_lang|escape:'html':'UTF-8'})" title="">{$lg.name|escape:'html':'UTF-8'}</a></li>
        								                        {/foreach}
        								                    </ul>
        								                </div>
        								            </div>
    								            {/foreach}
    								        </div>
                                            <div class="col-lg-1">
                                                <a class="btn btn-default btn-sm btn-delete-field js-btn-delete-field" href="javascript:void(0)"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> {l s='Delete' mod='ets_marketplace'}</a>
                                            </div>
    								    </div>
    								    <div class="form-group row ">
    								        <label class="control-label col-lg-3">{l s='Require' mod='ets_marketplace'}</label>
    								        <div class="col-lg-3">
    								        	<select name="payment_method_field[{$key|escape:'html':'UTF-8'}][required]" class="form-control">
    								        		<option value="1" {if $field.required == 1}selected="selected"{/if}>{l s='Yes' mod='ets_marketplace'}</option>
    								        		<option value="0" {if $field.required == 0}selected="selected"{/if}>{l s='No' mod='ets_marketplace'}</option>
    								        		
    								        	</select>
    								        </div>
    								    </div>
    								    <div class="form-group row ">
    								        <label class="control-label col-lg-3">{l s='Enable' mod='ets_marketplace'}</label>
    								        <div class="col-lg-9">
    								            <span class="switch prestashop-switch fixed-width-lg">
    								                <input type="radio" name="payment_method_field[{$key|escape:'html':'UTF-8'}][enable]" id="payment_method_field_{$key|escape:'html':'UTF-8'}_enable_on" value="1" class="payment_method_field_enable" {if $field.enable == 1}checked="checked"{/if}>
    								                <label for="payment_method_field_{$key|escape:'html':'UTF-8'}_enable_on">{l s='Yes' mod='ets_marketplace'}</label>
    								                <input type="radio" name="payment_method_field[{$key|escape:'html':'UTF-8'}][enable]" id="payment_method_field_{$key|escape:'html':'UTF-8'}_enable_off" class="payment_method_field_enable" value="0" {if $field.enable == 0}checked="checked"{/if}>
    								                <label for="payment_method_field_{$key|escape:'html':'UTF-8'}_enable_off">{l s='No' mod='ets_marketplace'}</label>
    								                <a class="slide-button btn"></a>
    								            </span>
    								        </div>
    								    </div>
    								    <input type="hidden" name="payment_method_field[{$key|escape:'html':'UTF-8'}][id]" value="{$field.id|escape:'html':'UTF-8'}" />
    								    
    							    </div>
    							</div>
    						{/foreach}
                        {/if}
						<div class="form-group row">
				            <div class="col-lg-10">
				                <button type="button" class="btn btn-default js-add-payment-method-field"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1600 736v192q0 40-28 68t-68 28h-416v416q0 40-28 68t-68 28h-192q-40 0-68-28t-28-68v-416h-416q-40 0-68-28t-28-68v-192q0-40 28-68t68-28h416v-416q0-40 28-68t68-28h192q40 0 68 28t28 68v416h416q40 0 68 28t28 68z"/></svg> {l s='Add new field' mod='ets_marketplace'}</button>
				            </div>
				        </div>
					</div>
				</div>
			</div>
			<div class="panel-footer">
				<button
						type="submit" value="1" name="submit_payment_method" class="btn btn-default pull-right">
					<svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg>&nbsp; {l s='Save' mod='ets_marketplace'}
				</button>
				<a href="{$link_pm nofilter}" class="btn btn-default">
					<svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Back' mod='ets_marketplace'}
				</a>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
	ets_mp_languages = {json_encode($languages) nofilter};
	ets_mp_currency = {json_encode($currency) nofilter};
    var method_field_title = '{l s='Method field title' mod='ets_marketplace' js=1}';
    var pmf_title_required = '{l s='Title of withdrawal method field is required' mod='ets_marketplace' js=1}';
    var method_field_type = '{l s='Method field type' mod='ets_marketplace' js=1}';
    var method_description_text = '{l s='Description' mod='ets_marketplace' js=1}';
    var required_text = '{l s='Required' mod='ets_marketplace' js=1}';
    var Enabled_text = '{l s='Enabled' mod='ets_marketplace' js=1}';
    var delete_text ='{l s='Delete' mod='ets_marketplace' js=1}';
    var yes_text ='{l s='Yes' mod='ets_marketplace' js=1}';
    var no_text ='{l s='No' mod='ets_marketplace' js=1}';
    var confirm_delete_field_text='{l s='Do you want to delete this item?' mod='ets_marketplace' js=1}';
</script>