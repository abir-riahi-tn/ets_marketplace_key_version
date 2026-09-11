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

<div id="product-images-form">
    <button class="float-right close ets_mp_close_image" type="button">
        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='close' mod='ets_marketplace'}
    </button>
    <div class="row">
        <div class="col-lg-12 col-xl-7">
            <div class="checkbox">                          
                <label><input id="form_image_cover" name="image_cover" value="1"{if $image_class->cover} checked="checked"{/if} type="checkbox" />{l s='Cover image' mod='ets_marketplace'} </label>
            </div>
        </div>
        <div class="col-lg-12 col-xl-4">
            <a class="btn btn-link btn-sm open-image" href="{$url_image|escape:'html':'UTF-8'}">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1088 800v64q0 13-9.5 22.5t-22.5 9.5h-224v224q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-224h-224q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h224v-224q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5v224h224q13 0 22.5 9.5t9.5 22.5zm128 32q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 53-37.5 90.5t-90.5 37.5q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg> {l s='Zoom' mod='ets_marketplace'}
            </a>
        </div>
    </div>
    <label class="control-label">{l s='Caption' mod='ets_marketplace'}</label>
    <div id="form_image_legend" class="translations tabbable">
        {if $languages && count($languages)>1}
            {foreach from=$languages item='language'}
                <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                    <div class="col-lg-10">
                        {assign var='value_text' value=$legends[$language.id_lang]}
                        <textarea class="form-control" name="legend_{$language.id_lang|intval}" >{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}</textarea>
                    </div>
                    <div class="col-lg-2">
                        <div class="toggle_form">
                        <button class="btn btn-default dropdown-toggle" type="button" tabindex="-1" data-toggle="dropdown">
                        {$language.iso_code|escape:'html':'UTF-8'}
                            <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 704q0 26-19 45l-448 448q-19 19-45 19t-45-19l-448-448q-19-19-19-45t19-45 45-19h896q26 0 45 19t19 45z"/></svg>
                        </button>
                        <ul class="dropdown-menu">
                            {foreach from=$languages item='lang'}
                                <li>
                                    <a class="hideOtherLanguage" href="#" tabindex="-1" data-id-lang="{$lang.id_lang|intval}">{$lang.name|escape:'html':'UTF-8'}</a>
                                </li>
                            {/foreach}
                        </ul>
                        </div>
                    </div>
                </div>
            {/foreach}
        {else}
            {assign var='value_text' value=$legends[$id_lang_default]}
            <textarea class="form-control" name="legend_{$id_lang_default|intval}">{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}</textarea>
        {/if}
    </div>
    <div class="actions">
        <input type="hidden" name="id_image" value="{$image_class->id|intval}"/>
        <button class="btn btn-sm btn-primary pull-sm-right ets_mp_save_image" type="button">{l s='Save image settings' mod='ets_marketplace'}</button>
        <button class="btn btn-sm btn-link ets_mp_delete_image" type="button">
            <i class="material-icons">delete</i>
            {l s='Delete' mod='ets_marketplace'}
        </button>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function(){
       $(".open-image").fancybox();
    });
</script>