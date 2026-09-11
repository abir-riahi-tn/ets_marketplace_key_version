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
<div class="panel">
    <div class="panel-heading">{l s='Vacation mode' mod='ets_marketplace'}</div>
    <section>
        <form id="vacation-form" action="{$link->getModuleLink('ets_marketplace','vacation')|escape:'html':'UTF-8'}" method="post" enctype="multipart/form-data">
            <section>
                <div class="form-group row">
                    <label class="col-md-3 form-control-label"> {l s='Enable vacation mode' mod='ets_marketplace'} </label>
                    <div class="col-md-9">
                        <span class="switch prestashop-switch fixed-width-lg">
                			<input name="vacation_mode" id="vacation_mode_on" value="1" {if isset($smarty.post.vacation_mode)}{if $smarty.post.vacation_mode} checked="checked"{/if}{else}{if $seller->vacation_mode==1} checked="checked"{/if}{/if} type="radio" />
                			<label for="vacation_mode_on" class="radioCheck">
                				<i class="color_success"></i> {l s='Yes' mod='ets_marketplace'}
                			</label>
                			<input name="vacation_mode" id="vacation_mode_off" value="0" {if isset($smarty.post.vacation_mode)}{if !$smarty.post.vacation_mode} checked="checked"{/if}{else}{if $seller->vacation_mode==0} checked="checked"{/if}{/if} type="radio" />
                			<label for="vacation_mode_off" class="radioCheck">
                				<i class="color_danger"></i> {l s='No' mod='ets_marketplace'}
                			</label>
                			<a class="slide-button btn"></a>
                		</span>
                    </div>
                </div>
                <div class="form-group row enable_vacation_mode">
                    <label class="col-md-3 form-control-label"> {l s='Start date' mod='ets_marketplace'} </label>
                    <div class="col-md-9">
                        <div class="input-group ets_mp_datepicker">
                            <input class="form-control ets-mp-datetimepicker" readonly="true" name="date_vacation_start" value="{if isset($smarty.post.date_vacation_start)}{$smarty.post.date_vacation_start|escape:'html':'UTF-8'} {else}{$seller->date_vacation_start|escape:'html':'UTF-8'}{/if}" />
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h288v-288h-288v288zm352 0h320v-288h-320v288zm-352-352h288v-320h-288v320zm352 0h320v-320h-320v320zm-352-384h288v-288h-288v288zm736 736h320v-288h-320v288zm-384-736h320v-288h-320v288zm768 736h288v-288h-288v288zm-384-352h320v-320h-320v320zm-352-864v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm736 864h288v-320h-288v320zm-384-384h320v-288h-320v288zm384 0h288v-288h-288v288zm32-480v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row enable_vacation_mode">
                    <label class="col-md-3 form-control-label"> {l s='End date' mod='ets_marketplace'} </label>
                    <div class="col-md-9">
                        <div class="input-group ets_mp_datepicker">
                            <input class="form-control ets-mp-datetimepicker" readonly="true" name="date_vacation_end" value="{if isset($smarty.post.date_vacation_end)}{$smarty.post.date_vacation_end|escape:'html':'UTF-8'} {else}{$seller->date_vacation_end|escape:'html':'UTF-8'}{/if}" />
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h288v-288h-288v288zm352 0h320v-288h-320v288zm-352-352h288v-320h-288v320zm352 0h320v-320h-320v320zm-352-384h288v-288h-288v288zm736 736h320v-288h-320v288zm-384-736h320v-288h-320v288zm768 736h288v-288h-288v288zm-384-352h320v-320h-320v320zm-352-864v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm736 864h288v-320h-288v320zm-384-384h320v-288h-320v288zm384 0h288v-288h-288v288zm32-480v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row enable_vacation_mode">
                    <label class="col-md-3 form-control-label"> {l s='Vacation mode' mod='ets_marketplace'} </label>
                    <div class="col-md-9">
                        <select name="vacation_type" id="vacation_type" class="form-control">
                            <option value="show_notifications" {if isset($smarty.post.vacation_type)}{if $smarty.post.vacation_type=='show_notifications'} selected="selected"{/if}{else}{if $seller->vacation_type=='show_notifications'} selected="selected"{/if}{/if}>{l s='Show notifications' mod='ets_marketplace'}</option>
                            <option value="disable_product" {if isset($smarty.post.vacation_type)}{if $smarty.post.vacation_type=='disable_product'} selected="selected"{/if}{else}{if $seller->vacation_type=='disable_product'} selected="selected"{/if}{/if}>{l s='Disable products' mod='ets_marketplace'}</option>
                            <option value="disable_product_and_show_notifications" {if isset($smarty.post.vacation_type)}{if $smarty.post.vacation_type=='disable_product_and_show_notifications'} selected="selected"{/if}{else}{if $seller->vacation_type=='disable_product_and_show_notifications'} selected="selected"{/if}{/if}>{l s='Disable products and show notifications' mod='ets_marketplace'}</option>
                            <option value="disable_shopping" {if isset($smarty.post.vacation_type)}{if $smarty.post.vacation_type=='disable_shopping'} selected="selected"{/if}{else}{if $seller->vacation_type=='disable_shopping'} selected="selected"{/if}{/if}>{l s='Disable shopping feature' mod='ets_marketplace'}</option>
                            <option value="disable_shopping_and_show_notifications" {if isset($smarty.post.vacation_type)}{if $smarty.post.vacation_type=='disable_shopping_and_show_notifications'} selected="selected"{/if}{else}{if $seller->vacation_type=='disable_shopping_and_show_notifications'} selected="selected"{/if}{/if}>{l s='Disable shopping feature and show notifications' mod='ets_marketplace'}</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row enable_vacation_mode show_notifications">
                    <label class="col-md-3 form-control-label required"> {l s='Notification' mod='ets_marketplace'} </label>
                    <div class="col-md-9">
                        {if $languages && count($languages)>1}
                            <div class="form-group row">
                                {foreach from=$languages item='language'}
                                    <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                                        <div class="col-lg-10">
                                            {if isset($valueFieldPost)}
                                                {assign var='value_text' value=$valueFieldPost['vacation_notifications'][$language.id_lang]}
                                            {/if}
                                            <textarea class="form-control" name="vacation_notifications_{$language.id_lang|intval}">{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{elseif !isset($smarty.post.vacation_type)}{l s='This seller is currently on vacation. Add the products to your shopping cart and purchase when the seller is back.' mod='ets_marketplace'}{/if}</textarea>
                                        </div>
                                        <div class="col-lg-2">
                                            <div class="toggle_form">
                                            <button class="btn btn-default dropdown-toggle" type="button" tabindex="-1" data-toggle="dropdown">
                                            {$language.iso_code|escape:'html':'UTF-8'}
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 704q0 26-19 45l-448 448q-19 19-45 19t-45-19l-448-448q-19-19-19-45t19-45 45-19h896q26 0 45 19t19 45z"/></svg>
                                            </button>
                                            <ul class="dropdown-menu">
                                                {foreach from=$languages item='lang'}
                                                    <li>
                                                        <a class="hideOtherLanguage" href="#" tabindex="-1" data-id-lang="{$lang.id_lang|intval}">{$lang.name|escape:'html':'UTF-8'}</a>
                                                    </li>
                                                {/foreach}
                                            </ul>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        {else}
                            {if isset($valueFieldPost)}
                                {assign var='value_text' value=$valueFieldPost['vacation_notifications'][$id_lang_default]}
                            {/if}
                            <textarea class="form-control" name="vacation_notifications_{$id_lang_default|intval}">{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{elseif !isset($smarty.post.vacation_type)}{l s='This seller is currently on vacation. Add the products to your shopping cart and purchase when the seller is back.' mod='ets_marketplace'}{/if}</textarea>
                        {/if}
                    </div>
                </div>  
                <div class="form-group row">
                    <div class="col-md-3"> </div>
                    <div class="col-md-9">
                        <input name="submitSaveVacationSeller" value="1" type="hidden" />
                        <button class="btn btn-primary form-control-submit float-xs-right" type="submit">
                            <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                        </button>
                    </div>
                </div>
                <div class="clearfix"></div>
            </section>
        </form>
    </section>
</div>