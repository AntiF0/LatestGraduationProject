/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : springboot-vue

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 04/05/2022 14:27:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dailyrecord
-- ----------------------------
DROP TABLE IF EXISTS `dailyrecord`;
CREATE TABLE `dailyrecord`  (
  `dId` int(0) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `dUserId` int(0) NOT NULL COMMENT '记录对应的用户id,引用user.uId',
  `dDate` date NOT NULL COMMENT '记录日期',
  `dContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '记录内容',
  PRIMARY KEY (`dId`) USING BTREE,
  INDEX `LinkDailyUser`(`dUserId`) USING BTREE,
  CONSTRAINT `LinkDailyUser` FOREIGN KEY (`dUserId`) REFERENCES `userinfo` (`uId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dailyrecord
-- ----------------------------
INSERT INTO `dailyrecord` VALUES (5, 1, '2022-03-24', '');
INSERT INTO `dailyrecord` VALUES (7, 1, '2022-02-28', '<p>用户1 02-28</p>');
INSERT INTO `dailyrecord` VALUES (12, 1, '2022-03-03', '<p>312312</p>');
INSERT INTO `dailyrecord` VALUES (14, 1, '2022-03-21', '<p>1314112421</p>');
INSERT INTO `dailyrecord` VALUES (31, 2, '2022-03-23', '<p>用户2<p>');
INSERT INTO `dailyrecord` VALUES (33, 1, '2022-03-22', '<p><span style=\"font-weight: normal;\">用户1 3-222</span></p>');
INSERT INTO `dailyrecord` VALUES (34, 1, '2022-03-07', '<p>03-09</p>');
INSERT INTO `dailyrecord` VALUES (35, 1, '2022-03-08', '<p>03-08 测试</p>');
INSERT INTO `dailyrecord` VALUES (37, 1, '2022-03-28', '<ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>3/28sssss</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>1</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>2</li></ul>');
INSERT INTO `dailyrecord` VALUES (38, 1, '2022-03-29', '<p>3/29</p><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>计划1</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>计划2</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>erewrrqrqrq</li></ul>');
INSERT INTO `dailyrecord` VALUES (39, 1, '2022-04-29', '<ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\" checked=\"true\"/></span>学习前端</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\" checked=\"true\"/></span>学习C++</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>学习Java</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>政治</li></ul>');
INSERT INTO `dailyrecord` VALUES (40, 1, '2022-04-30', '<ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>学习C++</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>学习政治</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>学习高等数学</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\" checked=\"true\"/></span>学习前端</li></ul>');
INSERT INTO `dailyrecord` VALUES (41, 1, '2022-05-01', '<ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>学习C++</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\" checked=\"true\"/></span>政治</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\" checked=\"true\"/></span>高等数学</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>学习Java</li></ul>');
INSERT INTO `dailyrecord` VALUES (42, 1, '2022-05-02', '<ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>学习Java</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>大学英语</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\" checked=\"true\"/></span>高等数学</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>政治</li></ul>');
INSERT INTO `dailyrecord` VALUES (43, 1, '2022-05-03', '<ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>学习前端</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>大学英语</li></ul><ul class=\"w-e-todo\"><li><span contenteditable=\"false\"><input type=\"checkbox\"/></span>政治</li></ul>');

-- ----------------------------
-- Table structure for focusinfo
-- ----------------------------
DROP TABLE IF EXISTS `focusinfo`;
CREATE TABLE `focusinfo`  (
  `fId` int(0) NOT NULL AUTO_INCREMENT COMMENT '某次任务专注的id',
  `fUserId` int(0) NOT NULL COMMENT '专注所属的用户',
  `fTaskId` int(0) NOT NULL COMMENT '专注对应的任务id,引用taskinfo.tId',
  `fTaskName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称,使用触发器填写',
  `fDate` date NOT NULL COMMENT '专注日期',
  `fStartTime` time(0) NOT NULL COMMENT '专注开始时间',
  `fEndTime` time(0) NOT NULL COMMENT '专注结束时间',
  `fLastedTime` int(0) NOT NULL COMMENT '专注持续时间,单位为分钟(不完全等于结束时间-开始时间)',
  `fDetail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '专注细节,可以填,可以不填',
  PRIMARY KEY (`fId`) USING BTREE,
  INDEX `LinkFocusTask`(`fTaskId`) USING BTREE,
  INDEX `LinkFocusUser`(`fUserId`) USING BTREE,
  CONSTRAINT `LinkFocusTask` FOREIGN KEY (`fTaskId`) REFERENCES `taskinfo` (`tId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `LinkFocusUser` FOREIGN KEY (`fUserId`) REFERENCES `userinfo` (`uId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of focusinfo
-- ----------------------------
INSERT INTO `focusinfo` VALUES (73, 1, 91, '学习C++', '2022-04-29', '08:00:00', '09:00:00', 60, NULL);
INSERT INTO `focusinfo` VALUES (74, 1, 91, '学习C++', '2022-04-30', '08:00:00', '09:00:00', 60, NULL);
INSERT INTO `focusinfo` VALUES (75, 1, 91, '学习C++', '2022-05-01', '10:00:00', '11:00:00', 50, NULL);
INSERT INTO `focusinfo` VALUES (76, 1, 92, '学习前端', '2022-04-29', '09:00:00', '10:30:00', 90, NULL);
INSERT INTO `focusinfo` VALUES (77, 1, 92, '学习前端', '2022-04-30', '12:00:00', '14:30:00', 120, NULL);
INSERT INTO `focusinfo` VALUES (78, 1, 92, '学习前端', '2022-05-03', '08:00:00', '09:30:00', 90, NULL);
INSERT INTO `focusinfo` VALUES (79, 1, 93, '学习Java', '2022-04-29', '12:00:00', '13:30:00', 80, NULL);
INSERT INTO `focusinfo` VALUES (80, 1, 93, '学习Java', '2022-05-01', '15:00:00', '16:30:00', 80, NULL);
INSERT INTO `focusinfo` VALUES (81, 1, 93, '学习Java', '2022-05-02', '08:00:00', '09:30:00', 80, NULL);
INSERT INTO `focusinfo` VALUES (82, 1, 94, '高等数学', '2022-04-30', '09:30:00', '10:30:00', 40, NULL);
INSERT INTO `focusinfo` VALUES (83, 1, 94, '高等数学', '2022-05-01', '08:30:00', '09:30:00', 60, NULL);
INSERT INTO `focusinfo` VALUES (84, 1, 94, '高等数学', '2022-05-02', '13:00:00', '14:30:00', 60, NULL);
INSERT INTO `focusinfo` VALUES (85, 1, 95, '大学英语', '2022-05-02', '10:00:00', '11:30:00', 60, NULL);
INSERT INTO `focusinfo` VALUES (86, 1, 95, '大学英语', '2022-05-03', '10:00:00', '12:30:00', 90, NULL);
INSERT INTO `focusinfo` VALUES (87, 1, 95, '大学英语', '2022-05-03', '14:00:00', '16:00:00', 80, NULL);
INSERT INTO `focusinfo` VALUES (88, 1, 96, '政治', '2022-04-29', '18:00:00', '19:30:00', 60, NULL);
INSERT INTO `focusinfo` VALUES (89, 1, 96, '政治', '2022-04-30', '18:00:00', '19:30:00', 60, NULL);
INSERT INTO `focusinfo` VALUES (90, 1, 96, '政治', '2022-05-01', '18:00:00', '19:30:00', 60, NULL);
INSERT INTO `focusinfo` VALUES (91, 1, 96, '政治', '2022-05-02', '18:00:00', '19:30:00', 60, NULL);
INSERT INTO `focusinfo` VALUES (92, 1, 96, '政治', '2022-05-03', '18:00:00', '19:30:00', 60, NULL);

-- ----------------------------
-- Table structure for taskinfo
-- ----------------------------
DROP TABLE IF EXISTS `taskinfo`;
CREATE TABLE `taskinfo`  (
  `tId` int(0) NOT NULL AUTO_INCREMENT,
  `tUserId` int(0) NOT NULL COMMENT '属于的用户id,引用user.uId',
  `tName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名',
  `tDescribe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '任务描述',
  `tCreateDate` date NULL DEFAULT NULL COMMENT '任务创建时间',
  `tFocusedNum` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '任务已专注次数,每次专注后加1',
  `tFocusedTime` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '任务已专注时间,以秒作为单位',
  `tIsDeleted` int(0) NULL DEFAULT NULL COMMENT '任务是否被删除,0表示未删除',
  `tIsPigeonholed` int(0) NULL DEFAULT NULL COMMENT '任务是否被归档,归档即完成,1表示已归档',
  `tTaskMode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务类型 三种：正计时、定目标、番茄计时',
  `tPlanTime` int(0) NULL DEFAULT NULL COMMENT '倒计时总计划时间，仅tTaskMode=\'定目标\'时生效，单位为小时',
  `tPlanEndDate` date NULL DEFAULT NULL COMMENT '倒计时计划完成日期，仅tTaskMode=\'定目标\'时生效',
  `tTomatoClock` int(0) NULL DEFAULT NULL COMMENT '一次番茄钟的时长,仅tTaskMode=\'番茄计时\'时生效单位为分钟',
  PRIMARY KEY (`tId`) USING BTREE,
  INDEX `LinkUserTask`(`tUserId`) USING BTREE,
  CONSTRAINT `LinkUserTask` FOREIGN KEY (`tUserId`) REFERENCES `userinfo` (`uId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 116 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of taskinfo
-- ----------------------------
INSERT INTO `taskinfo` VALUES (91, 1, '学习C++', 'C++介绍、面向对象、STL...', '2022-04-25', 0000000003, 0000000170, 0, 0, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (92, 1, '学习前端', '', '2022-04-25', 0000000003, 0000000300, 0, 0, '定目标', 20, '2022-05-09', NULL);
INSERT INTO `taskinfo` VALUES (93, 1, '学习Java', NULL, '2022-04-25', 0000000003, 0000000240, 0, 0, '番茄计时', NULL, NULL, 20);
INSERT INTO `taskinfo` VALUES (94, 1, '高等数学', NULL, '2022-04-25', 0000000003, 0000000160, 0, 0, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (95, 1, '大学英语', NULL, '2022-04-25', 0000000003, 0000000230, 0, 0, '定目标', 20, '2022-05-09', NULL);
INSERT INTO `taskinfo` VALUES (96, 1, '政治', NULL, '2022-04-25', 0000000005, 0000000300, 0, 0, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (97, 1, '数据结构', NULL, '2022-04-25', 0000000000, 0000000000, 0, 0, '番茄计时', NULL, NULL, 20);
INSERT INTO `taskinfo` VALUES (98, 1, '计算机网络', NULL, '2022-04-25', 0000000000, 0000000000, 0, 0, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (99, 1, 'Linux操作系统', NULL, '2022-04-25', 0000000000, 0000000000, 0, 0, '定目标', 20, '2022-05-09', NULL);
INSERT INTO `taskinfo` VALUES (100, 1, '计算机原理与汇编', NULL, '2022-04-25', 0000000000, 0000000000, 0, 0, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (102, 1, '微机接口技术', NULL, '2022-04-25', 0000000000, 0000000000, 0, 1, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (103, 1, '软件开发管理', NULL, '2022-04-25', 0000000000, 0000000000, 0, 1, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (104, 1, '计算机图像处理', NULL, '2022-04-25', 0000000000, 0000000000, 0, 1, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (105, 1, '中西近代史', NULL, '2022-04-25', 0000000000, 0000000000, 1, 0, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (106, 1, '大学物理', NULL, '2022-04-25', 0000000000, 0000000000, 1, 0, '正计时', NULL, NULL, NULL);
INSERT INTO `taskinfo` VALUES (107, 1, '西方哲学史', NULL, '2022-04-25', 0000000000, 0000000000, 1, 0, '正计时', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `age` int(0) NULL DEFAULT NULL COMMENT '年龄',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '11', NULL, '11', 2, '男', '41');
INSERT INTO `user` VALUES (2, '2', NULL, '2', 2, '未知', '2');
INSERT INTO `user` VALUES (3, '3', '123456', '3', 3, '女', '3');
INSERT INTO `user` VALUES (4, '6', '123456', '你好', 6, '男', '6');
INSERT INTO `user` VALUES (5, '5', '123456', '5', 5, '女', '5');
INSERT INTO `user` VALUES (6, '1', '53', '23', 341, '男', '1231');
INSERT INTO `user` VALUES (7, '7', '8', '9', 19, '女', '1313');
INSERT INTO `user` VALUES (8, '11', '312', '3213', 31, '男', 'wq');
INSERT INTO `user` VALUES (9, '1', '53', '23', 341, '男', '1231');
INSERT INTO `user` VALUES (10, '1', '53', '23', 341, '男', '12314');
INSERT INTO `user` VALUES (12, '1', '123456', '1', 1, '男', '1');
INSERT INTO `user` VALUES (13, 'cjh1', 'haha', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (14, '1', '1', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (15, '6', '123456', '6', 6, '女', '6');
INSERT INTO `user` VALUES (16, '23213', '123456', '3', 131, '女', '31231');
INSERT INTO `user` VALUES (17, '23123', '123456', '123213123', 1231232, '女', '1331231');

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo`  (
  `uId` int(0) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `uName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `uPassword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `uSaying` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名言',
  `uSuper` int(0) NULL DEFAULT NULL COMMENT '是否是管理员',
  `uFocusedNum` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '用户总专注次数',
  `uFocusedTime` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '用户总专注时长,单位分钟',
  `uHead` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像url',
  PRIMARY KEY (`uId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES (1, '1', '1', '好好学习!', 1, 0000000020, 0000001400, 'https://s1.ax1x.com/2022/04/18/LdCjl4.jpg');
INSERT INTO `userinfo` VALUES (2, '2', '2', '2qwewqe', 0, 0000000000, 0000000000, 'https://s1.ax1x.com/2022/04/16/LtBCTI.jpg');

-- ----------------------------
-- Triggers structure for table focusinfo
-- ----------------------------
DROP TRIGGER IF EXISTS `subtractTime`;
delimiter ;;
CREATE TRIGGER `subtractTime` BEFORE INSERT ON `focusinfo` FOR EACH ROW BEGIN
--    set new.fLastedTime=FLOOR(TIME_TO_SEC(new.fEndTime-new.fStartTime) / 60);
	 set new.fTaskName = (select tName from taskinfo where tId = new.fTaskId);
	 update taskinfo set tFocusedNum = tFocusedNum + 1 where tId = new.fTaskId;
	 update taskinfo set tFocusedTime = tFocusedTime + new.fLastedTime where tId = new.fTaskId;
	 update userinfo set uFocusedNum = uFocusedNum + 1 where uId = ( select tUserId from taskinfo where tId = new.fTaskId);
	 update userinfo set uFocusedTime = uFocusedTime + new.fLastedTime where uId = ( select tUserId from taskinfo where tId = new.fTaskId);
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
