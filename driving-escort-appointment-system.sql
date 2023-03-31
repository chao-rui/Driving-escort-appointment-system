/*
Navicat MySQL Data Transfer

Source Server         : 驾驶陪练预约
Source Server Version : 80032
Source Host           : localhost:3306
Source Database       : driving-escort-appointment-system

Target Server Type    : MYSQL
Target Server Version : 80032
File Encoding         : 65001

Date: 2023-03-31 17:02:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for appmnts
-- ----------------------------
DROP TABLE IF EXISTS `appmnts`;
CREATE TABLE `appmnts` (
  `APPOINTMENT_ID` smallint NOT NULL AUTO_INCREMENT,
  `USER_ID` smallint NOT NULL,
  `OBJECT_ID` smallint NOT NULL,
  `TIME` smallint NOT NULL,
  `START_DATE` datetime NOT NULL,
  `END_DATE` datetime NOT NULL,
  `APPOINTMENT_ADDERS` varchar(20) NOT NULL,
  `APPOINTMENT_STATE` varchar(2) NOT NULL,
  `APPRAISE` smallint DEFAULT NULL,
  `APPRAISE_CONTEXT` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`APPOINTMENT_ID`),
  KEY `fk_user_appmnts` (`USER_ID`),
  KEY `object_userid` (`OBJECT_ID`),
  CONSTRAINT `fk_user_appmnts` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE CASCADE,
  CONSTRAINT `object_userid` FOREIGN KEY (`OBJECT_ID`) REFERENCES `user` (`USER_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of appmnts
-- ----------------------------

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
  `CAR_ID` smallint NOT NULL AUTO_INCREMENT,
  `CAR_NUMBER` varchar(10) NOT NULL,
  `CAR_BRANDS` varchar(10) NOT NULL,
  `CAR_MODEL` varchar(20) NOT NULL,
  `USER_ID` smallint DEFAULT NULL,
  `CAR_FLAG` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UPDATE_DATE` datetime NOT NULL,
  PRIMARY KEY (`CAR_ID`),
  KEY `fk_user_car` (`USER_ID`),
  CONSTRAINT `fk_user_car` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of car
-- ----------------------------

-- ----------------------------
-- Table structure for coach
-- ----------------------------
DROP TABLE IF EXISTS `coach`;
CREATE TABLE `coach` (
  `USER_ID` smallint NOT NULL,
  `WORK_ID` varchar(10) NOT NULL,
  `CAR_SCHOOL_ID` smallint NOT NULL,
  `APPRAISE_COACH` smallint DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  KEY `fk_cschool_coach` (`CAR_SCHOOL_ID`),
  CONSTRAINT `fk_cschool_coach` FOREIGN KEY (`CAR_SCHOOL_ID`) REFERENCES `cschool` (`CAR_SCHOOL_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_coach` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of coach
-- ----------------------------

-- ----------------------------
-- Table structure for csadmin
-- ----------------------------
DROP TABLE IF EXISTS `csadmin`;
CREATE TABLE `csadmin` (
  `USER_ID` smallint NOT NULL,
  `WORK_ID` varchar(10) NOT NULL,
  `CAR_SCHOOL_ID` smallint NOT NULL,
  PRIMARY KEY (`USER_ID`),
  KEY `fk_cschool_csadmin` (`CAR_SCHOOL_ID`),
  CONSTRAINT `fk_cschool_csadmin` FOREIGN KEY (`CAR_SCHOOL_ID`) REFERENCES `cschool` (`CAR_SCHOOL_ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_casdmin` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of csadmin
-- ----------------------------

-- ----------------------------
-- Table structure for cschool
-- ----------------------------
DROP TABLE IF EXISTS `cschool`;
CREATE TABLE `cschool` (
  `CAR_SCHOOL_ID` smallint NOT NULL AUTO_INCREMENT,
  `CAR_SCHOOL_NAME` varchar(20) NOT NULL,
  `CAR_SCHOOL_ADDERS` varchar(20) DEFAULT NULL,
  `CAR_SCHOOL_PHONE` varchar(20) DEFAULT NULL,
  `APPRAISE_CAR_SHOOL` smallint DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`CAR_SCHOOL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of cschool
-- ----------------------------

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
  `PASSWORD` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `ROLE_FLAG` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色标识',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '001', null, null, null, '10000000', null, '001', '1');
