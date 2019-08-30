<?php
//必须要中文
error_reporting(E_ALL);
set_time_limit(0);
require("config.php");
function __autoload($class_name) {
    require_once $class_name . '.class.php';
}
$brtk=new brtk($config);
$brtk->start();
?>