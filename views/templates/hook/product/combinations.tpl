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
{assign var='has_attributes' value=false}
{if $attributeGroups &&  is_array($attributeGroups)}
    {foreach from =$attributeGroups item='attributeGroup'}
        {if $attributeGroup.attributes}
            {assign var='has_attributes' value=true}
        {/if}
    {/foreach}
{/if}
<div class="form-group">
    <div class="ets_mp_combination_left {if $has_attributes}col-lg-9{else}col-lg-12{/if}"> 
        <h2>
            {l s='Manage your product combinations' mod='ets_marketplace'}
            <span class="help-box">
                <span>{l s='Combinations are the different variations of a product, with attributes like its size, weight or color taking different values. To create a combination, you need to create your product attributes first. Go to Catalog > Attributes & Features for this!' mod='ets_marketplace'}</span>
            </span>
        </h2>
        <div id="attributes-generator">
            <div class="alert alert-info"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                <p class="alert-text">
                    {l s='To add combinations, you first need to create proper attributes and values in' mod='ets_marketplace'} <a class="alert-link" href="{$link->getModuleLink('ets_marketplace','attributes')|escape:'html':'UTF-8'}" target="_blank">{l s='Attributes and Features' mod='ets_marketplace'}</a>. <br/> {l s='When done, you may enter the wanted attributes (like "size" or "color") and their respective values ("XS", "red", "all", etc.) in the field below; or simply select them from the right column. Then click on "Generate": it will automatically create all the combinations for you!' mod='ets_marketplace'}
                </p>
            </div>
            {if $has_attributes}
                <div class="row">
                    <div class="col-lg-9">
                        <fieldset class="form-group">
                            <div class="tokenfield form-control">
                                
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-lg-3">
                        <button id="create-combinations" class="btn btn-outline-primary"> {l s='Generate' mod='ets_marketplace'} </button>
                    </div>
                </div>
            {/if}
        </div>
        <div id="combinations-bulk-form" class="{if $productAttributes|Count==0}inactive{/if}">
            <div class="row">
                <div class="col-md-12">
                    <p class="form-control bulk-action ets-mp-bulk-action-form-attribute">
                        <strong>{l s='Bulk actions' mod='ets_marketplace'} (<span class="js-bulk-combinations">0</span>/<span id="js-bulk-combinations-total">{$productAttributes|count}</span> {l s='combination(s) selected' mod='ets_marketplace'})</strong>
                        <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1395 736q0 13-10 23l-466 466q-10 10-23 10t-23-10l-466-466q-10-10-10-23t10-23l50-50q10-10 23-10t23 10l393 393 393-393q10-10 23-10t23 10l50 50q10 10 10 23z"/></svg>
                    </p>
                </div>
                <div id="bulk-combinations-container" class="col-md-12" style="display:none;">
                    <div class="bulk-combinations-container-form">
                        <div id="bulk-combinations-container-fields" class="">
                            <div class="col-lg-4 col-md-3 col-sm-6">
                                <label class="form-control-label">{l s='Quantity' mod='ets_marketplace'}</label>
                                <input id="product_combination_bulk_quantity" class="form-control" name="product_combination_bulk[quantity]" type="text" />
                            </div>
                            <div class="col-lg-4 col-md-3 col-sm-6">
                                <label class="form-control-label">{l s='Cost price' mod='ets_marketplace'}</label>
                                <div class="input-group money-type">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">{$default_currency->sign|escape:'html':'UTF-8'} </span>
                                    </div>
                                    <input id="product_combination_bulk_cost_price" name="product_combination_bulk[cost_price]" data-display-price-precision="6" class="form-control" type="text" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-3 col-sm-6">
                                <label class="form-control-label">{l s='Impact on weight' mod='ets_marketplace'}</label>
                                <input id="product_combination_bulk_impact_on_weight" class="form-control" name="product_combination_bulk[impact_on_weight]" type="text" />
                            </div>
                            <div class="col-lg-4 col-md-3 col-sm-6">
                                <label class="form-control-label">{l s='Impact on price (tax excl.)' mod='ets_marketplace'}</label>
                                <div class="input-group money-type">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">{$default_currency->sign|escape:'html':'UTF-8'}</span>
                                    </div>
                                    <input id="product_combination_bulk_impact_on_price_te" name="product_combination_bulk[impact_on_price_te]" class="form-control" type="text" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-3 col-sm-6">
                                <label class="form-control-label">{l s='Impact on price (tax incl.)' mod='ets_marketplace'}</label>
                                <div class="input-group money-type">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">{$default_currency->sign|escape:'html':'UTF-8'}</span>
                                    </div>
                                    <input id="product_combination_bulk_impact_on_price_ti" name="product_combination_bulk[impact_on_price_ti]" class="form-control" type="text" />
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-3 col-sm-6">
                                <label class="form-control-label">{l s='Availability date' mod='ets_marketplace'}</label>
                                <div class="input-group datepicker">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h288v-288h-288v288zm352 0h320v-288h-320v288zm-352-352h288v-320h-288v320zm352 0h320v-320h-320v320zm-352-384h288v-288h-288v288zm736 736h320v-288h-320v288zm-384-736h320v-288h-320v288zm768 736h288v-288h-288v288zm-384-352h320v-320h-320v320zm-352-864v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm736 864h288v-320h-288v320zm-384-384h320v-288h-320v288zm384 0h288v-288h-288v288zm32-480v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg></span>
                                    </div>
                                    <input id="product_combination_bulk_date_availability" autocomplete="off" name="product_combination_bulk[date_availability]" class="form-control" type="text" placeholder="YYYY-MM-DD" />

                                </div>
                            </div>
                            <div class="col-lg-4 col-md-3 col-sm-6">
                                <label class="form-control-label">{l s='Reference' mod='ets_marketplace'}</label>
                                <input id="product_combination_bulk_reference" name="product_combination_bulk[reference]" class="form-control" type="text" />
                            </div>
                            <div class="col-lg-4 col-md-3 col-sm-6">
                                <label class="form-control-label">{l s='Minimum quantity' mod='ets_marketplace'}</label>
                                <input id="product_combination_bulk_minimal_quantity" name="product_combination_bulk[minimal_quantity]" class="form-control" type="text" />
                            </div>
                            {if $is17}
                                <div class="col-lg-4 col-md-3 col-sm-6">
                                    <label class="form-control-label">{l s='Low stock level' mod='ets_marketplace'}
                                      <span class="help-box" title="{l s='You can increase or decrease low stock levels in bulk. You cannot disable them in bulk: you have to do it on a per-combination basis.' mod='ets_marketplace'}">
                                          <span class="ets_tooltip" data-tooltip="{l s='You can increase or decrease low stock levels in bulk. You cannot disable them in bulk: you have to do it on a per-combination basis.' mod='ets_marketplace'}" >
                                              
                                          </span>
                                      </span>
                                    </label>
                                    <input id="product_combination_bulk_low_stock_threshold" name="product_combination_bulk[low_stock_threshold]" class="form-control" type="text" />
                                </div>
                            {/if}
                            <div class="col-lg-12 col-md-12 col-sm-12 widget-checkbox-inline">
                                <div class="widget-checkbox-inline">
                                      <div class="checkbox">                          
                                        <label><input id="product_combination_bulk_low_stock_alert" name="product_combination_bulk[low_stock_alert]" value="1" type="checkbox" />
                                            {l s='Send me an email when the quantity is below or equals this level' mod='ets_marketplace'}
                                            <span class="help-box" title="{l s='The email will be sent to all the users who have the right to run the stock page. To modify the permissions, go to Advanced Parameters > Team' mod='ets_marketplace'}" title="">
                                                <span class="ets_tooltip" data-tooltip="{l s='The email will be sent to all the users who have the right to run the stock page. To modify the permissions, go to Advanced Parameters > Team' mod='ets_marketplace'}" >
                                                    
                                                </span>
                                            </span>
                                        </label>
                                      </div>

                                </div>
                            </div>
                        </div>
                        <div class="justify-content-end mt-2">
                            <button id="delete-combinations" class="btn btn-primary mr-2 btn-outline-secondary">
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 736v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm256 0v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm256 0v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm128 724v-948h-896v948q0 22 7 40.5t14.5 27 10.5 8.5h832q3 0 10.5-8.5t14.5-27 7-40.5zm-672-1076h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                                {l s='Delete combinations' mod='ets_marketplace'}
                            </button>
                            <button id="apply-on-combinations" class="btn btn-outline-primary">
                                {l s='Apply' mod='ets_marketplace'}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="combinations-list">
            {$list_product_attributes nofilter}
        </div>
    </div>
    <div class="ets_mp_combination_right col-lg-3">
        {if $has_attributes}
            <div id="attributes-list">
                {foreach from=$attributeGroups item='attributeGroup'}
                    {if $attributeGroup.attributes}
                        <div class="attribute-group">
                            <a  class="attribute-group-name" data-toggle="collapse" aria-expanded="true" href="#attribute-group-{$attributeGroup.id_attribute_group|intval}"> {$attributeGroup.name|escape:'html':'UTF-8'} </a>
                            <div id="attribute-group-{$attributeGroup.id_attribute_group|intval}" class="attributes show collapse in" aria-expanded="true">
                                <div class="attributes-overflow">
                                    {foreach from =$attributeGroup.attributes item='attribute'}
                                        <div class="attribute">
                                            <div class="ets_input_group">
                                                <input  name="attribute_options[{$attribute.id_attribute_group|intval}][{$attribute.id_attribute|intval}]" id="attribute-{$attribute.id_attribute|intval}" class="js-attribute-checkbox" data-label="{$attributeGroup.name|escape:'html':'UTF-8'} : {$attribute.name|escape:'html':'UTF-8'}" data-value="{$attribute.id_attribute|intval}" data-group-id="{$attribute.id_attribute_group|intval}" type="checkbox" value="{$attribute.id_attribute|intval}" />
                                                <div class="ets_input_check"></div>
                                            </div>
                                            <label class="attribute-label" for="attribute-{$attribute.id_attribute|intval}">
                                                <span class="pretty-checkbox {if $attributeGroup.is_color_group}ets-item-color{/if} " {if $attributeGroup.is_color_group} {if $attribute.color} style="background-color:{$attribute.color|escape:'html':'UTF-8'}"{elseif isset($attribute.image) && $attribute.image} style="background-image: url('{$attribute.image|escape:'html':'UTF-8'}');"{/if}{/if}> {$attribute.name|escape:'html':'UTF-8'}</span>
                                            </label>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                    {/if}
                {/foreach}
            </div>
        {/if}
    </div>
    <div class="clearfix"></div>
</div>
