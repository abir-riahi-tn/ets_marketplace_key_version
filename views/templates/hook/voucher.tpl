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
<div class="panel" style="float:left">
    <div class="ets_mp-voucer-message">
        {if isset($cart_rule) && $cart_rule->id}
            <div class="alert alert-success">
                <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1412 734q0-28-18-46l-91-90q-19-19-45-19t-45 19l-408 407-226-226q-19-19-45-19t-45 19l-91 90q-18 18-18 46 0 27 18 45l362 362q19 19 45 19 27 0 46-19l543-543q18-18 18-45zm252 162q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                {l s='You have successfully converted ' mod='ets_marketplace'} {Ets_marketplace::displayPrice($cart_rule->reduction_amount,$currency_default)|escape:'html':'UTF-8'} {l s=' into voucher code:' mod='ets_marketplace'} {$cart_rule->code|escape:'html':'UTF-8'}<br/>
                <a href="javascript:void(0)" class="btn btn-success ets_mp-apply-voucher b-radius-3 text-uppercase" data-voucher-code="{$cart_rule->id|intval}">{l s='Apply Voucher code to my cart' mod='ets_marketplace'}</a>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
        {/if}
    </div>
    <div class="ets_mp-form ets_mp-voucher-form mb-40">
        {if $total_commission_can_user >0}
            <p>{l s='You have ' mod='ets_marketplace'} <strong>{Ets_marketplace::displayPrice($total_commission_can_user,$currency_default)|escape:'html':'UTF-8'}</strong> {l s=' in your balance. It can be converted into voucher code. Fill in required fields below to convert your commission balance into voucher code. Voucher code can be used to checkout your shopping cart.' mod='ets_marketplace'}</p>
            <form action="" method="post">
                <div class="form-group{if isset($error_amount) && $error_amount} has-error{/if}">
                    <label class="fw-b mb-5" for="ets_mp_VOUCHER_AMOUNT">{l s='Amount to convert:' mod='ets_marketplace'}</label>
                    <div class="input-group mb-5">
                        <input class="form-control" name="ets_mp_VOUCHER_AMOUNT" placeholder="0.00" aria-label="0.00" value="{if isset($ets_mp_VOUCHER_AMOUNT)}{$ets_mp_VOUCHER_AMOUNT|escape:'html':'UTF-8'}{/if}" aria-describedby="ets_mp_VOUCHER_AMOUNT" type="text" />
                        <div class="input-group-append">
                        <span class="input-group-text" id="ets_mp_VOUCHER_AMOUNT">{$currency_default->sign|escape:'html':'UTF-8'}</span>
                        </div>
                    </div>
                    {if isset($error_amount) && $error_amount}
                        <span class="help-block">{$error_amount|escape:'html':'UTF-8'}</span>
                    {/if}
                    <p class="ets_mp-note mb-20">
                        {l s='Note: Voucher availability:' mod='ets_marketplace'} <strong> {l s='30 days' mod='ets_marketplace'}</strong>.{if $MIN_VOUCHER} {l s='Min amount to convert' mod='ets_marketplace'} {$MIN_VOUCHER|escape:'html':'UTF-8'}.{/if}{if $MAX_VOUCHER} {l s='Max amount to convert' mod='ets_marketplace'} {$MAX_VOUCHER|escape:'html':'UTF-8'}.{/if}
                    </p>
                </div>
                <input name="ets_mp-submit-voucher" value="1" type="hidden" />
                <button class="btn btn-info text-uppercase b-radius-3 fs-14" type="submit">{l s='Convert now' mod='ets_marketplace'}</button>
            </form>
        {else}
            <div class="alert alert-warning"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {l s='Voucher is not available. You are required to have positive balance in order to submit your convert request.' mod='ets_marketplace'}</div>
        {/if}
    </div>
    <div class="ets_mp-voucher-history">
        <h4 class="text-uppercase fs-14 mb-15">{l s='Your voucher codes' mod='ets_marketplace'}</h4>
        <div class="table-responsive">
            <form action="" method="post">
                <table class="table ets_mp-table-flat">
                    <thead>
                        <tr>
                            <th>{l s='Code' mod='ets_marketplace'}</th>
                            <th>{l s='Description' mod='ets_marketplace'}</th>
                            <th class="text-center">{l s='Quantity' mod='ets_marketplace'}</th>
                            <th>{l s='Value' mod='ets_marketplace'}</th>
                            <th class="text-center">{l s='Minimum' mod='ets_marketplace'}</th>
                            <th class="text-center">{l s='Cumulative' mod='ets_marketplace'}</th>
                            <th class="text-center">{l s='Expiration date' mod='ets_marketplace'}</th>
                            <th class="text-center">{l s='Status' mod='ets_marketplace'}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {if $cart_rules}
                            {foreach from=$cart_rules item='cart_rule'}
                                <tr>
                                    <td>{$cart_rule.code|escape:'html':'UTF-8'}</td>
                                    <td>{$cart_rule.name|escape:'html':'UTF-8'}</td>
                                    <td class="text-center">{$cart_rule.quantity|intval}</td>
                                    <td>{Ets_marketplace::displayPrice($cart_rule.reduction_amount,$currency_default)|escape:'html':'UTF-8'}</td>
                                    <td class="text-center">{$cart_rule.voucher_minimal|escape:'html':'UTF-8'}</td>
                                    <td class="text-center">{if $cart_rule.cart_rule_restriction}{l s='No' mod='ets_marketplace'}{else}{l s='Yes' mod='ets_marketplace'}{/if}</td>
                                    <td class="text-center">{$cart_rule.voucher_date|escape:'html':'UTF-8'}</td>
                                    <td class="text-center">
                                        {if $cart_rule.status == 1}
                                            <svg width="14" height="14" style="fill: firebrick!important;" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 768h512v-192q0-106-75-181t-181-75-181 75-75 181v192zm832 96v576q0 40-28 68t-68 28h-960q-40 0-68-28t-28-68v-576q0-40 28-68t68-28h32v-192q0-184 132-316t316-132 316 132 132 316v192h32q40 0 68 28t28 68z"/></svg> {l s='Used' mod='ets_marketplace'}
                                        {elseif $cart_rule.status == -1}
                                            <i class="check text-danger">
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>
                                            </i> {l s='Expired' mod='ets_marketplace'}
                                        {else}
                                            <i class="check text-success">
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>
                                            </i> {l s='Available' mod='ets_marketplace'}
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        {else}
                            <tr><td class="text-center" colspan="8">{l s='No data' mod='ets_marketplace'}</td></tr>
                        {/if}
                    </tbody>
                </table>
                <div class="ets_mp_paggination" style="margin-top: 10px;">
                    {$paggination nofilter}
                </div>
            </form>
        </div>
    </div>
</div>