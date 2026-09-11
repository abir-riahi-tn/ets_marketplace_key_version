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
var text_update_position='{l s='Successful update' mod='ets_marketplace'}';
</script>
<div class="panel ets_mp-panel{if isset($class)} {$class|escape:'html':'UTF-8'}{/if}">
    <div class="panel-heading">{$title nofilter}
        {if isset($totalRecords) && $totalRecords>0}<span class="badge">{$totalRecords|intval}</span>{/if}
        <span class="panel-heading-action">
            {if isset($show_add_new) && $show_add_new}            
                <a class="list-toolbar-btn add_new_link" href="{if isset($link_new)}{$link_new|escape:'html':'UTF-8'}{else}{$currentIndex|escape:'html':'UTF-8'}{/if}">
                    <span data-placement="top" data-html="true" data-original-title="{l s='Add new' mod='ets_marketplace'}" class="label-tooltip" data-toggle="tooltip" title="">
        				<svg width="18" height="18" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-256v-256q0-26-19-45t-45-19h-128q-26 0-45 19t-19 45v256h-256q-26 0-45 19t-19 45v128q0 26 19 45t45 19h256v256q0 26 19 45t45 19h128q26 0 45-19t19-45v-256h256q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg> {l s='Add new' mod='ets_marketplace'}
                    </span>
                </a>            
            {/if}
            {if isset($preview_link) && $preview_link}            
                <a target="_blank" class="list-toolbar-btn" href="{$preview_link|escape:'html':'UTF-8'}">
                    <span data-placement="top" data-html="true" data-original-title="{l s='Preview ' mod='ets_marketplace'} ({$title|escape:'html':'UTF-8'})" class="label-tooltip" data-toggle="tooltip" title="">
        				<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1088 800v64q0 13-9.5 22.5t-22.5 9.5h-224v224q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-224h-224q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h224v-224q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5v224h224q13 0 22.5 9.5t9.5 22.5zm128 32q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 53-37.5 90.5t-90.5 37.5q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg>
                    </span>
                </a>            
            {/if}
            {if isset($link_export) && $link_export}            
                <a  class="list-toolbar-btn" href="{$link_export|escape:'html':'UTF-8'}">
                    <span data-placement="top" data-html="true" data-original-title="{l s='Export ' mod='ets_marketplace'} ({$title|escape:'html':'UTF-8'})" class="label-tooltip" data-toggle="tooltip" title="">
        				<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 1344q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm256 0q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm128-224v320q0 40-28 68t-68 28h-1472q-40 0-68-28t-28-68v-320q0-40 28-68t68-28h465l135 136q58 56 136 56t136-56l136-136h464q40 0 68 28t28 68zm-325-569q17 41-14 70l-448 448q-18 19-45 19t-45-19l-448-448q-31-29-14-70 17-39 59-39h256v-448q0-26 19-45t45-19h256q26 0 45 19t19 45v448h256q42 0 59 39z"/></svg> {l s='Export' mod='ets_marketplace'}
                    </span>
                </a>            
            {/if}
            {if isset($link_import) && $link_import}            
                <a class="list-toolbar-btn" href="{$link_import|escape:'html':'UTF-8'}">
                    <span data-placement="top" data-html="true" data-original-title="{l s='Import ' mod='ets_marketplace'} ({$title|escape:'html':'UTF-8'})" class="label-tooltip" data-toggle="tooltip" title="">
        				<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 1472q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm256 0q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm128-224v320q0 40-28 68t-68 28h-1472q-40 0-68-28t-28-68v-320q0-40 28-68t68-28h427q21 56 70.5 92t110.5 36h256q61 0 110.5-36t70.5-92h427q40 0 68 28t28 68zm-325-648q-17 40-59 40h-256v448q0 26-19 45t-45 19h-256q-26 0-45-19t-19-45v-448h-256q-42 0-59-40-17-39 14-69l448-448q18-19 45-19t45 19l448 448q31 30 14 69z"/></svg> {l s='Import' mod='ets_marketplace'}
                    </span>
                </a>            
            {/if}
        </span>
    </div>
    {if $fields_list}
        <div class="table-responsive clearfix">
            <form method="post" action="{if isset($postIndex)}{$postIndex|escape:'html':'UTF-8'}{else}{$currentIndex|escape:'html':'UTF-8'}{/if}">
                {if isset($bulk_action_html)}
                    {$bulk_action_html nofilter}
                {/if}
                <table class="table configuration alltab_ss{if isset($has_delete_product) && (Configuration::get('ETS_MP_ALLOW_SELLER_CREATE_PRODUCT') || (isset($has_edit_product) && $has_edit_product) || $has_delete_product) } allow_checkbox_product{/if} list-{$name|escape:'html':'UTF-8'}">
                    <thead>
                        <tr class="nodrag nodrop">
                            {assign var ='i' value=1}
                            {foreach from=$fields_list item='field' key='index'}
                                <th class="{$index|escape:'html':'UTF-8'}{if isset($field.class)} {$field.class|escape:'html':'UTF-8'}{/if}" {if $show_action && !$actions && count($fields_list)==$i}colspan="2"{/if}>
                                    <span class="title_box">
                                        {$field.title nofilter}
                                        {if isset($field.sort) && $field.sort}
                                            <span class="soft">
                                            <a href="{$currentIndex|escape:'html':'UTF-8'}&sort={$index|escape:'html':'UTF-8'}&sort_type=desc{$filter_params nofilter}" {if isset($sort)&& $sort==$index && isset($sort_type) && $sort_type=='desc'} class="active"{/if}><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 704q0 26-19 45l-448 448q-19 19-45 19t-45-19l-448-448q-19-19-19-45t19-45 45-19h896q26 0 45 19t19 45z"/></svg></a>
                                            <a href="{$currentIndex|escape:'html':'UTF-8'}&sort={$index|escape:'html':'UTF-8'}&sort_type=asc{$filter_params nofilter}" {if isset($sort)&& $sort==$index && isset($sort_type) && $sort_type=='asc'} class="active"{/if}><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 1216q0 26-19 45t-45 19h-896q-26 0-45-19t-19-45 19-45l448-448q19-19 45-19t45 19l448 448q19 19 19 45z"/></svg></a>
                                            </span>
                                         {/if}
                                    </span>
                                </th>  
                                {assign var ='i' value=$i+1}                          
                            {/foreach}
                            {if $show_action && $actions}
                                <th class="table_action" style="text-align: right;">{l s='Action' mod='ets_marketplace'}</th>
                            {/if}
                        </tr>
                        {if $show_toolbar}
                            <tr class="nodrag nodrop filter row_hover">
                                {foreach from=$fields_list item='field' key='index'}
                                    <th class="{$index|escape:'html':'UTF-8'}{if isset($field.class)} {$field.class|escape:'html':'UTF-8'}{/if}">
                                        {if isset($field.filter) && $field.filter}
                                            {if $field.type=='text'}
                                                <input class="filter" name="{$index|escape:'html':'UTF-8'}" type="text" {if isset($field.width)}style="width: {$field.width|intval}px;"{/if} {if isset($field.active)}value="{$field.active|escape:'html':'UTF-8'}"{/if}/>
                                            {/if}
                                            {if $field.type=='select' || $field.type=='active'}
                                                <select  {if isset($field.width)}style="width: {$field.width|intval}px;"{/if}  name="{$index|escape:'html':'UTF-8'}">
                                                    <option value=""> -- </option>
                                                    {if isset($field.filter_list.list) && $field.filter_list.list}
                                                        {assign var='id_option' value=$field.filter_list.id_option}
                                                        {assign var='value' value=$field.filter_list.value}
                                                        {foreach from=$field.filter_list.list item='option'}
                                                            <option {if ($field.active!=='' && $field.active==$option.$id_option) || ($field.active=='' && $index=='has_post' && $option.$id_option==1 )} selected="selected"{/if} value="{$option.$id_option|escape:'html':'UTF-8'}">{$option.$value|escape:'html':'UTF-8'}</option>
                                                        {/foreach}
                                                    {/if}
                                                </select>                                            
                                            {/if}
                                            {if $field.type=='int'}
                                                <label for="{$index|escape:'html':'UTF-8'}_min"><input type="text" placeholder="{l s='Min' mod='ets_marketplace'}" name="{$index|escape:'html':'UTF-8'}_min" value="{$field.active.min|escape:'html':'UTF-8'}" /></label>
                                                <label for="{$index|escape:'html':'UTF-8'}_max"><input type="text" placeholder="{l s='Max' mod='ets_marketplace'}" name="{$index|escape:'html':'UTF-8'}_max" value="{$field.active.max|escape:'html':'UTF-8'}" /></label>
                                            {/if}
                                            {if $field.type=='date'}
                                                <fieldset class="form-group"> 
                                                    <div class="input-group ets_mp_datepicker">
                                                        <input id="{$index|escape:'html':'UTF-8'}_min" autocomplete="off" class="form-control" name="{$index|escape:'html':'UTF-8'}_min" placeholder="{l s='From' mod='ets_marketplace'}" value="{$field.active.min|escape:'html':'UTF-8'}" type="text" autocomplete="off" />
                                                        <div class="input-group-append">
                                                            <div class="input-group-text">
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h288v-288h-288v288zm352 0h320v-288h-320v288zm-352-352h288v-320h-288v320zm352 0h320v-320h-320v320zm-352-384h288v-288h-288v288zm736 736h320v-288h-320v288zm-384-736h320v-288h-320v288zm768 736h288v-288h-288v288zm-384-352h320v-320h-320v320zm-352-864v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm736 864h288v-320h-288v320zm-384-384h320v-288h-320v288zm384 0h288v-288h-288v288zm32-480v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                                <fieldset class="form-group"> 
                                                    <div class="input-group ets_mp_datepicker">
                                                        <input id="{$index|escape:'html':'UTF-8'}_max" autocomplete="off" class="form-control" name="{$index|escape:'html':'UTF-8'}_max" placeholder="{l s='To' mod='ets_marketplace'}" value="{$field.active.max|escape:'html':'UTF-8'}" type="text" autocomplete="off" />
                                                        <div class="input-group-append">
                                                            <div class="input-group-text">
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h288v-288h-288v288zm352 0h320v-288h-320v288zm-352-352h288v-320h-288v320zm352 0h320v-320h-320v320zm-352-384h288v-288h-288v288zm736 736h320v-288h-320v288zm-384-736h320v-288h-320v288zm768 736h288v-288h-288v288zm-384-352h320v-320h-320v320zm-352-864v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm736 864h288v-320h-288v320zm-384-384h320v-288h-320v288zm384 0h288v-288h-288v288zm32-480v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            {/if}
                                        {elseif ( ($name == 'mp_front_products' || $name == 'mp_products') && $field.type == 'text' && isset($index) && $index == 'input_box') }
                                            <div class="md-checkbox">
                                                <label>
                                                  <input id="bulk_action_select_all" onclick="$('table').find('td input:checkbox').prop('checked', $(this).prop('checked')); ets_mp_updateBulkMenu();" value="" type="checkbox">
                                                  <i class="md-checkbox-control"></i>
                                                </label>
                                            </div>
                                        {elseif ( $field.type == 'text' && isset($index) && $index == 'input_box') }
                                            <div class="md-checkbox">
                                                <label>
                                                    <input id="bulk_action_select_all" onclick="$('table').find('td input:checkbox').prop('checked', $(this).prop('checked')); ets_mp_updateBulkMenu();" value="" type="checkbox" />
                                                    <i class="md-checkbox-control"></i>
                                                </label>
                                            </div>
                                        {else}
                                           {l s=' -- ' mod='ets_marketplace'}
                                        {/if}
                                    </th>
                                {/foreach}
                                {if $show_action}
                                    <th class="actions">
                                        <span class="pull-right flex">
                                            <input type="hidden" name="post_filter" value="yes" />
                                            {if $show_reset}<a  class="btn btn-warning"  href="{$currentIndex|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M960 1408l336-384h-768l-336 384h768zm1013-1077q15 34 9.5 71.5t-30.5 65.5l-896 1024q-38 44-96 44h-768q-38 0-69.5-20.5t-47.5-54.5q-15-34-9.5-71.5t30.5-65.5l896-1024q38-44 96-44h768q38 0 69.5 20.5t47.5 54.5z"/></svg> {l s='Reset' mod='ets_marketplace'}</a> &nbsp;{/if}
                                            <button class="btn btn-default" name="ets_mp_submit_{$name|escape:'html':'UTF-8'}" id="ets_mp_submit_{$name|escape:'html':'UTF-8'}" type="submit">
            									<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1216 832q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 52-38 90t-90 38q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg> {l s='Filter' mod='ets_marketplace'}
            								</button>
                                        </span>
                                    </th>
                                {/if}
                            </tr>
                        {/if}
                    </thead>
                    <tbody id="list-{$name|escape:'html':'UTF-8'}">
                        {if $field_values}
                        {foreach from=$field_values item='row'}
                            <tr {if isset($row.read) && !$row.read}class="no-read"{/if} data-id="{$row.$identifier|intval}">
                                {assign var='i' value=1}
                                {foreach from=$fields_list item='field' key='key'}                             
                                    <td class="{$key|escape:'html':'UTF-8'} {if isset($sort)&& $sort==$key && isset($sort_type) && $sort_type=='asc' && isset($field.update_position) && $field.update_position}pointer dragHandle center{/if}{if isset($field.class)} {$field.class|escape:'html':'UTF-8'}{/if}" {if $show_action && !$actions && count($fields_list)==$i}colspan="2"{/if} >
                                        {if isset($field.rating_field) && $field.rating_field}
                                            {if isset($row.$key) && $row.$key > 0}
                                                {for $i=1 to (int)$row.$key}
                                                    <div class="star star_on"></div>
                                                {/for}
                                                {if (int)$row.$key < 5}
                                                    {for $i=(int)$row.$key+1 to 5}
                                                        <div class="star"></div>
                                                    {/for}
                                                {/if}
                                            {else}
                                                {l s=' -- ' mod='ets_marketplace'}
                                            {/if}
                                        {elseif $field.type != 'active'}
                                            {if $field.type=='date'}
                                                {if !$row.$key}
                                                --
                                                {else}
                                                    {if $key!='date_from' && $key!='date_to'}
                                                        {dateFormat date=$row.$key full=1}
                                                    {else}
                                                        {dateFormat date=$row.$key full=0}
                                                    {/if}
                                                {/if}
                                            {elseif $field.type=='checkbox'}
                                                <input type="checkbox" name="{$name|escape:'html':'UTF-8'}_boxs[]" value="{$row.$identifier|escape:'html':'UTF-8'}" class="{$name|escape:'html':'UTF-8'}_boxs" />
                                            {elseif $field.type=='input_number'}
                                                {assign var='field_input' value=$field.field}
                                                <div class="qty edit_quantity" data-v-599c0dc5="">
                                                    <div class="ps-number edit-qty hover-buttons" data-{$identifier|escape:'html':'UTF-8'}="{$row.$identifier|escape:'html':'UTF-8'}">
                                                        <input class="form-control {$name|escape:'html':'UTF-8'}_{$field_input|escape:'html':'UTF-8'}" type="number" name="{$name|escape:'html':'UTF-8'}_{$field_input|escape:'html':'UTF-8'}[{$row.$identifier|escape:'html':'UTF-8'}]" value="" placeholder="0" />
                                                        <div class="ps-number-spinner d-flex">
                                                            <span class="ps-number-up"></span>
                                                            <span class="ps-number-down"></span>
                                                        </div>
                                                    </div>
                                                    <button class="check-button" disabled="disabled">
                                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg></button>
                                                </div>
                                            {else}
                                                {if isset($field.update_position) && $field.update_position}
                                                    <div class="dragGroup">
                                                    <span class="positions">
                                                {/if}
                                                {if isset($row.$key) && $row.$key!=='' && !is_array($row.$key)}{if isset($field.strip_tag) && !$field.strip_tag}{$row.$key nofilter}{else}{$row.$key|strip_tags:'UTF-8'|truncate:120:'...'|escape:'html':'UTF-8'}{/if}{else}--{/if}
                                                {if isset($row.$key) && is_array($row.$key) && isset($row.$key.image_field) && $row.$key.image_field}
                                                    <a class="ets_mp_fancy" href="{$row.$key.img_url|escape:'html':'UTF-8'}"><img style="{if isset($row.$key.height) && $row.$key.height}max-height: {$row.$key.height|intval}px;{/if}{if isset($row.$key.width) && $row.$key.width}max-width: {$row.$key.width|intval}px;{/if}" src="{$row.$key.img_url|escape:'html':'UTF-8'}" /></a>
                                                {/if} 
                                                {if isset($field.update_position) && $field.update_position}
                                                    </div>
                                                    </span>
                                                {/if}  
                                            {/if}                                     
                                        {else}
                                            {if isset($row.$key) && $row.$key}
                                                {if $row.$key==-1}
                                                    {if (!isset($row.action_edit) || $row.action_edit) && ($name!='mp_front_products' || (isset($row.approved) && $row.approved==1))}
                                                        <a name="{$name|escape:'html':'UTF-8'}" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&change_enabled=1&field={$key|escape:'html':'UTF-8'}" class="list-action field-{$key|escape:'html':'UTF-8'} list-action-enable action-pending  list-item-{$row.$identifier|escape:'html':'UTF-8'}" data-id="{$row.$identifier|escape:'html':'UTF-8'}" title="{if $key=='reported'}{l s='Click to mark as reported' mod='ets_marketplace'}{else}{l s='Click to enable' mod='ets_marketplace'}{/if}">
                                                            <svg width="14" height="14" style="fill:orange!important;" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 544v448q0 14-9 23t-23 9h-320q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h224v-352q0-14 9-23t23-9h64q14 0 23 9t9 23zm416 352q0-148-73-273t-198-198-273-73-273 73-198 198-73 273 73 273 198 198 273 73 273-73 198-198 73-273zm224 0q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                                        </a>
                                                    {else}
                                                        <span class="list-action-enable action-pending" title="{l s='Pending' mod='ets_marketplace'}">
                                                            <svg width="14" height="14" style="fill:orange!important;" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 544v448q0 14-9 23t-23 9h-320q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h224v-352q0-14 9-23t23-9h64q14 0 23 9t9 23zm416 352q0-148-73-273t-198-198-273-73-273 73-198 198-73 273 73 273 198 198 273 73 273-73 198-198 73-273zm224 0q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                                        </span>
                                                    {/if}
                                                {else}
                                                    {if $row.$key==-2}
                                                        {if (!isset($row.action_edit) || $row.action_edit) && $name!='mp_front_products'}
                                                            <a name="{$name|escape:'html':'UTF-8'}" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&change_enabled=1&field={$key|escape:'html':'UTF-8'}" class="list-action field-{$key|escape:'html':'UTF-8'} list-action-enable action-disabled  list-item-{$row.$identifier|escape:'html':'UTF-8'}" data-id="{$row.$identifier|escape:'html':'UTF-8'}" title="{l s='Click to enable' mod='ets_marketplace'}"><svg fill="red" style="fill:red!important;" width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1440 893q0-161-87-295l-754 753q137 89 297 89 111 0 211.5-43.5t173.5-116.5 116-174.5 43-212.5zm-999 299l755-754q-135-91-300-91-148 0-273 73t-198 199-73 274q0 162 89 299zm1223-299q0 157-61 300t-163.5 246-245 164-298.5 61-298.5-61-245-164-163.5-246-61-300 61-299.5 163.5-245.5 245-164 298.5-61 298.5 61 245 164 163.5 245.5 61 299.5z"/></svg></a>
                                                        {else}
                                                            <span class="list-action-enable action-disabled" title="{l s='Declined' mod='ets_marketplace'}">
                                                                <svg style="fill:red!important;" width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1440 893q0-161-87-295l-754 753q137 89 297 89 111 0 211.5-43.5t173.5-116.5 116-174.5 43-212.5zm-999 299l755-754q-135-91-300-91-148 0-273 73t-198 199-73 274q0 162 89 299zm1223-299q0 157-61 300t-163.5 246-245 164-298.5 61-298.5-61-245-164-163.5-246-61-300 61-299.5 163.5-245.5 245-164 298.5-61 298.5 61 245 164 163.5 245.5 61 299.5z"/></svg>
                                                            </span>
                                                        {/if}
                                                    {else}
                                                        {if (!isset($row.action_edit) || $row.action_edit) && ($name!='mp_front_products' || (isset($row.approved) && $row.approved==1))}
                                                            <a name="{$name|escape:'html':'UTF-8'}"  href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&change_enabled=0&field={$key|escape:'html':'UTF-8'}" class="list-action field-{$key|escape:'html':'UTF-8'} list-action-enable action-enabled list-item-{$row.$identifier|escape:'html':'UTF-8'}" data-id="{$row.$identifier|escape:'html':'UTF-8'}" title="{if $key=='reported'}{l s='Click to unreport' mod='ets_marketplace'}{else}{l s='Click to disable' mod='ets_marketplace'}{/if}">
                                                                <svg width="14" height="14" style="fill:#00d200!important;" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>
                                                            </a>
                                                        {else}
                                                            <span class="list-action-enable action-enabled" title="{l s='Enabled' mod='ets_marketplace'}">
                                                                <svg width="14" height="14" style="fill:#00d200!important;" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>
                                                            </span>
                                                        {/if}
                                                    {/if}
                                                {/if}
                                            {else}
                                                {if (!isset($row.action_edit) || $row.action_edit) && ($name!='mp_front_products' || (isset($row.approved) && $row.approved==1))}
                                                    <a name="{$name|escape:'html':'UTF-8'}" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&change_enabled=1&field={$key|escape:'html':'UTF-8'}" class="list-action field-{$key|escape:'html':'UTF-8'} list-action-enable action-disabled  list-item-{$row.$identifier|escape:'html':'UTF-8'}" data-id="{$row.$identifier|escape:'html':'UTF-8'}" title="{if $key=='reported'}{l s='Click to mark as reported' mod='ets_marketplace'}{else}{l s='Click to enable' mod='ets_marketplace'}{/if}">
                                                        <svg style="fill:red!important;" width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                                                    </a>
                                                {else}
                                                    <span class="list-action-enable action-disabled" title="{l s='Disabled' mod='ets_marketplace'}">
                                                        <svg style="fill:red!important;" width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                                                    </span>
                                                {/if}
                                            {/if}
                                            {if $name=='mp_front_products' && !$row.available_for_order}
                                               <a name="{$name|escape:'html':'UTF-8'}" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&change_enabled=1&field=available_for_order" class="list-action field-available_for_order list-action-enable action-disabled  list-item-{$row.$identifier|escape:'html':'UTF-8'}" data-id="{$row.$identifier|escape:'html':'UTF-8'}" title="{l s='Not available for order' mod='ets_marketplace'}">
                                                   <svg style="fill:red!important;" width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                                               </a> 
                                            {/if}
                                            {if $name=='mp_front_products' && $row.wait_change}
                                                {if $row.change_status==-1}
                                                    <p class="change_status color_pending">{l s='Pending update' mod='ets_marketplace'}</p>
                                                {/if}
                                                {if $row.change_status==0}
                                                    <p class="change_status color_decline">{l s='Declined update' mod='ets_marketplace'}</p>
                                                {/if}
                                            {/if}
                                        {/if}
                                    </td>
                                    {assign var='i' value=$i+1}
                                {/foreach}
                                {if $show_action}
                                    {if $actions}  
                                        <td class="text-right">                            
                                            <div class="btn-group-action">
                                                <div class="btn-group pull-right">
                                                        {if $actions[0]=='view'}
                                                            {if isset($row.child_view_url) && $row.child_view_url}
                                                                <a class="btn btn-default link_view" href="{$row.child_view_url|escape:'html':'UTF-8'}" {if isset($view_new_tab) && $view_new_tab} target="_blank" {/if}><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1088 800v64q0 13-9.5 22.5t-22.5 9.5h-224v224q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-224h-224q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h224v-224q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5v224h224q13 0 22.5 9.5t9.5 22.5zm128 32q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 53-37.5 90.5t-90.5 37.5q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg> {l s='View' mod='ets_marketplace'}</a>
                                                            {elseif !isset($row.action_edit) || $row.action_edit}
                                                                <a class="btn btn-default link_edit" href="{$currentIndex|escape:'html':'UTF-8'}&edit{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}" ><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg> {l s='Edit' mod='ets_marketplace'}</a>
                                                            {/if}
                                                        {/if}
                                                        {if $actions[0]=='delete'}
                                                            <a class="btn btn-default" onclick="return confirm('{l s='Do you want to delete this item?' mod='ets_marketplace' js=1}');" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&del=yes"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> {l s='Delete' mod='ets_marketplace'}</a>
                                                        {/if}
                                                        {if $actions[0]=='send_mail'}
                                                            <a class="btn btn-default btn-send-mail" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&submitSendMail=1"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1504v-768q-32 36-69 66-268 206-426 338-51 43-83 67t-86.5 48.5-102.5 24.5h-2q-48 0-102.5-24.5t-86.5-48.5-83-67q-158-132-426-338-37-30-69-66v768q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm0-1051v-24.5l-.5-13-3-12.5-5.5-9-9-7.5-14-2.5h-1472q-13 0-22.5 9.5t-9.5 22.5q0 168 147 284 193 152 401 317 6 5 35 29.5t46 37.5 44.5 31.5 50.5 27.5 43 9h2q20 0 43-9t50.5-27.5 44.5-31.5 46-37.5 35-29.5q208-165 401-317 54-43 100.5-115.5t46.5-131.5zm128-37v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg> {l s='Send email' mod='ets_marketplace'}</a>
                                                        {/if}
                                                        {if $actions[0]=='reply'}
                                                            <a class="btn btn-default link_edit" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&reply=yes"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1792 1120q0 166-127 451-3 7-10.5 24t-13.5 30-13 22q-12 17-28 17-15 0-23.5-10t-8.5-25q0-9 2.5-26.5t2.5-23.5q5-68 5-123 0-101-17.5-181t-48.5-138.5-80-101-105.5-69.5-133-42.5-154-21.5-175.5-6h-224v256q0 26-19 45t-45 19-45-19l-512-512q-19-19-19-45t19-45l512-512q19-19 45-19t45 19 19 45v256h224q713 0 875 403 53 134 53 333z"/></svg> {l s='Reply' mod='ets_marketplace'}</a>
                                                        {/if}
                                                        {if $actions[0]=='dowloadpdf'}
                                                            <a class="ets_mp_downloadpdf" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&dowloadpdf=yes">
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1596 380q28 28 48 76t20 88v1152q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1600q0-40 28-68t68-28h896q40 0 88 20t76 48zm-444-244v376h376q-10-29-22-41l-313-313q-12-12-41-22zm384 1528v-1024h-416q-40 0-68-28t-28-68v-416h-768v1536h1280zm-514-593q33 26 84 56 59-7 117-7 147 0 177 49 16 22 2 52 0 1-1 2l-2 2v1q-6 38-71 38-48 0-115-20t-130-53q-221 24-392 83-153 262-242 262-15 0-28-7l-24-12q-1-1-6-5-10-10-6-36 9-40 56-91.5t132-96.5q14-9 23 6 2 2 2 4 52-85 107-197 68-136 104-262-24-82-30.5-159.5t6.5-127.5q11-40 42-40h22q23 0 35 15 18 21 9 68-2 6-4 8 1 3 1 8v30q-2 123-14 192 55 164 146 238zm-576 411q52-24 137-158-51 40-87.5 84t-49.5 74zm398-920q-15 42-2 132 1-7 7-44 0-3 7-43 1-4 4-8-1-1-1-2-1-2-1-3-1-22-13-36 0 1-1 2v2zm-124 661q135-54 284-81-2-1-13-9.5t-16-13.5q-76-67-127-176-27 86-83 197-30 56-45 83zm646-16q-24-24-140-24 76 28 124 28 14 0 18-1 0-1-2-3z"/></svg>
                                                                {l s='Download pdf' mod='ets_marketplace'}
                                                            </a>
                                                        {/if}
                                                        {if $name=='ms_commissions' && isset($row.status_val)}
                                                            {if isset($row.type) && $row.type=='usage'}
                                                                {if $row.status_val==1}
                                                                    <a onclick="return confirm('{l s='Do you want to refund this commission?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&return{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 896q0 156-61 298t-164 245-245 164-298 61q-172 0-327-72.5t-264-204.5q-7-10-6.5-22.5t8.5-20.5l137-138q10-9 25-9 16 2 23 12 73 95 179 147t225 52q104 0 198.5-40.5t163.5-109.5 109.5-163.5 40.5-198.5-40.5-198.5-109.5-163.5-163.5-109.5-198.5-40.5q-98 0-188 35.5t-160 101.5l137 138q31 30 14 69-17 40-59 40h-448q-26 0-45-19t-19-45v-448q0-42 40-59 39-17 69 14l130 129q107-101 244.5-156.5t284.5-55.5q156 0 298 61t245 164 164 245 61 298z"/></svg> {l s='Refund' mod='ets_marketplace'}</a>
                                                                {else}
                                                                    <a onclick="return confirm('{l s='Do you want to deduct this commission?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&deduct{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1600 736v192q0 40-28 68t-68 28h-1216q-40 0-68-28t-28-68v-192q0-40 28-68t68-28h1216q40 0 68 28t28 68z"/></svg> {l s='Deduct' mod='ets_marketplace'}</a>
                                                                {/if}
                                                            {else}
                                                                {if $row.status_val==-1 || $row.status_val==0}
                                                                    <a onclick="return confirm('{l s='Do you want to approve commission?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&approve{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Approve' mod='ets_marketplace'}</a>
                                                                {else}
                                                                    <a onclick="return confirm('{l s='Do you want to cancel commission?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&cancel{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Cancel' mod='ets_marketplace'}</a>
                                                                {/if}
                                                            {/if}
                                                        {/if}
                                                        {if $name=='ms_commissions_usage' && isset($row.status_val)}
                                                            {if $row.status_val==1}
                                                                <a onclick="return confirm('{l s='Do you want to refund this commission?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&return{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 896q0 156-61 298t-164 245-245 164-298 61q-172 0-327-72.5t-264-204.5q-7-10-6.5-22.5t8.5-20.5l137-138q10-9 25-9 16 2 23 12 73 95 179 147t225 52q104 0 198.5-40.5t163.5-109.5 109.5-163.5 40.5-198.5-40.5-198.5-109.5-163.5-163.5-109.5-198.5-40.5q-98 0-188 35.5t-160 101.5l137 138q31 30 14 69-17 40-59 40h-448q-26 0-45-19t-19-45v-448q0-42 40-59 39-17 69 14l130 129q107-101 244.5-156.5t284.5-55.5q156 0 298 61t245 164 164 245 61 298z"/></svg> {l s='Refund' mod='ets_marketplace'}</a>
                                                            {else}
                                                                <a onclick="return confirm('{l s='Do you want to deduct this commission?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&deduct{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1600 736v192q0 40-28 68t-68 28h-1216q-40 0-68-28t-28-68v-192q0-40 28-68t68-28h1216q40 0 68 28t28 68z"/></svg> {l s='Deduct' mod='ets_marketplace'}</a>
                                                            {/if}
                                                        {/if}
                                                        {if $name=='ms_billings' && isset($row.status)}
                                                            {if $row.status==0 || $row.status==-1}
                                                                <a onclick="return confirm('{l s='Do you want to paid this invoice? Please make sure this seller already sent the fee to you' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&purchase{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Set as paid' mod='ets_marketplace'}</a>
                                                            {else}
                                                                <a onclick="return confirm('{l s='Do you want to cancel this invoice?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&cancel{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Cancel' mod='ets_marketplace'}</a>
                                                            {/if}
                                                        {/if}
                                                        {if $name=='ets_registration'}
                                                            <a class="btn btn-default" href="{$row.child_view_url|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1088 800v64q0 13-9.5 22.5t-22.5 9.5h-224v224q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-224h-224q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h224v-224q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5v224h224q13 0 22.5 9.5t9.5 22.5zm128 32q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 53-37.5 90.5t-90.5 37.5q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg> {l s='View' mod='ets_marketplace'}</a>
                                                        {/if}
                                                        {if $actions|count >=2 && (!isset($row.action_edit) || $row.action_edit || in_array('action',$actions) || (isset($row.action_delete) &&$row.action_delete) )}
                                                            <button data-toggle="dropdown" class="btn btn-default dropdown-toggle">
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 704q0 26-19 45l-448 448q-19 19-45 19t-45-19l-448-448q-19-19-19-45t19-45 45-19h896q26 0 45 19t19 45z"/></svg>&nbsp;
                                        					</button>
                                                            <ul class="dropdown-menu">
                                                                {if $name=='ets_withdraw' && isset($row.change_status) && $row.change_status}
                                                                    <li><a onclick="return confirm('{l s='Do you want to approve this withdrawal?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&approve{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Approve' mod='ets_marketplace'}</a></li>
                                                                    <li><a onclick="return confirm('{l s='Do you want to decline with return commission this withdrawal?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&return{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 896q0 156-61 298t-164 245-245 164-298 61q-172 0-327-72.5t-264-204.5q-7-10-6.5-22.5t8.5-20.5l137-138q10-9 25-9 16 2 23 12 73 95 179 147t225 52q104 0 198.5-40.5t163.5-109.5 109.5-163.5 40.5-198.5-40.5-198.5-109.5-163.5-163.5-109.5-198.5-40.5q-98 0-188 35.5t-160 101.5l137 138q31 30 14 69-17 40-59 40h-448q-26 0-45-19t-19-45v-448q0-42 40-59 39-17 69 14l130 129q107-101 244.5-156.5t284.5-55.5q156 0 298 61t245 164 164 245 61 298z"/></svg> {l s='Decline - Return commission' mod='ets_marketplace'}</a></li>
                                                                    <li><a onclick="return confirm('{l s='Do you want to decline with deduct commission this withdrawal?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&deduct{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Decline - Deduct commission' mod='ets_marketplace'}</a></li>
                                                                {/if}
                                                                {if $name=='ms_commissions' && isset($row.status_val)}
                                                                    {if $row.status_val==-1}
                                                                       <li><a onclick="return confirm('{l s='Do you want to cancel this commission?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&cancel{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Cancel' mod='ets_marketplace'}</a></li>
                                                                    {/if}
                                                                {/if}
                                                                {if $name=='ms_billings' && isset($row.status)}
                                                                    {if $row.status==0}
                                                                        <a onclick="return confirm('{l s='Do you want to cancel this billing?' mod='ets_marketplace' js=1}');" class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&cancel{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Cancel' mod='ets_marketplace'}</a>
                                                                    {/if}
                                                                {/if}
                                                                {if $name=='ets_registration'}
                                                                    <li>
                                                                        <span class="btn btn-default action_approve_registration" data-id="{$row.$identifier|intval}" {if $row.status==1} style="display:none;"{/if}>
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
                                                                            <input name="active_registration" value="1" type="hidden" />
                                                                            <input name="id_registration" value="{$row.$identifier|intval}" type="hidden" />
                                                                            <div class="panel_footer form-group">
                                                                                <div class="control-label col-lg-3"></div>
                                                                                <div class="col-lg-9">
                                                                                    <button type="submit" value="1" name="saveStatusRegistration" class="btn btn-default saveStatusRegistration">
                                                                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                                                    </button>
                                                                                </div>
                                                                            </div>           
                                                                        </div>
                                                                    </li>
                                                                    <li>
                                                                        <span class="btn btn-default approve_registration action_decline_registration" data-id="{$row.$identifier|intval}" {if ($row.status==1 && $row.has_seller) || $row.status==0} style="display:none;"{/if}>
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
                                                                            <input name="id_registration" value="{$row.$identifier|intval}" type="hidden" />
                                                                            <div class="panel_footer form-group">
                                                                                <div class="control-label col-lg-3"></div>
                                                                                <div class="col-lg-9">
                                                                                    <button type="submit" value="1" name="saveStatusRegistration" class="btn btn-default saveStatusRegistration">
                                                                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                                                    </button>
                                                                                </div>
                                                                            </div>           
                                                                        </div>
                                                                    </li>
                                                                    <li><a onclick="return confirm('{l s='Do you want to delete this item?' mod='ets_marketplace'}');" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&del=yes"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> {l s='Delete' mod='ets_marketplace'}</a></li>
                                                                {/if}
                                                                {if $name=='ets_seller'}
                                                                    <li {if $row.status_val==1}style="display:none;"{/if}>
                                                                        <span class="btn btn-default approve_registration action_approve_seller" data-id="{$row.$identifier|intval}">
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
                                                                                            <input name="date_from" autocomplete="off" value="{$row.date_from|escape:'html':'UTF-8'}" class="" type="text" />
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
                                                                                            <input autocomplete="off" name="date_to" value="{$row.date_to|escape:'html':'UTF-8'}" class="" type="text" />
                                                                                            <span class="input-group-addon">
                                                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <input name="active_seller" value="1" type="hidden" />
                                                                            
                                                                            <input name="seller_id" value="{$row.$identifier|intval}" type="hidden" />
                                                                            <div class="panel_footer form-group">
                                                                                <div class="control-label col-lg-3"></div>
                                                                                <div class="col-lg-9">
                                                                                    <button type="submit" value="1" name="saveStatusSeller" class="btn btn-default saveStatusSeller">
                                                                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                                                    </button>
                                                                                </div>
                                                                            </div>           
                                                                        </div>
                                                                    </li>
                                                                    <li {if $row.status_val!=-1} style="display:none;"{/if}>
                                                                        <span class="btn btn-default approve_registration action_decline_seller" data-id="{$row.$identifier|intval}">
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
                                                                                    <textarea name="reason">{$row.reason|escape:'html':'UTF-8'}</textarea>
                                                                                </div>
                                                                            </div>
                                                                            <input name="active_seller" value="-3" type="hidden" />
                                                                            
                                                                            <input name="seller_id" value="{$row.$identifier|intval}" type="hidden" />
                                                                            <div class="panel_footer form-group">
                                                                                <div class="control-label col-lg-3"></div>
                                                                                <div class="col-lg-9">
                                                                                    <button type="submit" value="1" name="saveStatusSeller" class="btn btn-default saveStatusSeller">
                                                                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                                                    </button>
                                                                                </div>
                                                                            </div>           
                                                                        </div>
                                                                    </li>
                                                                    <li {if $row.status_val==0} style="display:none;"{/if}>
                                                                        <span class="btn btn-default approve_registration action_disable_seller" data-id="{$row.$identifier|intval}">
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
                                                                                    <textarea name="reason">{$row.reason|escape:'html':'UTF-8'}</textarea>
                                                                                </div>
                                                                            </div>
                                                                            <input name="active_seller" value="0" type="hidden" />
                                                                            <input name="seller_id" value="{$row.$identifier|intval}" type="hidden" />
                                                                            <div class="panel_footer form-group">
                                                                                <div class="control-label col-lg-3"></div>
                                                                                <div class="col-lg-9">
                                                                                    <button type="submit" value="1" name="saveStatusSeller" class="btn btn-default saveStatusSeller">
                                                                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                                                    </button>
                                                                                </div>
                                                                            </div>           
                                                                        </div>
                                                                    </li>
                                                                {/if}
                                                                {if $name=='mp_products'}
                                                                    {if $row.id_seller}
                                                                        <li {if $row.active!=-1 && $row.active!=-2} style="display:none;"{/if}>
                                                                            <span class="btn btn-default action_approve_product" data-id="{$row.$identifier|intval}">
                                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Approve' mod='ets_marketplace'}
                                                                            </span>
                                                                        </li>
                                                                        <li {if $row.active!=-1} style="display:none;"{/if}>
                                                                            <span class="btn btn-default approve_registration action_decline_product" data-id="{$row.$identifier|intval}">
                                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1440 893q0-161-87-295l-754 753q137 89 297 89 111 0 211.5-43.5t173.5-116.5 116-174.5 43-212.5zm-999 299l755-754q-135-91-300-91-148 0-273 73t-198 199-73 274q0 162 89 299zm1223-299q0 157-61 300t-163.5 246-245 164-298.5 61-298.5-61-245-164-163.5-246-61-300 61-299.5 163.5-245.5 245-164 298.5-61 298.5 61 245 164 163.5 245.5 61 299.5z"/></svg> {l s='Decline' mod='ets_marketplace'}
                                                                            </span>
                                                                            <div class="approve_registration_form" style="display:none">
                                                                                <div class="ets_mp_close_popup" title="Close">{l s='Close' mod='ets_marketplace'}</div>
                                                                                <div class="form-group">
                                                                                    <label class="control-label col-lg-3">{l s='Status' mod='ets_marketplace'}</label>
                                                                                    <div class="col-lg-9">
                                                                                        <span class="ets_mp_status declined">{l s='Declined' mod='ets_marketplace'}</span>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <label class="control-label col-lg-3">{l s='Reason' mod='ets_marketplace'}</label>
                                                                                    <div class="col-lg-9">
                                                                                        <textarea name="reason"></textarea>
                                                                                    </div>
                                                                                </div>
                                                                                <input name="product_id" value="{$row.$identifier|intval}" type="hidden" />
                                                                                <div class="panel_footer form-group">
                                                                                    <div class="control-label col-lg-3"></div>
                                                                                    <div class="col-lg-9">
                                                                                        <button type="submit" value="1" name="submitDeclineProductSeller" class="btn btn-default">
                                                                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                                                                        </button>
                                                                                    </div>
                                                                                </div>           
                                                                            </div>
                                                                        </li>
                                                                    {/if}
                                                                {/if}
                                                                {foreach from=$actions item='action' key='key'}
                                                                    {if $key!=0}
                                                                        {if $action=='delete' && (!isset($row.view_order_url) || (isset($row.view_order_url) && !$row.view_order_url) )}
                                                                            <li><a class="btn btn-default" onclick="return confirm('{if $name=='mp_front_products' || $name=='mp_products'}{l s='Do you want to delete this product?' mod='ets_marketplace'}{else}{l s='Do you want to delete this item?' mod='ets_marketplace'}{/if}');" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&del=yes{if isset($row.type)}&type={$row.type|escape:'html':'UTF-8'}{/if}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> {l s='Delete' mod='ets_marketplace'}</a></li>
                                                                        {/if}
                                                                        {if $action=='assign' && !$row.id_customer_seller}
                                                                            <li><a data-id_product="{$row.id_product|intval}" class="btn btn-default btn-assign-product" href="#"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1696 384q40 0 68 28t28 68v1216q0 40-28 68t-68 28h-960q-40 0-68-28t-28-68v-288h-544q-40 0-68-28t-28-68v-672q0-40 20-88t48-76l408-408q28-28 76-48t88-20h416q40 0 68 28t28 68v328q68-40 128-40h416zm-544 213l-299 299h299v-299zm-640-384l-299 299h299v-299zm196 647l316-316v-416h-384v416q0 40-28 68t-68 28h-416v640h512v-256q0-40 20-88t48-76zm956 804v-1152h-384v416q0 40-28 68t-68 28h-416v640h896z"/></svg> {l s='Assign product' mod='ets_marketplace'}</a></li>
                                                                        {/if}
                                                                        {if $action=='delete_shop'}
                                                                            <li><a class="btn btn-default" onclick="return confirm('{l s='Do you want to delete this shop?' mod='ets_marketplace'}');" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&del=yes{if isset($row.type)}&type={$row.type|escape:'html':'UTF-8'}{/if}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Delete shop' mod='ets_marketplace'}</a></li>
                                                                        {/if}
                                                                        {if $action=='delete_product'}
                                                                            <li><a class="btn btn-default" onclick="return confirm('{l s='Do you want to delete all products in shop?' mod='ets_marketplace'}');" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&delproducts=yes{if isset($row.type)}&type={$row.type|escape:'html':'UTF-8'}{/if}"><svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M960 1408l336-384h-768l-336 384h768zm1013-1077q15 34 9.5 71.5t-30.5 65.5l-896 1024q-38 44-96 44h-768q-38 0-69.5-20.5t-47.5-54.5q-15-34-9.5-71.5t30.5-65.5l896-1024q38-44 96-44h768q38 0 69.5 20.5t47.5 54.5z"/></svg> {l s='Delete products' mod='ets_marketplace'}</a></li>
                                                                        {/if}
                                                                        {if $action=='delete_commission'}
                                                                            <li><a class="btn btn-default" onclick="return confirm('{l s='Do you want to delete all commissions in shop?' mod='ets_marketplace'}');" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&delcommissions=yes{if isset($row.type)}&type={$row.type|escape:'html':'UTF-8'}{/if}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Delete commissions' mod='ets_marketplace'}</a></li>
                                                                        {/if}
                                                                        {if $action=='delete_all'}
                                                                            <li><a class="btn btn-default" onclick="return confirm('{l s='Do you want to delete this shop and all data?' mod='ets_marketplace'}');" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&delall=yes{if isset($row.type)}&type={$row.type|escape:'html':'UTF-8'}{/if}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> {l s='Delete all' mod='ets_marketplace'}</a></li>
                                                                        {/if}
                                                                        {if $action=='dowloadpdf'}
                                                                            <li>
                                                                                <a href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&dowloadpdf=yes{if isset($row.type)}&type={$row.type|escape:'html':'UTF-8'}{/if}">
                                                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1596 380q28 28 48 76t20 88v1152q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1600q0-40 28-68t68-28h896q40 0 88 20t76 48zm-444-244v376h376q-10-29-22-41l-313-313q-12-12-41-22zm384 1528v-1024h-416q-40 0-68-28t-28-68v-416h-768v1536h1280zm-514-593q33 26 84 56 59-7 117-7 147 0 177 49 16 22 2 52 0 1-1 2l-2 2v1q-6 38-71 38-48 0-115-20t-130-53q-221 24-392 83-153 262-242 262-15 0-28-7l-24-12q-1-1-6-5-10-10-6-36 9-40 56-91.5t132-96.5q14-9 23 6 2 2 2 4 52-85 107-197 68-136 104-262-24-82-30.5-159.5t6.5-127.5q11-40 42-40h22q23 0 35 15 18 21 9 68-2 6-4 8 1 3 1 8v30q-2 123-14 192 55 164 146 238zm-576 411q52-24 137-158-51 40-87.5 84t-49.5 74zm398-920q-15 42-2 132 1-7 7-44 0-3 7-43 1-4 4-8-1-1-1-2-1-2-1-3-1-22-13-36 0 1-1 2v2zm-124 661q135-54 284-81-2-1-13-9.5t-16-13.5q-76-67-127-176-27 86-83 197-30 56-45 83zm646-16q-24-24-140-24 76 28 124 28 14 0 18-1 0-1-2-3z"/></svg> {l s='Download pdf' mod='ets_marketplace'}
                                                                                </a>
                                                                            </li>
                                                                        {/if}
                                                                        {if $action=='view'}
                                                                            {if isset($row.child_view_url) && $row.child_view_url}
                                                                                <li><a class="btn btn-default" href="{$row.child_view_url|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1088 800v64q0 13-9.5 22.5t-22.5 9.5h-224v224q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-224h-224q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h224v-224q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5v224h224q13 0 22.5 9.5t9.5 22.5zm128 32q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 53-37.5 90.5t-90.5 37.5q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg> {l s='View' mod='ets_marketplace'}</a></li>
                                                                            {else}
                                                                                <li><a class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg> {l s='Edit' mod='ets_marketplace'}</a></li>
                                                                            {/if}
                                                                        {/if}
                                                                        {if $action =='edit'}
                                                                            <li><a class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&edit{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg> {l s='Edit' mod='ets_marketplace'}</a></li>
                                                                        {/if}
                                                                        {if $action =='duplicate'}
                                                                            <li><a class="btn btn-default" href="{$currentIndex|escape:'html':'UTF-8'}&duplicate{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1696 384q40 0 68 28t28 68v1216q0 40-28 68t-68 28h-960q-40 0-68-28t-28-68v-288h-544q-40 0-68-28t-28-68v-672q0-40 20-88t48-76l408-408q28-28 76-48t88-20h416q40 0 68 28t28 68v328q68-40 128-40h416zm-544 213l-299 299h299v-299zm-640-384l-299 299h299v-299zm196 647l316-316v-416h-384v416q0 40-28 68t-68 28h-416v640h512v-256q0-40 20-88t48-76zm956 804v-1152h-384v416q0 40-28 68t-68 28h-416v640h896z"/></svg> {l s='Duplicate' mod='ets_marketplace'}</a></li>
                                                                        {/if}
                                                                        {if $action =='approve_review' && isset($row.action_approve) && $row.action_approve}
                                                                            <li><a class="btn btn-default" onclick="return confirm('{l s='Do you want to approve this item?' mod='ets_marketplace'}');" href="{$currentIndex|escape:'html':'UTF-8'}&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}&approve=yes{if isset($row.type)}&type={$row.type|escape:'html':'UTF-8'}{/if}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Approve' mod='ets_marketplace'}</a></li>
                                                                        {/if}
                                                                        {if $action=='action'}
                                                                            <li>
                                                                                <a class="btn btn-default action-edit-inline" href="{$currentIndex|escape:'html':'UTF-8'}&action{$name|escape:'html':'UTF-8'}=1&{$identifier|escape:'html':'UTF-8'}={$row.$identifier|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg> {l s='Action' mod='ets_marketplace'}</a>
                                                                            </li>
                                                                        {/if}
                                                                        {if $action=='vieworder' && $row.view_order_url}
                                                                            <li>
                                                                                <a class="btn btn-default" href="{$row.view_order_url|escape:'html':'UTF-8'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1216 832q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 52-38 90t-90 38q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg> {l s='View order' mod='ets_marketplace'}</a>
                                                                            </li>
                                                                        {/if}
                                                                    {/if}
                                                                {/foreach}
                                                            </ul>
                                                        {/if}
                                                </div>
                                            </div>
                                        </td>
                                    {/if}
                                {/if}
                            </tr>
                        {/foreach}  
                        {/if}  
                        {if !$field_values}
                           <tr class="no-record not_items_found"> <td colspan="100%"><p>{l s='No items found' mod='ets_marketplace'}</p></td></tr> 
                        {/if}                
                    </tbody>
                </table>
                {if isset($has_delete_product) &&  ((isset($is_admin) && $is_admin) || ( (Configuration::get('ETS_MP_ALLOW_SELLER_CREATE_PRODUCT') && (!isset($has_duplicate_product) || $has_duplicate_product)) || (isset($has_edit_product) && $has_edit_product) || $has_delete_product))}
                      <div id="catalog-actions" class="col order-first">
                        <div class="row">
                            <div class="col">
                                <div class="d-inline-block hide" bulkurl="{if isset($is_admin) && $is_admin}{$link->getAdminLink('AdminMarketPlaceProducts')|escape:'html':'UTF-8'}&bulk_action=activate_all{else}{$link->getModuleLink('ets_marketplace','products',['bulk_action'=>'activate_all'])|escape:'html':'UTF-8'}{/if}" redirecturl="{if isset($is_admin) && $is_admin}{$link->getAdminLink('AdminMarketPlaceProducts')|escape:'html':'UTF-8'}{else}{$link->getModuleLink('ets_marketplace','products',['list'=>1])|escape:'html':'UTF-8'}{/if}">
                                    <div class="btn-group dropdown bulk-catalog">
                                        <button id="product_bulk_menu" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="true" disabled="" style="color:black;">
                                            {l s='Bulk actions' mod='ets_marketplace'}&nbsp;
                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 1216q0 26-19 45t-45 19h-896q-26 0-45-19t-19-45 19-45l448-448q19-19 45-19t45 19l448 448q19 19 19 45z"/></svg>
                                        </button>
                                        <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 35px, 0px); top: 0px; left: 0px; will-change: transform;">
                                            {if (isset($is_admin) && $is_admin) || (isset($has_edit_product) && $has_edit_product)}
                                                <a class="dropdown-item" href="#" onclick="ets_mp_bulkProductAction(this, 'activate_all');">
                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 896q0 106-75 181t-181 75-181-75-75-181 75-181 181-75 181 75 75 181zm-256-544q-148 0-273 73t-198 198-73 273 73 273 198 198 273 73 273-73 198-198 73-273-73-273-198-198-273-73zm768 544q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                                    &nbsp;{l s='Activate selection' mod='ets_marketplace'}
                                                </a>
                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item" href="#" onclick="ets_mp_bulkProductAction(this, 'deactivate_all');">
                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M896 352q-148 0-273 73t-198 198-73 273 73 273 198 198 273 73 273-73 198-198 73-273-73-273-198-198-273-73zm768 544q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                                    &nbsp;{l s='Deactivate selection' mod='ets_marketplace'}
                                                </a>
                                            {/if}
                                            {if (isset($is_admin) && $is_admin) || (Configuration::get('ETS_MP_ALLOW_SELLER_CREATE_PRODUCT') && (!isset($has_duplicate_product) || $has_duplicate_product))}
                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item" href="#" onclick="ets_mp_bulkProductAction(this, 'duplicate_all');">
                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1632v-1088q0-13-9.5-22.5t-22.5-9.5h-1088q-13 0-22.5 9.5t-9.5 22.5v1088q0 13 9.5 22.5t22.5 9.5h1088q13 0 22.5-9.5t9.5-22.5zm128-1088v1088q0 66-47 113t-113 47h-1088q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1088q66 0 113 47t47 113zm-384-384v160h-128v-160q0-13-9.5-22.5t-22.5-9.5h-1088q-13 0-22.5 9.5t-9.5 22.5v1088q0 13 9.5 22.5t22.5 9.5h160v128h-160q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1088q66 0 113 47t47 113z"/></svg>
                                                    &nbsp;{l s='Duplicate selection' mod='ets_marketplace'}
                                                </a>
                                            {/if}
                                            {if isset($has_delete_product) && $has_delete_product}
                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item" href="#" onclick="ets_mp_bulkProductAction(this, 'delete_all');">
                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                                                    &nbsp;{l s='Delete selection' mod='ets_marketplace'}
                                                </a>
                                            {/if}
                                            {if $name=='mp_products'}
                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item btn-assign-products" href="#">
                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1696 384q40 0 68 28t28 68v1216q0 40-28 68t-68 28h-960q-40 0-68-28t-28-68v-288h-544q-40 0-68-28t-28-68v-672q0-40 20-88t48-76l408-408q28-28 76-48t88-20h416q40 0 68 28t28 68v328q68-40 128-40h416zm-544 213l-299 299h299v-299zm-640-384l-299 299h299v-299zm196 647l316-316v-416h-384v416q0 40-28 68t-68 28h-416v640h512v-256q0-40 20-88t48-76zm956 804v-1152h-384v416q0 40-28 68t-68 28h-416v640h896z"/></svg>
                                                    &nbsp;{l s='Assign products' mod='ets_marketplace'}
                                                </a>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                {if isset($show_bulk_action) && $show_bulk_action}
                    <div id="catalog-actions" class="col order-first">
                        <div class="row">
                            <div class="col">
                                <div class="d-inline-block hide">
                                    <div class="btn-group dropdown bulk-catalog">
                                        <button id="product_bulk_menu" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="true" style="color:black;">
                                            {l s='Bulk actions' mod='ets_marketplace'}
                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 1216q0 26-19 45t-45 19h-896q-26 0-45-19t-19-45 19-45l448-448q19-19 45-19t45 19l448 448q19 19 19 45z"/></svg>
                                        </button>
                                        <div class="dropdown-menu">
                                            <button class="dropdown-item" name="submitBulkDelete" type="submit" style="border:none;background:none" onclick="return confirm('{l s='Do you want to delete the selected items?' mod='ets_marketplace' js=1}');">
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                                                &nbsp;{l s='Delete' mod='ets_marketplace'}
                                            </button>
                                            {if $name=='mail_queue'}
                                                <button class="dropdown-item" name="submitBulkSend" type="submit" style="border:none;background:none" onclick="return confirm('{l s='Do you want to send selected emails?' mod='ets_marketplace' js=1}');">
                                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1504v-768q-32 36-69 66-268 206-426 338-51 43-83 67t-86.5 48.5-102.5 24.5h-2q-48 0-102.5-24.5t-86.5-48.5-83-67q-158-132-426-338-37-30-69-66v768q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm0-1051v-24.5l-.5-13-3-12.5-5.5-9-9-7.5-14-2.5h-1472q-13 0-22.5 9.5t-9.5 22.5q0 168 147 284 193 152 401 317 6 5 35 29.5t46 37.5 44.5 31.5 50.5 27.5 43 9h2q20 0 43-9t50.5-27.5 44.5-31.5 46-37.5 35-29.5q208-165 401-317 54-43 100.5-115.5t46.5-131.5zm128-37v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg>
                                                    &nbsp;{l s='Send emails' mod='ets_marketplace'}
                                                </button>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                {if $paggination}
                    <div class="ets_mp_paggination" style="margin-top: 10px;">
                        {$paggination nofilter}
                    </div>
                {/if}
            </form>
        </div>
    {/if}
    {if isset($link_back_to_list)}
        <div class="panel-footer">
            <a id="desc-attribute-back" class="btn btn-default btn-primary" href="{$link_back_to_list|escape:'html':'UTF-8'}">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1427 301l-531 531 531 531q19 19 19 45t-19 45l-166 166q-19 19-45 19t-45-19l-742-742q-19-19-19-45t19-45l742-742q19-19 45-19t45 19l166 166q19 19 19 45t-19 45z"/></svg> <span>{l s='Back to list' mod='ets_marketplace'}</span>
        	</a>
        </div>
    {/if}
</div>


