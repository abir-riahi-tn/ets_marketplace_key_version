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
<div class="quick-view-order" id="quick-view-order">
    {assign var="hook_invoice" value={hook h="displayInvoice" id_order=$order->id}}
    {assign var="order_documents" value=$order->getDocuments()}
    {assign var="order_shipping" value=$order->getShipping()}
    {assign var="order_return" value=$order->getReturn()}
        <div class="header_poup">
            <div class="group_action">
                {if $order->invoice_number}
                    <a class="order_file" title="{l s='Download invoice as PDF file' mod='ets_marketplace'}" href="{$link->getAdminLink('AdminPdf',true)|escape:'html':'UTF-8'}&submitAction=generateInvoicePDF&id_order={$order->id|intval}">
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1596 380q28 28 48 76t20 88v1152q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1600q0-40 28-68t68-28h896q40 0 88 20t76 48zm-444-244v376h376q-10-29-22-41l-313-313q-12-12-41-22zm384 1528v-1024h-416q-40 0-68-28t-28-68v-416h-768v1536h1280zm-1024-864q0-14 9-23t23-9h704q14 0 23 9t9 23v64q0 14-9 23t-23 9h-704q-14 0-23-9t-9-23v-64zm736 224q14 0 23 9t9 23v64q0 14-9 23t-23 9h-704q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h704zm0 256q14 0 23 9t9 23v64q0 14-9 23t-23 9h-704q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h704z"/></svg>
                    </a>
                {/if}
                {if $order->delivery_number}
                    <a class="order_file" title="{l s='Download delivery slip as PDF file' mod='ets_marketplace'}" href="{$link->getAdminLink('AdminPdf',true)|escape:'html':'UTF-8'}&submitAction=generateDeliverySlipPDF&id_order={$order->id|intval}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 1408q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm-384-512h384v-256h-158q-13 0-22 9l-195 195q-9 9-9 22v30zm1280 512q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm256-1088v1024q0 15-4 26.5t-13.5 18.5-16.5 11.5-23.5 6-22.5 2-25.5 0-22.5-.5q0 106-75 181t-181 75-181-75-75-181h-384q0 106-75 181t-181 75-181-75-75-181h-64q-3 0-22.5.5t-25.5 0-22.5-2-23.5-6-16.5-11.5-13.5-18.5-4-26.5q0-26 19-45t45-19v-320q0-8-.5-35t0-38 2.5-34.5 6.5-37 14-30.5 22.5-30l198-198q19-19 50.5-32t58.5-13h160v-192q0-26 19-45t45-19h1024q26 0 45 19t19 45z"/></svg></a>
                {/if}
                <a class="order_print" title="{l s='Print this order' mod='ets_marketplace'}" href="javascript:window.print();"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M448 1536h896v-256h-896v256zm0-640h896v-384h-160q-40 0-68-28t-28-68v-160h-640v640zm1152 64q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm128 0v416q0 13-9.5 22.5t-22.5 9.5h-224v160q0 40-28 68t-68 28h-960q-40 0-68-28t-28-68v-160h-224q-13 0-22.5-9.5t-9.5-22.5v-416q0-79 56.5-135.5t135.5-56.5h64v-544q0-40 28-68t68-28h672q40 0 88 20t76 48l152 152q28 28 48 76t20 88v256h64q79 0 135.5 56.5t56.5 135.5z"/></svg></a>
            </div>
            {l s='Order details' mod='ets_marketplace'}<span class="id_order">(<a title="{l s='View order' mod='ets_marketplace'}" href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&id_order={$order->id|intval}&vieworder">#{$order->id|intval} {if $order->reference != ''}| {$order->reference|escape:'html':'UTF-8'} {/if}</a>)</span>
        </div>
    <div class="row form-group main-order">
    <div class="col-sm-6">
        <span><strong><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg> {l s='Date' mod='ets_marketplace'}</strong>: {$order->date_add|escape:'html':'UTF-8'}</span>
    </div>
    <div class="col-sm-6">
        <span><strong><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1536 1399q0 109-62.5 187t-150.5 78h-854q-88 0-150.5-78t-62.5-187q0-85 8.5-160.5t31.5-152 58.5-131 94-89 134.5-34.5q131 128 313 128t313-128q76 0 134.5 34.5t94 89 58.5 131 31.5 152 8.5 160.5zm-256-887q0 159-112.5 271.5t-271.5 112.5-271.5-112.5-112.5-271.5 112.5-271.5 271.5-112.5 271.5 112.5 112.5 271.5z"/></svg> {l s='Customer' mod='ets_marketplace'}</strong>: {if ($customer->isGuest())}{l s='This order has been placed by a guest.' mod='ets_marketplace'}{else}{$customer->firstname|escape:'html':'UTF-8'}&nbsp;{$customer->lastname|escape:'html':'UTF-8'}{/if}</span>
    </div>
    <div class="col-sm-6">
        <span><strong><svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1824 128q66 0 113 47t47 113v1216q0 66-47 113t-113 47h-1600q-66 0-113-47t-47-113v-1216q0-66 47-113t113-47h1600zm-1600 128q-13 0-22.5 9.5t-9.5 22.5v224h1664v-224q0-13-9.5-22.5t-22.5-9.5h-1600zm1600 1280q13 0 22.5-9.5t9.5-22.5v-608h-1664v608q0 13 9.5 22.5t22.5 9.5h1600zm-1504-128v-128h256v128h-256zm384 0v-128h384v128h-384z"/></svg> {l s='Payment method' mod='ets_marketplace'}</strong>: {$order->payment|escape:'html':'UTF-8'}</span>
    </div>
    
    <div class="col-sm-6">
        <span><strong><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1504v-768q-32 36-69 66-268 206-426 338-51 43-83 67t-86.5 48.5-102.5 24.5h-2q-48 0-102.5-24.5t-86.5-48.5-83-67q-158-132-426-338-37-30-69-66v768q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm0-1051v-24.5l-.5-13-3-12.5-5.5-9-9-7.5-14-2.5h-1472q-13 0-22.5 9.5t-9.5 22.5q0 168 147 284 193 152 401 317 6 5 35 29.5t46 37.5 44.5 31.5 50.5 27.5 43 9h2q20 0 43-9t50.5-27.5 44.5-31.5 46-37.5 35-29.5q208-165 401-317 54-43 100.5-115.5t46.5-131.5zm128-37v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg> {l s='Email' mod='ets_marketplace'}</strong>: {$customer->email|escape:'html':'UTF-8'}</span>
    </div>
    <div class="col-sm-6">
        <span><strong><svg width="14" height="14" style="fill:orange!important;" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 544v448q0 14-9 23t-23 9h-320q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h224v-352q0-14 9-23t23-9h64q14 0 23 9t9 23zm416 352q0-148-73-273t-198-198-273-73-273 73-198 198-73 273 73 273 198 198 273 73 273-73 198-198 73-273zm224 0q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg> {l s='Order status' mod='ets_marketplace'}</strong>: {$order_state->name|escape:'html':'UTF-8'}</span>
    </div>
    <div class="col-sm-6">
        <span><strong><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1600 1240q0 27-10 70.5t-21 68.5q-21 50-122 106-94 51-186 51-27 0-53-3.5t-57.5-12.5-47-14.5-55.5-20.5-49-18q-98-35-175-83-127-79-264-216t-216-264q-48-77-83-175-3-9-18-49t-20.5-55.5-14.5-47-12.5-57.5-3.5-53q0-92 51-186 56-101 106-122 25-11 68.5-21t70.5-10q14 0 21 3 18 6 53 76 11 19 30 54t35 63.5 31 53.5q3 4 17.5 25t21.5 35.5 7 28.5q0 20-28.5 50t-62 55-62 53-28.5 46q0 9 5 22.5t8.5 20.5 14 24 11.5 19q76 137 174 235t235 174q2 1 19 11.5t24 14 20.5 8.5 22.5 5q18 0 46-28.5t53-62 55-62 50-28.5q14 0 28.5 7t35.5 21.5 25 17.5q25 15 53.5 31t63.5 35 54 30q70 35 76 53 3 7 3 21z"/></svg> {l s='Phone number' mod='ets_marketplace'}</strong>: {if $addresses.delivery->phone}{$addresses.delivery->phone|escape:'html':'UTF-8'}{elseif $addresses.delivery->phone_mobile}{$addresses.delivery->phone_mobile|escape:'html':'UTF-8'}{else}--{/if}</span>
    </div>
    </div>
    <div class="row" id="start_products">
    <div class="col-lg-12">
      <form class="container-command-top-spacing" action="" method="post" onsubmit="return orderDeleteProduct('{l s='This product cannot be returned.' mod='ets_marketplace'}', '{l s='Quantity to cancel is greater than available quantity.' mod='ets_marketplace'}');">
        <input type="hidden" name="id_order" value="{$order->id|escape:'html':'UTF-8'}" />
        <div style="display: none">
          <input type="hidden" value="{$order->getWarehouseList()|implode|escape:'html':'UTF-8'}" id="warehouse_list" />
        </div>
        <div class="prdouct-list">
          <div id="refundForm">
          </div>
          {capture "TaxMethod"}
            {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
              {l s='Tax excluded' mod='ets_marketplace'}
            {else}
              {l s='Tax included' mod='ets_marketplace'}
            {/if}
          {/capture}
          {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
            <input type="hidden" name="TaxMethod" value="0" />
          {else}
            <input type="hidden" name="TaxMethod" value="1" />
          {/if}
          <div class="table-responsive">
            <table class="table" id="orderProducts">
              <thead>
                <tr>
                  <th></th>
                  <th><span class="title_box ">{l s='Product' mod='ets_marketplace'}</span></th>
                  <th>
                    <span class="title_box ">{l s='Price per unit' mod='ets_marketplace'}</span>
                    <small class="text-muted">{$smarty.capture.TaxMethod|escape:'html':'UTF-8'}</small>
                  </th>
                  <th class="text-center"><span class="title_box ">{l s='Qty' mod='ets_marketplace'}</span></th>
                  {if $display_warehouse}<th><span class="title_box ">{l s='Warehouse' mod='ets_marketplace'}</span></th>{/if}
                  {if ($order->hasBeenPaid())}<th class="text-center"><span class="title_box ">{l s='Refunded' mod='ets_marketplace'}</span></th>{/if}
                  {if ($order->hasBeenDelivered() || $order->hasProductReturned())}
                    <th class="text-center"><span class="title_box ">{l s='Returned' mod='ets_marketplace'}</span></th>
                  {/if}
                  {if $stock_location_is_available}<th class="text-center"><span class="title_box ">{l s='Stock location' mod='ets_marketplace'}</span></th>{/if}
                  {if $stock_management}<th class="text-center"><span class="title_box ">{l s='Available quantity' mod='ets_marketplace'}</span></th>{/if}
                  <th>
                    <span class="title_box ">{l s='Total' mod='ets_marketplace'}</span>
                    <small class="text-muted">{$smarty.capture.TaxMethod|escape:'html':'UTF-8'}</small>
                  </th>
                  <th style="display: none;" class="add_product_fields"></th>
                  <th style="display: none;" class="edit_product_fields"></th>
                  <th style="display: none;" class="standard_refund_fields">
                    <i class="icon-minus-sign"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-768q-26 0-45 19t-19 45v128q0 26 19 45t45 19h768q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg></i>
                    {if ($order->hasBeenDelivered() || $order->hasBeenShipped())}
                      {l s='Return' mod='ets_marketplace'}
                    {elseif ($order->hasBeenPaid())}
                      {l s='Refund' mod='ets_marketplace'}
                    {else}
                      {l s='Cancel' mod='ets_marketplace'}
                    {/if}
                  </th>
                  <th style="display:none" class="partial_refund_fields">
                    <span class="title_box ">{l s='Partial refund' mod='ets_marketplace'}</span>
                  </th>
                </tr>
              </thead>
              <tbody>
              {foreach from=$products item=product key=k}
                {* Include customized datas partial *}
                {include file='modules/ets_marketplace/views/templates/hook/orders/_customized_data.tpl'}
                {* Include product line partial *}
                {include file='modules/ets_marketplace/views/templates/hook/orders/_product_line.tpl'}
              {/foreach}
              </tbody>
            </table>
          </div>
          <div class="clear">&nbsp;</div>
          <div class="row">
            <div class="col-xs-6">
              
            </div>
            <div class="col-xs-6">
              <div class="panel panel-vouchers" style="{if !sizeof($discounts)}display:none;{/if}">
                {if (sizeof($discounts))}
                <div class="table-responsive">
                  <table class="table">
                    <thead>
                      <tr>
                        <th>
                          <span class="title_box ">
                            {l s='Discount name' mod='ets_marketplace'}
                          </span>
                        </th>
                        <th>
                          <span class="title_box ">
                            {l s='Value' mod='ets_marketplace'}
                          </span>
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      {foreach from=$discounts item=discount}
                      <tr>
                        <td>{$discount['name']|escape:'html':'UTF-8'}</td>
                        <td>
                        {if $discount['value'] != 0.00}
                          -
                        {/if}
                        {Ets_marketplace::displayPrice($discount['value'],$currency)|escape:'html':'UTF-8'}
                        </td>
                        
                      </tr>
                      {/foreach}
                    </tbody>
                  </table>
                </div>
                <div class="current-edit" id="voucher_form" style="display:none;">
                  {include file='modules/ets_marketplace/views/templates/hook/orders/_discount_form.tpl'}
                </div>
                {/if}
              </div>
              <div class="panel panel-total">
                <div class="table-responsive">
                  <table class="table">
                    {* Assign order price *}
                    {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
                      {assign var=order_product_price value=($order->total_products)}
                      {assign var=order_discount_price value=$order->total_discounts_tax_excl}
                      {assign var=order_wrapping_price value=$order->total_wrapping_tax_excl}
                      {assign var=order_shipping_price value=$order->total_shipping_tax_excl}
                      {assign var=shipping_refundable value=$shipping_refundable_tax_excl}
                    {else}
                      {assign var=order_product_price value=$order->total_products_wt}
                      {assign var=order_discount_price value=$order->total_discounts_tax_incl}
                      {assign var=order_wrapping_price value=$order->total_wrapping_tax_incl}
                      {assign var=order_shipping_price value=$order->total_shipping_tax_incl}
                      {assign var=shipping_refundable value=$shipping_refundable_tax_incl}
                    {/if}
                    <tr id="total_products">
                      <td class="text-right"><strong>{l s='Products:' mod='ets_marketplace'}</strong></td>
                      <td class="amount text-right nowrap">
                        {Ets_marketplace::displayPrice($order_product_price,$currency)|escape:'html':'UTF-8'}
                      </td>
                      <td class="partial_refund_fields current-edit" style="display:none;"></td>
                    </tr>
                    <tr id="total_discounts" {if $order->total_discounts_tax_incl == 0}style="display: none;"{/if}>
                      <td class="text-right"><strong>{l s='Discounts:' mod='ets_marketplace'}</strong></td>
                      <td class="amount text-right nowrap">
                        -{Ets_marketplace::displayPrice($order_discount_price,$currency)|escape:'html':'UTF-8'}
                      </td>
                      <td class="partial_refund_fields current-edit" style="display:none;"></td>
                    </tr>
                    <tr id="total_wrapping" {if $order->total_wrapping_tax_incl == 0}style="display: none;"{/if}>
                      <td class="text-right"><strong>{l s='Wrapping:' mod='ets_marketplace'}</strong></td>
                      <td class="amount text-right nowrap">
                        {Ets_marketplace::displayPrice($order_wrapping_price,$currency)|escape:'html':'UTF-8'}
                      </td>
                      <td class="partial_refund_fields current-edit" style="display:none;"></td>
                    </tr>
                    <tr id="total_shipping">
                      <td class="text-right"><strong>{l s='Shipping:' mod='ets_marketplace'}</strong></td>
                      <td class="amount text-right nowrap" >
                        {Ets_marketplace::displayPrice($order_shipping_price,$currency)|escape:'html':'UTF-8'}
                      </td>
                      <td class="partial_refund_fields current-edit" style="display:none;">
                        <div class="input-group">
                          <div class="input-group-addon">
                            {$currency->sign|escape:'html':'UTF-8'}
                          </div>
                          <input type="text" name="partialRefundShippingCost" value="0" />
                        </div>
                      </td>
                    </tr>
                    {if isset($payment_fee)}
                        <tr id="total_payment_fee">
                          <td class="text-right"><strong>{l s='Payment fee:' mod='ets_marketplace'}</strong></td>
                          <td class="amount text-right nowrap" >{$payment_fee|escape:'html':'UTF-8'}</td>
                          <td class="partial_refund_fields current-edit" style="display:none;"></td>
                        </tr>
                    {/if}
                    {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC) && $order->total_paid_tax_incl-$order->total_paid_tax_excl >0}
                    <tr id="total_taxes">
                      <td class="text-right"><strong>{l s='Taxes:' mod='ets_marketplace'}</strong></td>
                      <td class="amount text-right nowrap" >{Ets_marketplace::displayPrice(($order->total_paid_tax_incl-$order->total_paid_tax_excl))|escape:'html':'UTF-8'}</td>
                      <td class="partial_refund_fields current-edit" style="display:none;"></td>
                    </tr>
                    {/if}
                    {assign var=order_total_price value=$order->total_paid_tax_incl}
                    <tr id="total_order">
                      <td class="text-right"><strong>{l s='Total:' mod='ets_marketplace'}</strong></td>
                      <td class="amount text-right nowrap">
                        <strong>{Ets_marketplace::displayPrice($order_total_price,$currency)|escape:'html':'UTF-8'}</strong>
                      </td>
                      <td class="partial_refund_fields current-edit" style="display:none;"></td>
                    </tr>
                  </table>
                </div>
              </div>
            </div>
          </div>
          <div style="display: none;" class="standard_refund_fields form-horizontal panel">
            <div class="form-group">
              {if ($order->hasBeenDelivered() && Configuration::get('PS_ORDER_RETURN'))}
              <p class="checkbox">
                <label for="reinjectQuantities">
                  <input type="checkbox" id="reinjectQuantities" name="reinjectQuantities" />
                  {l s='Re-stock products' mod='ets_marketplace'}
                </label>
              </p>
              {/if}
              {if ((!$order->hasBeenDelivered() && $order->hasBeenPaid()) || ($order->hasBeenDelivered() && Configuration::get('PS_ORDER_RETURN')))}
              <p class="checkbox">
                <label for="generateCreditSlip">
                  <input type="checkbox" id="generateCreditSlip" name="generateCreditSlip" onclick="toggleShippingCost()" />
                  {l s='Generate a credit slip' mod='ets_marketplace'}
                </label>
              </p>
              <p class="checkbox">
                <label for="generateDiscount">
                  <input type="checkbox" id="generateDiscount" name="generateDiscount" onclick="toggleShippingCost()" />
                  {l s='Generate a voucher' mod='ets_marketplace'}
                </label>
              </p>
              <p class="checkbox" id="spanShippingBack" style="display:none;">
                <label for="shippingBack">
                  <input type="checkbox" id="shippingBack" name="shippingBack" />
                  {l s='Repay shipping costs' mod='ets_marketplace'}
                </label>
              </p>
              {if $order->total_discounts_tax_excl > 0 || $order->total_discounts_tax_incl > 0}
              <br/><p>{l s='This order has been partially paid by voucher. Choose the amount you want to refund:' mod='ets_marketplace'}</p>
              <p class="radio">
                <label id="lab_refund_total_1" for="refund_total_1">
                  <input type="radio" value="0" name="refund_total_voucher_off" id="refund_total_1" checked="checked" />
                  {l s='Include amount of initial voucher: ' mod='ets_marketplace'}
                </label>
              </p>
              <p class="radio">
                <label id="lab_refund_total_2" for="refund_total_2">
                  <input type="radio" value="1" name="refund_total_voucher_off" id="refund_total_2"/>
                  {l s='Exclude amount of initial voucher: ' mod='ets_marketplace'}
                </label>
              </p>
              <div class="nowrap radio-inline">
                <label id="lab_refund_total_3" class="pull-left" for="refund_total_3">
                  {l s='Amount of your choice: ' mod='ets_marketplace'}
                  <input type="radio" value="2" name="refund_total_voucher_off" id="refund_total_3"/>
                </label>
                <div class="input-group col-lg-1 pull-left">
                  <div class="input-group-addon">
                    {$currency->sign|escape:'html':'UTF-8'}
                  </div>
                  <input type="text" class="input fixed-width-md" name="refund_total_voucher_choose" value="0"/>
                </div>
              </div>
              {/if}
            {/if}
            </div>
            {if (!$order->hasBeenDelivered() || ($order->hasBeenDelivered() && Configuration::get('PS_ORDER_RETURN')))}
            <div class="row">
              <input type="submit" name="cancelProduct" value="{if $order->hasBeenDelivered()}{l s='Return products' mod='ets_marketplace'}{elseif $order->hasBeenPaid()}{l s='Refund products' mod='ets_marketplace'}{else}{l s='Cancel products' mod='ets_marketplace'}{/if}" class="btn btn-default" />
            </div>
            {/if}
          </div>
          <div style="display:none;" class="partial_refund_fields">
            <p class="checkbox">
              <label for="reinjectQuantitiesRefund">
                <input type="checkbox" id="reinjectQuantitiesRefund" name="reinjectQuantities" />
                {l s='Re-stock products' mod='ets_marketplace'}
              </label>
            </p>
            <p class="checkbox">
              <label for="generateDiscountRefund">
                <input type="checkbox" id="generateDiscountRefund" name="generateDiscountRefund" onclick="toggleShippingCost()" />
                {l s='Generate a voucher' mod='ets_marketplace'}
              </label>
            </p>
            {if $order->total_discounts_tax_excl > 0 || $order->total_discounts_tax_incl > 0}
            <p>{l s='This order has been partially paid by voucher. Choose the amount you want to refund: ' mod='ets_marketplace'}</p>
            <p class="radio">
              <label id="lab_refund_1" for="refund_1">
                <input type="radio" value="0" name="refund_voucher_off" id="refund_1" checked="checked" />
                {l s='Product(s) price: ' mod='ets_marketplace'}
              </label>
            </p>
            <p class="radio">
              <label id="lab_refund_2" for="refund_2">
                <input type="radio" value="1" name="refund_voucher_off" id="refund_2"/>
                {l s='Product(s) price, excluding amount of initial voucher: ' mod='ets_marketplace'}
              </label>
            </p>
            <div class="nowrap radio-inline">
                <label id="lab_refund_3" class="pull-left" for="refund_3">
                  {l s='Amount of your choice: ' mod='ets_marketplace'}
                  <input type="radio" value="2" name="refund_voucher_off" id="refund_3"/>
                </label>
                <div class="input-group col-lg-1 pull-left">
                  <div class="input-group-addon">
                    {$currency->sign|escape:'html':'UTF-8'}
                  </div>
                  <input type="text" class="input fixed-width-md" name="refund_voucher_choose" value="0"/>
                </div>
              </div>
            {/if}
            <br/>
            <button type="submit" name="partialRefund" class="btn btn-default">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Partial refund' mod='ets_marketplace'}
            </button>
          </div>
        </div>
      </form>
    </div>
    </div>
        <hr/>
    <div class="row">
    <div class="form-group">
        <span><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 1408q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm-384-512h384v-256h-158q-13 0-22 9l-195 195q-9 9-9 22v30zm1280 512q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm256-1088v1024q0 15-4 26.5t-13.5 18.5-16.5 11.5-23.5 6-22.5 2-25.5 0-22.5-.5q0 106-75 181t-181 75-181-75-75-181h-384q0 106-75 181t-181 75-181-75-75-181h-64q-3 0-22.5.5t-25.5 0-22.5-2-23.5-6-16.5-11.5-13.5-18.5-4-26.5q0-26 19-45t45-19v-320q0-8-.5-35t0-38 2.5-34.5 6.5-37 14-30.5 22.5-30l198-198q19-19 50.5-32t58.5-13h160v-192q0-26 19-45t45-19h1024q26 0 45 19t19 45z"/></svg> <strong>{l s='Shipping method' mod='ets_marketplace'}</strong>: {$carrier->name|escape:'html':'UTF-8'}</span>
    </div>
    </div>
    <div class="row">
        <div class="customer-address">
            <div class="row">
            <div id="addressShipping" class="col-sm-6">
              <div class="title">
                  <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 640q0-106-75-181t-181-75-181 75-75 181 75 181 181 75 181-75 75-181zm256 0q0 109-33 179l-364 774q-16 33-47.5 52t-67.5 19-67.5-19-46.5-52l-365-774q-33-70-33-179 0-212 150-362t362-150 362 150 150 362z"/></svg> <strong>{l s='Shipping address' mod='ets_marketplace'}</strong>
              </div>
              {if !$order->isVirtual()}
              <!-- Shipping address -->
                <div class="col-sm-6 address_order">
                  {displayAddressDetail address=$addresses.delivery newLine='<br />'}
                  {if $addresses.delivery->other}
                    <hr />{$addresses.delivery->other|escape:'html':'UTF-8'}<br />
                  {/if}
                </div>
                <div class="col-sm-6 hidden-print">
                  <div id="map-delivery-canvas" style="height: 100px"></div>
                </div>
              {/if}
            </div>
                  <!-- Invoice address -->
            <div id="invoiceShipping" class="col-sm-6">
              <div class="title">
                  <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1596 476q14 14 28 36h-472v-472q22 14 36 28zm-476 164h544v1056q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1600q0-40 28-68t68-28h800v544q0 40 28 68t68 28zm160 736v-64q0-14-9-23t-23-9h-704q-14 0-23 9t-9 23v64q0 14 9 23t23 9h704q14 0 23-9t9-23zm0-256v-64q0-14-9-23t-23-9h-704q-14 0-23 9t-9 23v64q0 14 9 23t23 9h704q14 0 23-9t9-23zm0-256v-64q0-14-9-23t-23-9h-704q-14 0-23 9t-9 23v64q0 14 9 23t23 9h704q14 0 23-9t9-23z"/></svg> <strong>{l s='Invoice address' mod='ets_marketplace'}</strong>
              </div>
              <div class="col-sm-12 address_order">
                {displayAddressDetail address=$addresses.invoice newLine='<br />'}
                {if $addresses.invoice->other}
                    <hr />{$addresses.invoice->other|escape:'html':'UTF-8'}<br />
                {/if}
              </div>
              <div class="col-sm-12 hidden-print">
                    <div id="map-invoice-canvas"></div>
              </div>
            </div>
          </div>
        </div>
    </div>
    <script>
      $('#tabAddresses a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
      });
    </script>
    {if (sizeof($messages))}
      <div class="row order-messages">
        <div class="messages-heading">
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1504v-768q-32 36-69 66-268 206-426 338-51 43-83 67t-86.5 48.5-102.5 24.5h-2q-48 0-102.5-24.5t-86.5-48.5-83-67q-158-132-426-338-37-30-69-66v768q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm0-1051v-24.5l-.5-13-3-12.5-5.5-9-9-7.5-14-2.5h-1472q-13 0-22.5 9.5t-9.5 22.5q0 168 147 284 193 152 401 317 6 5 35 29.5t46 37.5 44.5 31.5 50.5 27.5 43 9h2q20 0 43-9t50.5-27.5 44.5-31.5 46-37.5 35-29.5q208-165 401-317 54-43 100.5-115.5t46.5-131.5zm128-37v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg> {l s='Messages' mod='ets_marketplace'} <span class="badge">{sizeof($customer_thread_message)|escape:'html':'UTF-8'}</span>
        </div>
        {if (sizeof($messages))}
          <div class="panel panel-highlighted">
                <div class="message-item">
                  {foreach from=$messages item=message}
                    <div class="message-avatar">
                      <div class="avatar-md">
                          <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1536 1399q0 109-62.5 187t-150.5 78h-854q-88 0-150.5-78t-62.5-187q0-85 8.5-160.5t31.5-152 58.5-131 94-89 134.5-34.5q131 128 313 128t313-128q76 0 134.5 34.5t94 89 58.5 131 31.5 152 8.5 160.5zm-256-887q0 159-112.5 271.5t-271.5 112.5-271.5-112.5-112.5-271.5 112.5-271.5 271.5-112.5 271.5 112.5 112.5 271.5z"/></svg>
                      </div>
                    </div>
                    <div class="message-body">
                          <span class="message-date">&nbsp;<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                            {dateFormat date=$message['date_add']} -
                          </span>
                          <h4 class="message-item-heading">
                            {if ($message['elastname']|escape:'html':'UTF-8')}{$message['efirstname']|escape:'html':'UTF-8'}
                              {$message['elastname']|escape:'html':'UTF-8'}{else}{$message['cfirstname']|escape:'html':'UTF-8'} {$message['clastname']|escape:'html':'UTF-8'}
                            {/if}
                            {if ($message['private'] == 1)}
                              <span class="badge badge-info">{l s='Private' mod='ets_marketplace'}</span>
                            {/if}
                          </h4>
                          <p class="message-item-text">
                            {$message['message']|escape:'html':'UTF-8'|nl2br}
                          </p>
                    </div>
                  {/foreach}
                </div>
          </div>
        {/if}
      </div>
    {/if}
</div>
<script type="text/javascript">
function PrintElem(elem)
{
var mywindow = window.open('', 'PRINT', 'height=400,width=600');

mywindow.document.write('<html><head><title>' + document.title  + '</title>');
mywindow.document.write('</head><body >');
mywindow.document.write('<h1>' + document.title  + '</h1>');
mywindow.document.write(document.getElementById(elem).innerHTML);
mywindow.document.write('</body></html>');

mywindow.document.close(); // necessary for IE >= 10
mywindow.focus(); // necessary for IE >= 10*/

mywindow.print();
mywindow.close();

return true;
}
</script>