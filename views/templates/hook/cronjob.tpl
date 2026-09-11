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

<div class="panel ets_mp-panel">
    <div class="panel-heading">
        {l s='Cronjob' mod='ets_marketplace'}<br />
    </div>
    <ul class="mkt_config_tab_header cronjob">
        <li class="confi_tab config_tab_configuration active" data-tab-id="configuration">{l s='Configuration' mod='ets_marketplace'}</li>
        <li class="confi_tab config_tab_cronjob_log" data-tab-id="cronjob_log">{l s='Cronjob log' mod='ets_marketplace'}</li>
    </ul>
    <div class="clearfix">
        <div class="emp-cronjob ets_mp_form configuration active">
			<form id="ets_hd_column_form" class="defaultForm form-horizontal" action="" method="post" enctype="multipart/form-data" novalidate="">
				<div class="row mt-15">
					<div class="col-lg-12">
						<p class="ets-mp-text-strong mb-10"><span style="color: red;">*</span> {l s='Some important notes before setting Cronjob:' mod='ets_marketplace'}</p>
						<ul>
							<li>{l s='Cronjob frequency should be at least twice per day, the recommended frequency is once per minute' mod='ets_marketplace'}</li>
							<li>{l s='How to setup a cronjob is different depending on your server. If you\'re using a Cpanel hosting, watch this video for more reference:' mod='ets_marketplace'}
								<a href="https://www.youtube.com/watch?v=bmBjg1nD5yA" target="_blank" rel="noreferrer noopener">https://www.youtube.com/watch?v=bmBjg1nD5yA</a> <br>
								{l s='You can also contact your hosting provider to ask them for support on setting up the cronjob' mod='ets_marketplace'}
							</li>

						</ul>
						<p class="ets-mp-text-strong emp-block mb-15"><span style="color: red;">*</span> {l s=' Setup a cronjob as below on your server to automatically send emails to sellers when their seller account is going to expire and to automatically upgrade seller shops.' mod='ets_marketplace'}</p>
						<p class="mb-15 emp-block"><span class="ets-mp-text-bg-light-gray">* * * * * {$php_path|escape:'html':'UTF-8'} {$dir_cronjob|escape:'html':'UTF-8'} secure=<span class="emp-cronjob-secure-value">{$ETS_MP_CRONJOB_TOKEN|escape:'html':'UTF-8'}</span></span></p>
						<p class="ets-mp-text-strong mb-10"><span style="color: red;">*</span> {l s='Execute the cronjob manually by clicking on the button below' mod='ets_marketplace'}</p>
						<a href="{$link_conjob nofilter}" data-secure="{$ETS_MP_CRONJOB_TOKEN|escape:'html':'UTF-8'}" class="btn btn-default btn-sm mb-10 js-emp-test-cronjob">{l s='Execute cronjob manually' mod='ets_marketplace'}</a>
					</div>
				</div>
				{if $cronjob_last}
					<br/>
					<div class="mb-15 emp-block form-horizontal">
						<p class="alert alert-info">{l s='Last time cronjob run' mod='ets_marketplace'}: {$cronjob_last|escape:'html':'UTF-8'}</p>
					</div>
				{/if}
				<hr/>
				<div class="form-wrapper row mt-15">
					<div class="form-group">
						<label class="control-label col-lg-4 required" style="">
							{l s='Cronjob secure token:' mod='ets_marketplace'}
						</label>
						<div class="col-lg-8">
							<input name="ETS_MP_CRONJOB_TOKEN" id="ETS_MP_CRONJOB_TOKEN" value="{$ETS_MP_CRONJOB_TOKEN|escape:'html':'UTF-8'}" type="text" />
							<button type="button" name="ets_mp_general_token" class="btn btn-default">
								<i class="ets_svg_fill_gray ets_svg_hover_fill_white lh_16">
									<svg class="w_14 h_14" width="12" height="12" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1639 1056q0 5-1 7-64 268-268 434.5t-478 166.5q-146 0-282.5-55t-243.5-157l-129 129q-19 19-45 19t-45-19-19-45v-448q0-26 19-45t45-19h448q26 0 45 19t19 45-19 45l-137 137q71 66 161 102t187 36q134 0 250-65t186-179q11-17 53-117 8-23 30-23h192q13 0 22.5 9.5t9.5 22.5zm25-800v448q0 26-19 45t-45 19h-448q-26 0-45-19t-19-45 19-45l138-138q-148-137-349-137-134 0-250 65t-186 179q-11 17-53 117-8 23-30 23h-199q-13 0-22.5-9.5t-9.5-22.5v-7q65-268 270-434.5t480-166.5q146 0 284 55.5t245 156.5l130-129q19-19 45-19t45 19 19 45z"/></svg>
								</i> {l s='General' mod='ets_marketplace'}
							</button>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-lg-4 required" style="">
							{l s='Mail queue step (Maximum number of emails sent per run of cronjob file):' mod='ets_marketplace'}
						</label>
						<div class="col-lg-4">
							<div class="input-group">
								<input name="ETS_MP_CRONJOB_EMAILS" id="ETS_MP_CRONJOB_EMAILS" value="{$ETS_MP_CRONJOB_EMAILS|escape:'html':'UTF-8'}" type="text" />
								<span class="input-group-addon">{l s='email(s)' mod='ets_marketplace'} </span>
							</div>
							<p class="help-block">{l s='Every time cronjob is run, it will check the mail queue to send emails. Reduce this value if your server has a limited timeout.' mod='ets_marketplace'}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-lg-4 required" style="">
							{l s='Mail queue max-trying times:' mod='ets_marketplace'}
						</label>
						<div class="col-lg-4">
							<div class="input-group">
								<input name="ETS_MP_CRONJOB_MAX_TRY" id="ETS_MP_CRONJOB_MAX_TRY" value="{$ETS_MP_CRONJOB_MAX_TRY|escape:'html':'UTF-8'}" type="text" />
								<span class="input-group-addon">{l s='time(s)' mod='ets_marketplace'} </span>
							</div>
							<p class="help-block">{l s='The number of times to resend an email if sending failed! Then, the email will be removed from the queue.' mod='ets_marketplace'}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-lg-4">
							{l s='Enable mail logs' mod='ets_marketplace'}
						</label>
						<div class="col-lg-8">
							<span class="switch prestashop-switch fixed-width-lg">
								<input name="ETS_MP_ENABLED_LOG_MAIL" id="ETS_MP_ENABLED_LOG_MAIL_on" value="1"{if $ETS_MP_ENABLED_LOG_MAIL==1} checked="checked"{/if} type="radio">
								<label for="ETS_MP_ENABLED_LOG_MAIL_on">{l s='Yes' mod='ets_marketplace'}</label>
								<input name="ETS_MP_ENABLED_LOG_MAIL" id="ETS_MP_ENABLED_LOG_MAIL_off" value="0"{if $ETS_MP_ENABLED_LOG_MAIL==0} checked="checked"{/if} type="radio">
								<label for="ETS_MP_ENABLED_LOG_MAIL_off">{l s='No' mod='ets_marketplace'}</label>
								<a class="slide-button btn"></a>
							</span>
						</div>
					</div>
				</div>
				<div class="panel-footer">
					<button type="submit" value="1" id="ets_hd_column_form_submit_btn" name="submitCronjobSettings" class="btn btn-default pull-right">
						<svg width="30" height="30" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
					</button>
				</div>
			</form>
         </div>
         <div class="ets_mp_form cronjob_log">
            <div class="mb-15 emp-block form-horizontal">
                <div class="form-group">
                    <label class="control-label" style="float:left;text-align: left;margin-bottom: 10px;padding-left:15px;">
        				{l s='Save cronjob log' mod='ets_marketplace'}
        			</label>
                    <div class="col-lg-9 flex">
                        <span class="switch prestashop-switch fixed-width-lg">
				            <input name="ETS_MP_SAVE_CRONJOB_LOG" id="ETS_MP_SAVE_CRONJOB_LOG_on" value="1" {if $ETS_MP_SAVE_CRONJOB_LOG}checked="checked"{/if} type="radio" />
							<label for="ETS_MP_SAVE_CRONJOB_LOG_on">{l s='Yes' mod='ets_marketplace'}</label>
				            <input name="ETS_MP_SAVE_CRONJOB_LOG" id="ETS_MP_SAVE_CRONJOB_LOG_off" value="0" type="radio" {if !$ETS_MP_SAVE_CRONJOB_LOG}checked="checked"{/if} />
							<label for="ETS_MP_SAVE_CRONJOB_LOG_off">{l s='No' mod='ets_marketplace'}</label>
							<a class="slide-button btn"></a>
						</span>
                        <p class="help-block">{l s='Only recommended for debug purpose' mod='ets_marketplace'}</p>
                    </div>
                </div>
                <div class="form-group">
        			<label class="control-label col-lg-12" style="text-align: left;margin-bottom: 10px;">
        				{l s='Cronjob log:' mod='ets_marketplace'}
        			</label>
        			<div class="col-lg-12 flex">
        				<textarea class="cronjob_log">{$cronjob_log nofilter}</textarea><br />
                        <button class="btn btn-default" name="etsmpSubmitClearLog"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> {l s='Clear log' mod='ets_marketplace'}</button>
        			</div>
        		</div>
            </div>
         </div>
    </div>
</div>