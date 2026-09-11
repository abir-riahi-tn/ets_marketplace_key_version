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
<script type="text/javascript">
    var commissions_line_datasets ={$commissions_line_datasets|json_encode nofilter};
    var chart_labels=[{foreach from=$chart_labels item='data'}'{$data|escape:'html':'UTF-8'}',{/foreach}];
    var charxlabelString = '{l s='Month' mod='ets_marketplace' js=1}';
    var charylabelString = '{$current_currency->iso_code|escape:'html':'UTF-8'}';
    var ets_mp_url_search_product='{$ets_mp_url_search_product nofilter}';
</script>
<div class="ets_mp-dashboard-page">
    
    <div class="stats-box-info">
        <div class="row margin-15 ">
            <div class="col-lg-3 box-padding-col box-static box-static-turnover">
                <div class="box-info js-type-info-stats" style="background: #f06295;">
                    <div class="box-inner turnover">
                        <svg width="30" height="30" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1536q0 52-38 90t-90 38-90-38-38-90 38-90 90-38 90 38 38 90zm896 0q0 52-38 90t-90 38-90-38-38-90 38-90 90-38 90 38 38 90zm128-1088v512q0 24-16.5 42.5t-40.5 21.5l-1044 122q13 60 13 70 0 16-24 64h920q26 0 45 19t19 45-19 45-45 19h-1024q-26 0-45-19t-19-45q0-11 8-31.5t16-36 21.5-40 15.5-29.5l-177-823h-204q-26 0-45-19t-19-45 19-45 45-19h256q16 0 28.5 6.5t19.5 15.5 13 24.5 8 26 5.5 29.5 4.5 26h1201q26 0 45 19t19 45z"/></svg>
                        <div class="box-inner-top">
                            <h5 class="box-info-title">{l s='Turnover' mod='ets_marketplace'}</h5>
                            <div class="box-info-content"> {displayPrice price=$total_turn_over_all|floatval} </div>
                            <div class="box-tooltip button">{l s='Total money you have earned from selling products' mod='ets_marketplace'}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 box-padding-col box-static box-static-commission-balance">
                <div class="box-info js-type-info-stats" style="background: #57c2a0;">
                    <div class="box-inner commission-balance">
                        <svg width="30" height="30" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M832 1152h384v-96h-128v-448h-114l-148 137 77 80q42-37 55-57h2v288h-128v96zm512-256q0 70-21 142t-59.5 134-101.5 101-138 39-138-39-101.5-101-59.5-134-21-142 21-142 59.5-134 101.5-101 138-39 138 39 101.5 101 59.5 134 21 142zm512 256v-512q-106 0-181-75t-75-181h-1152q0 106-75 181t-181 75v512q106 0 181 75t75 181h1152q0-106 75-181t181-75zm128-832v1152q0 26-19 45t-45 19h-1792q-26 0-45-19t-19-45v-1152q0-26 19-45t45-19h1792q26 0 45 19t19 45z"/></svg>
                        <div class="box-inner-top">
                            <h5 class="box-info-title">{l s='Commission balance' mod='ets_marketplace'}</h5>
                            <div class="box-info-content"> {displayPrice price=$total_commission_balance|floatval} </div>
                            <div class="box-tooltip button">{l s='Total commission available to withdraw, pay for order, convert to voucher codes' mod='ets_marketplace'}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 box-padding-col box-static box-static-withdrawals">
                <div class="box-info js-type-info-stats" style="background: #f87f6f;">
                    <div class="box-inner withdrawals">
                        <svg width="30" height="30" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1362 1185q0 153-99.5 263.5t-258.5 136.5v175q0 14-9 23t-23 9h-135q-13 0-22.5-9.5t-9.5-22.5v-175q-66-9-127.5-31t-101.5-44.5-74-48-46.5-37.5-17.5-18q-17-21-2-41l103-135q7-10 23-12 15-2 24 9l2 2q113 99 243 125 37 8 74 8 81 0 142.5-43t61.5-122q0-28-15-53t-33.5-42-58.5-37.5-66-32-80-32.5q-39-16-61.5-25t-61.5-26.5-62.5-31-56.5-35.5-53.5-42.5-43.5-49-35.5-58-21-66.5-8.5-78q0-138 98-242t255-134v-180q0-13 9.5-22.5t22.5-9.5h135q14 0 23 9t9 23v176q57 6 110.5 23t87 33.5 63.5 37.5 39 29 15 14q17 18 5 38l-81 146q-8 15-23 16-14 3-27-7-3-3-14.5-12t-39-26.5-58.5-32-74.5-26-85.5-11.5q-95 0-155 43t-60 111q0 26 8.5 48t29.5 41.5 39.5 33 56 31 60.5 27 70 27.5q53 20 81 31.5t76 35 75.5 42.5 62 50 53 63.5 31.5 76.5 13 94z"/></svg>
                        <div class="box-inner-top">
                            <h5 class="box-info-title">{l s='Withdrawals' mod='ets_marketplace'}</h5>
                            <div class="box-info-content"> {displayPrice price=$total_withdrawls|floatval} </div>
                            <div class="box-tooltip button">{l s='Total money you have withdrawal successfully' mod='ets_marketplace'}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 box-padding-col box-static box-static-used-commission">
                <div class="box-info js-type-info-stats" style="background: #45bbe2;">
                    <div class="box-inner used-commission">
                        <svg width="30" height="30" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M832 1024v384q0 52-38 90t-90 38h-512q-52 0-90-38t-38-90v-384q0-52 38-90t90-38h512q52 0 90 38t38 90zm0-768v384q0 52-38 90t-90 38h-512q-52 0-90-38t-38-90v-384q0-52 38-90t90-38h512q52 0 90 38t38 90zm896 768v384q0 52-38 90t-90 38h-512q-52 0-90-38t-38-90v-384q0-52 38-90t90-38h512q52 0 90 38t38 90zm0-768v384q0 52-38 90t-90 38h-512q-52 0-90-38t-38-90v-384q0-52 38-90t90-38h512q52 0 90 38t38 90z"/></svg>
                        <div class="box-inner-top">
                            <h5 class="box-info-title">{l s='Commission' mod='ets_marketplace'}</h5>
                            <div class="box-info-content"> {displayPrice price=$total_commission_used|floatval} </div>
                            <div class="box-tooltip button">{l s='Total commission money you have withdrawal, paid for orders, converted into voucher' mod='ets_marketplace'}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="section-item ets_mp-section-commissions">
        <div class="title titleblock">{l s='Statistics' mod='ets_marketplace'}</div>
        <div class="row margin-15 row-991">
            <div class="col-lg-12 col-xs-12 col-sm-12 plr-15">
                <div class="stats-data-commissions">
                    <div class="stats-container">
                        <div class="stats-body">
                            <div class="box-dashboard line-chart-commissions">
                                <div class="box-header">
                                    <div class="stats-options-left">
                                        <div class="box-tool-buttons">
                                            <label for="chart_by_product_all"><input type="radio" name="chart_by_product" id="chart_by_product_all" value="all" checked="checked" />{l s='All products' mod='ets_marketplace'}</label>
                                            <label for="chart_by_product_search"><input type="radio" name="chart_by_product" id="chart_by_product_search" value="search" />{l s='Single product' mod='ets_marketplace'}</label>
                                            <div class="box-tool">
                                                <div class="box-tool-search box-search" style="display: none;">
                                                    <input type="hidden" value="" name="id_product_chart" id="id_product_chart" />
                                                    <input id="product_search_chart" name="product_search_chart" placeholder="{l s='Enter product name, ID or reference' mod='ets_marketplace'}" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="stats-options-right">
                                        <div class="box-tool-dropdown">
                                            <select name="filter-time-stats-commissions">
                                                <option value="all_time">{l s='All time' mod='ets_marketplace'}</option>
                                                <option value="this_month">{l s='This month' mod='ets_marketplace'}</option>
                                                <option value="_month">{l s='Month-1' mod='ets_marketplace'}</option>
                                                <option value="this_year" selected="selected">{l s='This year' mod='ets_marketplace'}</option>
                                                <option value="_year">{l s='Year-1' mod='ets_marketplace'}</option>
                                                <option value="time_range">{l s='Time range' mod='ets_marketplace'}</option>
                                            </select>
                                        </div>
                                        <div class="box-tool">
                                            <div class="box-tool-timerange box-date-ranger" style="display: none;">
                                                <input class="ajax-date-range ets_mp_date_ranger_filter" type="text" autocomplete="off" />
                                                <input class="date_from_commissions" value="" type="hidden" />
                                                <input class="date_to_commissions" value="" type="hidden" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <canvas id="ets_mp_stats_commision_line">
                                        
                                    </canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 col-xs-12 col-sm-12 plr-15">
                <table class="table">
                    <tr>
                        <td>{l s='Total number of product sold' mod='ets_marketplace'}</td>
                        <td class="text-right" id="total_number_of_product_sold">{$total_number_of_product_sold|intval}</td>
                    </tr>
                    <tr>
                        <td>{l s='Turnover' mod='ets_marketplace'}</td>
                        <td class="text-right" id="total_turn_over">{displayPrice price=$total_turn_over|floatval}</td>
                    </tr>
                    <tr>
                        <td>{l s='Earning commission' mod='ets_marketplace'}</td>
                        <td class="text-right" id="total_earning_commission">{displayPrice price=$total_earning_commission|floatval}</td>
                    </tr>
                </table>
            </div>
            <div class="col-lg-12 col-xs-12 col-sm-12 plr-15 list-best-selling-products">
                <h3>{l s='Best selling products' mod='ets_marketplace'}</h3>
                {$best_selling_products nofilter}
            </div>
        </div>
    </div>
</div>