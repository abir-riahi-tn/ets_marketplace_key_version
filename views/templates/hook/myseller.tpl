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
{if !$seller && $registration && !$registration->active}
    <div class="ets_mp_content_left">
        <div class="panel">
            <div class="alert alert-info">
                <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                {l s='Your application is waiting for approval' mod='ets_marketplace'}
            </div>
        </div>
    </div>
{else}
    
    {if $seller}
        {if !$seller->active || $seller->active==-3}
            <div class="ets_mp_content_left">
                <div class="panel">
                    <div class="alert alert-error" style="margin-bottom:0;">
                        <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {if !$seller->active}
                            {$ETS_MP_MESSAGE_SELLER_IS_DISABLED nofilter} 
                        {else}
                            {$ETS_MP_MESSAGE_SHOP_DECLINED nofilter}
                        {/if}
                    </div>
                </div>
            </div>
        {else}
            {if $seller->active==-1 || $seller->active==-2}
                <div class="ets_mp_content_left">
                    <div class="panel">
                        <div class="alert alert-info">
                            <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                            {if $seller->active==-1}
                                {if $seller->getFeeType()!='no_fee'}
                                    {if $seller_billing &&  $seller_billing->seller_confirm !=1}
                                        {$ETS_MP_MESSAGE_CREATED_SHOP_FEE_REQUIRED nofilter}
                                    {else}
                                        {$ETS_MP_MESSAGE_CONFIRMED_PAYMENT nofilter}
                                    {/if}
                                {else}
                                    {$ETS_MP_MESSAGE_CREATED_SHOP_NO_FEE nofilter}
                                {/if}
                            {/if}
                            {if $seller->active==-2}
                                {if $seller_billing &&  $seller_billing->seller_confirm ==1}
                                    {$ETS_MP_MESSAGE_CONFIRMED_PAYMENT nofilter}
                                {else}
                                    {$ETS_MP_MESSAGE_SELLER_IS_EXPIRED nofilter}
                                {/if}
                            {/if}
                        </div>
                        {if $seller->active==-1 && $seller->getFeeType()!='no_fee' && $ETS_MP_SELLER_FEE_EXPLANATION}
                            {if $ETS_MP_SELLER_FEE_EXPLANATION && $seller_billing->active==0 && $seller_billing->seller_confirm==0}
                                <div class="fee_explanation">
                                    <b>{l s='Fee explanation' mod='ets_marketplace'}:</b> {$ETS_MP_SELLER_FEE_EXPLANATION nofilter}
                                </div>
                            {/if}
                        {/if}
                        {if $seller_billing &&  $seller_billing->active==0 && $seller_billing->seller_confirm==0 && !$isManager}
                            <button type="button" class="btn btn-primary i_have_just_sent_the_fee">{l s='I have just sent the fee' mod='ets_marketplace'}</button>
                        {/if}
                    </div>
                </div>
            {else}
                
                <section id="main" class="page-my-account myseller">
                    <header class="page-header">
                        <h1> {l s='Your seller account' mod='ets_marketplace'} </h1>
                    </header>
                    {if $going_to_be_expired}
                        <div class="alert alert-info">
                            <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                            {if $seller_billing &&  $seller_billing->seller_confirm ==1}
                                {$ETS_MP_MESSAGE_CONFIRMED_PAYMENT nofilter}
                            {else}
                                {$ETS_MP_MESSAGE_SELLER_GOING_TOBE_EXPIRED nofilter}
                            {/if}
                            {if $seller_billing &&  $seller_billing->active==0 && $seller_billing->seller_confirm==0 && !$isManager}
                                <br/>
                                <button type="button" class="btn btn-primary i_have_just_sent_the_fee">{l s='I have just sent the fee' mod='ets_marketplace'}</button>
                            {/if}
                        </div>
                    {/if}
                    <section id="content" class="page-content">
                        <div class="row myseller-list">
                            <div class="links">
                                {foreach from=$seller_pages item='page'}
                                	<a id="ets_mp_{$page.page|escape:'html':'UTF-8'}-link" href="{if isset($page.link)}{$page.link|escape:'html':'UTF-8'}{else} {$link->getModuleLink('ets_marketplace',$page.page)|escape:'html':'UTF-8'}{/if}" class="seller_link col-lg-4 col-md-6 col-sm-6 col-xs-12" {if isset($page.new_tab) && $page.new_tab} target="_blank"{/if}>
                                        <span class="link-item">
                                            <i class="mp-seller-{$page.page|escape:'html':'UTF-8'}icons"></i>
                                            {$page.name|escape:'html':'UTF-8'}
                                        </span>
                                	</a>
                                 {/foreach}
                            </div>
                        </div>
                    </section>
                </section>
            {/if}
        {/if}
    {else}
        <div class="ets_mp_content_left">
        <div class="panel">
        {if $registration && $registration->active}
            {$ETS_MP_MESSAGE_APPLICATION_ACCEPTED nofilter}
        {else}
            <div class="alert alert-info">
                <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg> {$ETS_MP_MESSAGE_INVITE nofilter}
            </div>
        {/if}
        <br />
        <a class="btn btn-primary" style="margin-top: 15px" href="{$link->getModuleLink('ets_marketplace','create')|escape:'html':'UTF-8'}">
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-256v-256q0-26-19-45t-45-19h-128q-26 0-45 19t-19 45v256h-256q-26 0-45 19t-19 45v128q0 26 19 45t45 19h256v256q0 26 19 45t45 19h128q26 0 45-19t19-45v-256h256q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg> {l s='Create shop' mod='ets_marketplace'}</a>
        </div>
        </div>
    {/if}
{/if}