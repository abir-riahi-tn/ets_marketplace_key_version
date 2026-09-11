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
<div id="js-shop-list-top" class="row shop-selection">
    <div class="col-xs-12">
        <h4>{l s='Shops' mod='ets_marketplace'}</h4>
    </div>
    {if isset($ETS_MP_ENABLE_MAP) && $ETS_MP_ENABLE_MAP && Ets_mp_seller::getMaps(false,true)}
        <div class="ets_mp_maps">
            <a class="view_maps" href="{$link->getModuleLink('ets_marketplace','map')|escape:'html':'UTF-8'}">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 640q0-106-75-181t-181-75-181 75-75 181 75 181 181 75 181-75 75-181zm256 0q0 109-33 179l-364 774q-16 33-47.5 52t-67.5 19-67.5-19-46.5-52l-365-774q-33-70-33-179 0-212 150-362t362-150 362 150 150 362z"/></svg> {l s='View maps' mod='ets_marketplace'}
            </a>
        </div>
    {/if}
    <div class="shop-list-top-box">
        <div class="ets_mp_shops_info">
            <div class="block-search">
                <label for="search_by_shop_name" >
                    {l s='Search:' mod='ets_marketplace'}
                </label>
                <div class="col_search col_search_shop_name">
                    <input class="form-control" name="search_by_shop_name" id="search_by_shop_name" placeholder="{l s='Search by shop name' mod='ets_marketplace'}"/>
                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1216 832q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 52-38 90t-90 38q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg>
                </div>
            </div>
        </div>
        <div class="col_shop_category">
            {if $shop_categories}
                <div class="col_search_shop_category">
                    <label for="search_id_shop_category">
                        {l s='Shop category:' mod='ets_marketplace'}
                    </label>
                    <select id="search_id_shop_category" name="search_id_shop_category" class="form-control">
                        <option value="">{l s='All shops' mod='ets_marketplace'}</option>
                        {foreach from=$shop_categories item='shop_category'}
                            <option value="{$shop_category.id_ets_mp_shop_category|intval}">{$shop_category.name|escape:'html':'UTF-8'}</option>
                        {/foreach}
                    </select>
                </div>
            {/if}
        </div>
        <div class="col_sortby">
            <div class="sort-by-row">
                <label class="sort-by">{l s='Sort by:' mod='ets_marketplace'}</label>
                <div class="products-sort-order dropdown">
                    <select class="ets_mp_sort_by_shop_list">
                        <option value="sale.desc">{l s='Popular' mod='ets_marketplace'}</option>
                        {if Module::isEnabled('ets_reviews') || Module::isEnabled('productcomments')}
                            <option value="rate.desc">{l s='Rating' mod='ets_marketplace'}</option>
                        {/if}
                        <option value="quantity.desc">{l s='Product quantity' mod='ets_marketplace'}</option>
                        <option value="name.asc">{l s='Name, A to Z' mod='ets_marketplace'}</option>
                        <option value="name.desc">{l s='Name, Z to A' mod='ets_marketplace'}</option>
                        <option value="date_add.desc">{l s='Newest' mod='ets_marketplace'}</option>
                        <option value="date_add.asc">{l s='Oldest' mod='ets_marketplace'}</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>
<ul class="ets_mp_list_seller">
    {$shop_list nofilter}
</ul>
<div class="paggination ets_mp_paggination_seller" >
    {$paggination nofilter}
</div>
