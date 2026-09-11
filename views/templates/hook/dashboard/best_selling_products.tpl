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
            <th class="text-center">{l s='Image' mod='ets_marketplace'}</th>
            <th>{l s='Product name' mod='ets_marketplace'}</th>
            <th class="text-center">{l s='Price' mod='ets_marketplace'}</th>
            <th class="text-center"> {l s='Sold quantity' mod='ets_marketplace'}</th>
            <th>{l s='Seller name' mod='ets_marketplace'}</th>
            <th class="text-center">{l s='Active' mod='ets_marketplace'}</th>
            <th>{l s='Added date' mod='ets_marketplace'}</th>
            <th>{l s='Action' mod='ets_marketplace'}</th>
        </tr>
    </thead>
    <tbody>
        {if $products}
            {foreach from=$products item='product'}
                <tr>
                    <td class="text-center">{if $product.id_product}{$product.id_product|intval}{else}--{/if}</td>
                    <td class="text-center">{if $product.image}{$product.image nofilter}{else}--{/if}</td>
                    <td>{if $product.name}{$product.name nofilter}{else}--{/if}</td>
                    <td class="text-center">{if $product.price}{$product.price|escape:'html':'UTF-8'}{else}--{/if}</td>
                    <td class="text-center">{if $product.quantity_sale}{$product.quantity_sale|intval}{else}--{/if}</td>
                    <td class="seller_name">
                        {if $product.id_customer_seller}
                            <a href="{$module->getLinkCustomerAdmin($product.id_customer_seller)|escape:'html':'UTF-8'}&viewseller=1&id_seller={$product.id_seller|intval}">{$product.seller_name|escape:'html':'UTF-8'}</a>
                        {else}
                            <span class="row_deleted">{l s='Seller deleted' mod='ets_marketplace'}</span>
                        {/if}
                    </td> 
                    <td class="text-center">
                        {if $product.active}
                            <i class="check" title="{l s='Active' mod='ets_marketplace'}">
                                <svg width="14" height="14" style="fill:#00d200!important;" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>
                            </i>
                        {else}
                            <i class="remove" title="{l s='Disabled' mod='ets_marketplace'}"><svg width="14" height="14" style="fill:red!important;" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg></i>
                        {/if} 
                    </td>
                    <td>{dateFormat date=$product.date_add full=1}</td>
                    <td>
                        <a class="btn btn-default" href="{$product.link|escape:'html':'UTF-8'}">
                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1088 800v64q0 13-9.5 22.5t-22.5 9.5h-224v224q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-224h-224q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h224v-224q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5v224h224q13 0 22.5 9.5t9.5 22.5zm128 32q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 53-37.5 90.5t-90.5 37.5q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg>
                            {l s='View' mod='ets_marketplace'}
                        </a>
                    </td>
                </tr>
            {/foreach}
        {else}
        <tr>
            <td colspan="100%" class="text-center no_data">{l s='No data' mod='ets_marketplace'}</td>
        </tr>
        {/if}
    </tbody>
</table>