/*
Navicat MySQL Data Transfer

Source Server         : 驾驶陪练预约
Source Server Version : 80032
Source Host           : localhost:3306
Source Database       : driving-escort-appointment-system

Target Server Type    : MYSQL
Target Server Version : 80032
File Encoding         : 65001

Date: 2023-05-09 21:50:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for apply
-- ----------------------------
DROP TABLE IF EXISTS `apply`;
CREATE TABLE `apply` (
  `APPLY_ID` smallint NOT NULL AUTO_INCREMENT,
  `USER_ID` smallint NOT NULL,
  `WORK_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CAR_SCHOOL_ID` smallint NOT NULL,
  `APPLY_STATE` varchar(2) NOT NULL,
  `UPDATE_DATE` date NOT NULL,
  PRIMARY KEY (`APPLY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of apply
-- ----------------------------
INSERT INTO `apply` VALUES ('7', '42', '0000000001', '3', '-1', '2023-05-08');

-- ----------------------------
-- Table structure for appmnts
-- ----------------------------
DROP TABLE IF EXISTS `appmnts`;
CREATE TABLE `appmnts` (
  `APPOINTMENT_ID` smallint NOT NULL AUTO_INCREMENT,
  `USER_ID` smallint NOT NULL,
  `OBJECT_ID` smallint NOT NULL,
  `TIME` double NOT NULL,
  `START_DATE` datetime NOT NULL,
  `END_DATE` datetime NOT NULL,
  `APPOINTMENT_STATE` varchar(2) NOT NULL,
  `APPRAISE` double DEFAULT NULL,
  `APPRAISE_CONTEXT` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`APPOINTMENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of appmnts
-- ----------------------------
INSERT INTO `appmnts` VALUES ('15', '42', '40', '2.5', '2023-04-28 08:30:00', '2023-04-28 11:00:00', '2', null, null);
INSERT INTO `appmnts` VALUES ('17', '42', '40', '1', '2023-04-28 13:00:00', '2023-04-28 14:00:00', '3', '5', '很不错的一个教练，技术很好');
INSERT INTO `appmnts` VALUES ('19', '42', '40', '4', '2023-04-29 08:00:00', '2023-04-29 12:00:00', '3', '5', '态度很好，也很有耐心');
INSERT INTO `appmnts` VALUES ('20', '42', '40', '1.5', '2023-05-06 08:00:00', '2023-05-06 09:30:00', '2', null, null);

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
  `CAR_ID` smallint NOT NULL AUTO_INCREMENT,
  `CAR_NUMBER` varchar(10) NOT NULL,
  `CAR_BRANDS` varchar(10) NOT NULL,
  `CAR_MODEL` varchar(20) NOT NULL,
  `CAR_SCHOOL_ID` smallint DEFAULT NULL,
  `USER_ID` smallint DEFAULT NULL,
  `CAR_FLAG` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UPDATE_DATE` datetime NOT NULL,
  PRIMARY KEY (`CAR_ID`),
  KEY `fk_user_car` (`USER_ID`),
  KEY `fk_cs_car` (`CAR_SCHOOL_ID`),
  CONSTRAINT `fk_cs_car` FOREIGN KEY (`CAR_SCHOOL_ID`) REFERENCES `cschool` (`CAR_SCHOOL_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_car` FOREIGN KEY (`USER_ID`) REFERENCES `coach` (`USER_ID`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of car
-- ----------------------------
INSERT INTO `car` VALUES ('1', '陕A38347', '本田S35', '1', '3', '40', '1', '2023-05-08 20:33:11');
INSERT INTO `car` VALUES ('2', '陕U23H25', '比亚迪唐', '1', '3', null, '1', '2023-04-24 02:13:02');
INSERT INTO `car` VALUES ('6', '陕A2234G', '比亚迪宋', '1', '3', null, '1', '2023-04-25 08:18:21');

-- ----------------------------
-- Table structure for coach
-- ----------------------------
DROP TABLE IF EXISTS `coach`;
CREATE TABLE `coach` (
  `USER_ID` smallint NOT NULL,
  `WORK_ID` varchar(10) NOT NULL,
  `CAR_SCHOOL_ID` smallint NOT NULL,
  `APPRAISE_COACH` double DEFAULT NULL,
  `CONTEXT` varchar(255) DEFAULT NULL,
  `PRICE` double DEFAULT '60',
  PRIMARY KEY (`USER_ID`),
  KEY `fk_cschool_coach` (`CAR_SCHOOL_ID`),
  CONSTRAINT `fk_cschool_coach` FOREIGN KEY (`CAR_SCHOOL_ID`) REFERENCES `cschool` (`CAR_SCHOOL_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of coach
-- ----------------------------
INSERT INTO `coach` VALUES ('40', '2023040001', '3', '5', '一个驾龄10年的老司机，为人热心，乐于助人。曾被评为“2022年度优秀员工”。', '30');

-- ----------------------------
-- Table structure for cschool
-- ----------------------------
DROP TABLE IF EXISTS `cschool`;
CREATE TABLE `cschool` (
  `CAR_SCHOOL_ID` smallint NOT NULL AUTO_INCREMENT,
  `CAR_SCHOOL_ADMIN` smallint NOT NULL,
  `CAR_SCHOOL_NAME` varchar(20) NOT NULL,
  `CAR_SCHOOL_ADDERS` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CAR_SCHOOL_PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `APPRAISE_CAR_SCHOOL` double(5,0) unsigned zerofill DEFAULT NULL,
  `CAR_SCHOOL_DESG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `UPDATE_DATE` datetime NOT NULL,
  PRIMARY KEY (`CAR_SCHOOL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of cschool
-- ----------------------------
INSERT INTO `cschool` VALUES ('3', '39', '西安宇星驾校', '陕西省西安市高新区团结南路26号西南方向180米', '18802980623', '00005', null, '2023-04-23 06:34:02');

-- ----------------------------
-- Table structure for photo
-- ----------------------------
DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo` (
  `PHOTO_ID` smallint NOT NULL AUTO_INCREMENT,
  `PHOTO_TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所有者的类型（普通用户，教练，驾校，车）',
  `PHOTO_OBJECT` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '照片所属',
  `PHOTO_ADD` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '照片存储路径',
  PRIMARY KEY (`PHOTO_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of photo
-- ----------------------------
INSERT INTO `photo` VALUES ('1', 'car', '1_1683549076207', '/resources/img/car/1_1683549076207.png');
INSERT INTO `photo` VALUES ('3', 'car', '1_1683549151262', '/resources/img/car/1_1683549151262.png');
INSERT INTO `photo` VALUES ('4', 'car', '1_1683549191454', '/resources/img/car/1_1683549191454.png');
INSERT INTO `photo` VALUES ('5', 'carSchool', '3_1683552462285', '/resources/img/carSchool/3_1683552462285.png');
INSERT INTO `photo` VALUES ('6', 'carSchool', '3_1683552703546', '/resources/img/carSchool/3_1683552703546.png');
INSERT INTO `photo` VALUES ('8', 'user', '42', '/resources/img/user/42.png');
INSERT INTO `photo` VALUES ('9', 'user', '40', '/resources/img/user/42.png');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `USER_ID` smallint NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `USER_NAME` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `USER_RNAME` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '真实姓名',
  `GENDER` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '性别',
  `BIRTH_YEAR` smallint DEFAULT NULL COMMENT '出生年',
  `PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话号码',
  `EMAIL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ID_NUMBER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证号',
  `PASSWORD` varchar(32) NOT NULL COMMENT '密码',
  `ROLE_FLAG` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色标识',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('39', '新用户', '郑弘厚', '男', '1990', '14322311341', null, '130705199001171179', 'c4ca4238a0b923820dcc509a6f75849b', '4');
INSERT INTO `user` VALUES ('40', '叶落', '宁天路', '男', '1995', '15342324311', null, '210727199504064373', 'c4ca4238a0b923820dcc509a6f75849b', '3');
INSERT INTO `user` VALUES ('41', '羽然', '', '女', null, '13282323421', null, '', 'c4ca4238a0b923820dcc509a6f75849b', '1');
INSERT INTO `user` VALUES ('42', '俨然', '叶无恙', '男', '2001', '17534332563', 'wang.rchao@outlook.com', '623433200106266518', 'c4ca4238a0b923820dcc509a6f75849b', '2');
INSERT INTO `user` VALUES ('43', '妄议', null, null, null, '16253726223', null, null, 'c4ca4238a0b923820dcc509a6f75849b', '1');
INSERT INTO `user` VALUES ('45', '南墙', null, null, null, '16724822435', null, null, 'c4ca4238a0b923820dcc509a6f75849b', '1');
INSERT INTO `user` VALUES ('46', '吴山', null, null, null, '17380503915', null, null, 'c4ca4238a0b923820dcc509a6f75849b', '1');
INSERT INTO `user` VALUES ('47', '南宁', null, null, null, '15648978342', null, null, 'c4ca4238a0b923820dcc509a6f75849b', '1');
DROP TRIGGER IF EXISTS `delApply`;
DELIMITER ;;
CREATE TRIGGER `delApply` AFTER DELETE ON `apply` FOR EACH ROW BEGIN
    DELETE FROM photo WHERE PHOTO_TYPE="user" AND PHOTO_OBJECT = OLD.USER_ID;
    IF OLD.APPLY_STATE = 0 THEN
        INSERT INTO coach VALUES (OLD.USER_ID,OLD.WORK_ID,OLD.CAR_SCHOOL_ID,0);
    END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `updAppmnts`;
DELIMITER ;;
CREATE TRIGGER `updAppmnts` AFTER UPDATE ON `appmnts` FOR EACH ROW BEGIN
    UPDATE coach
    SET APPRAISE_COACH = (SELECT AVG(APPRAISE) FROM appmnts WHERE OBJECT_ID = NEW.OBJECT_ID AND APPOINTMENT_STATE=3 )
    WHERE USER_ID = NEW.OBJECT_ID;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `addCoach`;
DELIMITER ;;
CREATE TRIGGER `addCoach` AFTER INSERT ON `coach` FOR EACH ROW BEGIN
    UPDATE user SET ROLE_FLAG = 3 WHERE USER_ID = NEW.USER_ID;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `updCoach`;
DELIMITER ;;
CREATE TRIGGER `updCoach` AFTER UPDATE ON `coach` FOR EACH ROW BEGIN
    UPDATE cschool SET APPRAISE_CAR_SCHOOL=(SELECT AVG(APPRAISE_COACH) FROM coach WHERE CAR_SCHOOL_ID= OLD.CAR_SCHOOL_ID) WHERE CAR_SCHOOL_ID= OLD.CAR_SCHOOL_ID;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `delCoach`;
DELIMITER ;;
CREATE TRIGGER `delCoach` AFTER DELETE ON `coach` FOR EACH ROW BEGIN
    UPDATE user SET ROLE_FLAG = 1 WHERE USER_ID = OLD.USER_ID;
    UPDATE car SET CAR_FLAG = 0 WHERE USER_ID=OLD.USER_ID;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `addCSchool`;
DELIMITER ;;
CREATE TRIGGER `addCSchool` AFTER INSERT ON `cschool` FOR EACH ROW BEGIN
    UPDATE user SET ROLE_FLAG = 4 WHERE USER_ID = NEW.CAR_SCHOOL_ADMIN;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `delCSchool`;
DELIMITER ;;
CREATE TRIGGER `delCSchool` AFTER DELETE ON `cschool` FOR EACH ROW BEGIN
    DELETE FROM coach WHERE CAR_SCHOOL_ID = OLD.CAR_SCHOOL_ID;
    UPDATE user SET ROLE_FLAG = 1 WHERE USER_ID = OLD.CAR_SCHOOL_ADMIN;
END
;;
DELIMITER ;
