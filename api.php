<?php

    // Allow from any origin
    if (isset($_SERVER['HTTP_ORIGIN'])) {
        // Decide if the origin in $_SERVER['HTTP_ORIGIN'] is one
        // you want to allow, and if so:
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
    }

    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            // may also be using PUT, PATCH, HEAD etc
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

        exit(0);
    }

if (!isset($_SESSION)) {
    ini_set('session.cookie_httponly', 1);
    ini_set('session.use_only_cookies', 1);
    ini_set('session.cookie_secure', 1);
    session_start();
    session_regenerate_id();
}
include('bmt/inc/secure.php');

$purified = $purifier->purify($_SERVER['REQUEST_URI']);
if ($purified != $_SERVER['REQUEST_URI']) {
    die();
    header('location: /');
}
include('inc/initialize.php');
if (api_active == 'on') {
    // Handle inputs
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $json = file_get_contents('php://input');
        $data = json_decode($json);
    }

    // Try to render endpoint
    $rendered = false;
    if (isset($_GET['request'])) {
        $endpoint = 'endpoints/' . $_GET['request'] . '.php';
        header('Content-Type: application/json');
        if (is_file($endpoint)) {
            $rendered = true;
            include($endpoint);
        }
    }

    // Print error message if nothing was rendered
    if (!$rendered) {
        echo '<pre>Can\'t process request.</pre>';
    }
}