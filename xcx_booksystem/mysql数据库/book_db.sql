/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : book_db

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2020-10-21 14:21:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_book`
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book` (
  `barcode` varchar(20) NOT NULL COMMENT 'barcode',
  `bookName` varchar(20) NOT NULL COMMENT '图书名称',
  `bookTypeObj` int(11) NOT NULL COMMENT '图书所在类别',
  `price` float NOT NULL COMMENT '图书价格',
  `count` int(11) NOT NULL COMMENT '库存',
  `publishDate` varchar(20) DEFAULT NULL COMMENT '出版日期',
  `publish` varchar(20) DEFAULT NULL COMMENT '出版社',
  `bookPhoto` varchar(60) NOT NULL COMMENT '图书图片',
  `bookDesc` varchar(800) DEFAULT NULL COMMENT '图书简介',
  `bookFile` varchar(60) NOT NULL COMMENT '图书文件',
  PRIMARY KEY (`barcode`),
  KEY `bookTypeObj` (`bookTypeObj`),
  CONSTRAINT `t_book_ibfk_1` FOREIGN KEY (`bookTypeObj`) REFERENCES `t_booktype` (`bookTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES ('TS001', 'php网站开发教程a', '1', '35.5', '12', '2019-09-03', '人民教育出版社', 'upload/d7280a79-99d0-4bea-b7de-62d22dfa44df.jpg', '这是一个编程入门书籍', 'upload/d7d08d01-2c66-442c-898c-0bcd401e9c5d.jpg');
INSERT INTO `t_book` VALUES ('TS002', '中国近代史', '2', '39.5', '12', '2019-10-02', '人民教育出版社', 'upload/b3cc11ee-f277-44e2-ad47-4a66da45784b.jpg', '好书一本哦', '');
INSERT INTO `t_book` VALUES ('TS003', 'Python网络编程', '1', '48', '12', '2019-10-01', '人民教育出版社', 'upload/d763728a-a48c-4b5a-b181-920d88410e67.jpg', '人生苦短我用python', '');
INSERT INTO `t_book` VALUES ('TS004', 'HTML5前端设计', '1', '32', '10', '2019-10-08', '四川大学出版社', 'upload/80324df5-0b74-4a49-919a-9d49efb22496.jpg', 'ui设计精品书籍', '');
INSERT INTO `t_book` VALUES ('TS005', 'C++驱动开发', '1', '88', '20', '2019-10-03', '人民教育出版社', 'upload/af8982f5-097b-492c-9dd5-2ef00cdd2c95.jpg', '高手讲解计算机底层驱动开发', 'upload/55a2ddea-684c-4c20-9c67-1bda25f617d8.jpg');
INSERT INTO `t_book` VALUES ('TS008', '1', '1', '2', '3', '2019-10-04', '5', 'upload/71033821-185c-4e7b-9389-7766c6b025f1.jpg', '6', '');

-- ----------------------------
-- Table structure for `t_booktype`
-- ----------------------------
DROP TABLE IF EXISTS `t_booktype`;
CREATE TABLE `t_booktype` (
  `bookTypeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书类别',
  `bookTypeName` varchar(18) NOT NULL COMMENT '类别名称',
  `days` int(11) NOT NULL COMMENT '可借阅天数',
  PRIMARY KEY (`bookTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_booktype
-- ----------------------------
INSERT INTO `t_booktype` VALUES ('1', '计算机类', '25');
INSERT INTO `t_booktype` VALUES ('2', '历史类', '25');
