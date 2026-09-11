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
<div class="table-responsive">
	<table class="table" id="documents_table">
		<thead>
			<tr>
				<th>
					<span class="title_box ">{l s='Date' mod='ets_marketplace'}</span>
				</th>
				<th>
					<span class="title_box ">{l s='Document' mod='ets_marketplace'}</span>
				</th>
				<th>
					<span class="title_box ">{l s='Number' mod='ets_marketplace'}</span>
				</th>
				<th>
					<span class="title_box ">{l s='Amount' mod='ets_marketplace'}</span>
				</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{foreach from=$order->getDocuments() item=document}

				{if get_class($document) eq 'OrderInvoice'}
					{if isset($document->is_delivery)}
					<tr id="delivery_{$document->id|escape:'html':'UTF-8'}">
					{else}
					<tr id="invoice_{$document->id|escape:'html':'UTF-8'}">
					{/if}
				{elseif get_class($document) eq 'OrderSlip'}
					<tr id="orderslip_{$document->id|escape:'html':'UTF-8'}">
				{/if}

						<td>{dateFormat date=$document->date_add}</td>
						<td>
							{if get_class($document) eq 'OrderInvoice'}
								{if isset($document->is_delivery)}
									{l s='Delivery slip' mod='ets_marketplace'}
								{else}
									{l s='Invoice' mod='ets_marketplace'}
								{/if}
							{elseif get_class($document) eq 'OrderSlip'}
								{l s='Credit slip' mod='ets_marketplace'}
							{/if}
						</td>
						<td>
							{if get_class($document) eq 'OrderInvoice'}
								{if isset($document->is_delivery)}
									<a class="_blank" title="{l s='See the document' mod='ets_marketplace'}" href="{$link->getModuleLink('ets_marketplace','pdf',['submitAction' => 'generateDeliverySlipPDF', 'id_order_invoice' => $document->id])|escape:'html':'UTF-8'}">
								{else}
									<a class="_blank" title="{l s='See the document' mod='ets_marketplace'}" href="{$link->getModuleLink('ets_marketplace','pdf',['submitAction' => 'generateInvoicePDF', 'id_order_invoice' => $document->id])|escape:'html':'UTF-8'}">
							   {/if}
							{elseif get_class($document) eq 'OrderSlip'}
								<a class="_blank" title="{l s='See the document' mod='ets_marketplace'}" href="{$link->getModuleLink('ets_marketplace','pdf',['submitAction' => 'generateOrderSlipPDF', 'id_order_slip' => $document->id])|escape:'html':'UTF-8'}">
							{/if}
							{if get_class($document) eq 'OrderInvoice'}
								{if isset($document->is_delivery)}
									{Configuration::get('PS_DELIVERY_PREFIX', $current_id_lang, null, $order->id_shop)|escape:'html':'UTF-8'}{'%06d'|sprintf:$document->delivery_number|escape:'html':'UTF-8'}
								{else}
									{$document->getInvoiceNumberFormatted($current_id_lang, $order->id_shop)|escape:'html':'UTF-8'}
								{/if}
							{elseif get_class($document) eq 'OrderSlip'}
								{Configuration::get('PS_CREDIT_SLIP_PREFIX', $current_id_lang)|escape:'html':'UTF-8'}{'%06d'|sprintf:$document->id|escape:'html':'UTF-8'}
							{/if}
							</a>
						</td>
						<td>
						{if get_class($document) eq 'OrderInvoice'}
							{if isset($document->is_delivery)}
								--
							{else}
								{displayPrice price=$document->total_paid_tax_incl currency=$mp_currency->id}&nbsp;
								{if $document->getTotalPaid()}
									<span>
									{if $document->getRestPaid() > 0}
										({displayPrice price=$document->getRestPaid() currency=$mp_currency->id} {l s='not paid' mod='ets_marketplace'})
									{elseif $document->getRestPaid() < 0}
										({displayPrice price=-$document->getRestPaid() currency=$mp_currency->id} {l s='overpaid' mod='ets_marketplace'})
									{/if}
									</span>
								{/if}
							{/if}
						{elseif get_class($document) eq 'OrderSlip'}
							{displayPrice price=$document->total_products_tax_incl+$document->total_shipping_tax_incl currency=$mp_currency->id}
						{/if}
						</td>
						<td class="text-right document_action">
						</td>
					</tr>
			{foreachelse}
				<tr>
					<td colspan="5" class="list-empty">
						<div class="list-empty-msg">
							<p><svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg>
							{l s='There is no available document' mod='ets_marketplace'}</p>
						</div>
					</td>
				</tr>
			{/foreach}
		</tbody>
	</table>
</div>
