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
            <th class="text-center"> {l s='Quantity' mod='ets_marketplace'}</th>
            <th class="text-center"> {l s='Commission' mod='ets_marketplace'}</th>
            <th class="text-center">{l s='Active' mod='ets_marketplace'}</th>
            <th>{l s='Added date' mod='ets_marketplace'}</th>
        </tr>
    </thead>
    <tbody>
        {if $products}
            {foreach from=$products item='product'}
                <tr>
                    <td class="text-center">{$product.id_product|intval}</td>
                    <td class="text-center">{$product.image nofilter}</td>
                    <td>{$product.name nofilter}</td>
                    <td class="text-center">{$product.price|escape:'html':'UTF-8'}</td>
                    <td class="text-center">{$product.quantity_sale|intval}</td>
                    <td class="text-center">{$product.commission|escape:'html':'UTF-8'}</td>
                    <td class="text-center">
                        {if $product.active}
                            <a title="{l s='Active' mod='ets_marketplace'}">
                                <svg style="fill: #00c800!important;" width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>
                            </a>
                        {else}
                            <a title="{l s='Disabled' mod='ets_marketplace'}">
                                <svg style="fill: red!important;" width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                            </a>
                        {/if}
                    </td>
                    <td>{dateFormat date=$product.date_add full=1}</td>
                </tr>
            {/foreach}
        {else}
        <tr>
            <td colspan="100%">{l s='No data' mod='ets_marketplace'}</td>
        </tr>
        {/if}
    </tbody>
</table>