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
{if $is17}
    <footer class="page-footer">
        {if $seller_account}
            <a href="{$seller_account|escape:'html':'UTF-8'}" class="account-link">
                <i class="material-icons">chevron_left</i>
                <span>{l s='Back to seller account' mod='ets_marketplace'}</span>
            </a>
        {else}
            <a href="{$link->getPageLink('my-account')|escape:'html':'UTF-8'}" class="account-link">
                <i class="material-icons">chevron_left</i>
                <span>{l s='Back to your account' mod='ets_marketplace'}</span>
            </a>
        {/if}
        <a href="{$link->getPageLink('index')|escape:'html':'UTF-8'}" class="account-link">
            <i class="material-icons">home</i>
            <span>{l s='Home' mod='ets_marketplace'}</span>
        </a>
    </footer>
{else}
    <ul class="footer_links clearfix">
        {if $seller_account}
            <li>
        		<a class="btn btn-default button button-small" href="{$seller_account|escape:'html':'UTF-8'}">
        			<span>
        				<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1427 301l-531 531 531 531q19 19 19 45t-19 45l-166 166q-19 19-45 19t-45-19l-742-742q-19-19-19-45t19-45l742-742q19-19 45-19t45 19l166 166q19 19 19 45t-19 45z"/></svg> {l s='Back to seller account' mod='ets_marketplace'}
        			</span>
        		</a>
        	</li>
        {else}
        	<li>
        		<a class="btn btn-default button button-small" href="{$link->getPageLink('my-account')|escape:'html':'UTF-8'}">
        			<span>
        				<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1427 301l-531 531 531 531q19 19 19 45t-19 45l-166 166q-19 19-45 19t-45-19l-742-742q-19-19-19-45t19-45l742-742q19-19 45-19t45 19l166 166q19 19 19 45t-19 45z"/></svg> {l s='Back to your account' mod='ets_marketplace'}
        			</span>
        		</a>
        	</li>
        {/if}
    	<li>
    		<a class="btn btn-default button button-small" href="{$link->getPageLink('index')|escape:'html':'UTF-8'}">
    			<span>
    				<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1427 301l-531 531 531 531q19 19 19 45t-19 45l-166 166q-19 19-45 19t-45-19l-742-742q-19-19-19-45t19-45l742-742q19-19 45-19t45 19l166 166q19 19 19 45t-19 45z"/></svg> {l s='Home' mod='ets_marketplace'}
    			</span>
    		</a>
    	</li>
    </ul>
{/if}