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
    <div class="ets_mp_close_popup" title="{l s='Close' mod='ets_marketplace'}">{l s='Close' mod='ets_marketplace'}</div>
    <div class="panel-heading">
        {l s='List of changed fields' mod='ets_marketplace'} - {l s='product name' mod='ets_marketplace'}: {$product_name|escape:'html':'UTF-8'}
    </div>
    <div class="table-responsive clearfix ets_mp_changeproduct">
        {if $items}
            <form method="post" action="">
                <table class="table">
                    <thead>
                        <tr>
                            <th>{l s='Field name' mod='ets_marketplace'}</th>
                            <th>{l s='Language' mod='ets_marketplace'}</th>
                            <th>{l s='Old value' mod='ets_marketplace'}</th>
                            <th>{l s='New value' mod='ets_marketplace'}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$items item='item'}
                            {if !is_array($item.old_values)}
                                <tr>
                                    <td class="text-center">
                                        {$item.name|escape:'html':'UTF-8'}
                                    </td>
                                    <td>--</td>
                                    <td>
                                        {$item.old_values nofilter}
                                    </td>
                                    <td>
                                        {$item.new_values nofilter}
                                    </td>
                                </tr>
                            {else}
                                {if count($item.old_values)>1}
                                    {foreach from=$item.old_values key='key' item='val'}
                                        <tr>
                                            {if $key==0}
                                                <td rowspan="{count($item.old_values)|intval}" class="text-center">{$item.name|escape:'html':'UTF-8'}</td>
                                            {/if}
                                            <td>{$item['languages'][$key]|escape:'html':'UTF-8'}</td>
                                            <td>{$item['old_values'][$key] nofilter}</td>
                                            <td>{$item['new_values'][$key] nofilter}</td>
                                        </tr>
                                    {/foreach}
                                {else}
                                    <tr>
                                        <td class="text-center">{$item.name|escape:'html':'UTF-8'}</td>
                                        <td>{$item.languages.0|escape:'html':'UTF-8'}</td>
                                        <td>{$item.old_values.0 nofilter}</td>
                                        <td>{$item.new_values.0 nofilter}</td>
                                    </tr>
                                {/if}
                            {/if}
                        {/foreach}
                    </tbody>
                </table>
                <div class="panel-footer">
                    <input type="hidden" value="1" name="etsmpSubmitApproveChanged" />
                    <input name="id_product" value="{$id_product|intval}" type="hidden" />
                    <a class="btn btn-default btn-close-popup" href="{$link->getAdminLink('AdminMarketPlaceProducts')|escape:'html':'UTF-8'}">
                        <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                        {l s='Cancel' mod='ets_marketplace'}
                    </a>
                    <button id="module_form_submit_btn" class="btn btn-default pull-right btn-approve-change" type="button" value="1" name="saveConfig" data-id_product="{$id_product|intval}">
                        <i class="process-icon-check ets_svg_process">
                            <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>
                        </i>
                        {l s='Approve' mod='ets_marketplace'}
                    </button>
                    {if !$declined}
                    <button class="btn btn-default pull-right btn-decline-change-product">
                        <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                        {l s='Decline' mod='ets_marketplace'}
                    </button>
                    {/if}
                </div>
            </form>
            {if !$declined}
                <div class="ets_mp_popup_child ets_mp_decline_product" style="display:none">
                    <div class="mp_pop_table_child ets_table">
                        <div class="ets_table-cell">
                            <form method="post" action="">
                                <div class="ets_mp_close_child" title="{l s='Close' mod='ets_marketplace'}">{l s='Close' mod='ets_marketplace'}</div>
                                <div class="form-wrapper">
                                    <div class="form-group">
                                        <label class="col-lg-3 control-label">{l s='Status' mod='ets_marketplace'}:</label>
                                        <div class="col-lg-3">
                                            <span class="ets_pmn_status decline">{l s='Declined' mod='ets_marketplace'}</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="reason_decline">{l s='Reason' mod='ets_marketplace'}</label>
                                        <div class="col-lg-9">
                                            <textarea class="" name="reason_decline" id="reason_decline"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    <input name="id_product" value="{$id_product|intval}" type="hidden" />
                                    <input name="btnSubmitDeclineChangeProduct" type="hidden" value="1"/>
                                    <button class="btn btn-default btn-close-popup-child">
                                        <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                                        {l s='Cancel' mod='ets_marketplace'}
                                    </button>
                                    <button class="btn btn-default pull-right" type="button" value="1" name="btnSubmitDeclineChangeProduct">
                                        <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg>
                                        {l s='Save' mod='ets_marketplace'}
                                    </button>
                                </div>
                            </form> 
                        </div>
                    </div>
                </div>
            {/if}
        {else}
            <div class="alert alert-warning"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {l s='There is not any new change.' mod='ets_marketplace'}</div>
        {/if}
    </div>
</div>