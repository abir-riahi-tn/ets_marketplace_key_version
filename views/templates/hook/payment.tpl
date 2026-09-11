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
<p class="payment_module">
	<a class="marketplace" href="{$link->getModuleLink('ets_marketplace', 'validation')|escape:'html':'UTF-8'}" title="{l s='Pay by commission' mod='ets_marketplace'}">
		{l s='Pay by commission' mod='ets_marketplace'} <span>({l s='You have ' mod='ets_marketplace'} {$commission_total_balance|escape:'html':'UTF-8'} {l s=' in your commission balance that can be used to pay for this order.' mod='ets_marketplace'})</span>
		<svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1363 877l-742 742q-19 19-45 19t-45-19l-166-166q-19-19-19-45t19-45l531-531-531-531q-19-19-19-45t19-45l166-166q19-19 45-19t45 19l742 742q19 19 19 45t-19 45z"/></svg>
	</a>

</p>