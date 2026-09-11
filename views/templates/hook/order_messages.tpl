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
<div id="ets_mp_order_messages_page">
    <div class="panel">
        <div class="panel-heading">
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1504v-768q-32 36-69 66-268 206-426 338-51 43-83 67t-86.5 48.5-102.5 24.5h-2q-48 0-102.5-24.5t-86.5-48.5-83-67q-158-132-426-338-37-30-69-66v768q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm0-1051v-24.5l-.5-13-3-12.5-5.5-9-9-7.5-14-2.5h-1472q-13 0-22.5 9.5t-9.5 22.5q0 168 147 284 193 152 401 317 6 5 35 29.5t46 37.5 44.5 31.5 50.5 27.5 43 9h2q20 0 43-9t50.5-27.5 44.5-31.5 46-37.5 35-29.5q208-165 401-317 54-43 100.5-115.5t46.5-131.5zm128-37v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg> {l s='Messages' mod='ets_marketplace'} <span class="badge cicle">{sizeof($customer_thread_message)|escape:'html':'UTF-8'}</span>
        </div>
        <div class="panel order-detail">
            <p><strong>{l s='Order reference' mod='ets_marketplace'}</strong>: <a class=" " href="{$link->getModuleLink('ets_marketplace','orders',['id_order'=>$order->id|intval])}">{$order->reference|escape:'html':'UTF-8'}</a></p>
            <p><strong>{l s='Customer name' mod='ets_marketplace'}</strong>: {$ets_mp_customer->firstname|escape:'html':'UTF-8'} {$ets_mp_customer->lastname|escape:'html':'UTF-8'}</p>
            {if Configuration::get('ETS_MP_DISPLAY_CUSTOMER_EMAIL')}
                <p><strong>{l s='Customer email' mod='ets_marketplace'}</strong>: {$ets_mp_customer->email|escape:'html':'UTF-8'}</p>
            {/if}
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
                        {dateFormat date=$message['date_add'] full=1} -
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
        <div id="messages" class="">
          <form action="" method="post">
            <div id="message" class="form-horizontal">
              <div class="form-group row">
                <label class="control-label col-lg-12">{l s='Message' mod='ets_marketplace'}</label>
                <div class="col-lg-12">
                  <textarea id="txt_msg" class="textarea-autosize" name="message" placeholder="{l s='Write a message to customer' mod='ets_marketplace'}">{if $_errors && isset($smarty.post.message)}{$smarty.post.message|escape:'html':'UTF-8'}{/if}</textarea>
                  <p id="nbchars"></p>
                </div>
              </div>
              <input type="hidden" name="id_order" value="{$order->id|intval}" />
              <input type="hidden" name="id_customer" value="{$order->id_customer|intval}" />
              <input type="hidden" name="submitMessage" value="1" />
              <a href="{$link->getModuleLink('ets_marketplace','messages')|escape:'html':'UTF-8'}" class="ets_cancel_message btn btn-default float-xs-left">
                {l s='Back to messages' mod='ets_marketplace'}
              </a>
              <button type="submit" id="submitMessage" class="ets_submit_message btn btn-primary float-xs-right" name="submitMessage">
                {l s='Send message' mod='ets_marketplace'}
              </button>
                <div class="clearfix"></div>
            </div>
          </form>
        </div>
    </div>
</div>