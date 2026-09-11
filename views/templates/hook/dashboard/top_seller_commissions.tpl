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
            <th>{l s='Seller email' mod='ets_marketplace'}</th>
            <th>{l s='Shop name' mod='ets_marketplace'}</th>
            <th>{l s='Shop description' mod='ets_marketplace'}</th>
            <th class="text-center">{l s='Total commission' mod='ets_marketplace'}</th>
            <th>{l s='Action' mod='ets_marketplace'}</th>
        </tr>
    </thead>
    <tbody>
        {if $sellers}
            {foreach from=$sellers item='seller'}
                <tr>
                    <td class="text-center">{if $seller.id_seller}{$seller.id_seller|intval}{else}--{/if}</td>
                    <td>{if $seller.seller_name}<a href="{$link->getAdminLink('AdminMarketPlaceSellers')|escape:'html':'UTF-8'}&viewseller=1&id_seller={$seller.id_seller|intval}">{$seller.seller_name|escape:'html':'UTF-8'}</a>{else}--{/if}</td>
                    <td>{if $seller.seller_email}{$seller.seller_email|escape:'html':'UTF-8'}{else}--{/if}</td>
                    <td>{if $seller.shop_name}{$seller.shop_name|escape:'html':'UTF-8'}{else}--{/if}</td>
                    <td>{if $seller.shop_description}{$seller.shop_description|strip_tags:'UTF-8'|truncate:120:'...'|escape:'html':'UTF-8'}{else}--{/if}</td>
                    <td class="text-center">{if $seller.shop_description}{displayPrice price=$seller.total_commission}{else}--{/if}</td>
                    <td>
                        <a class="btn btn-default" href="{$link->getAdminLink('AdminMarketPlaceSellers')|escape:'html':'UTF-8'}&viewseller=1&id_seller={$seller.id_seller|intval}">
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