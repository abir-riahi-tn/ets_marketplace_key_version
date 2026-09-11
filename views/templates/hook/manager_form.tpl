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

<form id="ets_mp_manager_shop_form" action="" method="post" enctype="multipart/form-data">
    <div class="ets_mp_close_popup" title="{l s='Close' mod='ets_marketplace'}">{l s='Close' mod='ets_marketplace'}</div>
     <div id="fieldset_0" class="panel">
         <div class="panel-heading">
             <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
            {if $id_ets_mp_seller_manager}{l s='Edit permission' mod='ets_marketplace'}{else}{l s='Add new permission' mod='ets_marketplace'}{/if}
         </div>
         <div class="form-wrapper">
            {$html_form nofilter}
         </div>
         <div class="panel-footer">
            <span class="btn btn-secondary ets_mp_cancel_popup" title="{l s='Cancel' mod='ets_marketplace'}">{l s='Cancel' mod='ets_marketplace'}</span>
            <input type="hidden" name="submitSaveManagerShop" value="1"/>
            <input type="hidden" name="id_ets_mp_seller_manager" value="{$id_ets_mp_seller_manager|intval}" />
            <button name="submitSaveManagerShop" type="submit" class="btn btn-primary form-control-submit float-xs-right">{l s='Save' mod='ets_marketplace'}</button>
         </div>
     </div>
</form>