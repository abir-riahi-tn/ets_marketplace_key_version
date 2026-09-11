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
<table class="table">
<thead>
    <tr>
        <th class="text-center">{l s='ID' mod='ets_marketplace'}</th>
        <th>{l s='Seller name' mod='ets_marketplace'}</th>    
        <th>{l s='Shop name' mod='ets_marketplace'}</th>
        <th class="text-center">{l s='Order ID' mod='ets_marketplace'}</th>
        <th>{l s='Product name' mod='ets_marketplace'}</th>
        <th class="text-center">{l s='Product price' mod='ets_marketplace'}</th>
        <th class="text-center">{l s='Product quantity' mod='ets_marketplace'}</th>
        <th class="text-center">{l s='Commission' mod='ets_marketplace'}</th>
        <th>{l s='Status' mod='ets_marketplace'}</th>
        <th>{l s='Date' mod='ets_marketplace'}</th>
        <th>{l s='Action' mod='ets_marketplace'}</th>
    </tr>
</thead>
<tbody>
    {if $latest_seller_commissions}
        {foreach from=$latest_seller_commissions item='commission'}
            <tr>
                <td class="text-center"> {$commission.id_seller_commission|intval}</td>
                <td class="seller_name">
                    {if $commission.id_customer_seller}
                        <a href="{$module->getLinkCustomerAdmin($commission.id_customer_seller)|escape:'html':'UTF-8'}&viewseller=1&id_seller={$commission.id_seller|intval}">{$commission.seller_name|escape:'html':'UTF-8'}</a>
                    {else}
                        <span class="row_deleted">{l s='Seller deleted' mod='ets_marketplace'}</span>
                    {/if}
                </td>
                <td class="shop_name">
                    {if $commission.id_seller}
                        <a href="{$module->getShopLink(['id_seller'=>$commission.id_seller])|escape:'html':'UTF-8'}">{$commission.shop_name|escape:'html':'UTF-8'}</a>
                    {else}
                        <span class="deleted_shop row_deleted">{l s='Shop deleted' mod='ets_marketplace'}</span>
                    {/if}
                </td>
                <td class="text-center">{if $commission.id_order}{$commission.id_order|escape:'html':'UTF-8'}{else}--{/if}</td>
                <td>{if $commission.product_name}{$commission.product_name nofilter}{else}--{/if}</td>
                <td class="text-center">{if $commission.price_tax_incl!=0}{displayPrice price=$commission.price_tax_incl}{else}--{/if}</td>
                <td class="text-center">{if $commission.quantity}{$commission.quantity|escape:'html':'UTF-8'}{else}--{/if}</td>
                <td class="text-center">{if $commission.commission}{displayPrice price=$commission.commission}{else}--{/if}</td>
                <td>
                    {if $commission.status==-1}
                        <span class="ets_mp_status pending">{l s='Pending' mod='ets_marketplace'}</span>
                    {/if}
                    {if $commission.status==0}
                        <span class="ets_mp_status canceled">{l s='Canceled' mod='ets_marketplace'}</span>
                    {/if}
                    {if $commission.status==1}
                        <span class="ets_mp_status approved">{l s='Approved' mod='ets_marketplace'}</span>
                    {/if}
                </td>
                <td>{dateFormat date=$commission.date_add full=1}</td>
                <td>
                    <a class="btn btn-default" href="{$link->getAdminLink('AdminMarketPlaceSellers')|escape:'html':'UTF-8'}&viewseller=1&id_seller={$commission.id_seller|intval}">
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1088 800v64q0 13-9.5 22.5t-22.5 9.5h-224v224q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-224h-224q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h224v-224q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5v224h224q13 0 22.5 9.5t9.5 22.5zm128 32q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 53-37.5 90.5t-90.5 37.5q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg>
                        {l s='View' mod='ets_marketplace'}
                    </a>
                </td>
            </tr>
        {/foreach}
    {else}
        <tr>
            <td colspan="100%" class="text-center">{l s='No data' mod='ets_marketplace'}</td>
        </tr>
    {/if}
</tbody>
</table>