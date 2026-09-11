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
<div class="ets_mp_popup ets_mp_assign_product" style="display:none;">
    <div class="mp_pop_table_child ets_table">
        <div class="ets_table-cell">
            <div class="panel ets_mp-panel">
                <div class="ets_mp_close_popup" title="Close">{l s='Close' mod='ets_marketplace'}</div>
                <div class="panel-heading">
                    {l s='Assign product to seller' mod='ets_marketplace'}
                </div>
                <div class="table-responsive clearfix">
                    <form method="post" action="">
                        <div class="form-wrapper">
                            <div class="form-group row">
                                <label class="col-lg-3 control-label required" for="assign_seller_product">{l s='Seller' mod='ets_marketplace'}</label>
                                <div class="col-lg-9">
                                    <div class="search search-with-icon">
                                        <input id="assign_seller_product" name="assign_seller_product" class="form-control ac_input" placeholder="{l s='Search by ID, name or shop' mod='ets_marketplace'}" type="text" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <input name="id_product" value="" type="hidden">
                            <input name="btnSubmitAssignProduct" value="1" type="hidden">
                            <input name="id_customer_seller" id="id_customer_seller" type="hidden" value="">
                            <button class="btn btn-default btn-close-popup" type="button">
                                <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> {l s='Cancel' mod='ets_marketplace'}
                            </button>
                            <button class="btn btn-default pull-right" type="button" value="1" name="btnSubmitAssignProduct">
                                <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg>&nbsp; {l s='Save' mod='ets_marketplace'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var confirm_del_seller ='{l s='Do you want to delete this seller?' mod='ets_marketplace' js=1}';
    var no_seller_found_text ='{l s='No seller found' mod='ets_marketplace' js=1}';
    var xhr;
    {literal}
    $(document).ready(function(){
        $(document).on('blur','#assign_seller_product',function(){
            $('.list_sellers li.active').removeClass('active');
        });
        $(document).on('keyup','#assign_seller_product',function(e){
            if((e.keyCode==13 || e.keyCode==38 || e.keyCode==40) && $('.list_sellers').length)
            {
                if(e.keyCode==40)
                {
                    if($('.list_sellers li.active').length==0)
                    {
                        $('.list_sellers li:first').addClass('active');
                    }
                    else
                    {
                        var $li_active = $('.list_sellers li.active');
                        $('.list_sellers li.active').removeClass('active');
                        if($li_active.next('li').length)
                            $li_active.next('li').addClass('active');
                        else
                            $('.list_sellers li:first').addClass('active');
                    }
                }
                if(e.keyCode==38)
                {
                    if($('.list_sellers li.active').length==0)
                    {
                        $('.list_sellers li:last').addClass('active');
                    }
                    else
                    {
                        var $li_active = $('.list_sellers li.active');
                        $('.list_sellers li.active').removeClass('active');
                        if($li_active.prev('li').length)
                            $li_active.prev('li').addClass('active');
                        else
                            $('.list_sellers li:last').addClass('active');
                    }
                }
                if(e.keyCode==13)
                {
                    $('.list_sellers li.active').click();
                }
                return false;
            }
            else
            {
                if(xhr)
                    xhr.abort();
                $('.no-seller-found').remove();
                $('#assign_seller_product').next('.list_sellers').remove();
                xhr = $.ajax({
                    type: 'POST',
                    headers: { "cache-control": "no-cache" },
                    url: ets_link_search_seller,
                    async: true,
                    cache: false,
                    dataType : "json",
                    data:'getSellerProductByAdmin=1&q='+$('#assign_seller_product').val(),
                    success: function(json)
                    {
                        if(json.sellers && json.sellers.length>=1)
                        {
                            $('.no-seller-found').remove();
                            var $html ='<ul class="list_sellers">';
                            $(json.sellers).each(function(){
                                $html +='<li data-id_customer="'+this.id_customer+'"> '+this.shop_name+ '('+this.email+') </li>';
                            });
                            $html +='</ul>';
                            $('#assign_seller_product').after($html);
                            $('.list_sellers li').hover(function(){ $('.list_sellers li.active').removeClass('active'); $(this).addClass('active');});
                        }
                        else
                            $('#assign_seller_product').after('<p class="alert alert-warning no-seller-found">'+no_seller_found_text+'</p>');
                    }
                });
            }
        });
        $(document).on('click','.list_sellers li',function(){
            $('#id_customer_seller').val($(this).data('id_customer'));
            var seller_name =$(this).html();
            if($('#assign_seller_product').prev('.seller_selected').length)
            {
                $('.seller_selected .seller_name').html(seller_name);
            } else{
                $('#assign_seller_product').before('<div class="seller_selected"><div class="seller_name">'+seller_name+'</div><span class="delete_seller_assign">Delete</span></div>');
                $('.seller_selected').parent().addClass('has_seller');
            }
            $('#assign_seller_product').val('');
            $('.list_sellers li').remove();
        });
        $(document).on('click','.delete_seller_assign',function(){
            $('#id_customer_seller').val('');
            $('.seller_selected').parent().removeClass('has_seller');
            $('.seller_selected').remove();
        });
    });
    {/literal}
</script>