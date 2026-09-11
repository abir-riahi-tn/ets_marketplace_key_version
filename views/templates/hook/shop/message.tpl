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
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1792 710v794q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-794q44 49 101 87 362 246 497 345 57 42 92.5 65.5t94.5 48 110 24.5h2q51 0 110-24.5t94.5-48 92.5-65.5q170-123 498-345 57-39 100-87zm0-294q0 79-49 151t-122 123q-376 261-468 325-10 7-42.5 30.5t-54 38-52 32.5-57.5 27-50 9h-2q-23 0-50-9t-57.5-27-52-32.5-54-38-42.5-30.5q-91-64-262-182.5t-205-142.5q-62-42-117-115.5t-55-136.5q0-78 41.5-130t118.5-52h1472q65 0 112.5 47t47.5 113z"/></svg> {l s='Messages' mod='ets_marketplace'} <span class="badge cicle">{sizeof($messages)|escape:'html':'UTF-8'}</span>
        </div>
        <div class="panel order-detail">
            {if $contact->name}
                <p><strong>{l s='Name' mod='ets_marketplace'}</strong>: {$contact->name|escape:'html':'UTF-8'}</p>
            {/if}
            {if Configuration::get('ETS_MP_DISPLAY_CUSTOMER_EMAIL') &&  $contact->email}
                <p><strong>{l s='Email' mod='ets_marketplace'}</strong>: {$contact->email|escape:'html':'UTF-8'}</p>
            {/if}
            {if $contact->phone}
                <p><strong>{l s='Phone' mod='ets_marketplace'}</strong>: {$contact->phone|escape:'html':'UTF-8'}</p>
            {/if}
            {if $contact->id_product}
                <p><strong>{l s='Product' mod='ets_marketplace'}</strong>: {if $link_image}&nbsp;<a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" target="_blank"><img src="{$link_image|escape:'html':'UTF-8'}"/></a>&nbsp;{/if}<a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" target="_blank">{$product->name|escape:'html':'UTF-8'}</a></p>
            {/if}
            <p><strong>{l s='Title' mod='ets_marketplace'}</strong>: {$contact->getTitle()|escape:'html':'UTF-8'}</p>
            {if $contact->attachment}
                <p><strong>{l s='Attachment' mod='ets_marketplace'}</strong>: <a href="{$link->getModuleLink('ets_marketplace',$smarty.get.controller,['id_contact'=>$contact->id,'downloadfile'=>1])|escape:'html':'UTF-8'}" target="_blank">{if $contact->attachment_name}{$contact->attachment_name|escape:'html':'UTF-8'}{else}{$contact->attachment|escape:'html':'UTF-8'}{/if}</a> </p>
            {/if}
            <p><strong>{l s='Message' mod='ets_marketplace'}</strong>: <br />{$contact->message|nl2br nofilter}</p>
            {if $contact->id_order}
                <p><strong>{l s='Order reference' mod='ets_marketplace'}</strong>: <a class="" href="{if $contact->id && !isset($seller_page)}{$link->getPageLink('order-detail',null,null,['id_order'=>$contact->id_order])|escape:'html':'UTF-8'}{else}{$link->getModuleLink('ets_marketplace','orders',['id_order'=>$order_message->id|intval])}{/if}">{$order_message->reference|escape:'html':'UTF-8'}</a></p>
            {/if}
        </div>
        <br />
        {if (sizeof($messages))}
          <div class="panel panel-highlighted">
            <div class="message-item">
              {foreach from=$messages item=message}
                <div class="message-avatar">
                  <div class="avatar-md">
                      <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1536 1399q0 109-62.5 187t-150.5 78h-854q-88 0-150.5-78t-62.5-187q0-85 8.5-160.5t31.5-152 58.5-131 94-89 134.5-34.5q131 128 313 128t313-128q76 0 134.5 34.5t94 89 58.5 131 31.5 152 8.5 160.5zm-256-887q0 159-112.5 271.5t-271.5 112.5-271.5-112.5-112.5-271.5 112.5-271.5 271.5-112.5 271.5 112.5 112.5 271.5z"/></svg>
                  </div>
                </div>
                <div class="message-body">
                      <span class="message-date">&nbsp;<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h288v-288h-288v288zm352 0h320v-288h-320v288zm-352-352h288v-320h-288v320zm352 0h320v-320h-320v320zm-352-384h288v-288h-288v288zm736 736h320v-288h-320v288zm-384-736h320v-288h-320v288zm768 736h288v-288h-288v288zm-384-352h320v-320h-320v320zm-352-864v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm736 864h288v-320h-288v320zm-384-384h320v-288h-320v288zm384 0h288v-288h-288v288zm32-480v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                        {dateFormat date=$message['date_add']} -
                      </span>
                  <h4 class="message-item-heading">
                    {if $message.id_customer}
                        {$message.customer_name|escape:'html':'UTF-8'}
                    {/if}
                    {if $message.id_employee}
                        {$message.employee_name|escape:'html':'UTF-8'} ({l s='admin' mod='ets_marketplace'})
                    {/if}
                    {if $message.id_manager}
                        {$message.manager_name|escape:'html':'UTF-8'} ({l s='manager' mod='ets_marketplace'})
                    {elseif $message.id_seller}
                        {$message.seller_name|escape:'html':'UTF-8'} ({l s='seller' mod='ets_marketplace'})
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
                    <input type="hidden" name="id_contact" value="{$contact->id|intval}" />
                    <input type="hidden" name="submitMessage" value="1" />
                    <a href="{$link->getModuleLink('ets_marketplace',$smarty.get.controller)|escape:'html':'UTF-8'}" class="ets_cancel_message btn btn-default float-xs-left">
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