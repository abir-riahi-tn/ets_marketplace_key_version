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

<script type="text/javascript" src="{$url_path|escape:'html':'UTF-8'}views/js/tinymce/tinymce.min.js"></script>
<script  type="text/javascript">
    var confirm_delete_specific = '{l s='This will delete the specific price. Do you wish to proceed?' mod='ets_marketplace' js=1}';
    var Unlimited_text ='{l s='Unlimited' mod='ets_marketplace' js=1}';
    var all_combinations_text = '{l s='All combinations' mod='ets_marketplace' js=1}';
    var all_currencies_text ='{l s='All currencies' mod='ets_marketplace' js=1}';
    var all_countries_text = '{l s='All countries' mod='ets_marketplace' js=1}';
    var all_groups_text ='{l s='All groups' mod='ets_marketplace' js=1}';
    var all_customer_text = '{l s='All customers' mod='ets_marketplace' js=1}';
    var from_text = '{l s='From' mod='ets_marketplace' js=1}';
    var to_text = '{l s='To' mod='ets_marketplace' js=1}';
    var id_lang_default ={$id_lang_default|intval};
    {if $product_class->id}
        var ets_mp_is_updating= true;
    {else}
        var ets_mp_is_updating = false;
    {/if}
    var virtual_product_text = '{l s='Virtual product' mod='ets_marketplace' js=1}';
    var quantities_text = '{l s='Quantities' mod='ets_marketplace' js=1}';
    var delete_all_combination_confirm = '{l s='This will delete all the combinations. Do you wish to proceed?' mod='ets_marketplace' js=1}';
    var download_file_text = '{l s='Download file' mod='ets_marketplace' js=1}';
    var delete_file_text = '{l s='Delete this file' mod='ets_marketplace' js=1}';
    var delete_file_comfirm = '{l s='Are you sure to delete this?' mod='ets_marketplace' js=1}';
    var delete_item_comfirm = '{l s='Do you want to delete this item?' mod='ets_marketplace' js=1}';
    var delete_image_comfirm = '{l s='Do you want to delete this image?' mod='ets_marketplace' js=1}';
    var PS_ALLOW_ACCENTED_CHARS_URL ={Configuration::get('PS_ALLOW_ACCENTED_CHARS_URL')|intval};
    var ets_mp_url_search_product = '{$ets_mp_url_search_product nofilter}';
    var ets_mp_url_search_related_product ='{$ets_mp_url_search_related_product nofilter}';
    var ets_mp_url_search_customer ='{$ets_mp_url_search_customer nofilter}';
    var cover_text = '{l s='Cover' mod='ets_marketplace' js=1}';
    var ets_mp_tax_rule_groups = {literal}{}{/literal};
    {if $tax_rule_groups}
        {foreach from=$tax_rule_groups item='rule_groups'}
            ets_mp_tax_rule_groups[{$rule_groups.id_tax_rules_group|intval}] = {$rule_groups.value_tax|floatval};
        {/foreach}
    {/if}
    {if !in_array('tax',$seller_product_information)}
        var no_user_tax= true;
    {else}
        var no_user_tax = false;
    {/if}
</script>
<form id="ets_mp_product_form" action="" method="post" enctype="multipart/form-data">
    <div class="ets_mp_errors"></div>
    {if $mpProduct && $mpProduct->id}
        {if $mpProduct->status==-1}
            <div class="alert alert-info"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg> {l s='Pending update' mod='ets_marketplace'}.</div>
        {/if}
        {if $mpProduct->status==0}
            <div class="alert alert-warning">
                <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {l s='Declined update' mod='ets_marketplace'}.
                {if $mpProduct->decline}
                    <p>{l s='Reason' mod='ets_marketplace'}: {$mpProduct->decline|nl2br nofilter}</p>
                {/if}
            </div>
        {/if}
    {/if}
    <div class="ets_mp_product_tab_content_header">
        <div class="form-group">
            <div class="col-lg-9">
                {if $languages && count($languages)>1}
                    <div class="form-group mp_product_name">
                        {foreach from=$languages item='language'}
                            <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                                <div class="col-lg-10">
                                    {if isset($valueFieldPost)}
                                        {assign var='value_text' value=$valueFieldPost['name'][$language.id_lang]}
                                    {/if}
                                    <input class="form-control" placeholder="{l s='Product Name' mod='ets_marketplace'}" name="name_{$language.id_lang|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
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
                        {assign var='value_text' value=$valueFieldPost['name'][$id_lang_default]}
                    {/if}
                    <input class="form-control" placeholder="{l s='Product Name' mod='ets_marketplace'}" name="name_{$id_lang_default|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
                {/if}
            </div>
            <div class="col-lg-3">
                <div class="product_type_select">
                    <select name="product_type" id="product_type" class="form-control {$valueFieldPost.product_type|escape:'html':'UTF-8'}">
                        {if in_array('standard_product',$seller_product_types) || ($valueFieldPost.product_type==0 && $product_class->id)}
                            <option value="0" {if $valueFieldPost.product_type==0} selected="selected"{/if}>{l s='Standard product' mod='ets_marketplace'}</option>
                        {/if}
                        {if in_array('pack_product',$seller_product_types) || $valueFieldPost.product_type==1}
                            <option value="1"{if $valueFieldPost.product_type==1} selected="selected"{/if}>{l s='Pack of products' mod='ets_marketplace'}</option>
                        {/if}
                        {if in_array('virtual_product',$seller_product_types) || $valueFieldPost.product_type==2}
                            <option value="2"{if $valueFieldPost.product_type==2} selected="selected"{/if}>{l s='Virtual product' mod='ets_marketplace'}</option>
                        {/if}
                    </select>
                </div>
                {*
                <a title="{l s='Add new' mod='ets_marketplace'}" class="list-toolbar-btn add_new_link" href="{$link_new_product nofilter}" {if !$product_class->id} style="display:none" {/if}>
                    <svg width="18" height="18" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-256v-256q0-26-19-45t-45-19h-128q-26 0-45 19t-19 45v256h-256q-26 0-45 19t-19 45v128q0 26 19 45t45 19h256v256q0 26 19 45t45 19h128q26 0 45-19t19-45v-256h256q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"></path></svg>
                </a>
                *}
            </div>
        </div>
    </div>
    <ul class="ets_mp_product_tab">
        {foreach from=$product_tabs item='product_tab'}
            <li class="ets_mp_tab{if $current_tab==$product_tab.tab} active{/if}" data-tab="{$product_tab.tab|escape:'html':'UTF-8'}">{$product_tab.name|escape:'html':'UTF-8'}</li>
        {/foreach}
    </ul>
    <div class="ets_mp_product_tab_content">
        <input name="id_product" type="hidden" id="ets_mp_id_product" value="{$product_class->id|intval}"/>
        <div class="ets_mp-form-content-setting-combination">
        </div>
        <div class="ets_mp-form-content">
            {foreach from=$product_tabs item='product_tab'}
                <div class="ets_mp_tab_content {$product_tab.tab|escape:'html':'UTF-8'}{if $current_tab==$product_tab.tab} active{/if}">
                    {$product_tab.content_html nofilter}        
                </div>
            {/foreach}
        </div>
        <div class="ets_mp-form-footer">
            <a class="btn btn-secondary bd text-uppercase" href="{$link->getModuleLink('ets_marketplace','products',['list'=>1])|escape:'html':'UTF-8'}" title="">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1203 544q0 13-10 23l-393 393 393 393q10 10 10 23t-10 23l-50 50q-10 10-23 10t-23-10l-466-466q-10-10-10-23t10-23l466-466q10-10 23-10t23 10l50 50q10 10 10 23z"/></svg> {l s='Back' mod='ets_marketplace'}
            </a>
            
            <button name="submitSaveProduct" type="submit" class="btn btn-primary form-control-submit float-xs-right">{if $product_class->id}{l s='Save' mod='ets_marketplace'}{else}{l s='Submit' mod='ets_marketplace'}{/if}</button>
            {if $product_class->id}
                <a class="btn btn-primary float-xs-right preview_product" href="{if $product_class->active}{$link->getProductLink($product_class->id)|escape:'html':'UTF-8'}{else}{$link->getProductLink($product_class->id,null,null,null,null,null,null,false,false,false,['adtoken'=>$adtoken,'id_employee'=>$customerID,'preview'=>1])|escape:'html':'UTF-8'}{/if}" target="_blank">{l s='Preview' mod='ets_marketplace'}</a>
            {/if}
        </div>
    </div>
</form>