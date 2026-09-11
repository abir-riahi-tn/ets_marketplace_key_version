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
<div class="row">
    <div class="col-lg-12">
        <div class="panel">
            <div class="panel-heading">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 1472q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm256 0q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm128-224v320q0 40-28 68t-68 28h-1472q-40 0-68-28t-28-68v-320q0-40 28-68t68-28h427q21 56 70.5 92t110.5 36h256q61 0 110.5-36t70.5-92h427q40 0 68 28t28 68zm-325-648q-17 40-59 40h-256v448q0 26-19 45t-45 19h-256q-26 0-45-19t-19-45v-448h-256q-42 0-59-40-17-39 14-69l448-448q18-19 45-19t45 19l448 448q31 30 14 69z"/></svg>
                {l s='Import products' mod='ets_marketplace'}
            </div>
            <form id="preview_import" class="form-horizontal" action="" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label class="control-label col-lg-4" for="truncate">
                        {l s='Select a CSV file to import' mod='ets_marketplace'}
                    </label>
                    <div class="col-lg-8">
                        <input type="file" name="file_import_product" />
                        <p class="help-block">{l s='Upload .csv file of your products following the format of sample file:' mod='ets_marketplace'}<a href="{$link_sample|escape:'html':'UTF-8'}">{l s='Download sample file' mod='ets_marketplace'}</a></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="truncate">
                        &nbsp;
                    </label>
                    <div class="col-lg-8">
                    <input type="hidden" name="submitUploadImportProduct" value="1" />
                    <button type="submit" class="btn btn-primary" name="submitUploadImportProduct"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 1344q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm256 0q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm128-224v320q0 40-28 68t-68 28h-1472q-40 0-68-28t-28-68v-320q0-40 28-68t68-28h465l135 136q58 56 136 56t136-56l136-136h464q40 0 68 28t28 68zm-325-569q17 41-14 70l-448 448q-18 19-45 19t-45-19l-448-448q-31-29-14-70 17-39 59-39h256v-448q0-26 19-45t45-19h256q26 0 45 19t19 45v448h256q42 0 59 39z"/></svg>&nbsp;{l s='Import' mod='ets_marketplace'}</button>
                    </div>
                </div>
                <div class="row">
                    <p class="note category_import">{l s='*Note: Categories which allow importing products' mod='ets_marketplace'}</p>
                    {if $categories}
                        <table class="list-categories-import">
                            <tr>
                                <td>{l s='Category ID' mod='ets_marketplace'}</td>
                                <td>{l s='Category Name' mod='ets_marketplace'}</td>
                            </tr>
                            {foreach from=$categories item='category'}
                                <tr>
                                    <td>{$category.id_category|intval}</td>
                                    <td>{$category.name|escape:'html':'UTF-8'}</td>
                                </tr>
                            {/foreach}
                        </table>
                    {/if}
                </div>
                <div class="clearfix"></div>
            </form>
        </div>
    </div>
</div>