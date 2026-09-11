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
{if isset($load_more) && $load_more}
    {if $products}
        {if $is17}
            {foreach from=$products item="product"}
                  {include file="catalog/_partials/miniatures/product.tpl" product=$product position=""}
            {/foreach}
        {else}
            {include file="$tpl_dir./product-list.tpl" class="product_list grid row products" id="product_page_seller"}
        {/if}
    {/if}
{else}
    <input type="hidden" value="{$current_page|intval}" class="ets_mp_current_tab"/>
    <section class="products">
        <div>
            <div id="js-product-list-top" class="row products-selection js-product-list-top">
                <input type="hidden" name="idCategories" value="{$idCategories|escape:'html':'UTF-8'}" />
            </div>
            <div class="ets_mp_search_product" style="display:none;">
                {if $products || $product_name || $products}
                    {if $products || $product_name}
                        {if $current_tab=='all'}
                            <div class="block-search">
                                <span class="col_search_icon"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1216 832q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 52-38 90t-90 38q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg></span>
                                <div class="col_search">
                                    {if $product_name}
                                        <button name="reset_product_name" class="reset_product_name" title="{l s='Reset' mod='ets_marketplace'}"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 896q0 156-61 298t-164 245-245 164-298 61q-172 0-327-72.5t-264-204.5q-7-10-6.5-22.5t8.5-20.5l137-138q10-9 25-9 16 2 23 12 73 95 179 147t225 52q104 0 198.5-40.5t163.5-109.5 109.5-163.5 40.5-198.5-40.5-198.5-109.5-163.5-163.5-109.5-198.5-40.5q-98 0-188 35.5t-160 101.5l137 138q31 30 14 69-17 40-59 40h-448q-26 0-45-19t-19-45v-448q0-42 40-59 39-17 69 14l130 129q107-101 244.5-156.5t284.5-55.5q156 0 298 61t245 164 164 245 61 298z"/></svg></button>
                                    {/if}
                                    <input style="text" name="product_search" value="{$product_name|escape:'html':'UTF-8'}" placeholder="{l s='Search' mod='ets_marketplace'}" />
                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1216 832q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 52-38 90t-90 38q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg>
                                </div>
                            </div>
                        {/if}
                    {/if}
                    {if $products }
                        <div class="col_sortby sort-by-row">
                            <div class="products-sort-order dropdown">
                                <span class="sort-by">{l s='Sort by:' mod='ets_marketplace'}</span>
                                <ul class="ets_mp_sort_by_dropdown_ul">
                                    <li data-value="position.asc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='position.asc'} selected="selected"{/if}>{l s='Relevance' mod='ets_marketplace'}</li>
                                    <li data-value="name.asc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='name.asc'} selected="selected"{/if}>{l s='Name, A to Z' mod='ets_marketplace'}</li>
                                    <li data-value="name.desc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='name.desc'} selected="selected"{/if}>{l s='Name, Z to A' mod='ets_marketplace'}</li>
                                    <li data-value="price.asc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='price.asc'} selected="selected"{/if}>{l s='Price, low to high' mod='ets_marketplace'}</li>
                                    <li data-value="price.desc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='price.desc'} selected="selected"{/if}>{l s='Price, high to low' mod='ets_marketplace'}</li>
                                    <li data-value="new_product" {if isset($smarty.post.order_by) && $smarty.post.order_by=='new_product'} selected="selected"{/if}>{l s='New products' mod='ets_marketplace'}</li>
                                    <li data-value="best_sale" {if isset($smarty.post.order_by) && $smarty.post.order_by=='best_sale'} selected="selected"{/if}>{l s='Best sellers' mod='ets_marketplace'}</li>
                                </ul>
                                <select class="ets_mp_sort_by_product_list">
                                    <option value="position.asc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='position.asc'} selected="selected"{/if}>{l s='Relevance' mod='ets_marketplace'}</option>
                                    <option value="name.asc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='name.asc'} selected="selected"{/if}>{l s='Name, A to Z' mod='ets_marketplace'}</option>
                                    <option value="name.desc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='name.desc'} selected="selected"{/if}>{l s='Name, Z to A' mod='ets_marketplace'}</option>
                                    <option value="price.asc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='price.asc'} selected="selected"{/if}>{l s='Price, low to high' mod='ets_marketplace'}</option>
                                    <option value="price.desc" {if isset($smarty.post.order_by) && $smarty.post.order_by=='price.desc'} selected="selected"{/if}>{l s='Price, high to low' mod='ets_marketplace'}</option>
                                    <option value="new_product" {if isset($smarty.post.order_by) && $smarty.post.order_by=='new_product'} selected="selected"{/if}>{l s='New products' mod='ets_marketplace'}</option>
                                    <option value="best_sale" {if isset($smarty.post.order_by) && $smarty.post.order_by=='best_sale'} selected="selected"{/if}>{l s='Best sellers' mod='ets_marketplace'}</option>
                                </select>
                            </div>
                        </div>
                    {/if}
                {/if}
            </div>
        </div>
        <div>
            <div class="js-product-list {count($products)|intval}">
                <div class="products row">
                    {if $products}
                        {if $is17}
                            {foreach from=$products item="product"}
                                  {include file="catalog/_partials/miniatures/product.tpl" product=$product position=""}
                            {/foreach}
                        {else}
                            {include file="$tpl_dir./product-list.tpl" class="product_list grid row products" id="product_page_seller"}
                        {/if}
                    {else}
                        <div class="clearfix"></div>
                        <span class="alert alert-warning"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {l s='No products available' mod='ets_marketplace'}</span>
                    {/if}
                </div>
                {if Configuration::get('ETS_MP_ENABLE_LOAD_MORE')}
                    {if $link_load_more}
                        <a id="ets_mp_load_more" class="ets_mp_load_more" href="{$link_load_more|escape:'html':'UTF-8'}">{l s='Load more' mod='ets_marketplace'}</a>
                    {/if}
                {else}
                    {if $paggination}
                        <div class="paggination">
                            {$paggination nofilter}
                        </div>
                    {/if}
                {/if}
                
            </div>
        </div>
    </section>
{/if}