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
<div class="form-group">
    <div class="col-lg-12">
        <h2 class="ets_mb_5">{l s='Price' mod='ets_marketplace'}</h2>
    </div>
    <div class="col-lg-12 form-group ets-mp-input-groups">
        <div class="row">
            <div class="col-lg-6 from-group">
                <label class="form-control-label" for="">{l s='Price (tax excl.)' mod='ets_marketplace'} </label>
                <div>
                    <div class="input-group">
                        <input id="price_excl2" autocomplete="off" name="" value="{$valueFieldPost.price_excl|escape:'html':'UTF-8'}" type="text" />
                        <div class="input-group-append">
                            <span class="input-group-text">{$currency_default->sign|escape:'html':'UTF-8'}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 from-group">
                <label class="form-control-label" for="">{l s='Price (tax incl.)' mod='ets_marketplace'}</label>
                <div>
                    <div class="input-group">
                        <input id="price_incl2" autocomplete="off" name="price_incl" value="{$valueFieldPost.price_incl|escape:'html':'UTF-8'}" type="text" />
                            <div class="input-group-append">
                                <span class="input-group-text">{$currency_default->sign|escape:'html':'UTF-8'}</span>
                            </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 from-group">
                <label class="form-control-label" for="">{l s='Tax rule' mod='ets_marketplace'}</label>
                <div>
                    <select name="id_tax_rules_group2">
                        {foreach from =$tax_rules_groups item='tax_rules_group'}
                            <option value="{$tax_rules_group.id_tax_rules_group|intval}"{if $tax_rules_group.id_tax_rules_group==$valueFieldPost.id_tax_rules_group} selected="selected"{/if}>{$tax_rules_group.name|escape:'html':'UTF-8'}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-lg-6 from-group">
                <label class="form-control-label" for="">{l s='Retail price per unit (tax excl.)' mod='ets_marketplace'}</label>
                <div>
                    <div class="input-group">
                        <input id="unit_price" autocomplete="off" name="unit_price" value="{$valueFieldPost.unit_price|escape:'html':'UTF-8'}" type="text" />
                        <div class="input-group-append">
                            <span class="input-group-text">{$currency_default->sign|escape:'html':'UTF-8'}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 from-group">
                <label class="form-control-label" for="">{l s='Cost price (tax excl.)' mod='ets_marketplace'}</label>
                <div>
                    <div class="input-group">
                        <input id="wholesale_price" autocomplete="off" name="wholesale_price" value="{$valueFieldPost.wholesale_price|escape:'html':'UTF-8'}" type="text" />
                        <div class="input-group-append">
                            <span class="input-group-text">{$currency_default->sign|escape:'html':'UTF-8'}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 from-group clearfix"></div>
        </div>
    </div>
</div>
{if in_array('specific_price',$seller_product_information)}
    <div class="row">
        <div class="col-md-12">
            <div class="">
                <div class="col-md-12">
                    <h2>
                      {l s='Specific prices' mod='ets_marketplace'}
                      <span class="help-box">
                          <span>
                          {l s='You can set specific prices for customers belonging to different groups, different countries, etc.' mod='ets_marketplace'}
                          </span>
                      </span>
                    </h2>
                </div>
                <div class="col-md-12">
                    <div id="specific-price" class="mb-2">
                        <a id="js-open-create-specific-price-form" class="btn btn-outline-primary" href="#specific_price_form">
                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-256v-256q0-26-19-45t-45-19h-128q-26 0-45 19t-19 45v256h-256q-26 0-45 19t-19 45v128q0 26 19 45t45 19h256v256q0 26 19 45t45 19h128q26 0 45-19t19-45v-256h256q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                            {l s='Add a specific price' mod='ets_marketplace'}
                        </a>
                        <div id="specific_price_form" class="hide" style="">
                            {$specific_prices_from nofilter}
                        </div>
                        <div class="table-responsive">
                            <table id="js-specific-price-list" class="table seo-table">
                                <thead class="thead-default">
                                    <tr>
                                      <th>{l s='Rule' mod='ets_marketplace'}</th>
                                      <th>{l s='Combination' mod='ets_marketplace'}</th>
                                      <th>{l s='Currency' mod='ets_marketplace'}</th>
                                      <th>{l s='Country' mod='ets_marketplace'}</th>
                                      <th>{l s='Group' mod='ets_marketplace'}</th>
                                      <th>{l s='Customer' mod='ets_marketplace'}</th>
                                      <th>{l s='Fixed price' mod='ets_marketplace'}</th>
                                      <th>{l s='Impact' mod='ets_marketplace'}</th>
                                      <th>{l s='Period' mod='ets_marketplace'}</th>
                                      <th>{l s='From' mod='ets_marketplace'}</th>
                                      <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {if $specific_prices}
                                        {foreach from= $specific_prices item='specific_price'}
                                            <tr id="specific_price-{$specific_price.id_specific_price|intval}">
                                                <td>--</td>
                                                <td>
                                                    {if $specific_price.id_product_attribute==0}
                                                        {l s='All combinations' mod='ets_marketplace'}
                                                    {else}
                                                        {$specific_price.attribute_name|escape:'html':'UTF-8'}
                                                    {/if}
                                                </td>
                                                <td>
                                                    {if $specific_price.id_currency==0}
                                                        {l s='All currencies' mod='ets_marketplace'}
                                                    {else}
                                                        {$specific_price.currency_name|escape:'html':'UTF-8'}
                                                    {/if}
                                                </td>
                                                <td>
                                                    {if $specific_price.id_country==0}
                                                        {l s='All countries' mod='ets_marketplace'}
                                                    {else}
                                                        {$specific_price.country_name|escape:'html':'UTF-8'}
                                                    {/if}
                                                </td>
                                                <td>
                                                    {if $specific_price.id_group==0}
                                                        {l s='All groups' mod='ets_marketplace'}
                                                    {else}
                                                        {$specific_price.group_name|escape:'html':'UTF-8'}
                                                    {/if}
                                                </td>
                                                <td>
                                                    {if $specific_price.id_customer==0}
                                                        {l s='All customers' mod='ets_marketplace'}
                                                    {else}
                                                        {$specific_price.customer_name|escape:'html':'UTF-8'}
                                                    {/if}
                                                </td>
                                                <td>
                                                    {$specific_price.price_text|escape:'html':'UTF-8'}
                                                </td>
                                                <td>
                                                    -{$specific_price.reduction|escape:'html':'UTF-8'}
                                                </td>
                                                <td>
                                                    {if $specific_price.from!='0000-00-00 00:00:00' || $specific_price.to!='0000-00-00 00:00:00'}
                                                        {l s='From' mod='ets_marketplace'}: {dateFormat date=$specific_price.from full=1}<br />
                                                        {l s='to' mod='ets_marketplace'}: {dateFormat date=$specific_price.to full=1}<br />
                                                    {else}
                                                        {l s='Unlimited' mod='ets_marketplace'}
                                                    {/if}
                                                </td>
                                                <td>
                                                    {$specific_price.from_quantity|intval}
                                                </td>
                                                <td class="ets-special-edit">
                                                    <a title="{l s='Delete' mod='ets_marketplace'}" href="#" class="js-delete delete btn ets_mp_delete_specific delete pl-0 pr-0" data-id_specific_price="{$specific_price.id_specific_price|intval}">
                                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 736v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm256 0v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm256 0v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm128 724v-948h-896v948q0 22 7 40.5t14.5 27 10.5 8.5h832q3 0 10.5-8.5t14.5-27 7-40.5zm-672-1076h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>{l s='Delete' mod='ets_marketplace'}
                                                    </a>
                                                    <a title="{l s='Edit' mod='ets_marketplace'}" class="js-edit edit btn tooltip-link delete pl-0 pr-0" href="#" data-id_specific_price="{$specific_price.id_specific_price|intval}">
                                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg> {l s='Edit' mod='ets_marketplace'}
                                                    </a>
                                                </td>
                                            </tr>
                                        {/foreach}
                                    {/if}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}