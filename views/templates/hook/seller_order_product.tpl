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
<div class="ets_mp_extra_product_order" style="display:none;">
    <div class="panel seller_info">
        <div class="panel-header">
            <h3 class="panel-title"><svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1131q0-64-9-117.5t-29.5-103-60.5-78-97-28.5q-6 4-30 18t-37.5 21.5-35.5 17.5-43 14.5-42 4.5-42-4.5-43-14.5-35.5-17.5-37.5-21.5-30-18q-57 0-97 28.5t-60.5 78-29.5 103-9 117.5 37 106.5 91 42.5h512q54 0 91-42.5t37-106.5zm-157-520q0-94-66.5-160.5t-160.5-66.5-160.5 66.5-66.5 160.5 66.5 160.5 160.5 66.5 160.5-66.5 66.5-160.5zm925 509v-64q0-14-9-23t-23-9h-576q-14 0-23 9t-9 23v64q0 14 9 23t23 9h576q14 0 23-9t9-23zm0-260v-56q0-15-10.5-25.5t-25.5-10.5h-568q-15 0-25.5 10.5t-10.5 25.5v56q0 15 10.5 25.5t25.5 10.5h568q15 0 25.5-10.5t10.5-25.5zm0-252v-64q0-14-9-23t-23-9h-576q-14 0-23 9t-9 23v64q0 14 9 23t23 9h576q14 0 23-9t9-23zm256-320v1216q0 66-47 113t-113 47h-352v-96q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v96h-768v-96q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v96h-352q-66 0-113-47t-47-113v-1216q0-66 47-113t113-47h1728q66 0 113 47t47 113z"/></svg>&nbsp;{l s='Seller info' mod='ets_marketplace'}
            </h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-6">
                    <div class="form-horizontal label_bold">
                        <div class="row">
            				<label class="control-label col-lg-4 col-sm-6">{l s='Full name' mod='ets_marketplace'}</label>
            				<div class="col-lg-8 col-sm-6">
            					<p class="form-control-static"> <a href="{$link->getAdminLink('AdminMarketPlaceSellers')|escape:'html':'UTF-8'}&viewseller=1&id_seller={$seller->id|intval}" title="{l s='View seller' mod='ets_marketplace'}" target="_blank">{if $seller->seller_name}{$seller->seller_name|escape:'html':'UTF-8'}{else}{$customer->firstname|escape:'html':'UTF-8'}&nbsp;{$customer->lastname|escape:'html':'UTF-8'}{/if}</a></p>
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
                        <div class="row info_status">
                            <label class="control-label col-lg-4 col-sm-6">{l s='Status' mod='ets_marketplace'}</label>
                            <div class="col-lg-8 col-sm-6">
                                {if $seller->active==-2}
                                    <span class="ets_mp_status expired">{l s='Expired' mod='ets_marketplace'}</span>
                                {elseif $seller->active==-1}
                                    <span class="ets_mp_status pending">{l s='Pending' mod='ets_marketplace'}</span>
                                {elseif $seller->active==0}
                                    <span class="ets_mp_status disabled">{l s='Disabled' mod='ets_marketplace'}</span>
                                {elseif $seller->active==1}
                                    <span class="ets_mp_status approved">{l s='Approved' mod='ets_marketplace'}</span>
                                {/if}
                            </div>
                        </div>
                        {if $seller->payment_verify}
                            <div class="row info_status">
                                <label class="control-label col-lg-4 col-sm-6">{l s='Payment verify' mod='ets_marketplace'}</label>
                                <div class="col-lg-8 col-sm-6">
                                    {if $seller->payment_verify==-1}
                                        <span class="ets_mp_status awaiting_payment">{l s='Awaiting payment' mod='ets_marketplace'}</span>
                                    {/if}
                                    {if $seller->payment_verify==1}
                                        <span class="ets_mp_status confirmed_payment">{l s='Seller confirmed payment' mod='ets_marketplace'}</span>
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
            				<label class="control-label col-lg-6">{l s='Withdrawn' mod='ets_marketplace'}
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
            				<label class="control-label col-lg-6">{l s='Paid for orders' mod='ets_marketplace'}
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
            				<label class="control-label col-lg-6">{l s='Converted to voucher' mod='ets_marketplace'}
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
            				<label class="control-label col-lg-6">{l s='Total used' mod='ets_marketplace'}
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