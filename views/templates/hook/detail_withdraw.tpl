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
<div class="row">
    <div class="col-lg-12">
        <div class="panel">
            <div class="panel-body pb-0">
                <div class="info-box">
                    <h3>{l s='Withdrawals' mod='ets_marketplace'} #{$withdraw_detail.id_ets_mp_withdrawal|intval}</h3>
                    <div class="row">
                        <div class="col-lg-7">
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-5 pl-15 pr-15">
                                    <div class="ets_mp-title-section">
                                        <h3 class="h-title">{l s='Commission status' mod='ets_marketplace'}</h3>
                                    </div>
                                    <div class="form-horizontal">
                                        <div class="row">
                    						<label class="control-label col-lg-6 col-sm-6"><em>{l s='Shop name' mod='ets_marketplace'}</em></label>
                    						<div class="col-lg-6 col-sm-6">
                    							<p class="form-control-static">{if $seller->id} <a href="{$seller->getLink()|escape:'html':'UTF-8'}" title="{l s='View shop' mod='ets_marketplace'}" target="_blank">{$seller->shop_name|escape:'html':'UTF-8'}</a>
													{else}
														<span class="deleted_shop row_deleted">{l s='Shop deleted' mod='ets_marketplace'}</span>
													{/if}
												</p>
                    						</div>
                    					</div>
                                        <div class="row">
                                            <label class="control-label col-sm-6 col-lg-6">
                                                <em>{l s='Total commission balance' mod='ets_marketplace'}</em>
												<i class="ets_tooltip_question">
													<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
												    <span class="ets_tooltip" data-tooltip="top">{l s='The remaining amount of commission after converting into voucher, withdrawing, paying for orders or being deducted by marketplace admin' mod='ets_marketplace'}</span>
												</i>
                                            </label>
                                            <div class="col-sm-6 col-lg-6">
                                                <p class="form-control-static" id="total_commission">{displayPrice price = $seller->getTotalCommission(1)-$seller->getToTalUseCommission(1)}</p>
                                            </div> 
                                        </div>
                                        <div class="row">
                                            <label class="control-label col-sm-6 col-lg-6">
                                                <em>{l s='Total commission' mod='ets_marketplace'}</em>
												<i class="ets_tooltip_question">
													<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
														<span class="ets_tooltip" data-tooltip="top">{l s='Total commission money this seller has earned' mod='ets_marketplace'}</span>
												</i>
                                            </label>
                                            <div class="col-sm-6 col-lg-6">
                                                <p class="form-control-static" id="total_commission">{displayPrice price=$seller->getTotalCommission(1)}</p>
                                            </div> 
                                        </div>
                                        <div class="row">
            								<label class="control-label col-sm-6 col-lg-6"><em>{l s='Withdrawn' mod='ets_marketplace'}</em>
												<i class="ets_tooltip_question">
													<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
														<span class="ets_tooltip" data-tooltip="top">{l s='Total amount of commission money this seller has withdrawn' mod='ets_marketplace'}</span>
												</i>
            								</label>
            								<div class="col-sm-6 col-lg-6">
            									<p class="form-control-static" id="total_withdrawn">{displayPrice price=$seller->getToTalUseCommission(1,false,false,true)}</p>
            								</div>
            							</div>
                                        <div class="row">
            								<label class="control-label col-sm-6 col-lg-6"><em>{l s='Paid for orders' mod='ets_marketplace'}</em>
												<i class="ets_tooltip_question">
													<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
														<span class="ets_tooltip" data-tooltip="top">{l s='Total amount of commission money this seller has used to pay for orders' mod='ets_marketplace'}</span>
												</i>
            								</label>
            								<div class="col-sm-6 col-lg-6">
            									<p class="form-control-static" id="total_paid_for_orders">{displayPrice price=$seller->getToTalUseCommission(1,true)}</p>
            								</div>
            							</div>
                                        <div class="row">
            								<label class="control-label col-sm-6 col-lg-6"><em>{l s='Converted to voucher' mod='ets_marketplace'}</em>
												<i class="ets_tooltip_question">
													<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
														<span class="ets_tooltip" data-tooltip="top">{l s='Total amount of commission money this seller has used to convert into vouchers' mod='ets_marketplace'}</span>
												</i>

            								</label>
            								<div class="col-sm-6 col-lg-6">
            									<p class="form-control-static" id="total_convert_to_voucher">{displayPrice price=$seller->getToTalUseCommission(1,false,true)}</p>
            								</div>
            							</div>
                                        <div class="row">
            								<label class="control-label col-sm-6 col-lg-6"><em>{l s='Total used' mod='ets_marketplace'}</em>
            									<i class="ets_tooltip_question">
													<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
														<span class="ets_tooltip" data-tooltip="top">{l s='Total amount of commission money this seller has withdrawn, paid for orders, converted into vouchers and commission money deducted by marketplace admin' mod='ets_marketplace'}</span>
												</i>
            								</label>
            								<div class="col-sm-6 col-lg-6">
            									<p class="form-control-static" id="total_commission_used">{displayPrice price=$seller->getToTalUseCommission(1)}</p>
            								</div>
            							</div>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-6 col-lg-7 pl-15 pr-15">
                                    <div class="ets_mp-title-section">
                                        <h3 class="h-title">{l s='Withdrawal info' mod='ets_marketplace'}</h3>
                                    </div>
                                    <div class="form-horizontal">
                                        <div class="row">
 											<label class="control-label col-lg-6 col-sm-6"><em>{l s='Withdrawal amount' mod='ets_marketplace'}</em> :</label>
											<div class="col-lg-6 col-sm-6">
												<p class="form-control-static">{displayPrice price=$withdraw_detail.amount} <em>({l s='Withdrawal fee included' mod='ets_marketplace'})</em> </p>
											</div>
  										</div>
                                        {if $withdraw_detail.status==0}
                                            <div class="row">
     											<label class="control-label col-lg-6 col-sm-6">&nbsp;</label>
    											<div class="col-lg-6 col-sm-6 withdraw_info">
                                                    {assign var ='total_commission_balance' value = $seller->getTotalCommission(1)-$seller->getToTalUseCommission(1)+$withdraw_detail.amount}
    												{if $withdraw_detail.amount > $total_commission_balance}
                                                        <span class="ets_mp_status invalid">{l s='Invalid withdrawal (insufficient balance)' mod='ets_marketplace'}</span>
                                                    {else}
                                                        <span class="ets_mp_status valid">{l s='Valid withdrawal' mod='ets_marketplace'}</span>
                                                    {/if}
    											</div>
      										</div>
                                        {/if}
                                        <div class="row">
											<label class="control-label col-lg-6 col-sm-6"><em>{l s='Amount to pay' mod='ets_marketplace'}</em>
												:
											</label>
											<div class="col-lg-6 col-sm-6">
												<p class="form-control-static">{displayPrice price=$withdraw_detail.pay_amount}</p>
											</div>
										</div>
                                        <div class="row">
											<label class="control-label col-lg-6 col-sm-6"><em>{l s='Payment method' mod='ets_marketplace'}</em>
												:
											</label>
											<div class="col-lg-6 col-sm-6">
												<p class="form-control-static">{$withdraw_detail.payment_name|escape:'html':'UTF-8'}</p>
											</div>
										</div>
                                        <div class="row">
											<label class="control-label col-lg-6 col-sm-6"><em>{l s='Fee type' mod='ets_marketplace'}</em>
												:
											</label>
											<div class="col-lg-6 col-sm-6">
                                                <p class="form-control-static">
    												{if $withdraw_detail.fee_type=='NO_FEE'}
                                                        {l s='Free' mod='ets_marketplace'}
                                                    {elseif $withdraw_detail.fee_type=='FIXED'}
                                                        {l s='Fixed' mod='ets_marketplace'}
                                                    {else}
                                                        {l s='Percent' mod='ets_marketplace'}
                                                    {/if}
                                                </p>
											</div>
										</div> 
                                        {if $withdraw_detail.fee!=0}
                                            <div class="row">
    											<label class="control-label col-lg-6 col-sm-6"><em>{l s='Fee value' mod='ets_marketplace'}</em>
    												:
    											</label>
    											<div class="col-lg-6 col-sm-6">
    												<p class="form-control-static">{displayPrice price=$withdraw_detail.fee|escape:'html':'UTF-8'}</p>
    											</div>
    										</div>
                                        {/if}
                                        {if $withdraw_fields}
                                            {foreach from = $withdraw_fields item='withdraw_field'}
                                                <div class="row">
        											<label class="control-label col-lg-6 col-sm-6 col-xs-6"><em>{if $withdraw_field.id_ets_mp_payment_method_field}{$withdraw_field.title|escape:'html':'UTF-8'}{else}{l s='Invoice' mod='ets_marketplace'}{/if}</em>
        												:
        											</label>
        											<div class="col-lg-6 col-sm-6 col-xs-6">
        												<p class="form-control-static">{if $withdraw_field.id_ets_mp_payment_method_field}{$withdraw_field.value|escape:'html':'UTF-8'}{else}<a href="{$link->getAdminLink('AdminMarketPlaceWithdrawals') nofilter}&downloadField=1&id_ets_mp_withdrawal_field={$withdraw_field.id_ets_mp_withdrawal_field|intval}" target="_blank">{$withdraw_field.value|escape:'html':'UTF-8'}</a>{/if}</p>
        											</div>
        										</div>
                                            {/foreach}
                                        {/if}
                                        <div class="row">
											<label class="control-label col-lg-6 col-sm-6"><em>{l s='Date of withdrawal' mod='ets_marketplace'}</em>
												:
											</label>
											<div class="col-lg-6 col-sm-6">
												<p class="form-control-static">{dateFormat date=$withdraw_detail.date_add full=1}</p>
											</div>
										</div>
                                        <div class="row">
											<label class="control-label col-lg-6 col-sm-6"><em>{l s='Status' mod='ets_marketplace'}</em>
												:
											</label>
											<div class="col-lg-6 col-sm-6">
												<p class="form-control-static">
                                                    {if $withdraw_detail.status==0}
                                                        <label class="label label-warning ets_mp_status pending" style="margin-top: 0;">{l s='Pending' mod='ets_marketplace'}</label>
                                                    {/if}
                                                    {if $withdraw_detail.status==1}
                                                        <label class="label label-success ets_mp_status approved" style="margin-top: 0;">{l s='Approved' mod='ets_marketplace'}</label>
                                                    {/if}
                                                    {if $withdraw_detail.status==-1}
                                                        <label class="label label-default ets_mp_status declined" style="margin-top: 0;">{l s='Declined' mod='ets_marketplace'}</label>
                                                    {/if}
                                                </p>
											</div>
										</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5 pl-15 pr-15">
                            <div class="form-group withdraw_header">
                                {if $withdraw_detail.status==0}
                                    <form action="" method="POST" accept-charset="utf-8">
                                        <button onclick="return confirm('{l s='Do you want to approve withdraw?' mod='ets_marketplace'}');" class="btn btn-default js-confirm-approve-withdraw mb-5" type="submit" name="approveets_withdraw">
											<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>
                                            {l s='Approve' mod='ets_marketplace'}
                                        </button>
                                        <button onclick="return confirm('{l s='Do you want to decline with return commission this withdrawal?' mod='ets_marketplace'}');" class="btn btn-default js-confirm-approve-withdraw mb-5" type="submit" name="returnets_withdraw">
											<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 896q0 156-61 298t-164 245-245 164-298 61q-172 0-327-72.5t-264-204.5q-7-10-6.5-22.5t8.5-20.5l137-138q10-9 25-9 16 2 23 12 73 95 179 147t225 52q104 0 198.5-40.5t163.5-109.5 109.5-163.5 40.5-198.5-40.5-198.5-109.5-163.5-163.5-109.5-198.5-40.5q-98 0-188 35.5t-160 101.5l137 138q31 30 14 69-17 40-59 40h-448q-26 0-45-19t-19-45v-448q0-42 40-59 39-17 69 14l130 129q107-101 244.5-156.5t284.5-55.5q156 0 298 61t245 164 164 245 61 298z"/></svg>
                                            {l s='Decline - Return commission' mod='ets_marketplace'}
                                        </button>
                                        <button class="btn btn-default js-confirm-approve-withdraw mb-5" type="submit" name="deductets_withdraw">
											<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                                            {l s='Decline - Deduct commission' mod='ets_marketplace'}
                                        </button>
										<a class="btn btn-default" onclick="return confirm('{l s='Do you want to delete this item?' mod='ets_marketplace'}');" href="{$link->getAdminLink('AdminMarketPlaceWithdrawals')|escape:'html':'UTF-8'}&id_ets_mp_withdrawal={$withdraw_detail.id_ets_mp_withdrawal|intval}&del=yes"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> {l s='Delete' mod='ets_marketplace'}</a>

									</form>
								{else}
									<div class="row">
										<a class="btn btn-default" onclick="return confirm('{l s='Do you want to delete this item?' mod='ets_marketplace'}');" href="{$link->getAdminLink('AdminMarketPlaceWithdrawals')|escape:'html':'UTF-8'}&id_ets_mp_withdrawal={$withdraw_detail.id_ets_mp_withdrawal|intval}&del=yes"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> {l s='Delete' mod='ets_marketplace'}</a>
									</div>
                                {/if}
                            </div>
                            <div class="divider-horizontal"></div>
                            <div class="form-group">
                                <form action="" method="POST" accept-charset="utf-8">
									<div class="form-group">
										<label><strong>{l s='Description' mod='ets_marketplace'}</strong>
										</label>
										<textarea name="note" rows="3">{$withdraw_detail.note nofilter}</textarea>
									</div>
									<input name="id_ets_mp_commission_usage" value="{$withdraw_detail.id_ets_mp_commission_usage|intval}" type="hidden" />
									<div class="form-group">
										<button type="submit" name="submitSaveNoteWithdrawal" class="btn btn-default"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}</button>
									</div>
								</form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="divider-horizontal"></div>
                <div class="row">
                    <div class="col-lg-12">
							<a href="{$link->getAdminLink('AdminMarketPlaceWithdrawals')|escape:'html':'UTF-8'}" title="" class="btn btn-default"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Back' mod='ets_marketplace'}</a>
				    </div>
                </div>
            </div>
        </div>
    </div>
</div>