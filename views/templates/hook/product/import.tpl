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
<div id="container-customer" class="panel">
    <h3>
        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M384 1184v64q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5zm0-256v64q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5zm0-256v64q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5zm1152 512v64q0 13-9.5 22.5t-22.5 9.5h-960q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h960q13 0 22.5 9.5t9.5 22.5zm0-256v64q0 13-9.5 22.5t-22.5 9.5h-960q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h960q13 0 22.5 9.5t9.5 22.5zm0-256v64q0 13-9.5 22.5t-22.5 9.5h-960q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h960q13 0 22.5 9.5t9.5 22.5zm128 704v-832q0-13-9.5-22.5t-22.5-9.5h-1472q-13 0-22.5 9.5t-9.5 22.5v832q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm128-1088v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg>
        {l s='View your data' mod='ets_marketplace'}
    </h3>
    {if $max_product_upload}
        <div class="alert alert-warning">
            <p><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {$max_product_upload|escape:'html':'UTF-8'}</p>
        </div>
    {else}
        <div class="alert alert-info">
            <p><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg> {l s='Please match each column of your source CSV file to one of the destination columns.' mod='ets_marketplace'}</p>
        </div>
    {/if}
    <form id="import_form" class="form-horizontal" action="" method="post" name="import_form">
        <div class="form-group">
            <div class="col-lg-12 pd_0">
                <div class="scroll_form">
                <table id="table0" class="table table-bordered" style="display: table;">
                    <thead>
                        <tr>
                            <th>
                                <select name="col_product_name">
                                    <option value="0" selected="selected">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                            <th>
                                <select name="col_product_image">
                                    <option value="0">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1" selected="selected">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                            <th>
                                <select name="col_product_quantity">
                                    <option value="0">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2" selected="selected">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                            <th>
                                <select name="col_product_price">
                                    <option value="0">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3" selected="selected">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                            <th>
                                <select name="col_product_description">
                                    <option value="0">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4" selected="selected">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {if $datas}
                            {foreach from=$datas item='data'}
                                <tr>
                                    <td>{if isset($data[0])}{$data[0]|escape:'html':'UTF-8'}{/if}</td>
                                    <td>{if isset($data[1])}{$data[1]|escape:'html':'UTF-8'}{/if}</td>
                                    <td>{if isset($data[2])}{$data[2]|escape:'html':'UTF-8'}{/if}</td>
                                    <td>{if isset($data[3])}{$data[3]|escape:'html':'UTF-8'}{/if}</td>
                                    <td>{if isset($data[4])}{$data[4]|escape:'html':'UTF-8'}{/if}</td>
                                </tr>
                            {/foreach}
                        {/if}
                    </tbody>
                </table>
                <table id="table1" class="table table-bordered" style="display:none;">
                    <thead>
                        <tr>
                            <th>
                                <select name="col_product_description_short">
                                    <option value="0">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5" selected="selected">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                            <th>
                                <select name="col_product_link_rewrite">
                                    <option value="0">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6" selected="selected">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                            <th>
                                <select name="col_product_category">
                                    <option value="0" >{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7" selected="selected">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                            <th>
                                <select name="col_product_default_category">
                                    <option value="0">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8" selected="selected">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                            <th>
                                <select name="col_product_combination">
                                    <option value="0">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9" selected="selected">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                            <th>
                                <select name="col_specific_price">
                                    <option value="0">{l s='Name' mod='ets_marketplace'}</option>
                                    <option value="1">{l s='Image' mod='ets_marketplace'}</option>
                                    <option value="2">{l s='Quantity' mod='ets_marketplace'}</option>
                                    <option value="3">{l s='Price' mod='ets_marketplace'}</option>
                                    <option value="4">{l s='Description' mod='ets_marketplace'}</option>
                                    <option value="5">{l s='Summary' mod='ets_marketplace'}</option>
                                    <option value="6">{l s='Link rewrite' mod='ets_marketplace'}</option>
                                    <option value="7">{l s='Categories' mod='ets_marketplace'}</option>
                                    <option value="8">{l s='Default category' mod='ets_marketplace'}</option>
                                    <option value="9">{l s='Combinations' mod='ets_marketplace'}</option>
                                    <option value="10" selected="selected">{l s='Specific price' mod='ets_marketplace'}</option>
                                </select>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {if $datas}
                            {foreach from=$datas item='data'}
                                <tr>
                                    <td>{if isset($data[5])}{$data[5]|escape:'html':'UTF-8'}{/if}</td>
                                    <td>{if isset($data[6])}{$data[6]|escape:'html':'UTF-8'}{/if}</td>
                                    <td>{if isset($data[7])}{$data[7]|escape:'html':'UTF-8'}{/if}</td>
                                    <td>{if isset($data[8])}{$data[8]|escape:'html':'UTF-8'}{/if}</td>
                                    <td>{if isset($data[9])}{$data[9]|escape:'html':'UTF-8'}{/if}</td>
                                    <td>{if isset($data[10])}{$data[10]|escape:'html':'UTF-8'}{/if}</td>
                                </tr>
                            {/foreach}
                        {/if}
                    </tbody>
                </table>
                </div>
                <button id="btn_import_left" class="btn btn-primary pull-left" type="button" disabled="disabled">
                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1427 301l-531 531 531 531q19 19 19 45t-19 45l-166 166q-19 19-45 19t-45-19l-742-742q-19-19-19-45t19-45l742-742q19-19 45-19t45 19l166 166q19 19 19 45t-19 45z"/></svg> {l s='Prev' mod='ets_marketplace'}
                </button>
                <button id="btn_import_right" class="btn btn-primary pull-right" type="button">
                    {l s='Next' mod='ets_marketplace'} <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1363 877l-742 742q-19 19-45 19t-45-19l-166-166q-19-19-19-45t19-45l531-531-531-531q-19-19-19-45t19-45l166-166q19-19 45-19t45 19l742 742q19 19 19 45t-19 45z"/></svg>
                </button>
            </div>
        </div>
        <div class="panel-footer">
            <button class="btn btn-primary pull-left" type="submit" name="cancelSubmitImport">
                {l s='Cancel' mod='ets_marketplace'}
            </button>
            {if !$max_product_upload}
                <button id="import" class="btn btn-primary pull-right" name="submitImportProduct" type="submit">
                    {l s='Import .CSV data' mod='ets_marketplace'}
                </button>
            {/if}
        </div>
    </form>
</div>