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
<div class="row product-actions">
    <div class="col-md-8 qty d-flex align-items-center">
        <div class="md-checkbox mt-2">
            <label>
                <input id="bulk-action" class="" type="checkbox" onclick="$('table').find('td input:checkbox').prop('checked', $(this).prop('checked'));ets_mp_updateBulkStock($(this));"/>
                <i class="md-checkbox-control"></i>
            </label>
        </div>
        <div class="ml-1">
            <small>{l s='Bulk edit quantity' mod='ets_marketplace'}</small>
            <div class="ps-number bulk-qty">
                <input class="form-control" placeholder="0" type="number" name="mp_stocks_quantity_all" id="mp_stocks_quantity_all" />
                <div class="ps-number-spinner d-flex">
                    <span class="ps-number-up"></span>
                    <span class="ps-number-down"></span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <button id="apply-new-quanitty" class="btn update-qty float-sm-right my-4 btn-primary btn-primary" type="button" disabled="disabled">
            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M491 1536l91-91-235-235-91 91v107h128v128h107zm523-928q0-22-22-22-10 0-17 7l-542 542q-7 7-7 17 0 22 22 22 10 0 17-7l542-542q7-7 7-17zm-54-192l416 416-832 832h-416v-416zm683 96q0 53-37 90l-166 166-416-416 166-165q36-38 90-38 53 0 91 38l235 234q37 39 37 91z"/></svg>
            {l s='Apply new quantity' mod='ets_marketplace'}
        </button>
    </div>
</div>