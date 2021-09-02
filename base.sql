-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Ago 10, 2021 alle 16:19
-- Versione del server: 5.7.30-0ubuntu0.18.04.1-log
-- Versione PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `basement_db`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL COMMENT 'print=>1;type=>text;required=>required',
  `password` varchar(255) DEFAULT NULL COMMENT 'print=>0;type=>password;required=>required;',
  `lastLogin` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'no',
  `level` varchar(10) DEFAULT '0' COMMENT 'print=>1;type=>select;specs=>[SUPERUSER,ADMIN,USER]'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `lastLogin`, `level`) VALUES
(2, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2021-08-09 10:24:54', 'SUPERUSER');

-- --------------------------------------------------------

--
-- Struttura della tabella `configs`
--

CREATE TABLE `configs` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `code` varchar(400) DEFAULT NULL COMMENT 'type=>text;print=>1',
  `value` text COMMENT 'type=>text;print=>1',
  `mod` int(11) DEFAULT '1' COMMENT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `configs`
--

INSERT INTO `configs` (`id`, `code`, `value`, `mod`) VALUES
(31, 'siteurl', 'http://website.bmt', 0),
(32, 'subdomain_offline', '', 0),
(33, 'subdomain_online', '', 0),
(34, 'debug_mode', 'off', 0),
(36, 'newsletter_mail', 'newsletter@website.bmt', 0),
(37, 'newsletter_from', 'Newsletter - My Awesome website', 0),
(38, 'ieblock', '0', 0),
(39, 'contattimail', 'info@website.bmt', 0),
(40, 'mail_host', 'mail.basementcms.com', 0),
(41, 'mail_port', '465', 0),
(42, 'mail_secure', 'ssl', 0),
(43, 'mail_username', 'notifications@basementcms.com', 0),
(44, 'mail_password', '@#note_bmt@#', 0),
(45, 'mail_name', 'Notification@BMT', 0),
(46, 'backup_pattern', 'Ymd_His', 1),
(47, 'backup_retain', '-3 days', 1),
(48, 'selected_language', 'en', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `db_backup`
--

CREATE TABLE `db_backup` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `backup_name` varchar(400) NOT NULL,
  `backup_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struttura della tabella `htaccess`
--

CREATE TABLE `htaccess` (
  `id` int(6) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `line` text COMMENT 'print=>1;order=>2;type=>textarea;specs=>html;multiple=>;required=>',
  `active` varchar(2) DEFAULT NULL COMMENT 'print=>1;order=>0;type=>select;specs=>[SI,NO];multiple=>;required=>',
  `ordine` int(11) DEFAULT NULL COMMENT 'print=>1;order=>1;type=>text;specs=>;multiple=>;required=>'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `htaccess`
--

INSERT INTO `htaccess` (`id`, `line`, `active`, `ordine`) VALUES
(1, 'RewriteRule documentation/([^/]+)/([^/]+) index.php?page=documentation&id=$1 [L]', '0', 0);

-- --------------------------------------------------------

--
-- Struttura della tabella `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `output_name` varchar(20) NOT NULL,
  `uni_code` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `languages`
--

INSERT INTO `languages` (`id`, `output_name`, `uni_code`) VALUES
(7, 'English', 'en');

-- --------------------------------------------------------

--
-- Struttura della tabella `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `order` int(11) DEFAULT NULL COMMENT 'print=>1;order=>0;type=>text;specs=>;multiple=>;required=>',
  `type` varchar(255) DEFAULT NULL COMMENT 'print=>1;order=>0;type=>select;specs=>[TOP,SIDEBAR];multiple=>;required=>',
  `title` varchar(255) DEFAULT NULL COMMENT 'print=>1;order=>0;type=>text;specs=>;multiple=>;required=>',
  `language` varchar(255) DEFAULT NULL COMMENT 'print=>1;order=>0;type=>select;specs=>languages->(output_name)->(uni_code);multiple=>;required=>',
  `permalink` varchar(255) DEFAULT NULL COMMENT 'print=>1;order=>0;type=>select;specs=>pages->(title)->(permalink);multiple=>;required=>'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struttura della tabella `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `permalink` varchar(255) DEFAULT NULL COMMENT 'print=>1;order=>0;type=>custom;specs=>;multiple=>;required=>required',
  `language` longtext COMMENT 'print=>1;order=>0;type=>select;specs=>languages->(output_name)->(uni_code);multiple=>;required=>required',
  `title` varchar(255) DEFAULT NULL COMMENT 'print=>1;order=>0;type=>text;specs=>;multiple=>;required=>required',
  `subtitle` varchar(400) DEFAULT NULL COMMENT 'print=>;order=>0;type=>text;specs=>;multiple=>;required=>',
  `content` longtext COMMENT 'print=>;order=>0;type=>textarea;specs=>;multiple=>;required=>',
  `ref_page` varchar(60) DEFAULT NULL COMMENT 'print=>1;order=>0;type=>custom;specs=>;multiple=>;required=>required',
  `cover_image` varchar(400) DEFAULT NULL COMMENT 'print=>;order=>0;type=>file;specs=>img_pages;multiple=>;required=>',
  `meta_description` text COMMENT 'print=>;order=>0;type=>textarea;specs=>html;multiple=>;required=>',
  `meta_keywords` text COMMENT 'print=>;order=>0;type=>tag;specs=>;multiple=>;required=>',
  `change_freq` varchar(20) DEFAULT NULL COMMENT 'print=>;order=>0;type=>text;specs=>;multiple=>;required=>',
  `priority` varchar(5) DEFAULT NULL COMMENT 'print=>;order=>0;type=>text;specs=>;multiple=>;required=>',
  `bozza` varchar(5) DEFAULT NULL COMMENT 'print=>;order=>0;type=>select;specs=>[SI,NO];multiple=>;required=>'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `pages`
--

INSERT INTO `pages` (`id`, `permalink`, `language`, `title`, `subtitle`, `content`, `ref_page`, `cover_image`, `meta_description`, `meta_keywords`, `change_freq`, `priority`, `bozza`) VALUES
(15, 'homepage', 'en', 'Homepage', NULL, '<p>Quisque velit nisi, pretium ut lacinia in, elementum id enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor lectus nibh. Nulla quis lorem ut libero malesuada feugiat. Vivamus suscipit tortor eget felis porttitor volutpat. Proin eget tortor risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Donec sollicitudin molestie malesuada.</p>\r\n<p>Quisque velit nisi, pretium ut lacinia in, elementum id enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor lectus nibh. Nulla quis lorem ut libero malesuada feugiat. Vivamus suscipit tortor eget felis porttitor volutpat. Proin eget tortor risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Donec sollicitudin molestie malesuada.</p>', 'homepage.php', '', NULL, NULL, 'always', '0', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `translations`
--

CREATE TABLE `translations` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `globale` varchar(255) DEFAULT NULL COMMENT 'print=>1;order=>1;type=>custom;specs=>;multiple=>;required=>',
  `is_html` varchar(2) DEFAULT NULL COMMENT 'print=>;order=>2;type=>select;specs=>[SI,NO];multiple=>;required=>',
  `locales` longtext COMMENT 'print=>1;order=>4;type=>custom;specs=>;multiple=>;required=>',
  `is_js` varchar(2) DEFAULT NULL COMMENT 'print=>;order=>3;type=>select;specs=>[SI,NO];multiple=>;required=>'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `translations`
--

INSERT INTO `translations` (`id`, `globale`, `is_html`, `locales`, `is_js`) VALUES
(8, 'helloworld', NULL, '[{\"language\":\"en\",\"locale\":\"<p>Hello World.</p>\"}]', NULL);


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
