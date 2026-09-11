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
{if $sellers}
    {foreach from=$sellers item='seller'}
        <li class="seller-miniature">
            <div class="thumbnail-container">
                {if $seller.shop_logo}
                    <a class="thumbnail seller-thumbnail" href="{$seller.link|escape:'html':'UTF-8'}" tabindex="0">
                        <img style="width:250px" src="{$link->getMediaLink("`$smarty.const.__PS_BASE_URI__`img/mp_seller/`$seller.shop_logo|escape:'html':'UTF-8'`")}" alt="{$seller.shop_name|escape:'html':'UTF-8'}" />
                    </a>
                {/if}
                <div class="seller-description">
                    <h3 class="h3 seller-name"><a href="{$seller.link|escape:'html':'UTF-8'}">{$seller.shop_name|escape:'html':'UTF-8'}</a></h3>
                    <div class="product">
                        <div class="number-product">
                            {$seller.total_product|intval} {if $seller.total_product>1}{l s='products' mod='ets_marketplace'}{else}{l s='product' mod='ets_marketplace'}{/if}
                        </div>
                        {if isset($seller.avg_rate) && $seller.avg_rate}
                            <div class="ets_review">
                                    {for $foo=1 to $seller.avg_rate_int}
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"/></svg>
                                    {/for}
                                    {if $seller.avg_rate_int < $seller.avg_rate}
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1250 957l257-250-356-52-66-10-30-60-159-322v963l59 31 318 168-60-355-12-66zm452-262l-363 354 86 500q5 33-6 51.5t-34 18.5q-17 0-40-12l-449-236-449 236q-23 12-40 12-23 0-34-18.5t-6-51.5l86-500-364-354q-32-32-23-59.5t54-34.5l502-73 225-455q20-41 49-41 28 0 49 41l225 455 502 73q45 7 54 34.5t-24 59.5z"/></svg>
                                        {for $foo= $seller.avg_rate_int+2 to 5}
                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1201 1004l306-297-422-62-189-382-189 382-422 62 306 297-73 421 378-199 377 199zm527-357q0 22-26 48l-363 354 86 500q1 7 1 20 0 50-41 50-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"/></svg>
                                        {/for}
                                    {else}
                                        {for $foo= $seller.avg_rate_int+1 to 5}
                                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1201 1004l306-297-422-62-189-382-189 382-422 62 306 297-73 421 378-199 377 199zm527-357q0 22-26 48l-363 354 86 500q1 7 1 20 0 50-41 50-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"/></svg>
                                        {/for}
                                    {/if}
                                    <span class="total_review">({$seller.count_grade|intval})</span>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </li>
    {/foreach}
{else}
    <div class="alert alert-warning"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {l s='No shops available' mod='ets_marketplace'}</div>
{/if}