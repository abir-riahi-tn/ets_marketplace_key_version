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
{assign var="currencySymbolBeforeAmount" value= false}
{if isset($product.customizedDatas) && $product.customizedDatas}
{* Assign product price *}
{if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
	{assign var=product_price value=($product['unit_price_tax_excl'] + $product['ecotax'])}
{else}
	{assign var=product_price value=$product['unit_price_tax_incl']}
{/if}
	<tr class="customized customized-{$product['id_order_detail']|intval} product-line-row">
		<td>
			<input type="hidden" class="edit_product_id_order_detail" value="{$product['id_order_detail']|intval}" />
			{if isset($product['image']) && $product['image']->id|intval}{$product['image_tag'] nofilter}{else}--{/if}
		</td>
		<td>
			<a href="{$link->getAdminLink('AdminProducts', true, ['id_product' => $product['product_id']|intval, 'updateproduct' => '1'])|escape:'html':'UTF-8'}">
			<span class="productName">{$product['product_name']|escape:'html':'UTF-8'} - {l s='Customized' mod='ets_marketplace'}</span><br />
			{if ($product['product_reference'])}{l s='Reference number:' mod='ets_marketplace'} {$product['product_reference']|escape:'html':'UTF-8'}<br />{/if}
			{if ($product['product_supplier_reference'])}{l s='Supplier reference:' mod='ets_marketplace'} {$product['product_supplier_reference']|escape:'html':'UTF-8'}{/if}
			</a>
		</td>
		<td >
			<span class="product_price_show">{Ets_marketplace::displayPrice($product_price,$currency)|escape:'html':'UTF-8'}</span>
			{if $can_edit}
			<div class="product_price_edit" style="display:none;">
				<input type="hidden" name="product_id_order_detail" class="edit_product_id_order_detail" value="{$product['id_order_detail']|intval}" />
				<div class="form-group">
					<div class="fixed-width-xl">
						<div class="input-group">
							{if $currencySymbolBeforeAmount}<div class="input-group-addon">{$mp_currency->sign|escape:'html':'UTF-8'} {l s='tax excl.' mod='ets_marketplace'}</div>{/if}
							<input type="text" name="product_price_tax_excl" class="edit_product_price_tax_excl edit_product_price" value="{Tools::ps_round($product['unit_price_tax_excl'], 2)|floatval}" size="5" />
							{if !$currencySymbolBeforeAmount}<div class="input-group-addon">{$mp_currency->sign|escape:'html':'UTF-8'} {l s='tax excl.' mod='ets_marketplace'}</div>{/if}
						</div>
					</div>
					<br/>
					<div class="fixed-width-xl">
						<div class="input-group">
							{if $currencySymbolBeforeAmount}<div class="input-group-addon">{$mp_currency->sign|escape:'html':'UTF-8'} {l s='tax incl.' mod='ets_marketplace'}</div>{/if}
							<input type="text" name="product_price_tax_incl" class="edit_product_price_tax_incl edit_product_price" value="{Tools::ps_round($product['unit_price_tax_incl'], 2)|floatval}" size="5" />
							{if $currencySymbolBeforeAmount}<div class="input-group-addon">{$mp_currency->sign|escape:'html':'UTF-8'} {l s='tax incl.' mod='ets_marketplace'}</div>{/if}
						</div>
					</div>
				</div>
			</div>
			{/if}
		</td>
		<td class="productQuantity text-center" >{$product['customizationQuantityTotal']|escape:'html':'UTF-8'}</td>
		{if $display_warehouse}<td>&nbsp;</td>{/if}
		{if ($order->hasBeenPaid())}<td class="productQuantity text-center">{$product['customizationQuantityRefunded']|escape:'html':'UTF-8'}</td>{/if}
		{if ($order->hasBeenDelivered() || $order->hasProductReturned())}<td class="productQuantity text-center">{$product['customizationQuantityReturned']|escape:'html':'UTF-8'}</td>{/if}
		{if $stock_location_is_available}<td class="productQuantity location text-center">{$product['location']|escape:'html':'UTF-8'}</td>{/if}
		{if $stock_management}<td class="text-center">{$product['current_stock']|escape:'html':'UTF-8'}</td>{/if}
		<td class="total_product">
		{if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
			{Ets_marketplace::displayPrice(Tools::ps_round($product['product_price'] * $product['customizationQuantityTotal'],2),$currency)|escape:'html':'UTF-8'}
		{else}
			{Ets_marketplace::displayPrice(Tools::ps_round($product['product_price_wt'] * $product['customizationQuantityTotal']),$currency)|escape:'html':'UTF-8'}
		{/if}
		</td>
		<td class="cancelQuantity standard_refund_fields current-edit" style="display:none" colspan="2">
			&nbsp;
		</td>
		<td class="edit_product_fields" colspan="2" style="display:none">&nbsp;</td>
		<td class="partial_refund_fields current-edit" style="text-align:left;display:none;"></td>
		{if ($can_edit && !$order->hasBeenDelivered())}
			<td class="product_action text-right">
				{* edit/delete controls *}
				<div class="btn-group">
					<button type="button" class="btn btn-default edit_product_change_link">
						<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg>
						{l s='Edit' mod='ets_marketplace'}
					</button>
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li>
							<a href="#" class="delete_product_line">
								<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
								{l s='Delete' mod='ets_marketplace'}
							</a>
						</li>
					</ul>
				</div>
				{* Update controls *}
				<button type="button" class="btn btn-default submitProductChange" style="display: none;">
					<i class="fa fa-ok"></i>
					{l s='Update' mod='ets_marketplace'}
				</button>
				<button type="button" class="btn btn-default cancel_product_change_link" style="display: none;">
					<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
					{l s='Cancel' mod='ets_marketplace'}
				</button>
			</td>
		{/if}
	</tr>
	{foreach $product['customizedDatas'] as $customizationPerAddress}
		{foreach $customizationPerAddress as $customizationId => $customization}
			<tr class="customized customized-{$product['id_order_detail']|intval}">
				<td colspan="9">
				<input type="hidden" class="edit_product_id_order_detail" value="{$product['id_order_detail']|intval}" />
					<div class="form-horizontal">
						{foreach $customization.datas as $type => $datas}
							{if ($type == Product::CUSTOMIZE_FILE)}
								{foreach from=$datas item=data}
									<div class="form-group">
										<span class="col-lg-4 control-label"><strong>{if $data['name']}{$data['name']|escape:'html':'UTF-8'}{else}{l s='Picture #' mod='ets_marketplace'}{$data@iteration|escape:'html':'UTF-8'}{/if}</strong></span>
										<div class="col-lg-8">
											<a href="{$link->getAdminLink('AdminCarts', true, [], ['ajax' => 1, 'action' => 'customizationImage', 'img' => $data['value'], 'name' => $order->id|intval|cat:'-file'|cat:$data@iteration])}" class="_blank">
												<img class="img-thumbnail" src="{$smarty.const._THEME_PROD_PIC_DIR_|escape:'html':'UTF-8'}{$data['value']|escape:'html':'UTF-8'}_small" alt=""/>
											</a>
										</div>
									</div>
								{/foreach}
							{elseif ($type == Product::CUSTOMIZE_TEXTFIELD)}
								{foreach from=$datas item=data}
									<div class="form-group">
										<span class="col-lg-4 control-label"><strong>{if $data['name']}{$data['name']|escape:'html':'UTF-8'}{else}{l s='Text #%s' sprintf=[$data@iteration] mod='ets_marketplace'}{/if}</strong></span>
										<div class="col-lg-8">
											<p class="form-control-static">{$data['value']|escape:'html':'UTF-8'}</p>
										</div>
									</div>
								{/foreach}
							{/if}
						{/foreach}
					</div>
				</td>
				{if ($can_edit && !$order->hasBeenDelivered())}
					<td class="edit_product_fields" colspan="2" style="display:none"></td>
					<td class="product_action" style="text-align:right"></td>
				{/if}
			</tr>
		{/foreach}
	{/foreach}
{/if}
