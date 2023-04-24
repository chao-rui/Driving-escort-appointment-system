/*
Navicat MySQL Data Transfer

Source Server         : 驾驶陪练预约
Source Server Version : 80032
Source Host           : localhost:3306
Source Database       : driving-escort-appointment-system

Target Server Type    : MYSQL
Target Server Version : 80032
File Encoding         : 65001

Date: 2023-04-24 18:17:56
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of apply
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of appmnts
-- ----------------------------
INSERT INTO `appmnts` VALUES ('1', '42', '40', '2', '2023-04-24 00:30:00', '2023-04-24 02:30:00', '1', null, null);
INSERT INTO `appmnts` VALUES ('2', '42', '40', '3', '2023-04-24 01:00:00', '2023-04-24 04:00:00', '1', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of car
-- ----------------------------
INSERT INTO `car` VALUES ('1', '陕A2234G', '比亚迪宋', '1', '3', '40', '1', '2023-04-24 02:01:04');
INSERT INTO `car` VALUES ('2', '陕U23H25', '比亚迪唐', '1', '3', '40', '1', '2023-04-24 02:13:02');

-- ----------------------------
-- Table structure for coach
-- ----------------------------
DROP TABLE IF EXISTS `coach`;
CREATE TABLE `coach` (
  `USER_ID` smallint NOT NULL,
  `WORK_ID` varchar(10) NOT NULL,
  `CAR_SCHOOL_ID` smallint NOT NULL,
  `APPRAISE_COACH` double DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  KEY `fk_cschool_coach` (`CAR_SCHOOL_ID`),
  CONSTRAINT `fk_cschool_coach` FOREIGN KEY (`CAR_SCHOOL_ID`) REFERENCES `cschool` (`CAR_SCHOOL_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of coach
-- ----------------------------
INSERT INTO `coach` VALUES ('40', '2023040001', '3', null);

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
INSERT INTO `cschool` VALUES ('3', '39', '西安宇星驾校', '陕西省西安市高新区团结南路26号西南方向180米', '18802980623', '00000', null, '2023-04-23 06:34:02');

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
  `ID_NUMBER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证号',
  `PASSWORD` varchar(32) NOT NULL COMMENT '密码',
  `ROLE_FLAG` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色标识',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('39', '新用户', '郑弘厚', '男', '1990', '14322311341', '130705199001171179', 'c4ca4238a0b923820dcc509a6f75849b', '4');
INSERT INTO `user` VALUES ('40', '叶落', '宁天路', '男', '1995', '15342324311', '210727199504064373', 'c4ca4238a0b923820dcc509a6f75849b', '3');
INSERT INTO `user` VALUES ('41', '羽然', '章哲熙', '女', '2017', '13282323421', '612425201703055247', 'c4ca4238a0b923820dcc509a6f75849b', '1');
INSERT INTO `user` VALUES ('42', '俨然', '叶无恙', '男', '2001', '17534332563', '623433200106266518', 'c4ca4238a0b923820dcc509a6f75849b', '2');
DROP TRIGGER IF EXISTS `delApply`;
DELIMITER ;;
CREATE TRIGGER `delApply` AFTER DELETE ON `apply` FOR EACH ROW BEGIN
    IF OLD.APPLY_STATE = 0 THEN
        INSERT INTO coach VALUES (OLD.USER_ID,OLD.WORK_ID,OLD.CAR_SCHOOL_ID,0);
    END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `updAppraise`;
DELIMITER ;;
CREATE TRIGGER `updAppraise` AFTER UPDATE ON `appmnts` FOR EACH ROW BEGIN
    UPDATE coach
    SET APPRAISE_COACH = (SELECT AVG(APPRAISE) FROM appmnts WHERE OBJECT_ID = NEW.OBJECT_ID)
    WHERE USER_ID = NEW.OBJECT_ID;

    UPDATE cschool
    SET APPRAISE_CAR_SCHOOL = (SELECT AVG(APPRAISE_COACH) FROM coach WHERE USER_ID = NEW.OBJECT_ID)
    WHERE CAR_SCHOOL_ADMIN=NEW.OBJECT_ID;
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
