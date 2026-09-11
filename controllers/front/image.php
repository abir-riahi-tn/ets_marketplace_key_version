<?php
/**
 * 2007-2018 ETS-Soft
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
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please contact us for extra customization service at an affordable price
 *
 * @author ETS-Soft - etssoft.jsc@gmail.com
 * @copyright  2007-2018 ETS-Soft
 * @license    EUPL
 *  International Registered Trademark & Property of ETS-Soft
 */

if (!defined('_PS_VERSION_')) { exit; }
class Ets_marketplaceImageModuleFrontController extends ModuleFrontController
{
    public function __construct()
    {
        if(($id_ets_mp_mailtraciking = (int)Tools::getValue('id_ets_mp_mailtraciking')) && Validate::isLoadedObject($mailTracking = new Ets_mp_mailtraciking($id_ets_mp_mailtraciking)))
        {
            $mailTracking->status = 'read';
            $mailTracking->update();
        }
        header('Content-Type: image/png');
        $code_binary = call_user_func('base64_decode', 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQMAAAAl21bKAAAAA1BMVEUAAACnej3aAAAAAXRSTlMAQObYZgAAAApJREFUCNdjYAAAAAIAAeIhvDMAAAAASUVORK5CYII=');
        $image = call_user_func('imagecreatefromstring', $code_binary);
        header('Content-Type: image/jpeg');
        call_user_func('imagejpeg', $image);
        call_user_func('imagedestroy', $image);
        ob_end_flush();
        exit();
    }
}
