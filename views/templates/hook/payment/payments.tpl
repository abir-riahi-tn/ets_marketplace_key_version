
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

<div class="payment-setting eam-ox-auto">
	<div class="eam-minwidth-900">
        <h3>{l s='Withdrawal methods' mod='ets_marketplace'}</h3>
		<div class="panel-action">
			<a href="{$link_pm nofilter}&create_pm=1" class="btn btn-default"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1600 736v192q0 40-28 68t-68 28h-416v416q0 40-28 68t-68 28h-192q-40 0-68-28t-28-68v-416h-416q-40 0-68-28t-28-68v-192q0-40 28-68t68-28h416v-416q0-40 28-68t68-28h192q40 0 68 28t28 68v416h416q40 0 68 28t28 68z"/></svg> {l s='Add new method' mod='ets_marketplace'}</a>
		</div>
		<table class="table table-bordered eam-datatables">
			<thead>
				<tr>
					<th>{l s='ID' mod='ets_marketplace'}</th>
					<th class="text-center">{l s='Method name' mod='ets_marketplace'}</th>
					<th class="text-center">{l s='Fee type' mod='ets_marketplace'}</th>
					<th class="text-center">{l s='Fee amount' mod='ets_marketplace'}</th>
					<th class="text-center">{l s='Status' mod='ets_marketplace'}</th>
					<th class="text-center">{l s='Sort order' mod='ets_marketplace'}</th>
					<th class="text-right" style="width: 150px;">{l s='Action' mod='ets_marketplace'}</th>
				</tr>
			</thead>
			<tbody class="list-pm" id="list-payment-methods">
				{if $payment_methods}
					{foreach $payment_methods as $p}
					<tr id="paymentmethod_{$p.id_ets_mp_payment_method|escape:'html':'UTF-8'}" data-id="{$p.id_ets_mp_payment_method|escape:'html':'UTF-8'}">
						<td class="text-left">{$p.id_ets_mp_payment_method|escape:'html':'UTF-8'}</td>
						<td class="text-center">{$p.title|escape:'html':'UTF-8'}</td>
						<td class="text-center">
							{if $p.fee_type == 'PERCENT'}
								{l s='Percentage' mod='ets_marketplace'}
							{elseif $p.fee_type == 'FIXED'}
								{l s='Fixed' mod='ets_marketplace'}
							{else}
								{l s='No fee' mod='ets_marketplace'}
							{/if}
						</td>
						<td class="text-center">
							{if $p.fee_type == 'PERCENT'}
								{$p.fee_percent|escape:'html':'UTF-8'} %
							{elseif $p.fee_type == 'FIXED'}
								{$p.fee_fixed|escape:'html':'UTF-8'}
							{/if}
						</td>
						<td class="text-center">
							{if $p.enable == 1}
								<span class="label label-success">{l s='Enabled' mod='ets_marketplace'}</span>
							{else}
								<span class="label label-default">{l s='Disabled' mod='ets_marketplace'}</span>
							{/if}
						</td>
						<td class="eam-active-sortable text-center"><div class="box-drag"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1792 896q0 26-19 45l-256 256q-19 19-45 19t-45-19-19-45v-128h-384v384h128q26 0 45 19t19 45-19 45l-256 256q-19 19-45 19t-45-19l-256-256q-19-19-19-45t19-45 45-19h128v-384h-384v128q0 26-19 45t-45 19-45-19l-256-256q-19-19-19-45t19-45l256-256q19-19 45-19t45 19 19 45v128h384v-384h-128q-26 0-45-19t-19-45 19-45l256-256q19-19 45-19t45 19l256 256q19 19 19 45t-19 45-45 19h-128v384h384v-128q0-26 19-45t45-19 45 19l256 256q19 19 19 45z"/></svg><span class="sort-order">{$p.sort|escape:'html':'UTF-8'}</span></div></td>
						<td class="text-right">
							<!-- Split button -->
							<div class="btn-group">
							  <a href="{$link_pm nofilter}&payment_method={$p.id_ets_mp_payment_method|escape:'html':'UTF-8'}&edit_pm=1" class="btn btn-default" style="text-transform: inherit;">
								  <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg> {l s='Edit' mod='ets_marketplace'}
								</a>
							  <button type="button" class="btn btn-default dropdown-toggle dropdown-has-form" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							    <span class="caret"></span>
							    <span class="sr-only">Toggle Dropdown</span>
							  </button>
							  <ul class="dropdown-menu">
							    <li>
							    	<a href="javascript:void(0)">
							    		<form style="display: inline-block;" action="{$link_pm|escape:'html':'UTF-8'}&payment_method={$p.id_ets_mp_payment_method|escape:'html':'UTF-8'}&delete_pm=1" method="POST" onsubmit="return ets_mpConfirmDelete()">
											<button type="submit" name="delete_payment_method" class="btn btn-link btn-link-dropdown"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> {l s='Delete' mod='ets_marketplace'}</button>
										</form>
							    	</a>
							    </li>
							  </ul>
							</div>
						</td>
					</tr>
					{/foreach}
				{else}
				<tr>
	                <td colspan="100%" style="text-align: center;">
	                    {l s='No data' mod='ets_marketplace'}
	                </td>
	            </tr>
				{/if}
			</tbody>
		</table>
	</div>
</div>
<script type="text/javascript">
    var confirm_delete_method_text='{l s='Do you want to delete this item?' mod='ets_marketplace' js=1}';
    {literal}
        function ets_mpConfirmDelete(){
            if(confirm(confirm_delete_method_text)){
                return true;
            }
            return false;
        }
    {/literal}
</script>