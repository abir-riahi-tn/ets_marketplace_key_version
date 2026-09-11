<?php
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

if (!defined('_PS_VERSION_')) { exit; }
/**
 * @param Ets_marketplace $module
 * @return bool
 */
function upgrade_module_3_6_3($module)
{
    $module->_installTabs();
    if($tabID =Tab::getIdFromClassName('AdminMarketPlaceCronJob'))
    {
        $tab = new Tab($tabID);
        if($id_parent = Tab::getIdFromClassName('AdminMarketPlaceEmailConfiguage'))
        {
            $tab->id_parent = $id_parent;
            $tab->save();
        }
    }
    Configuration::updateGlobalValue('ETS_MP_WHEN_SEND_EMAIL','immediately');
    Configuration::updateGlobalValue('ETS_MP_CRONJOB_EMAILS',5);
    Configuration::updateGlobalValue('ETS_MP_CRONJOB_MAX_TRY',5);
    Configuration::updateGlobalValue('ETS_MP_ENABLED_LOG_MAIL',1);
    Db::getInstance()->execute('CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'ets_mp_mailqueue` ( 
            `id_ets_mp_mailqueue` INT(11) NOT NULL AUTO_INCREMENT , 
            `id_lang` INT(11) NOT NULL,
            `id_employee` INT(11) NOT NULL , 
            `id_customer` INT(11) NOT NULL , 
            `customer_name` VARCHAR(200) NOT NULL , 
            `from_email` VARCHAR(200) NOT NULL , 
            `from_name` VARCHAR(200) NOT NULL , 
            `email` VARCHAR(150) NOT NULL , 
            `subject` VARCHAR(255) NOT NULL , 
            `content` TEXT NOT NULL , 
            `send_count` TINYINT(3) NOT NULL , 
            `sending_time` DATETIME NOT NULL , 
            `date_add` DATETIME NOT NULL , 
            `fileAttachment` text NOT NULL , 
            INDEX (`id_employee`, `id_customer`),
            INDEX(`email`),
            PRIMARY KEY (`id_ets_mp_mailqueue`)
            ) ENGINE = ' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
        ');
    Db::getInstance()->execute('CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'ets_mp_mailtraciking` ( 
        `id_ets_mp_mailtraciking` INT(11) NOT NULL AUTO_INCREMENT , 
        `id_ets_mp_mailqueue` INT(11) NOT NULL , 
        `id_customer` INT(11) NOT NULL , 
        `id_employee` INT(11) NOT NULL , 
        `customer_name` VARCHAR(200) NOT NULL , 
        `email` VARCHAR(150) NOT NULL , 
        `status` VARCHAR(20) NOT NULL , 
        `subject` VARCHAR(255) NOT NULL , 
        `content` TEXT NOT NULL , 
        `queue_date` DATETIME NOT NULL , 
        `date_add` DATETIME NOT NULL , 
        PRIMARY KEY (`id_ets_mp_mailtraciking`),
        INDEX (`id_ets_mp_mailqueue`), INDEX (`id_customer`), INDEX (`id_employee`), INDEX (`status`)) ENGINE = ' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci');
    Db::getInstance()->execute('CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'ets_mp_maillog` ( 
        `id_ets_mp_maillog` INT(11) NOT NULL AUTO_INCREMENT ,
        `id_ets_mp_mailqueue` INT(11) NOT NULL , 
        `id_customer` INT(11) NOT NULL , 
        `id_employee` INT(11) NOT NULL , 
        `id_lang` INT(11) NOT NULL , 
        `customer_name` VARCHAR(100) NOT NULL , 
        `email` VARCHAR(150) NOT NULL , 
        `from_email` VARCHAR(200) NOT NULL , 
        `from_name` VARCHAR(200) NOT NULL , 
        `subject` VARCHAR(255) NOT NULL , 
        `content` TEXT NOT NULL , 
        `fileAttachment` TEXT NOT NULL , 
        `status` VARCHAR(20) NOT NULL , 
        `queue_date` DATETIME NOT NULL , 
        `date_add` DATETIME NOT NULL , 
         PRIMARY KEY (`id_ets_mp_maillog`), INDEX (`id_ets_mp_mailqueue`), INDEX (`id_customer`), INDEX (`id_employee`), INDEX (`id_lang`)) ENGINE = ' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci');
    return true;
}
