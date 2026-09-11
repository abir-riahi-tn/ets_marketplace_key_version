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
  var admin_order_tab_link = "{$link->getAdminLink('AdminOrders')|addslashes|escape:'html':'UTF-8'}";
  var id_order = {$order->id|intval};
  var id_lang = {$current_id_lang|intval};
  var id_currency = {$order->id_currency|intval};
  var id_customer = {$order->id_customer|intval};
  {assign var=PS_TAX_ADDRESS_TYPE value=Configuration::get('PS_TAX_ADDRESS_TYPE')}
  var id_address = {$order->$PS_TAX_ADDRESS_TYPE|intval};
  var currency_sign = "{$mp_currency->sign|escape:'html':'UTF-8'}";
  var currency_format = "{$mp_currency->format|escape:'html':'UTF-8'}";
  var currency_blank = "{$mp_currency->blank|escape:'html':'UTF-8'}";
  var priceDisplayPrecision = {$smarty.const._PS_PRICE_DISPLAY_PRECISION_|intval};
  var use_taxes = {if $order->getTaxCalculationMethod() == $smarty.const.PS_TAX_INC}true{else}false{/if};
  var stock_management = {$stock_management|intval};
  var txt_add_product_stock_issue = "{l s='Are you sure you want to add this quantity?' mod='ets_marketplace' js=1}";
  var txt_add_product_new_invoice = "{l s='Are you sure you want to create a new invoice?' mod='ets_marketplace' js=1}";
  var txt_add_product_no_product = "{l s='Error: No product has been selected' mod='ets_marketplace' js=1}";
  var txt_add_product_no_product_quantity = "{l s='Error: Quantity of products must be set' mod='ets_marketplace' js=1}";
  var txt_add_product_no_product_price = "{l s='Error: Product price must be set' mod='ets_marketplace' js=1}";
  var txt_confirm = "{l s='Are you sure?' mod='ets_marketplace' js=1}";
  var statesShipped = new Array();
  var has_voucher = {if count($discounts)}1{else}0{/if};
  {foreach from=$states item=state}
  {if (isset($currentState->shipped) && !$currentState->shipped && $state['shipped'])}
    statesShipped.push({$state['id_order_state']|intval});
  {/if}
  {/foreach}
  var order_discount_price = {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
          {$order->total_discounts_tax_excl|floatval}
          {else}
          {$order->total_discounts_tax_incl|floatval}
          {/if};

  var errorRefund = "{l s='Error. You cannot refund a negative amount.' mod='ets_marketplace'}";
</script>

{assign var="hook_invoice" value={hook h="displayInvoice" id_order=$order->id}}
{if ($hook_invoice)}
  <div>{$hook_invoice nofilter}</div>
{/if}
{assign var="order_documents" value=$order->getDocuments()}
{assign var="order_shipping" value=$order->getShipping()}
{assign var="order_return" value=$order->getReturn()}

<div class="panel kpi-container">
  <div class="row">
    <div class="col-xs-6 col-sm-3 box-stats color3" >
      <div class="kpi-content">
        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
        <span class="title">{l s='Date' mod='ets_marketplace'}</span>
        <span class="value">{dateFormat date=$order->date_add full=false}</span>
      </div>
    </div>
    <div class="col-xs-6 col-sm-3 box-stats color4" >
      <div class="kpi-content">
        <svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M832 1152h384v-96h-128v-448h-114l-148 137 77 80q42-37 55-57h2v288h-128v96zm512-256q0 70-21 142t-59.5 134-101.5 101-138 39-138-39-101.5-101-59.5-134-21-142 21-142 59.5-134 101.5-101 138-39 138 39 101.5 101 59.5 134 21 142zm512 256v-512q-106 0-181-75t-75-181h-1152q0 106-75 181t-181 75v512q106 0 181 75t75 181h1152q0-106 75-181t181-75zm128-832v1152q0 26-19 45t-45 19h-1792q-26 0-45-19t-19-45v-1152q0-26 19-45t45-19h1792q26 0 45 19t19 45z"/></svg>
        <span class="title">{l s='Total' mod='ets_marketplace'}</span>
        <span class="value price">{displayPrice price=$order->total_paid_tax_incl currency=$mp_currency->id}</span>
      </div>
    </div>
    <div class="col-xs-6 col-sm-3 box-stats color2" >
      <div class="kpi-content">
        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 768q0 139-94 257t-256.5 186.5-353.5 68.5q-86 0-176-16-124 88-278 128-36 9-86 16h-3q-11 0-20.5-8t-11.5-21q-1-3-1-6.5t.5-6.5 2-6l2.5-5 3.5-5.5 4-5 4.5-5 4-4.5q5-6 23-25t26-29.5 22.5-29 25-38.5 20.5-44q-124-72-195-177t-71-224q0-139 94-257t256.5-186.5 353.5-68.5 353.5 68.5 256.5 186.5 94 257zm384 256q0 120-71 224.5t-195 176.5q10 24 20.5 44t25 38.5 22.5 29 26 29.5 23 25q1 1 4 4.5t4.5 5 4 5 3.5 5.5l2.5 5 2 6 .5 6.5-1 6.5q-3 14-13 22t-22 7q-50-7-86-16-154-40-278-128-90 16-176 16-271 0-472-132 58 4 88 4 161 0 309-45t264-129q125-92 192-212t67-254q0-77-23-152 129 71 204 178t75 230z"/></svg>
        <span class="title">{l s='Messages' mod='ets_marketplace'}</span>
        <span class="value">{sizeof($customer_thread_message)|escape:'html':'UTF-8'}</span>
      </div>
    </div>
    <div class="col-xs-6 col-sm-3 box-stats color1" >
        <div class="kpi-content">
          <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1703 478q40 57 18 129l-275 906q-19 64-76.5 107.5t-122.5 43.5h-923q-77 0-148.5-53.5t-99.5-131.5q-24-67-2-127 0-4 3-27t4-37q1-8-3-21.5t-3-19.5q2-11 8-21t16.5-23.5 16.5-23.5q23-38 45-91.5t30-91.5q3-10 .5-30t-.5-28q3-11 17-28t17-23q21-36 42-92t25-90q1-9-2.5-32t.5-28q4-13 22-30.5t22-22.5q19-26 42.5-84.5t27.5-96.5q1-8-3-25.5t-2-26.5q2-8 9-18t18-23 17-21q8-12 16.5-30.5t15-35 16-36 19.5-32 26.5-23.5 36-11.5 47.5 5.5l-1 3q38-9 51-9h761q74 0 114 56t18 130l-274 906q-36 119-71.5 153.5t-128.5 34.5h-869q-27 0-38 15-11 16-1 43 24 70 144 70h923q29 0 56-15.5t35-41.5l300-987q7-22 5-57 38 15 59 43zm-1064 2q-4 13 2 22.5t20 9.5h608q13 0 25.5-9.5t16.5-22.5l21-64q4-13-2-22.5t-20-9.5h-608q-13 0-25.5 9.5t-16.5 22.5zm-83 256q-4 13 2 22.5t20 9.5h608q13 0 25.5-9.5t16.5-22.5l21-64q4-13-2-22.5t-20-9.5h-608q-13 0-25.5 9.5t-16.5 22.5z"/></svg>
          <span class="title">{l s='Products' mod='ets_marketplace'}</span>
          <span class="value">{sizeof($products)|escape:'html':'UTF-8'}</span>
        </div>
    </div>
  </div>
</div>
<div class="row kpi-content">
  <div class="col-lg-7">
    <div class="panel">
      <div class="panel-heading">
        <svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1824 128q66 0 113 47t47 113v1216q0 66-47 113t-113 47h-1600q-66 0-113-47t-47-113v-1216q0-66 47-113t113-47h1600zm-1600 128q-13 0-22.5 9.5t-9.5 22.5v224h1664v-224q0-13-9.5-22.5t-22.5-9.5h-1600zm1600 1280q13 0 22.5-9.5t9.5-22.5v-608h-1664v608q0 13 9.5 22.5t22.5 9.5h1600zm-1504-128v-128h256v128h-256zm384 0v-128h384v128h-384z"/></svg>
        {l s='Order' mod='ets_marketplace'}
        <span class="badge">{$order->reference|escape:'html':'UTF-8'}</span>
        <span class="badge">#{$order->id|intval}</span>
        <div class="panel-heading-action kpi_panel-heading-action">
          <div class="btn-group">
            <a class="btn btn-default{if !$previousOrder} disabled{/if}" href="{$link->getModuleLink('ets_marketplace','orders',['id_order' => $previousOrder|intval])|escape:'html':'UTF-8'}">
              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1683 141q19-19 32-13t13 32v1472q0 26-13 32t-32-13l-710-710q-9-9-13-19v710q0 26-13 32t-32-13l-710-710q-19-19-19-45t19-45l710-710q19-19 32-13t13 32v710q4-10 13-19z"/></svg>
            </a>
            <a class="btn btn-default{if !$nextOrder} disabled{/if}" href="{$link->getModuleLink('ets_marketplace','orders',['id_order' => $nextOrder|intval])|escape:'html':'UTF-8'}">
              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M109 1651q-19 19-32 13t-13-32v-1472q0-26 13-32t32 13l710 710q9 9 13 19v-710q0-26 13-32t32 13l710 710q19 19 19 45t-19 45l-710 710q-19 19-32 13t-13-32v-710q-4 10-13 19z"/></svg>
            </a>
          </div>
        </div>
      </div>
      <!-- Orders Actions -->
      <div class="well hidden-print kpi_printorder">
        <a class="btn btn-default" href="javascript:window.print()">
          <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M448 1536h896v-256h-896v256zm0-640h896v-384h-160q-40 0-68-28t-28-68v-160h-640v640zm1152 64q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm128 0v416q0 13-9.5 22.5t-22.5 9.5h-224v160q0 40-28 68t-68 28h-960q-40 0-68-28t-28-68v-160h-224q-13 0-22.5-9.5t-9.5-22.5v-416q0-79 56.5-135.5t135.5-56.5h64v-544q0-40 28-68t68-28h672q40 0 88 20t76 48l152 152q28 28 48 76t20 88v256h64q79 0 135.5 56.5t56.5 135.5z"/></svg>
          {l s='Print order' mod='ets_marketplace'}
        </a>
        {if Configuration::get('PS_INVOICE') && count($invoices_collection) && $order->invoice_number}
            <a data-selenium-id="view_invoice" class="btn btn-default _blank" href="{$link->getModuleLink('ets_marketplace','pdf',['submitAction' => 'generateInvoicePDF', 'id_order' => $order->id|intval])|escape:'html':'UTF-8'}">
              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 512v-472q22 14 36 28l408 408q14 14 28 36h-472zm-128 32q0 40 28 68t68 28h544v1056q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1600q0-40 28-68t68-28h800v544z"/></svg>
              {l s='View invoice' mod='ets_marketplace'}
            </a>
          {else}
            <span class="span label label-inactive">
              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
              {l s='No invoice' mod='ets_marketplace'}
            </span>
          {/if}
          &nbsp;
          {if $order->delivery_number}
            <a class="btn btn-default _blank"  href="{$link->getModuleLink('ets_marketplace','pdf', ['submitAction' => 'generateDeliverySlipPDF', 'id_order' => $order->id|intval])|escape:'html':'UTF-8'}">
              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 1408q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm-384-512h384v-256h-158q-13 0-22 9l-195 195q-9 9-9 22v30zm1280 512q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm256-1088v1024q0 15-4 26.5t-13.5 18.5-16.5 11.5-23.5 6-22.5 2-25.5 0-22.5-.5q0 106-75 181t-181 75-181-75-75-181h-384q0 106-75 181t-181 75-181-75-75-181h-64q-3 0-22.5.5t-25.5 0-22.5-2-23.5-6-16.5-11.5-13.5-18.5-4-26.5q0-26 19-45t45-19v-320q0-8-.5-35t0-38 2.5-34.5 6.5-37 14-30.5 22.5-30l198-198q19-19 50.5-32t58.5-13h160v-192q0-26 19-45t45-19h1024q26 0 45 19t19 45z"/></svg>
              {l s='View delivery slip' mod='ets_marketplace'}
            </a>
          {else}
            <span class="span label label-inactive">
              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
              {l s='No delivery slip' mod='ets_marketplace'}
            </span>
          {/if}
        {hook h='displayBackOfficeOrderActions' id_order=$order->id|intval}
      </div>
      <!-- Tab nav -->
      <ul class="nav nav-tabs" id="tabOrder">
        {$HOOK_TAB_ORDER nofilter}
        <li class="active">
          <a href="#status">
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
            {l s='Status' mod='ets_marketplace'} <span class="badge">{$history|@count|intval}</span>
          </a>
        </li>
        <li>
          <a href="#documents">
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1596 476q14 14 28 36h-472v-472q22 14 36 28zm-476 164h544v1056q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1600q0-40 28-68t68-28h800v544q0 40 28 68t68 28zm160 736v-64q0-14-9-23t-23-9h-704q-14 0-23 9t-9 23v64q0 14 9 23t23 9h704q14 0 23-9t9-23zm0-256v-64q0-14-9-23t-23-9h-704q-14 0-23 9t-9 23v64q0 14 9 23t23 9h704q14 0 23-9t9-23zm0-256v-64q0-14-9-23t-23-9h-704q-14 0-23 9t-9 23v64q0 14 9 23t23 9h704q14 0 23-9t9-23z"/></svg>
            {l s='Documents' mod='ets_marketplace'} <span class="badge">{$order_documents|@count|intval}</span>
          </a>
        </li>
      </ul>
      <!-- Tab content -->
      <div class="tab-content panel">
        {$HOOK_CONTENT_ORDER nofilter}
        <!-- Tab status -->
        <div class="tab-pane active" id="status">
         
          <!-- History of status -->
          <div class="table-responsive">
            <table class="table history-status row-margin-bottom">
              <tbody>
              {foreach from=$history item=row key=key}
                {if ($key == 0)}
                  <tr>
                    <td style="background-color:{$row['color']|escape:'html':'UTF-8'}"><img src="{$link_base|escape:'html':'UTF-8'}/img/os/{$row['id_order_state']|intval}.gif" width="16" height="16" alt="{$row['ostate_name']|stripslashes}" /></td>
                    <td style="background-color:{$row['color']|escape:'html':'UTF-8'};color:{$row['text-color']|escape:'html':'UTF-8'}">{$row['ostate_name']|stripslashes|escape:'html':'UTF-8'}</td>
                    <td style="background-color:{$row['color']|escape:'html':'UTF-8'};color:{$row['text-color']|escape:'html':'UTF-8'}">{dateFormat date=$row['date_add'] full=true}</td>
                    <td style="background-color:{$row['color']|escape:'html':'UTF-8'};color:{$row['text-color']|escape:'html':'UTF-8'}" class="text-right">
                      
                    </td>
                  </tr>
                {else}
                  <tr>
                    <td><img src="{$link_base|escape:'html':'UTF-8'}/img/os/{$row['id_order_state']|intval}.gif" width="16" height="16" /></td>
                    <td>{$row['ostate_name']|stripslashes|escape:'html':'UTF-8'}</td>
                    <td>{dateFormat date=$row['date_add'] full=true}</td>
                    <td class="text-right">
    
                    </td>
                  </tr>
                {/if}
              {/foreach}
              </tbody>
            </table>
          </div>
          <!-- Change status form -->
          {if $ETS_MP_SELLER_CAN_CHANGE_ORDER_STATUS && $states}
            <form action="" method="post" class="form-horizontal well hidden-print">
              <div class="row">
                <div class="col-lg-12">
                  <select id="id_order_state" class="chosen form-control" name="id_order_state">
                    {foreach from=$states item=state}
                      <option value="{$state['id_order_state']|intval}"{if isset($currentState) && $state['id_order_state'] == $currentState->id} selected="selected"{/if}>{$state['name']|escape}</option>
                    {/foreach}
                  </select>
                  <input type="hidden" name="id_order" value="{$order->id|intval}" />
                </div>
                <div class="col-lg-12">
                  <input type="hidden" name="submitChangeState" value="1"/>
                  <button type="submit" name="submitChangeState" id="submit_state" class="btn btn-primary">
                    {l s='Update status' mod='ets_marketplace'}
                  </button>
                </div>
              </div>
            </form>
          {/if}
        </div>
        <!-- Tab documents -->
        <div class="tab-pane" id="documents">
          
          {* Include document template *}
          {include file='modules/ets_marketplace/views/templates/hook/orders/_documents.tpl'}
        </div>
      </div>
      <hr />
      <!-- Tab nav -->
      <ul class="nav nav-tabs myTab_order" id="myTab">
        {$HOOK_TAB_SHIP nofilter}
        <li class="active">
          <a href="#shipping">
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 1408q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm-384-512h384v-256h-158q-13 0-22 9l-195 195q-9 9-9 22v30zm1280 512q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm256-1088v1024q0 15-4 26.5t-13.5 18.5-16.5 11.5-23.5 6-22.5 2-25.5 0-22.5-.5q0 106-75 181t-181 75-181-75-75-181h-384q0 106-75 181t-181 75-181-75-75-181h-64q-3 0-22.5.5t-25.5 0-22.5-2-23.5-6-16.5-11.5-13.5-18.5-4-26.5q0-26 19-45t45-19v-320q0-8-.5-35t0-38 2.5-34.5 6.5-37 14-30.5 22.5-30l198-198q19-19 50.5-32t58.5-13h160v-192q0-26 19-45t45-19h1024q26 0 45 19t19 45z"/></svg>
            {l s='Shipping' mod='ets_marketplace'} <span class="badge">{if !$order->isVirtual()}{$order_shipping|@count|intval}{else}0{/if}</span>
          </a>
        </li>
        <li>
          <a href="#returns">
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 896q0 156-61 298t-164 245-245 164-298 61q-172 0-327-72.5t-264-204.5q-7-10-6.5-22.5t8.5-20.5l137-138q10-9 25-9 16 2 23 12 73 95 179 147t225 52q104 0 198.5-40.5t163.5-109.5 109.5-163.5 40.5-198.5-40.5-198.5-109.5-163.5-163.5-109.5-198.5-40.5q-98 0-188 35.5t-160 101.5l137 138q31 30 14 69-17 40-59 40h-448q-26 0-45-19t-19-45v-448q0-42 40-59 39-17 69 14l130 129q107-101 244.5-156.5t284.5-55.5q156 0 298 61t245 164 164 245 61 298z"/></svg>
            {l s='Merchandise Returns' mod='ets_marketplace'} <span class="badge">{$order_return|@count|intval}</span>
          </a>
        </li>
      </ul>
      <!-- Tab content -->
      <div class="tab-content panel">
        {$HOOK_CONTENT_SHIP nofilter}
        <!-- Tab shipping -->
        <div class="tab-pane active" id="shipping">
          <!-- Shipping block -->
          {if !$order->isVirtual()}
            <div class="form-horizontal">
              {if $order->gift_message}
                <div class="form-group">
                  <label class="control-label col-lg-3">{l s='Message' mod='ets_marketplace'}</label>
                  <div class="col-lg-9">
                    <p class="form-control-static">{$order->gift_message|nl2br nofilter}</p>
                  </div>
                </div>
              {/if}
              {include file='modules/ets_marketplace/views/templates/hook/orders/_shipping.tpl'}
              {if $carrierModuleCall}
                {$carrierModuleCall nofilter}
              {/if}
              <hr />
              {if $order->recyclable}
                <span class="label label-success"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Recycled packaging' mod='ets_marketplace'}</span>
              {else}
                <span class="label label-inactive"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Recycled packaging' mod='ets_marketplace'}</span>
              {/if}

              {if $order->gift}
                <span class="label label-success"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg> {l s='Gift wrapping' mod='ets_marketplace'}</span>
              {else}
                <span class="label label-inactive"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Gift wrapping' mod='ets_marketplace'}</span>
              {/if}
            </div>
          {/if}
        </div>
        <!-- Tab returns -->
        <div class="tab-pane" id="returns">
          {if !$order->isVirtual()}
            
            <!-- Return block -->
            {if $order_return|count > 0}
              <div class="table-responsive">
                <table class="table">
                  <thead>
                  <tr>
                    <th><span class="title_box ">{l s='Date' mod='ets_marketplace'}</span></th>
                    <th><span class="title_box ">{l s='Type' mod='ets_marketplace'}</span></th>
                    <th><span class="title_box ">{l s='Carrier' mod='ets_marketplace'}</span></th>
                    <th><span class="title_box ">{l s='Tracking number' mod='ets_marketplace'}</span></th>
                  </tr>
                  </thead>
                  <tbody>
                  {foreach from=$order_return item=line}
                    <tr>
                      <td>{$line.date_add|escape:'html':'UTF-8'}</td>
                      <td>{$line.type|escape:'html':'UTF-8'}</td>
                      <td>{$line.state_name|escape:'html':'UTF-8'}</td>
                      <td class="actions">
                        <span class="shipping_number_show">{if isset($line.url) && isset($line.tracking_number)}<a href="{$line.url|replace:'@':$line.tracking_number|escape:'html':'UTF-8'}">{$line.tracking_number|escape:'html':'UTF-8'}</a>{elseif isset($line.tracking_number)}{$line.tracking_number|escape:'html':'UTF-8'}{/if}</span>
                        {if $line.can_edit}
                          <form method="post" action="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&amp;vieworder&amp;id_order={$order->id|intval}&amp;id_order_invoice={if $line.id_order_invoice}{$line.id_order_invoice|intval}{else}0{/if}&amp;id_carrier={if $line.id_carrier}{$line.id_carrier|escape:'html':'UTF-8'}{else}0{/if}">
                          <span class="shipping_number_edit" style="display:none;">
                            <button type="button" name="tracking_number">
                              {$line.tracking_number|htmlentities|escape:'html':'UTF-8'}
                            </button>
                            <button type="submit" class="btn btn-default" name="submitShippingNumber">
                              {l s='Update' mod='ets_marketplace'}
                            </button>
                          </span>
                            <button href="#" class="edit_shipping_number_link">
                              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg>
                              {l s='Edit' mod='ets_marketplace'}
                            </button>
                            <button href="#" class="cancel_shipping_number_link" style="display: none;">
                              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                              {l s='Cancel' mod='ets_marketplace'}
                            </button>
                          </form>
                        {/if}
                      </td>
                    </tr>
                  {/foreach}
                  </tbody>
                </table>
              </div>
            {else}
              <div class="list-empty hidden-print">
                <div class="list-empty-msg">
                  <svg width="18" height="18" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg>
                  {l s='No merchandise returned yet' mod='ets_marketplace'}
                </div>
              </div>
            {/if}
            {if $carrierModuleCall}
              {$carrierModuleCall nofilter}
            {/if}
          {/if}
        </div>
      </div>
    </div>
  </div>
  <div class="col-lg-5">
    <!-- Customer informations -->
    <div class="panel">
      {if $order_customer->id && !$order_customer->isGuest()}
        <div class="panel-heading">
          <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1536 1399q0 109-62.5 187t-150.5 78h-854q-88 0-150.5-78t-62.5-187q0-85 8.5-160.5t31.5-152 58.5-131 94-89 134.5-34.5q131 128 313 128t313-128q76 0 134.5 34.5t94 89 58.5 131 31.5 152 8.5 160.5zm-256-887q0 159-112.5 271.5t-271.5 112.5-271.5-112.5-112.5-271.5 112.5-271.5 271.5-112.5 271.5 112.5 112.5 271.5z"/></svg>
              {l s='Customer' mod='ets_marketplace'}
              <span class="customer">
                  <strong>
                    {if Configuration::get('PS_B2B_ENABLE')}{$order_customer->company|escape:'html':'UTF-8'} - {/if}
                    {$gender->name|escape:'html':'UTF-8'}
                    {$order_customer->firstname|escape:'html':'UTF-8'}
                    {$order_customer->lastname|escape:'html':'UTF-8'}
                  </strong>
              </span>
              <span class="badge">
                  {l s='#' mod='ets_marketplace'}{$order_customer->id|intval}
              </span>
        </div>
        <div class="row">
          <div class="col-xs-12">
            {if (!$order_customer->isGuest())}
              <dl class="well list-detail">
                {if Configuration::get('ETS_MP_DISPLAY_CUSTOMER_EMAIL')}
                    <dt>{l s='Email' mod='ets_marketplace'}</dt>
                    <dd class="email"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1504v-768q-32 36-69 66-268 206-426 338-51 43-83 67t-86.5 48.5-102.5 24.5h-2q-48 0-102.5-24.5t-86.5-48.5-83-67q-158-132-426-338-37-30-69-66v768q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm0-1051v-24.5l-.5-13-3-12.5-5.5-9-9-7.5-14-2.5h-1472q-13 0-22.5 9.5t-9.5 22.5q0 168 147 284 193 152 401 317 6 5 35 29.5t46 37.5 44.5 31.5 50.5 27.5 43 9h2q20 0 43-9t50.5-27.5 44.5-31.5 46-37.5 35-29.5q208-165 401-317 54-43 100.5-115.5t46.5-131.5zm128-37v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg> {$order_customer->email|escape:'html':'UTF-8'}</dd>
                {/if}
                <dt>{l s='Account registered' mod='ets_marketplace'}</dt>
                <dd class="text-muted"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h1408v-1024h-1408v1024zm384-1216v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm768 0v-288q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v288q0 14 9 23t23 9h64q14 0 23-9t9-23zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg> {dateFormat date=$order_customer->date_add full=true}</dd>
                <dt>{l s='Valid orders placed' mod='ets_marketplace'}</dt>
                <dd><span class="badge">{$customerStats['nb_orders']|intval}</span></dd>
                <dt>{l s='Total spent since registration' mod='ets_marketplace'}</dt>
                <dd><span class="badge badge-success">{displayPrice price=Tools::ps_round(Tools::convertPrice($customerStats['total_orders'], $mp_currency), 2) currency=$mp_currency->id}</span></dd>
                {if Configuration::get('PS_B2B_ENABLE')}
                  <dt>{l s='SIRET' mod='ets_marketplace'}</dt>
                  <dd>{$order_customer->siret|escape:'html':'UTF-8'}</dd>
                  <dt>{l s='APE' mod='ets_marketplace'}</dt>
                  <dd>{$order_customer->ape|escape:'html':'UTF-8'}</dd>
                {/if}
              </dl>
            {/if}
          </div>
        </div>
      {/if}
      <!-- Tab nav -->
      {if $ETS_MP_DISPLAY_CUSTOMER_ADDRESS}
      <div class="ets_mp_address_tab">
        <ul class="nav nav-tabs myTab_order" id="tabAddresses">
          <li class="active">
            <a href="#addressShipping">
              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 1408q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm-384-512h384v-256h-158q-13 0-22 9l-195 195q-9 9-9 22v30zm1280 512q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm256-1088v1024q0 15-4 26.5t-13.5 18.5-16.5 11.5-23.5 6-22.5 2-25.5 0-22.5-.5q0 106-75 181t-181 75-181-75-75-181h-384q0 106-75 181t-181 75-181-75-75-181h-64q-3 0-22.5.5t-25.5 0-22.5-2-23.5-6-16.5-11.5-13.5-18.5-4-26.5q0-26 19-45t45-19v-320q0-8-.5-35t0-38 2.5-34.5 6.5-37 14-30.5 22.5-30l198-198q19-19 50.5-32t58.5-13h160v-192q0-26 19-45t45-19h1024q26 0 45 19t19 45z"/></svg>
              {l s='Shipping address' mod='ets_marketplace'}
            </a>
          </li>
          <li>
            <a href="#addressInvoice">
              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1596 476q14 14 28 36h-472v-472q22 14 36 28zm-476 164h544v1056q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1600q0-40 28-68t68-28h800v544q0 40 28 68t68 28zm160 736v-64q0-14-9-23t-23-9h-704q-14 0-23 9t-9 23v64q0 14 9 23t23 9h704q14 0 23-9t9-23zm0-256v-64q0-14-9-23t-23-9h-704q-14 0-23 9t-9 23v64q0 14 9 23t23 9h704q14 0 23-9t9-23zm0-256v-64q0-14-9-23t-23-9h-704q-14 0-23 9t-9 23v64q0 14 9 23t23 9h704q14 0 23-9t9-23z"/></svg>
              {l s='Invoice address' mod='ets_marketplace'}
            </a>
          </li>
        </ul>
        <!-- Tab content -->
        <div class="tab-content panel">
          <!-- Tab status -->
          <div class="tab-pane  in active" id="addressShipping">
            <!-- Addresses -->
            
            {if !$order->isVirtual()}
              <!-- Shipping address -->
              <h4 class="visible-print">{l s='Shipping address' mod='ets_marketplace'}</h4>
              {if $can_edit}
                <form class="form-horizontal hidden-print" method="post" action="{$link->getAdminLink('AdminOrders', true, [], ['vieworder' => 1, 'id_order' => $order->id|intval])|escape:'html':'UTF-8'}">
                  <div class="form-group">
                    <div class="col-lg-9">
                      <select name="id_address">
                        {foreach from=$customer_addresses item=address}
                          <option value="{$address['id_address']|intval}"
                                  {if $address['id_address'] == $order->id_address_delivery}
                            selected="selected"
                                  {/if}>
                            {$address['alias']|escape:'html':'UTF-8'} -
                            {$address['address1']|escape:'html':'UTF-8'}
                            {$address['postcode']|escape:'html':'UTF-8'}
                            {$address['city']|escape:'html':'UTF-8'}
                            {if !empty($address['state'])}
                              {$address['state']|escape:'html':'UTF-8'}
                            {/if},
                            {$address['country']|escape:'html':'UTF-8'}
                          </option>
                        {/foreach}
                      </select>
                    </div>
                    <div class="col-lg-3">
                      <button class="btn btn-default" type="submit" name="submitAddressShipping"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1639 1056q0 5-1 7-64 268-268 434.5t-478 166.5q-146 0-282.5-55t-243.5-157l-129 129q-19 19-45 19t-45-19-19-45v-448q0-26 19-45t45-19h448q26 0 45 19t19 45-19 45l-137 137q71 66 161 102t187 36q134 0 250-65t186-179q11-17 53-117 8-23 30-23h192q13 0 22.5 9.5t9.5 22.5zm25-800v448q0 26-19 45t-45 19h-448q-26 0-45-19t-19-45 19-45l138-138q-148-137-349-137-134 0-250 65t-186 179q-11 17-53 117-8 23-30 23h-199q-13 0-22.5-9.5t-9.5-22.5v-7q65-268 270-434.5t480-166.5q146 0 284 55.5t245 156.5l130-129q19-19 45-19t45 19 19 45z"/></svg> {l s='Change' mod='ets_marketplace'}</button>
                    </div>
                  </div>
                </form>
              {/if}
              <div class="well">
                <div class="row">
                  <div class="col-sm-12">
                    {displayAddressDetail address=$addresses.delivery newLine='<br />'}
                    {if $addresses.delivery->other}
                      <hr />{$addresses.delivery->other|escape:'html':'UTF-8'}<br />
                    {/if}
                  </div>
                  <div class="col-sm-12 hidden-print">
                    <div id="map-delivery-canvas"></div>
                  </div>
                </div>
              </div>
            {/if}
          </div>
          <div class="tab-pane " id="addressInvoice">
            <!-- Invoice address -->
            <h4 class="visible-print">{l s='Invoice address' mod='ets_marketplace'}</h4>
            {if $can_edit}
              <form class="form-horizontal hidden-print" method="post" action="{$link->getAdminLink('AdminOrders', true, [], ['vieworder' => 1, 'id_order' => $order->id|intval])|escape:'html':'UTF-8'}">
                <div class="form-group">
                  <div class="col-lg-9">
                    <select name="id_address">
                      {foreach from=$customer_addresses item=address}
                        <option value="{$address['id_address']|intval}"
                                {if $address['id_address'] == $order->id_address_invoice}
                          selected="selected"
                                {/if}>
                          {$address['alias']|escape:'html':'UTF-8'} -
                          {$address['address1']|escape:'html':'UTF-8'}
                          {$address['postcode']|escape:'html':'UTF-8'}
                          {$address['city']|escape:'html':'UTF-8'}
                          {if !empty($address['state'])}
                            {$address['state']|escape:'html':'UTF-8'}
                          {/if},
                          {$address['country']|escape:'html':'UTF-8'}
                        </option>
                      {/foreach}
                    </select>
                  </div>
                  <div class="col-lg-3">
                    <button class="btn btn-default" type="submit" name="submitAddressInvoice"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1639 1056q0 5-1 7-64 268-268 434.5t-478 166.5q-146 0-282.5-55t-243.5-157l-129 129q-19 19-45 19t-45-19-19-45v-448q0-26 19-45t45-19h448q26 0 45 19t19 45-19 45l-137 137q71 66 161 102t187 36q134 0 250-65t186-179q11-17 53-117 8-23 30-23h192q13 0 22.5 9.5t9.5 22.5zm25-800v448q0 26-19 45t-45 19h-448q-26 0-45-19t-19-45 19-45l138-138q-148-137-349-137-134 0-250 65t-186 179q-11 17-53 117-8 23-30 23h-199q-13 0-22.5-9.5t-9.5-22.5v-7q65-268 270-434.5t480-166.5q146 0 284 55.5t245 156.5l130-129q19-19 45-19t45 19 19 45z"/></svg> {l s='Change' mod='ets_marketplace'}</button>
                  </div>
                </div>
              </form>
            {/if}
            <div class="well">
              <div class="row">
                <div class="col-sm-12">
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
      </div>
      {/if}
    </div>
    {*start messages*}
    {if $ETS_MP_SELLER_MESSAGE_DISPLAYED && isset($ETS_MP_ENABLE_CONTACT_SHOP) && $ETS_MP_ENABLE_CONTACT_SHOP}
      <div class="panel">
        <div class="panel-heading">
          <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1504v-768q-32 36-69 66-268 206-426 338-51 43-83 67t-86.5 48.5-102.5 24.5h-2q-48 0-102.5-24.5t-86.5-48.5-83-67q-158-132-426-338-37-30-69-66v768q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm0-1051v-24.5l-.5-13-3-12.5-5.5-9-9-7.5-14-2.5h-1472q-13 0-22.5 9.5t-9.5 22.5q0 168 147 284 193 152 401 317 6 5 35 29.5t46 37.5 44.5 31.5 50.5 27.5 43 9h2q20 0 43-9t50.5-27.5 44.5-31.5 46-37.5 35-29.5q208-165 401-317 54-43 100.5-115.5t46.5-131.5zm128-37v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg> {l s='Messages' mod='ets_marketplace'} <span class="badge cicle">{sizeof($customer_thread_message)|escape:'html':'UTF-8'}</span>
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

                      <span class="message-date">&nbsp;<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h288v-288h-288v288zm352 0h320v-288h-320v288zm-352-352h288v-320h-288v320zm352 0h320v-320h-320v320zm-352-384h288v-288h-288v288zm736 736h320v-288h-320v288zm-384-736h320v-288h-320v288zm768 736h288v-288h-288v288zm-384-352h320v-320h-320v320zm-352-864v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm736 864h288v-320h-288v320zm-384-384h320v-288h-320v288zm384 0h288v-288h-288v288zm32-480v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
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
                    {$message['message']|nl2br nofilter}
                  </p>
                </div>
              {/foreach}
            </div>
          </div>
        {/if}
        <div id="messages" class="well hidden-print">
          <form action="" method="post">
            <div id="message" class="form-horizontal">
              <div class="form-group row">
                <label class="control-label col-lg-12">{l s='Message' mod='ets_marketplace'}</label>
                <div class="col-lg-12">
                  <textarea id="txt_msg" class="textarea-autosize" name="message">{if isset($smarty.post.message)}{$smarty.post.message|escape:'html':'UTF-8'}{/if}</textarea>
                  <p id="nbchars"></p>
                </div>
              </div>
              <input type="hidden" name="id_order" value="{$order->id|intval}" />
              <input type="hidden" name="id_customer" value="{$order->id_customer|escape:'html':'UTF-8'}" />
              <input type="hidden" name="submitMessage" value="1" />
              <button type="submit" id="submitMessage" class="btn btn-primary" name="submitMessage">
                {l s='Send message' mod='ets_marketplace'}
              </button>
            </div>
          </form>
        </div>
      </div>
    {/if}
    {*end nessage*}
  </div>
</div>
<div class="row" id="start_products">
  <div class="col-lg-12">
    <form class="container-command-top-spacing" action="" method="post" onsubmit="return orderDeleteProduct('{l s='This product cannot be returned.' mod='ets_marketplace'}', '{l s='Quantity to cancel is greater than available quantity.' mod='ets_marketplace'}');">
      <input type="hidden" name="id_order" value="{$order->id|intval}" />
      <div style="display: none">
        <input type="hidden" value="{$order->getWarehouseList()|implode|escape:'html':'UTF-8'}" id="warehouse_list" />
      </div>

      <div class="panel">
        <div class="panel-heading">
          <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1536q0 52-38 90t-90 38-90-38-38-90 38-90 90-38 90 38 38 90zm896 0q0 52-38 90t-90 38-90-38-38-90 38-90 90-38 90 38 38 90zm128-1088v512q0 24-16.5 42.5t-40.5 21.5l-1044 122q13 60 13 70 0 16-24 64h920q26 0 45 19t19 45-19 45-45 19h-1024q-26 0-45-19t-19-45q0-11 8-31.5t16-36 21.5-40 15.5-29.5l-177-823h-204q-26 0-45-19t-19-45 19-45 45-19h256q16 0 28.5 6.5t19.5 15.5 13 24.5 8 26 5.5 29.5 4.5 26h1201q26 0 45 19t19 45z"/></svg>
          {l s='Products' mod='ets_marketplace'} <span class="badge cicle">{$products|@count|intval}</span>
        </div>
        <div id="refundForm">
          <!--
            <a href="#" class="standard_refund"><img src="../img/admin/add.gif" alt="{l s='Process a standard refund' mod='ets_marketplace'}" /> {l s='Process a standard refund' mod='ets_marketplace'}</a>
            <a href="#" class="partial_refund"><img src="../img/admin/add.gif" alt="{l s='Process a partial refund' mod='ets_marketplace'}" /> {l s='Process a partial refund' mod='ets_marketplace'}</a>
          -->
        </div>

        {capture "TaxMethod"}
          {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
            {l s='Tax excluded' mod='ets_marketplace'}
          {else}
            {l s='Tax included' mod='ets_marketplace'}
          {/if}
        {/capture}
        {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
          <input type="hidden" name="TaxMethod" value="0">
        {else}
          <input type="hidden" name="TaxMethod" value="1">
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
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-768q-26 0-45 19t-19 45v128q0 26 19 45t45 19h768q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
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
              {if !$order->hasBeenDelivered()}
                <th></th>
              {/if}
            </tr>
            </thead>
            <tbody>
            {foreach from=$products item=product key=k}
              {* Include customized datas partial *}
              {include file='modules/ets_marketplace/views/templates/hook/orders/_customized_data.tpl'}
              {* Include product line partial *}
              {include file='modules/ets_marketplace/views/templates/hook/orders/_product_line.tpl'}
            {/foreach}
            {if $can_edit}
              {include file='modules/ets_marketplace/views/templates/hook/orders/_new_product.tpl'}
            {/if}
            </tbody>
          </table>
        </div>

        {if $can_edit}
          <div class="row-margin-bottom row-margin-top order_action">
            {if !$order->hasBeenDelivered()}
              <button type="button" id="add_product" class="btn btn-default">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-256v-256q0-26-19-45t-45-19h-128q-26 0-45 19t-19 45v256h-256q-26 0-45 19t-19 45v128q0 26 19 45t45 19h256v256q0 26 19 45t45 19h128q26 0 45-19t19-45v-256h256q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                {l s='Add a product' mod='ets_marketplace'}
              </button>
            {/if}
            <button id="add_voucher" class="btn btn-default" type="button" >
              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 452l316 316-572 572-316-316zm-211 979l618-618q19-19 19-45t-19-45l-362-362q-18-18-45-18t-45 18l-618 618q-19 19-19 45t19 45l362 362q18 18 45 18t45-18zm889-637l-907 908q-37 37-90.5 37t-90.5-37l-126-126q56-56 56-136t-56-136-136-56-136 56l-125-126q-37-37-37-90.5t37-90.5l907-906q37-37 90.5-37t90.5 37l125 125q-56 56-56 136t56 136 136 56 136-56l126 125q37 37 37 90.5t-37 90.5z"/></svg>
              {l s='Add a new discount' mod='ets_marketplace'}
            </button>
          </div>
        {/if}
        <div class="clear">&nbsp;</div>
        <div class="row">
          <div class="col-xs-6">
            <div class="alert alert-warning">
              <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg>
              {l s='For this customer group, prices are displayed as:' mod='ets_marketplace'}
              <strong>{$smarty.capture.TaxMethod|escape:'html':'UTF-8'}</strong>
              {if !Configuration::get('PS_ORDER_RETURN')}
                <br/><strong>{l s='Merchandise returns are disabled' mod='ets_marketplace'}</strong>
              {/if}
            </div>
          </div>
          <div class="col-xs-6">
            <div class="panel panel-vouchers" style="{if !sizeof($discounts)}display:none;{/if}">
              {if (sizeof($discounts) || $can_edit)}
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
                      {if $can_edit}
                        <th></th>
                      {/if}
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
                          {displayPrice price=$discount['value'] currency=$mp_currency->id}
                        </td>
                        {if $can_edit}
                          <td>
                            <a href="">
                              <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-768q-26 0-45 19t-19 45v128q0 26 19 45t45 19h768q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                              {l s='Delete voucher' mod='ets_marketplace'}
                            </a>
                          </td>
                        {/if}
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
            <div class="panel-total front_total_info">
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
                    <td class="text-right">{l s='Products:' mod='ets_marketplace'}</td>
                    <td class="amount text-right nowrap">
                      {displayPrice price=$order_product_price currency=$mp_currency->id}
                    </td>
                    <td class="partial_refund_fields current-edit" style="display:none;"></td>
                  </tr>
                  <tr id="total_discounts" {if $order->total_discounts_tax_incl == 0}style="display: none;"{/if}>
                    <td class="text-right">{l s='Discounts' mod='ets_marketplace'}</td>
                    <td class="amount text-right nowrap">
                      -{displayPrice price=$order_discount_price currency=$mp_currency->id}
                    </td>
                    <td class="partial_refund_fields current-edit" style="display:none;"></td>
                  </tr>
                  <tr id="total_wrapping" {if $order->total_wrapping_tax_incl == 0}style="display: none;"{/if}>
                    <td class="text-right">{l s='Wrapping' mod='ets_marketplace'}</td>
                    <td class="amount text-right nowrap">
                      {displayPrice price=$order_wrapping_price currency=$mp_currency->id}
                    </td>
                    <td class="partial_refund_fields current-edit" style="display:none;"></td>
                  </tr>
                  <tr id="total_shipping">
                    <td class="text-right">{l s='Shipping' mod='ets_marketplace'}</td>
                    <td class="amount text-right nowrap" >
                      {displayPrice price=$order_shipping_price currency=$mp_currency->id}
                    </td>
                    <td class="partial_refund_fields current-edit" style="display:none;">
                      <div class="input-group">
                        <div class="input-group-addon">
                          {$mp_currency->sign|escape:'html':'UTF-8'}
                        </div>
                        <input type="text" name="partialRefundShippingCost" value="0" />
                      </div>
                      <p class="help-block"><svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {l
                        s='(Max %s %s)'
                        sprintf=[Ets_marketplace::displayPrice(Tools::ps_round($shipping_refundable, 2), $mp_currency->id) , $smarty.capture.TaxMethod]
                        mod='ets_marketplace'
                        }
                      </p>
                    </td>
                  </tr>
                  {if ($order->getTaxCalculationMethod() == $smarty.const.PS_TAX_EXC)}
                    <tr id="total_taxes">
                      <td class="text-right">{l s='Taxes' mod='ets_marketplace'}</td>
                      <td class="amount text-right nowrap" >{displayPrice price=($order->total_paid_tax_incl-$order->total_paid_tax_excl) currency=$mp_currency->id}</td>
                      <td class="partial_refund_fields current-edit" style="display:none;"></td>
                    </tr>
                  {/if}
                  {assign var=order_total_price value=$order->total_paid_tax_incl}
                  <tr id="total_order">
                    <td class="text-right"><strong>{l s='Total' mod='ets_marketplace'}</strong></td>
                    <td class="amount text-right nowrap">
                      <strong>{displayPrice price=$order_total_price currency=$mp_currency->id}</strong>
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
                      {$mp_currency->sign|escape:'html':'UTF-8'}
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
                  {$mp_currency->sign|escape:'html':'UTF-8'}
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