/**
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
 */
/**
 * jquery.growl n'est pas charge par le back-office de PrestaShop 9 : sans ce
 * repli, chaque appel a $.growl leve une exception et interrompt le traitement
 * en cours (clic sans effet et sans message). On fournit une implementation
 * minimale, uniquement lorsque la bibliotheque est absente.
 */
if (typeof jQuery != 'undefined' && typeof jQuery.growl == 'undefined') {
    jQuery.growl = (function($){
        var colors = {notice: '#4cbb6c', error: '#c9564b', warning: '#f0ad4e'};
        function show(options, type)
        {
            var message = (options && options.message) ? options.message : '';
            if (!message)
                return;
            var $container = $('#ets_mp_growl_container');
            if (!$container.length)
            {
                $container = $('<div id="ets_mp_growl_container"></div>').css({
                    position: 'fixed', top: '20px', right: '20px',
                    zIndex: 99999, maxWidth: '420px'
                }).appendTo('body');
            }
            var $item = $('<div></div>').html(message).css({
                background: colors[type] || '#333', color: '#fff',
                padding: '12px 16px', marginBottom: '8px', borderRadius: '3px',
                boxShadow: '0 2px 6px rgba(0,0,0,.3)', fontSize: '13px',
                cursor: 'pointer'
            }).appendTo($container);
            $item.on('click', function(){ $(this).remove(); });
            setTimeout(function(){
                $item.fadeOut(300, function(){ $(this).remove(); });
            }, 6000);
        }
        var growl = function(options){ show(options, 'notice'); };
        growl.notice  = function(options){ show(options, 'notice'); };
        growl.error   = function(options){ show(options, 'error'); };
        growl.warning = function(options){ show(options, 'warning'); };
        return growl;
    })(jQuery);
}
var etsMPAddSellerName = function(event,data,formatted)
{
    if (data == null)
		    return false;
  $('#id_seller').val(data[0]);
  if($('#seller_name').next('.seller_selected').length <=0)
  {
       $('#seller_name').before('<div class="seller_selected">'+data[1]+' ('+data[2]+') <span class="delete_seller_search">delete</span><div>');
       $('#seller_name').val(''); 
       $('.seller_selected').parent().addClass('has_seller');
  }
}
function etsMPDisplayFormCommissionUsage()
{
    if($('input[name="ETS_MP_ALLOW_BALANCE_TO_PAY"]').length)
    {
        if($('input[name="ETS_MP_ALLOW_BALANCE_TO_PAY"]:checked').val()==1)
            $('.form-group.usage_order').show();
        else
            $('.form-group.usage_order').hide();
        if($('input[name="ETS_MP_ALLOW_CONVERT_TO_VOUCHER"]:checked').val()==1)
            $('.form-group.usage_voucher').show();
        else
            $('.form-group.usage_voucher').hide();
        if($('input[name="ETS_MP_ALLOW_WITHDRAW"]:checked').val()==1)
            $('.form-group.usage_withdraw').show();
        else
            $('.form-group.usage_withdraw').hide();
    }
}
function etsMpDisplayFormShopGroups()
{
    if($('input[name="use_fee_global"]').length)
    {
        
        if($('input[name="use_fee_global"]:checked').val()==1)
        {
            $('.form-group.global_fee').hide();
        }
        else
        {
            $('.form-group.global_fee').show();
            if($('input[name="fee_type"]:checked').val()=='no_fee')
                $('.form-group.global_fee.ets_mp_fee').hide();
            else
                $('.form-group.global_fee.ets_mp_fee').show();
        }
        if($('input[name="use_commission_global"]:checked').val()==1)
        {
            $('.form-group.global_commission').hide();
        }
        else
        {
            $('.form-group.global_commission').show();
            if($('input[name="enable_commission_by_category"]:checked').val()==1)
            {
                $('.form-group.category_commission_rate').show();
            }
            else
            {
                $('.form-group.category_commission_rate').hide();
                
            }
        }
        
    }
}
function setMore_menu(){
    var menu_width_box = $('.etsmp-left-panel.etsmp-sidebar-menu').width();
    var menu_width = $('.etsmp-left-panel.etsmp-sidebar-menu .list-group').width();
    var itemwidthlist = 0
    $( ".etsmp-sidebar-menu .list-tab" ).each(function() {
        var itemwidth = $(this).width();
        itemwidthlist = itemwidthlist + itemwidth;
        if ( itemwidthlist > menu_width_box - 70){
            $(this).addClass('hide_more');
        } else {
            $(this).removeClass('hide_more');
        }
    });
}
$(document).ready(function(){
    if($('.seller_selected').length && $('input[name="seller_name"]').length)
    {
        $('input[name="seller_name"]').before($('.seller_selected').clone());
        $('input[name="seller_name"]').parent().addClass('has_seller');
        $('input[name="seller_name"]').parent().prev('.seller_selected').remove();
    }
    setMore_menu();
    setTimeout(function() {
        if ( $('body.mobile').length > 0 ) {
            setMore_menu();
            $(".list-tab.hide_more").removeClass('show_hover');
        }
    }, 3000);
    $(window).resize(function(){
        setMore_menu();
        $(".list-tab.hide_more").removeClass('show_hover');
        setTimeout(function() {
            if ( $('body.mobile').length > 0 ) {
                setMore_menu();
                $(".list-tab.hide_more").removeClass('show_hover');
            }
        }, 3000);
    });
    $(document).mouseup(function (e)
    {
        var confirm_popup=$('.list-tab.hide_more');
        if (!confirm_popup.is(e.target)&& confirm_popup.has(e.target).length === 0)
        {
            $(".list-tab.hide_more").removeClass('show_hover');
        }
    });

    $('.list-tab.more_menu').on('click',function(e){
        $(".list-tab.hide_more").toggleClass('show_hover');
    });




    $(document).on('change','.paginator_select_limit',function(e){
        $(this).parents('form').submit();
    });
    $(document).on('click','.ets_mp_map .view_map',function(){
        $('.ets_mp_map_seller').show();
        return false;
    });
    if ($("input.datepicker").length > 0) {
        $("input.datepicker").attr('autocomplete','off');
	} 
    etsMpDisplayFormCommissionRate();
    etsMpDisplayFormShopGroups();
    $(document).on('click','input[name="use_fee_global"],input[name="fee_type"],input[name="use_commission_global"],#ets_mp_seller_group_form input[name="enable_commission_by_category"]',function(){
        etsMpDisplayFormShopGroups();
    });
    etsMPDisplayFormCommissionUsage();
    $(document).on('click','input[name="ETS_MP_ALLOW_WITHDRAW"],input[name="ETS_MP_ALLOW_CONVERT_TO_VOUCHER"],input[name="ETS_MP_ALLOW_BALANCE_TO_PAY"]',function(){
        etsMPDisplayFormCommissionUsage();
    });
    if($('#active').length)
    {
        if($("#active").val()==1)
        {
            $('.form-group.seller_date').show();
        }
        else
            $('.form-group.seller_date').hide();
        if($("#active").val()==-3 || $("#active").val()==0)
        {
            $('.form-group.seller_reason').show();
        }
        else
            $('.form-group.seller_reason').hide();
    }
    $(document).on('change','#active',function(){
        if($("#active").val()==1)
        {
            $('.form-group.seller_date').show();
        }
        else
            $('.form-group.seller_date').hide();
        if($("#active").val()==-3 || $("#active").val()==0)
        {
            $('.form-group.seller_reason').show();
        }
        else
            $('.form-group.seller_reason').hide();
    });
    $(document).on('click','#shop_logo-images-thumbnails a',function(){
        if(!confirm(confim_delete_logo))
            return false;
    });
    $(document).on('click','.seller_categories .category',function(){
        if(!$(this).is(':checked'))
        {
            if($(this).parent().parent().next('.children').length)
            {
                $(this).parent().parent().next('.children').find('.category').prop('checked',false);
            }
        }
        else
        {
            $(this).parents('.children').prev('.has-child').find('.category').prop('checked',true);
        }
    });
    $('.seller_categories .category').each(function(){
        if($(this).parent().parent().next('.children').length)
        {
            if($(this).is(':checked'))
            {
                $(this).parent().parent().next('.children').show();
                $(this).parent().addClass('opend');
            }
            else
            {
                $(this).parent().parent().next('.children').hide();
                $(this).parent().removeClass('opend');
            }
        }   
    });
    $(document).on('click','.seller_categories .label',function(){
        $(this).parent().parent().next('.children').toggle();
        $(this).parent().toggleClass('opend');
    });
    $(document).on('click','.delete_seller_search',function(e){
        e.preventDefault();
        $('.seller_selected').remove();
        $('#id_seller').val('');
        $('#seller_name').val('');
    });
    if($('.form_search_seller #seller_name').length)
    {
        $('.form_search_seller #seller_name').autocomplete(ets_link_search_seller,{
    		minChars: 3,
    		autoFill: true,
    		max:20,
    		matchContains: true,
    		mustMatch:false,
    		scroll:false,
    		cacheLength:0,
    		formatItem: function(item) {
            return item[1]+' ('+item[2]+')';
    		}
    	}).result(etsMPAddSellerName);
    }
    setTimeout(function(){
        $('.alert.alert-success').remove(); 
        $('.module_error.alert').remove();
    }, 3000);
    $(document).on('click','.change_seller_status',function(){
       $('.ets_mp_status_seller').toggle(); 
       return false;
    });
    ets_mp_sidebar_height();
    $(window).load(function(){
        ets_mp_sidebar_height();
    });
    $(window).resize(function(){
        ets_mp_sidebar_height();
    });
    $(document).on('click','.ets_mp_close_popup,.btn-close-popup',function(){
        $('.ets_mp_popup').hide();
        return false;
    });
    $(document).on('submit','.ets_mp_assign_product form',function(){
       return false;
    });
    $(document).on('click','.approve_registration',function(){
        var $html ='<div class="ets_mp_popup ets_mp_status_seller" style="display:block">';
        $html +='<div class="mp_pop_table">';                                                                            
        $html +='<div class="mp_pop_table_cell">';                                                                                
        $html +='<form id="eamFormActionRegistration" class="form-horizontal " method="POST">';
        $html +=$(this).next('.approve_registration_form').html();
        $html +='</form></div></div></div>';
        if($('.etsmp-left-panel > .ets_mp-panel').prev('.ets_mp_status_seller').length)
            $('.etsmp-left-panel > .ets_mp-panel').prev('.ets_mp_status_seller').remove();
        $('.etsmp-left-panel > .ets_mp-panel:first').before($html);
        if ($(".ets_mp_datepicker input").length > 0) {
            $('.hasDatepicker').removeClass('hasDatepicker');
    		$(".ets_mp_datepicker input").datepicker({
    			dateFormat: 'yy-mm-dd',
                changeMonth: true,
                changeYear: true,
    		});
    	}
    });
    $(document).keyup(function(e) { 
        if(e.keyCode == 27) {
            if($('.ets_mp_popup').length >0)
                $('.ets_mp_popup').hide();
        }
    });
    $(document).mouseup(function (e)
    {
        if($('.ets_mp_popup').length >0)
        {
           if (!$('.ets_mp_popup').is(e.target)&& $('.ets_mp_popup').has(e.target).length === 0 && !$('.ui-datepicker').is(e.target) && $('.ui-datepicker').has(e.target).length === 0)
           {
                $('.ets_mp_popup').hide();
           } 
        }
        if($('#eamFormActionRegistration').length>0)
        {
            if (!$('#eamFormActionRegistration').is(e.target)&& $('#eamFormActionRegistration').has(e.target).length === 0 && !$('.ui-datepicker').is(e.target)&& $('.ui-datepicker').has(e.target).length === 0)
            {
                $('.ets_mp_popup').hide();
            } 
        }
        if($('#eamFormActionSellerBilling').length>0)
        {
            if (!$('#eamFormActionSellerBilling').is(e.target)&& $('#eamFormActionSellerBilling').has(e.target).length === 0 && !$('.ui-datepicker').is(e.target)&& $('.ui-datepicker').has(e.target).length === 0)
           {
                $('.ets_mp_popup').hide();
           } 
        }
    });
    ets_mpToggleFeePayment($('.payment_method_fee_type'));
    $(document).on('change', '.payment_method_fee_type', function (event) {
        ets_mpToggleFeePayment(this);
    });
    $(document).on('click', '.js-add-payment-method-field', function (event) {
        event.preventDefault();
        $this = $(this);
        if (typeof ets_mp_languages !== 'undefined' && ets_mp_languages) {
            ets_mpRenderFieldsMethodPayment(this, ets_mp_languages, ets_mp_currency);
        }
        else {
            $.ajax({
                url: ets_snw_link_ajax,
                type: 'GET',
                data: {
                    'getLanguage': true,
                },
                success: function (res) {
                    if (typeof res !== 'object') {
                        res = JSON.parse(res);
                    }
                    ets_mp_languages = res.languages;
                    ets_mpRenderFieldsMethodPayment($this, res.languages);
                }
            })
        }
    });
    $(document).on('click', '.js-btn-delete-field', function (event) { 
        event.preventDefault();
        if(confirm(confirm_delete_field_text)){
            $(this).closest('.payment-method-field').remove();
        }
    });
    if ($(".ets_mp_datepicker input").length > 0) {
		$(".ets_mp_datepicker input").datepicker({
			dateFormat: 'yy-mm-dd',
            changeMonth: true,
            changeYear: true,
		});
	}
    $(document).on('click','.checkbox_all input',function(){
        if($(this).is(':checked'))
        {
            $(this).closest('.form-group').find('input').prop('checked',true);
            $('.ets_mp_extrainput').each(function(){
                $('label[for="'+$(this).attr('id')+'_validate"]').show();
            });
        }
        else
        {
            $(this).closest('.form-group').find('input').prop('checked',false);
            $('.ets_mp_extrainput').each(function(){
                $('label[for="'+$(this).attr('id')+'_validate"]').hide();
            });
        }
    });
    $(document).on('click','.checkbox input',function(){
        if($(this).is(':checked'))
        {
            if($(this).closest('.form-group').find('input:checked').length==$(this).closest('.form-group').find('input[type="checkbox"]').length-1)
                 $(this).closest('.form-group').find('.checkbox_all input').prop('checked',true);
        }
        else
        {
            $(this).closest('.form-group').find('.checkbox_all input').prop('checked',false);
        } 
    });
    $(document).on('click','.table_ets_mp_registration_fields #ETS_MP_REGISTRATION_FIELDS_all',function(e){
        if($(this).is(':checked'))
            $('.table_ets_mp_registration_fields .registration_field').prop('checked',true);
        else
        {
            $('.table_ets_mp_registration_fields .registration_field').prop('checked',false);
            $('.table_ets_mp_registration_fields .registration_field_validate').prop('checked',false);
        }
        if($('.table_ets_mp_registration_fields .registration_field').length== $('.table_ets_mp_registration_fields .registration_field:checked').length)
            $('#ETS_MP_REGISTRATION_FIELDS_all').prop('checked',true);
        else
            $('#ETS_MP_REGISTRATION_FIELDS_all').prop('checked',false);
        if($('.table_ets_mp_registration_fields .registration_field_validate').length== $('.table_ets_mp_registration_fields .registration_field_validate:checked').length)
            $('#ETS_MP_REGISTRATION_FIELDS_VALIDATE_all').prop('checked',true);
        else
            $('#ETS_MP_REGISTRATION_FIELDS_VALIDATE_all').prop('checked',false);
    });
    $(document).on('click','.table_ets_mp_registration_fields #ETS_MP_REGISTRATION_FIELDS_VALIDATE_all',function(e){
        if($(this).is(':checked'))
        {
            $('.table_ets_mp_registration_fields .registration_field').prop('checked',true);
            $('.table_ets_mp_registration_fields .registration_field_validate').prop('checked',true);
        }
        else
           $('.table_ets_mp_registration_fields .registration_field_validate').prop('checked',false);
        if($('.table_ets_mp_registration_fields .registration_field').length== $('.table_ets_mp_registration_fields .registration_field:checked').length)
            $('#ETS_MP_REGISTRATION_FIELDS_all').prop('checked',true);
        else
            $('#ETS_MP_REGISTRATION_FIELDS_all').prop('checked',false);
        if($('.table_ets_mp_registration_fields .registration_field_validate').length== $('.table_ets_mp_registration_fields .registration_field_validate:checked').length)
            $('#ETS_MP_REGISTRATION_FIELDS_VALIDATE_all').prop('checked',true);
        else
            $('#ETS_MP_REGISTRATION_FIELDS_VALIDATE_all').prop('checked',false);
    });
    $(document).on('click','.table_ets_mp_contact_fields #ETS_MP_CONTACT_FIELDS_all',function(e){
        if($(this).is(':checked'))
            $('.table_ets_mp_contact_fields .contact_field').prop('checked',true);
        else
        {
            $('.table_ets_mp_contact_fields .contact_field').prop('checked',false);
            $('.table_ets_mp_contact_fields .contact_field_validate').prop('checked',false);
        }
        if($('.table_ets_mp_contact_fields .contact_field').length== $('.table_ets_mp_contact_fields .contact_field:checked').length)
            $('#ETS_MP_CONTACT_FIELDS_all').prop('checked',true);
        else
            $('#ETS_MP_CONTACT_FIELDS_all').prop('checked',false);
        if($('.table_ets_mp_contact_fields .contact_field_validate').length== $('.table_ets_mp_contact_fields .contact_field_validate:checked').length)
            $('#ETS_MP_CONTACT_FIELDS_VALIDATE_all').prop('checked',true);
        else
            $('#ETS_MP_CONTACT_FIELDS_VALIDATE_all').prop('checked',false);
    });
    $(document).on('click','.table_ets_mp_contact_fields #ETS_MP_CONTACT_FIELDS_VALIDATE_all',function(e){
        if($(this).is(':checked'))
        {
            $('.table_ets_mp_contact_fields .contact_field').prop('checked',true);
            $('.table_ets_mp_contact_fields .contact_field_validate').prop('checked',true);
        }
        else
           $('.table_ets_mp_contact_fields .contact_field_validate').prop('checked',false);
        if($('.table_ets_mp_contact_fields .contact_field').length== $('.table_ets_mp_contact_fields .contact_field:checked').length)
            $('#ETS_MP_CONTACT_FIELDS_all').prop('checked',true);
        else
            $('#ETS_MP_CONTACT_FIELDS_all').prop('checked',false);
        if($('.table_ets_mp_contact_fields .contact_field_validate').length== $('.table_ets_mp_contact_fields .contact_field_validate:checked').length)
            $('#ETS_MP_CONTACT_FIELDS_VALIDATE_all').prop('checked',true);
        else
            $('#ETS_MP_CONTACT_FIELDS_VALIDATE_all').prop('checked',false);
    });
    $(document).on('click','.table_ets_mp_registration_fields .registration_field',function(){
        if(!$(this).is(':checked'))
        {
            $(this).parent().parent().find('.registration_field_validate').prop('checked',false);
        }
        if($('.table_ets_mp_registration_fields .registration_field').length== $('.table_ets_mp_registration_fields .registration_field:checked').length)
            $('#ETS_MP_REGISTRATION_FIELDS_all').prop('checked',true);
        else
            $('#ETS_MP_REGISTRATION_FIELDS_all').prop('checked',false);
        if($('.table_ets_mp_registration_fields .registration_field_validate').length== $('.table_ets_mp_registration_fields .registration_field_validate:checked').length)
            $('#ETS_MP_REGISTRATION_FIELDS_VALIDATE_all').prop('checked',true);
        else
            $('#ETS_MP_REGISTRATION_FIELDS_VALIDATE_all').prop('checked',false);
    });
    $(document).on('click','.table_ets_mp_registration_fields .registration_field_validate',function(){
        if($(this).is(':checked'))
        {
            $(this).parent().parent().find('.registration_field').prop('checked',true);
        }
        if($('.table_ets_mp_registration_fields .registration_field').length== $('.table_ets_mp_registration_fields .registration_field:checked').length)
            $('#ETS_MP_REGISTRATION_FIELDS_all').prop('checked',true);
        else
            $('#ETS_MP_REGISTRATION_FIELDS_all').prop('checked',false);
        if($('.table_ets_mp_registration_fields .registration_field_validate').length== $('.table_ets_mp_registration_fields .registration_field_validate:checked').length)
            $('#ETS_MP_REGISTRATION_FIELDS_VALIDATE_all').prop('checked',true);
        else
            $('#ETS_MP_REGISTRATION_FIELDS_VALIDATE_all').prop('checked',false);
    });
    //
    $(document).on('click','.table_ets_mp_contact_fields .contact_field',function(){
        if(!$(this).is(':checked'))
        {
            $(this).parent().parent().find('.contact_field_validate').prop('checked',false);
        }
        if($('.table_ets_mp_contact_fields .contact_field').length== $('.table_ets_mp_contact_fields .contact_field:checked').length)
            $('#ETS_MP_CONTACT_FIELDS_all').prop('checked',true);
        else
            $('#ETS_MP_CONTACT_FIELDS_all').prop('checked',false);
        if($('.table_ets_mp_contact_fields .contact_field_validate').length== $('.table_ets_mp_contact_fields .contact_field_validate:checked').length)
            $('#ETS_MP_CONTACT_FIELDS_VALIDATE_all').prop('checked',true);
        else
            $('#ETS_MP_CONTACT_FIELDS_VALIDATE_all').prop('checked',false);
    });
    $(document).on('click','.table_ets_mp_contact_fields .contact_field_validate',function(){
        if($(this).is(':checked'))
        {
            $(this).parent().parent().find('.contact_field').prop('checked',true);
        }
        if($('.table_ets_mp_contact_fields .contact_field').length== $('.table_ets_mp_contact_fields .contact_field:checked').length)
            $('#ETS_MP_CONTACT_FIELDS_all').prop('checked',true);
        else
            $('#ETS_MP_CONTACT_FIELDS_all').prop('checked',false);
        if($('.table_ets_mp_contact_fields .contact_field_validate').length== $('.table_ets_mp_contact_fields .contact_field_validate:checked').length)
            $('#ETS_MP_CONTACT_FIELDS_VALIDATE_all').prop('checked',true);
        else
            $('#ETS_MP_CONTACT_FIELDS_VALIDATE_all').prop('checked',false);
    });
    if($('.confi_tab.active').length >0)
    {
        $('.ets_mp_form:not(.'+$('.confi_tab.active').data('tab-id')+')').hide();
    }
    $(document).on('click','input[name="ETS_MP_SAVE_CRONJOB_LOG"]',function(){
        $.ajax({
			type: 'POST',
			headers: { "cache-control": "no-cache" },
			url: '',
			async: true,
			cache: false,
			dataType : "json",
			data:'ETS_MP_SAVE_CRONJOB_LOG='+$('input[name="ETS_MP_SAVE_CRONJOB_LOG"]:checked').val(),
			success: function(json)
			{
                if(json.success)
                {
                    $.growl.notice({ message: json.success });
                }
                if(json.errors)
                {
                    $.growl.error({message:json.errors});
                }
            }
		});
    });
    $(document).on('click','.confi_tab',function(){
        if(!$(this).hasClass('active'))
        {
            $('.confi_tab').removeClass('active');
            $(this).addClass('active');
            $('.ets_mp_form.'+$('.confi_tab.active').data('tab-id')).show();
            $('.ets_mp_form:not(.'+$('.confi_tab.active').data('tab-id')+')').hide();
            $('#current_tab').val($('.confi_tab.active').data('tab-id'));
        }
    });
    $(document).on('click','.ets_mp_extrainput',function(){
        $('label[for="'+$(this).attr('id')+'_validate"]').toggle();
    });
    $(document).on('click','input[name="ETS_MP_SELLER_CAN_CREATE_VOUCHER"],input[name="ETS_MP_DISPLAY_TOP_SHOP"],input[name="ETS_MP_SELLER_PRODUCT_APPROVE_REQUIRED"],input[name="ETS_MP_EDIT_PRODUCT_APPROVE_REQUIRED"], input[name="ETS_MP_DISPLAY_FOLLOWED_SHOP"],input[name="ETS_MP_DISPLAY_PRODUCT_FOLLOWED_SHOP"],input[name="ETS_MP_DISPLAY_PRODUCT_TRENDING_SHOP"],input[name="ETS_MP_ENABLE_MAP"], input[name="ETS_MP_SEARCH_ADDRESS_BY_GOOGLE"],input[name="ETS_MP_ENABLE_CAPTCHA"],SELECT[name="ETS_MP_ENABLE_CAPTCHA_TYPE"],input[name="ETS_MP_SELLER_CREATE_PRODUCT_ATTRIBUTE"],input[name="ETS_MP_APPLICABLE_CATEGORIES"],input[name="ETS_MP_SELLER_FEE_TYPE"],input[name="ETS_MP_SELLER_CAN_CHANGE_ORDER_STATUS"]',function(){
        ets_mp_displayFormInput();
    });
    $('.form-group.commission_status input[type="checkbox"]').each(function(){
        if($(this).is(':checked'))
        {
            $('.form-group.commission_status input[type="checkbox"][value="'+$(this).val()+'"]:not(#'+$(this).attr('id')+')').parent().parent().hide();
        } 
    });
    $(document).on('click','.form-group.commission_status input[type="checkbox"]',function(){
        if($(this).is(':checked'))
        {
            if($('.form-group.commission_status input[value="'+$(this).val()+'"]:not(#'+$(this).attr('id')+'):checked').length>0)
            {
                
                $(this).prop('checked', false);
                showErrorMessage('Duplicate item'+$('.form-group.commission_status input[value="'+$(this).val()+'"]:not(#'+$(this).attr('id')+'):checked').attr('id'));
            }
            else
                $('.form-group.commission_status input[value="'+$(this).val()+'"]:not(#'+$(this).attr('id')+')').parent().parent().hide();
        }
        else
            $('.form-group.commission_status input[value="'+$(this).val()+'"]:not(#'+$(this).attr('id')+')').parent().parent().show();
    });
    $(document).on('click','.ets_mp-panel .list-action',function(){
        if(!$(this).hasClass('disabled'))
        {            
            $(this).addClass('disabled');
            var $this= $(this);
            $.ajax({
                url: $(this).attr('href')+'&ajax=1',
                data: {},
                type: 'post',
                dataType: 'json',                
                success: function(json){ 
                    if(json.success)
                    {
                        if(json.enabled=='1')
                        {
                            $this.removeClass('action-disabled').addClass('action-enabled');
                            $this.html('<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>');
                        }                        
                        else
                        {
                            $this.removeClass('action-enabled').addClass('action-disabled');
                            $this.html('<svg width="14" height="14" style="fill:red!important;" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>');
                        }
                        $this.attr('href',json.href);
                        $this.removeClass('disabled');
                        if(json.title)
                            $this.attr('title',json.title); 
                        $.growl.notice({ message: json.success }); 
                    }
                    if(json.errors)
                        $.growl.error({message:json.errors});
                        
                                                                
                },
                error: function(error)
                {                                      
                    $this.removeClass('disabled');
                }
            });
        }
        return false;
    });
    ets_mp_displayFormInput();
    if($('#list-payment-methods').length)
    {
        var $mypayment = $("#list-payment-methods");
    	$mypayment.sortable({
    		opacity: 0.6,
            handle: ".eam-active-sortable",
            cursor: 'move',
    		update: function() {
    			var order = $(this).sortable("serialize") + "&action=updatePaymentMethodOrdering";	
                var $this=  $(this);					
                $.ajax({
        			type: 'POST',
        			headers: { "cache-control": "no-cache" },
        			url: '',
        			async: true,
        			cache: false,
        			dataType : "json",
        			data:order,
        			success: function(json)
        			{
                        if(json.success)
                        {
                            $.growl.notice({ message: json.success });
                            var i=1;
                            $('#list-payment-methods tr').each(function(){
                                $(this).find('.sort-order').html(i);
                                i++;
                            });
                        }
                        if(json.errors)
                        {
                            $.growl.error({message:json.errors});
                            $mypayment.sortable("cancel");
                        }
                    }
        		});
    		},
        	stop: function( event, ui ) {
       		}
    	});
    }
    if($('#eam_method_fields_append').length)
    {
        var $myfield = $("#eam_method_fields_append");
    	$myfield.sortable({
    		opacity: 0.6,
            cursor: 'move',
    		update: function() {
    			var order = $(this).sortable("serialize") + "&action=updatePaymentMethodFieldOrdering";	
                var $this=  $(this);					
                $.ajax({
        			type: 'POST',
        			headers: { "cache-control": "no-cache" },
        			url: '',
        			async: true,
        			cache: false,
        			dataType : "json",
        			data:order,
        			success: function(json)
        			{
                        if(json.success)
                        {
                            $.growl.notice({ message: json.success });
                        }
                        if(json.errors)
                        {
                            $.growl.error({message:json.errors});
                            $myfield.sortable("cancel");
                        }
                    }
        		});
    		},
        	stop: function( event, ui ) {
       		}
    	});
    }
    $(document).on('change','#eamFormActionCommissionUser select[name="action"]',function(){
        if($(this).val()=='deduct')
        {
            $('button[name="deduct_commission_by_admin"]').show();
            $('button[name="add_commission_by_admin"]').hide();
            $('textarea[name="reason"]').val(reason_deducted_text);
        }
        else
        {
            $('button[name="deduct_commission_by_admin"]').hide();
            $('button[name="add_commission_by_admin"]').show();
            $('textarea[name="reason"]').val(reason_added_text);
        }
    });
    $(document).on('click','button[name="ets_mp_general_token"]',function(e){
        e.preventDefault();
        var chars = "123456789ABCDEFGHIJKLMNPQRSTUVWXYZ";
        var code = '';
        for (var i = 1; i <= 12; ++i) {
            code += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        $('#ETS_MP_CRONJOB_TOKEN').val(code);
    });
    $(document).on('click','input[name="etsmpSubmitUpdateToken"]',function(){
        $.ajax({
			type: 'POST',
			headers: { "cache-control": "no-cache" },
			url: '',
			async: true,
			cache: false,
			dataType : "json",
			data:'etsmpSubmitUpdateToken=1&ETS_MP_CRONJOB_TOKEN='+$('#ETS_MP_CRONJOB_TOKEN').val(),
			success: function(json)
			{
                if(json.success)
                {
                    $.growl.notice({ message: json.success });
                    $('.js-emp-test-cronjob').attr('data-secure',$('#ETS_MP_CRONJOB_TOKEN').val());
                    $('.emp-cronjob-secure-value').html($('#ETS_MP_CRONJOB_TOKEN').val());
                }
                if(json.errors)
                {
                    $.growl.error({message:json.errors});
                }
            }
		});
    });
    $(document).on('click','.js-emp-test-cronjob',function(e){
        e.preventDefault();
        if(!$(this).hasClass('loading'))
        {   $(this).addClass('loading');
            var url_ajax= $(this).attr('href');
            var secure = $(this).attr('data-secure');
            $.ajax({
    			type: 'POST',
    			headers: { "cache-control": "no-cache" },
    			url: '',
    			async: true,
    			cache: false,
    			dataType : "json",
    			data:'submitCronjob&ajax=1&secure='+secure,
    			success: function(json)
    			{
                    if(json.success)
                    {
                        $.growl.notice({ message: json.success });
                        $('.cronjob_log').val(json.cronjob_log);
                    }
                    if(json.errors)
                    {
                        $.growl.error({message:json.errors});
                    }
                    $('.js-emp-test-cronjob').removeClass('loading');
                }
    		});
        }
        
    });
    $(document).on('click','button[name="etsmpSubmitClearLog"]',function(e){
        e.preventDefault();
        $(this).addClass('loading');
        $.ajax({
			type: 'POST',
			headers: { "cache-control": "no-cache" },
			url: '',
			async: true,
			cache: false,
			dataType : "json",
			data:'ajax=1&etsmpSubmitClearLog=1',
			success: function(json)
			{
                if(json.success)
                {
                    $.growl.notice({ message: json.success });
                    $('.cronjob_log').val('');
                }
                if(json.errors)
                {
                    $.growl.error({message:json.errors});
                }
                $('button[name="etsmpSubmitClearLog"]').removeClass('loading');
            }
		});
    });
    $(document).on('click','.btn-approve-change',function(e){
        e.preventDefault();
        if(!$(this).hasClass('loading'))
        {
            var id_product = $(this).data('id_product');
            $(this).addClass('loading');
            var $this = $(this);
            $.ajax({
    			type: 'POST',
    			headers: { "cache-control": "no-cache" },
    			url: '',
    			async: true,
    			cache: false,
    			dataType : "json",
    			data:'ajax=1&etsmpSubmitApproveChanged=1&id_product='+id_product,
    			success: function(json)
    			{
                    $this.removeClass('loading');
                    if(json.success)
                    {
                        $.growl.notice({ message: json.success });
                        $('#list-mp_products tr[data-id="'+id_product+'"] td.name a').html(json.product_name);
                        $('#list-mp_products tr[data-id="'+id_product+'"] td.price').html(json.product_price);
                        $('#list-mp_products tr[data-id="'+id_product+'"] td.wait_change').html('--');
                        $('#list-mp_products tr[data-id="'+id_product+'"] td.date_add').html(json.date_add);
                        $('.ets_mp_popup.ets_mp_approve_product').remove();
                    }
                    if(json.errors)
                    {
                        $.growl.error({message:json.errors});
                    }
                },
                error: function(error)
                {                                      
                    $this.removeClass('loading');
                }
                
    		});
        }
    });
    $(document).on('click','.btn-view-change-product',function(e){
        e.preventDefault(); 
        if(!$(this).hasClass('loading'))
        {
            var $this = $(this);
            var url_ajax = $(this).data('href');
            var id_product = $(this).data('id_product');
            if($('.ets_mp_popup.ets_mp_approve_product[data-id_product="'+id_product+'"]').length)
            {
                $('.ets_mp_popup.ets_mp_approve_product[data-id_product="'+id_product+'"]').show();
            }
            else
            {
                $(this).addClass('loading');
                $('.ets_mp_popup.ets_mp_approve_product').remove();
                $.ajax({
        			type: 'POST',
        			headers: { "cache-control": "no-cache" },
        			url: url_ajax,
        			async: true,
        			cache: false,
        			dataType : "json",
        			data:'ajax=1',
        			success: function(json)
        			{
                        $this.removeClass('loading');
                        $('.etsmp-left-panel').append('<div class="ets_mp_popup ets_mp_approve_product" style="display:block" data-id_product="'+id_product+'"><div class="mp_pop_table ets_table"><div class="ets_table-cell">'+json.form_html+'</div></div></div>');
                    },
                    error: function(error)
                    {                                      
                        $this.removeClass('loading');
                    }
                    
        		});
            }
            
        }
    });
    $(document).on('click','.btn-decline-change-product',function(e){
        e.preventDefault(); 
        $('.ets_mp_popup_child.ets_mp_decline_product').show();
    });
    $(document).on('click','.btn-assign-product',function(e){
        e.preventDefault();
        $('#id_customer_seller').val('');
        $('.seller_selected').parent().removeClass('has_seller');
        $('.seller_selected').remove();
        $('.ets_mp_popup.ets_mp_assign_product').show();
        $('.ets_mp_popup.ets_mp_assign_product input[name="id_product"]').val($(this).data('id_product'));
    });
    $(document).on('click','.btn-assign-products',function(e){
        e.preventDefault();
        $('#id_customer_seller').val('');
        $('.seller_selected').parent().removeClass('has_seller');
        $('.seller_selected').remove();
        if($('input[name="bulk_action_selected_products[]"]:checked').length)
        {
            $('.ets_mp_popup.ets_mp_assign_product').show();
            var ids = '';
            $('input[name="bulk_action_selected_products[]"]:checked').each(function(){
                ids += $(this).val()+',';
            });
            $('.ets_mp_popup.ets_mp_assign_product input[name="id_product"]').val(ids);
        }

    });
    $(document).on('click','.ets_mp_close_child,.btn-close-popup-child',function(e){
        e.preventDefault(); 
        $('.ets_mp_popup_child').hide();
    });
    $(document).on('click','button[name="btnSubmitDeclineChangeProduct"]',function(e){
       e.preventDefault();
       var formData = new FormData($(this).parents('form').get(0));
       if(!$(this).hasClass('loading'))
       {
            $(this).addClass('loading');
            $.ajax({
    			type: 'POST',
    			headers: { "cache-control": "no-cache" },
    			url: '',
    			async: true,
    			cache: false,
    			dataType : "json",
    			data:formData,
                processData: false,
                contentType: false,
    			success: function(json)
    			{
                    $('button[name="btnSubmitDeclineChangeProduct"]').removeClass('loading');
                    if(json.success)
                    {
                        $.growl.notice({ message: json.success });
                        $('.ets_mp_popup').hide();
                        $('.ets_mp_popup_child').remove();
                        $('#list-mp_products tr[data-id="'+json.id_product+'"] .btn-decline-change').remove();
                        $('.btn-decline-change-product').remove();
                    }
                    if(json.errors)
                    {
                        $.growl.error({message:json.errors});
                    }
                }
    		});
       }
    });
    $(document).on('click','button[name="btnSubmitAssignProduct"]',function(e){
        e.preventDefault();
        var formData = new FormData($(this).parents('form').get(0));
        if(!$(this).hasClass('loading'))
        {
            $(this).addClass('loading');
            $.ajax({
                type: 'POST',
                headers: { "cache-control": "no-cache" },
                url: '',
                async: true,
                cache: false,
                dataType : "json",
                data:formData,
                processData: false,
                contentType: false,
                success: function(json)
                {
                    $('button[name="btnSubmitAssignProduct"]').removeClass('loading');
                    if(json.success)
                    {
                        $.growl.notice({ message: json.success });
                        $('.ets_mp_popup').hide();
                        if(json.products)
                        {
                            $(json.products).each(function(){
                                var row =$('#list-mp_products tr[data-id="'+this.id_product+'"]');
                                row.find('.shop_name').html('<a href="'+this.shop_link+'" target="_blank">'+this.shop_name+'</a>');
                                row.find('.btn-assign-product').remove();
                            });
                        }
                    }
                    if(json.errors)
                    {
                        $.growl.error({message:json.errors});
                    }
                }
            });
        }
    });
    $(document).on('click','.wait_change .btn-decline-change',function(e){
        e.preventDefault(); 
        var id_product = $(this).data('id_product');
        var html ='<div class="ets_mp_popup_child ets_mp_decline_product" style="">';
            html +=    '<div class="mp_pop_table_child ets_table">';
            html +=        '<div class="ets_table-cell">';
            html +=            '<form method="post" action="">';
            html +=                '<div class="ets_mp_close_child" title="Close">'+Close_text+'</div>';
            html +=                '<div class="form-wrapper">';
            html +=                    '<div class="form-group">';
            html +=                        '<label class="col-lg-3 control-label">'+Status_text+':</label>';
            html +=                        '<div class="col-lg-3">';
            html +=                            '<span class="ets_pmn_status decline">'+Declined_text+'</span>';
            html +=                        '</div>';
            html +=                    '</div>';
            html +=                    '<div class="form-group">';
            html +=                        '<label class="col-lg-3 control-label" for="reason_decline">'+Reason_text+'</label>';
            html +=                        '<div class="col-lg-9">';
            html +=                            '<textarea class="" name="reason_decline" id="reason_decline"></textarea>';
            html +=                        '</div>';
            html +=                    '</div>';
            html +=                '</div>';
            html +=                '<div class="panel-footer">';
            html +=                    '<input name="id_product" value="'+id_product+'" type="hidden">';
            html +=                    '<input name="btnSubmitDeclineChangeProduct" value="1" type="hidden">';
            html +=                    '<button class="btn btn-default btn-close-popup-child">';
            html +=                        '<svg width="30" height="30" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>';
            html +=                        Cancel_text;
            html +=                    '</button>';
            html +=                    '<button class="btn btn-default pull-right" type="button" value="1" name="btnSubmitDeclineChangeProduct">';
            html +=                        '<svg width="30" height="30" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg>';
            html +=                        Save_text;
            html +=                    '</button>';
            html +=                '</div>';
            html +=            '</form> ';
            html +=        '</div>';
            html +=    '</div>';
            html +='</div>';
        if($('.etsmp-left-panel >.ets_mp-panel').next('.ets_mp_popup_child').length)
            $('.etsmp-left-panel >.ets_mp-panel').next('.ets_mp_popup_child').remove();
        $('.etsmp-left-panel >.ets_mp-panel').after(html);
    });
});
function ets_mp_sidebar_height()
{
    var sidebar_height = $('.etsmp-left-panel.etsmp-sidebar-menu').height();
    $('.etsmp-sidebar-height').height(sidebar_height);
}
function ets_mp_displayFormInput()
{
    if($('input[name="ETS_MP_SELLER_FEE_TYPE"]').length)
    {
        if($('input[name="ETS_MP_SELLER_FEE_TYPE"]:checked').val()!='no_fee')
        {
            $('.form-group.ets_mp_fee').show();
            $('.form-group.ets_mp_no_fee').hide();
        }
        else
        {
            $('.form-group.ets_mp_fee').hide();
            $('.form-group.ets_mp_no_fee').show();
        }
    }
    if($('input[name="ETS_MP_SELLER_CAN_CREATE_VOUCHER"]').length)
    {
        if($('input[name="ETS_MP_SELLER_CAN_CREATE_VOUCHER"]:checked').val()==1)
        {
            $('.form-group.limit_user_code').show();
        }
        else
        {
            $('.form-group.limit_user_code').hide();
        }
    }
    if($('input[name="ETS_MP_SELLER_CAN_CHANGE_ORDER_STATUS"]:checked').val()==1)
        $('.form-group.ets_mp_allowed_statuses').show();
    else
        $('.form-group.ets_mp_allowed_statuses').hide();
    if($('input[name="ETS_MP_APPLICABLE_CATEGORIES"]:checked').val()=='all_product_categories' || $('input[name="ETS_MP_APPLICABLE_CATEGORIES"]:checked').val()=='default')
    {
        $('.form-group.seller_categories').hide();
    }
    else
    {
        $('.form-group.seller_categories').show();
    }
    if($('input[name="ETS_MP_ENABLE_CAPTCHA"]:checked').val()==1)
    {
        $('.form-group.captcha').show();
        if($('#ETS_MP_ENABLE_CAPTCHA_TYPE').val()=='google_v2')
            $('.form-group.captcha.v3').hide();
        else
            $('.form-group.captcha.v2').hide();
    }
    else
        $('.form-group.captcha').hide();
    if($('input[name="ETS_MP_SELLER_PRODUCT_APPROVE_REQUIRED"]:checked').val()==1)
    {
        $('.form-group.approve_edit').show();
        if($('input[name="ETS_MP_EDIT_PRODUCT_APPROVE_REQUIRED"]:checked').val()==1)
        {
            $('.form-group.approve_edit.field_approve').show();
            
        }
        else
        {
            $('.form-group.approve_edit.field_approve').hide();
        }
    }
    else
    {
        $('.form-group.approve_edit').hide();
    }
    if($('input[name="ETS_MP_SEARCH_ADDRESS_BY_GOOGLE"]:checked').val()==0)
        $('.form-group.map.search').hide();
    else
        $('.form-group.map.search').show();
    if($('input[name="ETS_MP_DISPLAY_FOLLOWED_SHOP"]:checked').val()==0)
        $('.form-group.shop_home').hide();
    else
        $('.form-group.shop_home').show();
    if($('input[name="ETS_MP_DISPLAY_PRODUCT_FOLLOWED_SHOP"]:checked').val()==0)
        $('.form-group.shop_product_home').hide();
    else
        $('.form-group.shop_product_home').show();
    if($('input[name="ETS_MP_DISPLAY_PRODUCT_TRENDING_SHOP"]:checked').val()==0)
        $('.form-group.trending_product_home').hide();
    else
        $('.form-group.trending_product_home').show();
    if($('input[name="ETS_MP_DISPLAY_TOP_SHOP"]:checked').val()==0)
        $('.form-group.top_shop_home').hide();
    else
        $('.form-group.top_shop_home').show();    
        
    if($('input[name="ETS_MP_SELLER_CREATE_PRODUCT_ATTRIBUTE"]:checked').val()==0)
        $('.form-group.create_attribute').hide();
    else
        $('.form-group.create_attribute').show()
}
function ets_mpHideOtherLang(id_lang) {
    $('.trans_field').addClass('hidden');
    $('.trans_field_' + id_lang).removeClass('hidden');
}
function ets_mpToggleFeePayment(input) {
    if (typeof input !== 'object') {
        input = $(input + ':selected');
    }
    if ($(input).val() == 'FIXED') {
        $(input).closest('.payment-method').find('.payment_method_fee_percent').closest('.form-group').hide();
        $(input).closest('.payment-method').find('.payment_method_fee_fixed').closest('.form-group').show();
    }
    else if ($(input).val() == 'PERCENT') {
        $(input).closest('.payment-method').find('.payment_method_fee_percent').closest('.form-group').show();
        $(input).closest('.payment-method').find('.payment_method_fee_fixed').closest('.form-group').hide();
    }
    else {
        $(input).closest('.payment-method').find('.payment_method_fee_percent').closest('.form-group').hide();
        $(input).closest('.payment-method').find('.payment_method_fee_fixed').closest('.form-group').hide();
    }
}
function ets_mpRenderFieldsMethodPayment(input, langs, currency) {
    var date = new Date();
    var rand_num = parseInt(date.getTime());
    method_name_html = '';
    method_name_html += '<div class="form-group payment-method-field">';
        method_name_html += '<div class="form-group row">';
            method_name_html += '<label class="control-label required col-lg-3">' + method_field_title + '</label>';
            method_name_html += '<div class="col-lg-6">';
            for (var l = 0; l < langs.length; l++) {
                lang = langs[l];
                method_name_html += '<div class="form-group row trans_field trans_field_' + lang.id_lang + ' ' + (l > 0 ? 'hidden' : '') + '">';
                method_name_html += '<div class="col-lg-9">';
                method_name_html += '<input type="text" name="payment_method_field['+rand_num+'][title][' + lang.id_lang + ']" value="" class="form-control '+(lang.id_lang == currency.id ? 'required' : '')+'" data-error="'+pmf_title_required+'">';
                method_name_html += '</div>';
                method_name_html += '<div class="col-lg-2">';
                method_name_html += '<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">';
                method_name_html += lang.iso_code + ' ';
                method_name_html += '<span class="caret"></span>';
                method_name_html += '</button>';
                method_name_html += '<ul class="dropdown-menu">';
                for (var i = 0; i < langs.length; i++) {
                    method_name_html += '<li><a href="javascript:ets_mpHideOtherLang(' + langs[i].id_lang + ')" title="">' + langs[i].name + '</a></li>';
                }
                method_name_html += '</ul>';
                method_name_html += '</div>';
                method_name_html += '</div>';
            }
            method_name_html += '</div>';
        method_name_html += '</div>';
    method_name_html += '<div class="form-group row">';
    method_name_html += '<label class="control-label col-lg-3">' + method_field_type + '</label>';
    method_name_html += '<div class="col-lg-5">';
    method_name_html += '<select name="payment_method_field['+rand_num+'][type]" class="form-control">';
    method_name_html += '<option value="text" selected>Text</option>';
    method_name_html += '<option value="textarea">Textarea</option>';
    method_name_html += '</select>';
    method_name_html += '</div>';
    method_name_html += '</div>';
    method_name_html += '<div class="form-group row">';
        method_name_html += '<label class="control-label col-lg-3">' + method_description_text + '</label>';
        method_name_html += '<div class="col-lg-6">';
        for (var l = 0; l < langs.length; l++) {
            lang = langs[l];
            method_name_html += '<div class="form-group row trans_field trans_field_' + lang.id_lang + ' ' + (l > 0 ? 'hidden' : '') + '">';
            method_name_html += '<div class="col-lg-9">';
            method_name_html += '<textarea name="payment_method_field['+rand_num+'][description][' + lang.id_lang + ']" class="form-control"></textarea>';
            method_name_html += '</div>';
            method_name_html += '<div class="col-lg-2">';
            method_name_html += '<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">';
            method_name_html += lang.iso_code + ' ';
            method_name_html += '<span class="caret"></span>';
            method_name_html += '</button>';
            method_name_html += '<ul class="dropdown-menu">';
            for (var i = 0; i < langs.length; i++) {
                method_name_html += '<li><a href="javascript:ets_mpHideOtherLang(' + langs[i].id_lang + ')" title="">' + langs[i].name + '</a></li>';
            }
            method_name_html += '</ul>';
            method_name_html += '</div>';
            method_name_html += '</div>';
        }
        method_name_html += '</div>';   
        method_name_html += '<div class="col-lg-1">';
            method_name_html += '<a class="btn btn-default btn-sm btn-delete-field js-btn-delete-field" href="javascript:void(0)"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> ' + delete_text + '</a>';
        method_name_html += '</div>';
    method_name_html += '</div>';
    
    method_name_html += '<div class="form-group row ">';
        method_name_html += '<label class="control-label col-lg-3">'+required_text+'</label>';
        method_name_html += '<div class="col-lg-3">';
            method_name_html += '<select name="payment_method_field['+rand_num+'][required]" class="form-control">';
                method_name_html += '<option value="1">'+yes_text+'</option>';
                method_name_html += '<option value="0">'+no_text+'</option>';
            method_name_html += '</select>';
        method_name_html += '</div>';
    method_name_html +=  '</div>';

    method_name_html += '<div class="form-group row ">';
        method_name_html += '<label class="control-label col-lg-3">'+Enabled_text+'</label>';
        method_name_html += '<div class="col-lg-9">';
            method_name_html +=  '<span class="switch prestashop-switch fixed-width-lg">';
            method_name_html += '<input type="radio" name="payment_method_field['+rand_num+'][enable]" id="payment_method_field_'+rand_num+'_enable_on" value="1" class="payment_method_field_enable" checked="checked">';
            method_name_html += '<label for="payment_method_field_'+rand_num+'_enable_on">'+yes_text+'</label>';
            method_name_html += '<input type="radio" name="payment_method_field['+rand_num+'][enable]" id="payment_method_field_'+rand_num+'_enable_off" class="payment_method_field_enable" value="0">';
            method_name_html += '<label for="payment_method_field_'+rand_num+'_enable_off">'+no_text+'</label>';
            method_name_html += '<a class="slide-button btn"></a>';
            method_name_html += '</span>'
        method_name_html += '</div>';
    method_name_html +=  '</div>';
    
    method_name_html += '</div>';

    $(input).closest('.form-group').before(method_name_html);
}
function ets_mp_getRegistrationSecretKeyMin(){
    return typeof ets_mp_registration_secret_key_min != 'undefined' ? parseInt(ets_mp_registration_secret_key_min) : 62;
}
function ets_mp_refreshRegistrationSecretKeyCounter(){
    var $secret_key = $('#ets_mp_secret_key');
    if(!$secret_key.length)
        return;
    var length = $.trim($secret_key.val()).length;
    var min_length = ets_mp_getRegistrationSecretKeyMin();
    var $counter = $('.ets_mp_secret_key_counter');
    $counter.text(length+' / '+min_length);
    $counter.css('color', length >= min_length ? '#4cbb6c' : '#c9564b');
    if(length >= min_length)
    {
        $secret_key.closest('.ets_mp_secret_key_wrapper').removeClass('has-error');
        $('.ets_mp_secret_key_message').hide().empty();
    }
}
function ets_mp_checkRegistrationSecretKey(){
    var $secret_key = $('#ets_mp_secret_key');
    if(!$secret_key.length)
        return true;
    if($.trim($secret_key.val()).length >= ets_mp_getRegistrationSecretKeyMin())
    {
        $secret_key.closest('.ets_mp_secret_key_wrapper').removeClass('has-error');
        $('.ets_mp_secret_key_message').hide().empty();
        return true;
    }
    var message = typeof ets_mp_registration_secret_key_error != 'undefined' ? ets_mp_registration_secret_key_error : '';
    $secret_key.closest('.ets_mp_secret_key_wrapper').addClass('has-error');
    $('.ets_mp_secret_key_message').text(message).show();
    if(message && typeof $.growl != 'undefined')
        $.growl.error({message: message});
    $secret_key.focus();
    return false;
}
$(document).on('input keyup change','#ets_mp_secret_key',function(){
    ets_mp_refreshRegistrationSecretKeyCounter();
});
$(document).ready(function(){
    ets_mp_refreshRegistrationSecretKeyCounter();
});
$(document).on('click','.ets_mp_secret_key_save',function(){
    var $this = $(this);
    if($this.hasClass('loading'))
        return false;
    if(!ets_mp_checkRegistrationSecretKey())
        return false;
    $this.addClass('loading');
    $.ajax({
        type: 'POST',
        headers: { "cache-control": "no-cache" },
        url: '',
        async: true,
        cache: false,
        dataType : "json",
        data:'ajax=1&submitSecretKey=1&id_registration='+$this.data('id')+'&secret_key='+encodeURIComponent($('#ets_mp_secret_key').val()||''),
        success: function(json)
        {
            $this.removeClass('loading');
            if(json.success)
                $.growl.notice({ message: json.success });
            if(json.errors)
                $.growl.error({message:json.errors});
        },
        error: function(xhr, status, error)
        {
            $this.removeClass('loading');
        }
    });
    return false;
});
$(document).on('click','.action_approve_registration',function(){
    if(!ets_mp_checkRegistrationSecretKey())
        return false;
    ets_mp_registrationUpdateStatus($(this),$(this).data('id'),1);
});
$(document).on('click','button[name="saveStatusRegistration"]',function(e){
    e.preventDefault();
    var active_registration = $('#eamFormActionRegistration input[name="active_registration"]').val();
    if(active_registration == 1 && !ets_mp_checkRegistrationSecretKey())
        return false;
    ets_mp_registrationUpdateStatus($(this),$('#eamFormActionRegistration input[name="id_registration"]').val(),active_registration);
});
$(document).on('click','button[name="saveStatusSeller"]',function(e){
    e.preventDefault();
    var $this= $(this);
    if(!$this.hasClass('loading'))
    {
        $this.addClass('loading');
        var formData = new FormData($(this).parents('form').get(0));
        formData.append('ajax', 1);
        formData.append('saveStatusSeller', 1);
        $.ajax({
            url: '',
            data: formData,
            type: 'post',
            dataType: 'json',
            processData: false,
            contentType: false,
            success: function(json){
                $this.removeClass('loading');
                if(json.success)
                {
                    $.growl.notice({ message: json.success });
                    if($('#list-ets_seller').length>0)
                    {
                        if($('tr[data-id="'+json.id_seller+'"] .active').length)
                        {
                            $('tr[data-id="'+json.id_seller+'"]').find('.active').html(json.status);
                        }
                        $('tr[data-id="'+json.id_seller+'"] .action_approve_seller').parent().show();
                        $('tr[data-id="'+json.id_seller+'"] .action_decline_seller').parent().show();
                        $('tr[data-id="'+json.id_seller+'"] .action_disable_seller').parent().show();
                        if(json.active==1)
                        {
                            $('tr[data-id="'+json.id_seller+'"] .action_approve_seller').parent().hide();
                        }
                        if(json.active==0)
                            $('tr[data-id="'+json.id_seller+'"] .action_disable_seller').parent().hide();
                        if(json.active!=-1)
                            $('tr[data-id="'+json.id_seller+'"] .action_decline_seller').parent().hide();
                        if(json.payment_verify)
                            $('tr[data-id="'+json.id_seller+'"] .payment_verify').html(json.payment_verify);
                    }
                    else
                    {
                        if(json.payment_verify)
                            $('.payment_verify').html(json.payment_verify);
                        if(!$('.ets_mp_status.vacation').length)
                        {
                            $('.seller-status').html(json.status);
                        }
                        $('.action_approve_seller').show();
                        $('.action_decline_seller').show();
                        $('.action_disable_seller').show();
                        if(json.active==1)
                        {
                            $('.action_approve_seller').hide();
                            $('.change_date_seller').show();
                            $('.date_seller_approve').html(json.date_approved); 
                        }
                        else
                            $('.change_date_seller').hide();
                        if(json.active==0)
                            $('.action_disable_seller').hide();
                        if(json.active!=-1)
                            $('.action_decline_seller').hide();
                    }
                    $('.ets_mp_popup').hide();
                    
                }
                if(json.errors)
                {
                    $.growl.error({message:json.errors});
                }
                
            },
            error: function(xhr, status, error)
            {
                $this.removeClass('loading');            
            }
        });
    }
});
$(document).on('click','button[name="submitDeclineProductSeller"]',function(e){
    e.preventDefault();
    if(!$(this).hasClass('loading'))
    {
        $(this).addClass('loading');
        
        var formData = new FormData($(this).parents('form').get(0));
        formData.append('submitDeclineProductSeller',1);
        $.ajax({
            url: '',
            data: formData,
            type: 'post',
            dataType: 'json',
            processData: false,
            contentType: false,
            success: function(json){
                $('button[name="submitDeclineProductSeller"]').removeClass('loading');
                if(json.success)
                {
                    $.growl.notice({ message: json.success });
                    $('.ets_mp_popup').hide();
                    $('#list-mp_products tr[data-id="'+json.id_product+'"] td.active i.fa').html('<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1440 893q0-161-87-295l-754 753q137 89 297 89 111 0 211.5-43.5t173.5-116.5 116-174.5 43-212.5zm-999 299l755-754q-135-91-300-91-148 0-273 73t-198 199-73 274q0 162 89 299zm1223-299q0 157-61 300t-163.5 246-245 164-298.5 61-298.5-61-245-164-163.5-246-61-300 61-299.5 163.5-245.5 245-164 298.5-61 298.5 61 245 164 163.5 245.5 61 299.5z"/></svg>').parent().removeClass('.action-pending').addClass('action-disabled');
                    $('#list-mp_products tr[data-id="'+json.id_product+'"] .action_decline_product').hide();
                }
                if(json.errors)
                {
                    $.growl.error({message:json.errors});
                }
            },
            error: function(xhr, status, error)
            {
                $('button[name="submitDeclineProductSeller"]').removeClass('loading');            
            }
        });
    }
});
$(document).on('click','.action_approve_product',function(e){
    e.preventDefault();
    if(!$(this).hasClass('loading'))
    {
        $(this).addClass('loading');
        var $this = $(this);
        var id_product = $(this).data('id');
        $.ajax({
            url: '',
            data: 'change_enabled=1&id_product='+id_product+'&field=active',
            type: 'post',
            dataType: 'json',
            success: function(json){
                $this.removeClass('loading');
                if(json.success)
                {
                    $.growl.notice({ message: json.success });
                    $('.ets_mp_popup').hide();
                    $('#list-mp_products tr[data-id="'+id_product+'"] td.active i.fa').html('<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1440 893q0-161-87-295l-754 753q137 89 297 89 111 0 211.5-43.5t173.5-116.5 116-174.5 43-212.5zm-999 299l755-754q-135-91-300-91-148 0-273 73t-198 199-73 274q0 162 89 299zm1223-299q0 157-61 300t-163.5 246-245 164-298.5 61-298.5-61-245-164-163.5-246-61-300 61-299.5 163.5-245.5 245-164 298.5-61 298.5 61 245 164 163.5 245.5 61 299.5z"/></svg>').parent().removeClass('.action-pending').addClass('action-disabled');
                    $('#list-mp_products tr[data-id="'+id_product+'"] .action_decline_product').hide();
                    $('#list-mp_products tr[data-id="'+id_product+'"] td.active a').removeClass('action-disabled').addClass('action-enabled');
                    $('#list-mp_products tr[data-id="'+id_product+'"] td.active a').html('<svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1671 566q0 40-28 68l-724 724-136 136q-28 28-68 28t-68-28l-136-136-362-362q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 295 656-657q28-28 68-28t68 28l136 136q28 28 28 68z"/></svg>');
                    $this.parent().hide();
                }
                if(json.errors)
                {
                    $.growl.error({message:json.errors});
                }
            },
            error: function(xhr, status, error)
            {
                $this.removeClass('loading');            
            }
        });
    }
});
function ets_mp_registrationUpdateStatus($this,id_registration,active_registration){
    $this.addClass('loading');
    $.ajax({
		type: 'POST',
		headers: { "cache-control": "no-cache" },
		url: '',
		async: true,
		cache: false,
		dataType : "json",
		data:'ajax=1&saveStatusRegistration=1&id_registration='+id_registration+'&active_registration='+active_registration+'&reason='+$('#eamFormActionRegistration textarea[name="reason"]').val()+'&secret_key='+encodeURIComponent($('#ets_mp_secret_key').val()||''),
		success: function(json)
		{
            if(json.success)
            {
                $.growl.notice({ message: json.success });
                if($('#list-ets_registration').length>0)
                {
                    $('tr[data-id="'+json.id_seller+'"]').find('.active').html(json.status);
                    if(active_registration==1)
                    {
                        $('tr[data-id="'+json.id_seller+'"]').find('.action_approve_registration').hide();
                        if(json.seller)
                        {
                            $('tr[data-id="'+json.id_seller+'"]').find('.action_decline_registration').hide();
                            $('tr[data-id="'+json.id_seller+'"]').find('.approve_registration.declined').hide();
                        }
                        else
                        {
                            $('tr[data-id="'+json.id_seller+'"]').find('.action_decline_registration').show();
                            $('tr[data-id="'+json.id_seller+'"]').find('.approve_registration.declined').show();
                        }
                    }
                    else
                    {
                        $('tr[data-id="'+json.id_seller+'"]').find('.action_decline_registration').hide();
                        $('tr[data-id="'+json.id_seller+'"]').find('.approve_registration.declined').hide();
                        $('tr[data-id="'+json.id_seller+'"]').find('.action_approve_registration').show();
                    }
                }
                else
                {
                    $('.registration-status').html(json.status);
                    if(active_registration==1)
                    {
                        $('.action_approve_registration').hide();
                        if(json.seller)
                        {
                            $('.action_decline_registration').hide();
                            $('.approve_registration.declined').hide();
                        }
                        else
                        {
                            $('.action_decline_registration').show();
                            $('.approve_registration.declined').show();
                        }
                    }
                    else
                    {
                        $('.action_decline_registration').hide();
                        $('.approve_registration.declined').hide();
                        $('.action_approve_registration').show();
                    }
                }
                $('.ets_mp_popup').hide();
                
            }
            if(json.errors)
            {
                $.growl.error({message:json.errors});
            }
            $this.removeClass('loading');
        }
	});  
}
$(document).on('change','input[name="shop_logo"],input[name="logo"]',function(){
    var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
    if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) != -1) {
        ets_mp_readShopLogoURL(this);            
    }
});
$(document).on('change','input.shop_banner',function(){
    var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
    if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) != -1) {
        ets_mp_readShopBannerURL(this);            
    }
});
$(document).on('change','input[name="badge_image"],input[name="ETS_MP_GOOGLE_MAP_LOGO"]',function(){
    var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
    if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) != -1) {
        ets_mp_readLevelBadgeImageURL(this);            
    }
});
$(document).on('click','.delete_logo_upload',function(e){
    e.preventDefault(); 
    $(this).parent().remove();
    $('input[name="shop_logo"]').val('');
    $('input[name="logo"]').val('');
    $('#shop_logo-images-thumbnails').show(); 
});
$(document).on('click','.delete_banner_upload',function(e){
    e.preventDefault(); 
    $(this).parent().prev('.uploaded_img_wrapper').show(); 
    $(this).parent().parent().find('.shop_banner').val('');
    $(this).parent().parent().find('input[name="filename"]').val('');
    $(this).parent().remove();
    
});
$(document).on('click','.delete_badge_image_upload',function(e){
    e.preventDefault(); 
    if($('.form-group.badge_image').next('.ets_uploaded_img_wrapper').length)
        $('.form-group.badge_image').next('.ets_uploaded_img_wrapper').show();
    $('.form-group.badge_image input').val('');
    $(this).parent().remove();
    
});
function ets_mp_readShopLogoURL(input){
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            if($(input).prev('.shop_logo').length <= 0)
            {
                $(input).before('<div class="shop_logo"><img class="ets_mp_shop_logo" src="'+e.target.result+'" width="160px"><a class="btn btn-default delete_logo_upload" href=""><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg> Delete</a></div>');
            }
            else
            {
                $(input).prev('.shop_logo').find('.ets_mp_shop_logo').attr('src',e.target.result);
            }
            $('#shop_logo-images-thumbnails').hide();                          
        }
        reader.readAsDataURL(input.files[0]);
    }
}
function ets_mp_readShopBannerURL(input)
{
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            if($(input).parent().prev('.shop_banner').length <= 0)
            {
                $(input).parent().before('<div class="shop_banner"><img class="ets_mp_shop_banner" src="'+e.target.result+'" width="160px"><a class="btn btn-default delete_banner_upload" href=""><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg></a></div>');
            }
            else
            {
                $(input).parent().prev('.shop_banner').find('.ets_mp_shop_banner').attr('src',e.target.result);
            }
            $(input).parent().parent().find('.uploaded_img_wrapper').hide();                          
        }
        reader.readAsDataURL(input.files[0]);
    }
}
function ets_mp_readLevelBadgeImageURL(input)
{
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            if($(input).closest('.form-group.badge_image').next('.ets_uploaded_img_wrapper').length)
                $(input).closest('.form-group.badge_image').next('.ets_uploaded_img_wrapper').hide(); 
            if($(input).closest('.form-group.badge_image .col-lg-9').find('.level_badge_image').length <= 0)
            {
                $(input).closest('.form-group.badge_image .col-lg-9').append('<div class="level_badge_image"><img class="ets_mp_level_badge_image" src="'+e.target.result+'" style="display: inline-block; max-width: 200px;"><a class="btn btn-default delete_badge_image_upload" href="" title="Delete"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg></a></div>');
            }
            else
            {
                $(input).closest('.form-group.badge_image').find('.ets_mp_level_badge_image').attr('src',e.target.result);
            }                       
        }
        reader.readAsDataURL(input.files[0]);
    }
}
function etsMpDisplayFormCommissionRate()
{
    if($('.category_commission_rate li').length)
    {
        $('.category_commission_rate li').each(function(){
            if($(this).find('.input-group.not-hide').length==0)
                $(this).addClass('hide'); 
        });
        if($('input[name="ETS_MP_ENABLE_COMMISSION_BY_CATEGORY"]').length)
        {
            if($('input[name="ETS_MP_ENABLE_COMMISSION_BY_CATEGORY"]:checked').val()==1)
            {
                $('.form-group.category_commission_rate').show();
            }
            else
                $('.form-group.category_commission_rate').hide();
            $(document).on('click','input[name="ETS_MP_ENABLE_COMMISSION_BY_CATEGORY"]',function(){
                if($(this).val()==1)
                {
                    $('.form-group.category_commission_rate').show();
                }
                else
                    $('.form-group.category_commission_rate').hide();
            });
        }
        if($('input[name="enable_commission_by_category"]').length)
        {
            if($('input[name="enable_commission_by_category"]:checked').val()==1)
            {
                $('.form-group.category_commission_rate').show();
            }
            else
                $('.form-group.category_commission_rate').hide();
            $(document).on('click','input[name="enable_commission_by_category"]',function(){
                if($(this).val()==1)
                {
                    $('.form-group.category_commission_rate').show();
                }
                else
                    $('.form-group.category_commission_rate').hide();
            });
        }
        if($('#ETS_MP_APPLICABLE_CATEGORIES_default').length)
        {
            etsMpChangeCommissionRate();
            $(document).on('change','input[name="ETS_MP_APPLICABLE_CATEGORIES"],input.category',function(){
                etsMpChangeCommissionRate();
            });
        }
        if($('#ets_mp_seller_form #id_group').length)
        {
            etsMpChangeCommissionGroupRate();
            $(document).on('change','#id_group',function(){
                etsMpChangeCommissionGroupRate();
            });
        }
    }
}
function etsMpChangeCommissionGroupRate()
{
    $('.category_commission_rate li').addClass('hide');
    $('.category_commission_rate .input-group.not-hide').addClass('hide').removeClass('not-hide');
    $('.category_commission_rate input[type="text"]').attr('disabled','disabled');
    var id_group = parseInt($('#ets_mp_seller_form #id_group').val());
    if(rate_seller_groups[id_group] && rate_seller_groups[id_group]!='all')
    {
        for(i=0;i<rate_seller_groups[id_group].length;i++)
        {
            if($('#rate_category_'+rate_seller_groups[id_group][i]).length)
            {
                $('#rate_category_'+rate_seller_groups[id_group][i]).parent().removeClass('hide').addClass('not-hide');
                $('#rate_category_'+rate_seller_groups[id_group][i]).removeAttr('disabled');
            }
        }
        $('.category_commission_rate li').each(function(){
            if($(this).find('.input-group.not-hide').length>0)
                $(this).removeClass('hide'); 
            else
                $(this).addClass('hide');
        });
    }
    else
    {
        $('.category_commission_rate li').removeClass('hide');
        $('.category_commission_rate .input-group.hide').addClass('not-hide').removeClass('hide');
        $('.category_commission_rate input[type="text"]').removeAttr('disabled');
    }
}
function etsMpChangeCommissionRate()
{
    $('.category_commission_rate li').addClass('hide');
    $('.category_commission_rate .input-group.not-hide').addClass('hide').removeClass('not-hide');
    $('.category_commission_rate input[type="text"]').attr('disabled','disabled');
    var applicable_product_categories = $('input[name="ETS_MP_APPLICABLE_CATEGORIES"]:checked').val();
    if(applicable_product_categories=='default')
    {
        if(default_rate_categories=='all')
        {
            $('.category_commission_rate li').removeClass('hide');
            $('.category_commission_rate .input-group.hide').addClass('not-hide').removeClass('hide');
            $('.category_commission_rate input[type="text"]').removeAttr('disabled');
        }
        else
        {
            for(i=0;i<default_rate_categories.length;i++)
            {
                if($('#rate_category_'+default_rate_categories[i]).length)
                {
                    $('#rate_category_'+default_rate_categories[i]).parent().removeClass('hide').addClass('not-hide');
                    $('#rate_category_'+default_rate_categories[i]).removeAttr('disabled');
                }
            }
            $('.category_commission_rate li').each(function(){
                if($(this).find('.input-group.not-hide').length>0)
                    $(this).removeClass('hide'); 
                else
                    $(this).addClass('hide');
            });
        }
    }
    if(applicable_product_categories=='all_product_categories')
    {
        $('.category_commission_rate li').removeClass('hide');
        $('.category_commission_rate .input-group.hide').addClass('not-hide').removeClass('hide');
        $('.category_commission_rate input[type="text"]').removeAttr('disabled');
    }
    if(applicable_product_categories=='specific_product_categories')
    {
        if($('input.category:checked').length)
        {
           $('input.category:checked').each(function(){
                var id_category = $(this).val();
                if($('#rate_category_'+id_category).length)
                {
                    $('#rate_category_'+id_category).parent().removeClass('hide').addClass('not-hide');
                    $('#rate_category_'+id_category).removeAttr('disabled');
                }
           }); 
           $('.category_commission_rate li').each(function(){
                if($(this).find('.input-group.not-hide').length>0)
                    $(this).removeClass('hide');
                else
                    $(this).addClass('hide'); 
           });
        }
    }
}