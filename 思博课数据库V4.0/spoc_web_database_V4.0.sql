/*
SQLyog Professional v12.09 (64 bit)
MySQL - 5.6.10 : Database - spoc_web
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`spoc_web` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `spoc_web`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `adminid` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户权限编号',
  `usertype` varchar(20) DEFAULT NULL COMMENT '用户类型（值为1为管理员，2为普通用户）',
  PRIMARY KEY (`adminid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户权限关系表';

/*Data for the table `admin` */

insert  into `admin`(`adminid`,`usertype`) values (1,'管理员'),(2,'普通用户');

/*Table structure for table `affair` */

DROP TABLE IF EXISTS `affair`;

CREATE TABLE `affair` (
  `aff_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '业务编号',
  `name` varchar(20) DEFAULT NULL COMMENT '联系人姓名',
  `phone` varchar(15) DEFAULT NULL COMMENT '联系人手机号',
  `content` varchar(1000) DEFAULT NULL COMMENT '具体内容',
  `flag` tinyint(1) DEFAULT NULL COMMENT '是否被处理',
  `doc` varchar(100) DEFAULT NULL COMMENT '附件路径',
  `loginid` varchar(20) DEFAULT NULL COMMENT '审核业务的管理员',
  `acid` int(11) DEFAULT NULL COMMENT '业务类别',
  PRIMARY KEY (`aff_id`),
  KEY `adminid` (`loginid`),
  KEY `ccid` (`acid`),
  CONSTRAINT `affair_ibfk_4` FOREIGN KEY (`acid`) REFERENCES `affair_category` (`acid`),
  CONSTRAINT `affair_ibfk_3` FOREIGN KEY (`loginid`) REFERENCES `member` (`loginid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务关系表';

/*Data for the table `affair` */

/*Table structure for table `affair_category` */

DROP TABLE IF EXISTS `affair_category`;

CREATE TABLE `affair_category` (
  `acid` int(11) NOT NULL AUTO_INCREMENT COMMENT '业务类别编号',
  `name` varchar(50) DEFAULT NULL COMMENT '业务类别名称',
  PRIMARY KEY (`acid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `affair_category` */

insert  into `affair_category`(`acid`,`name`) values (1,'微课慕课'),(2,'广告'),(3,'视频'),(4,'行业软件'),(5,'商业活动软件'),(6,'游戏软件'),(7,'VR视频'),(8,'VR游戏');

/*Table structure for table `apply` */

DROP TABLE IF EXISTS `apply`;

CREATE TABLE `apply` (
  `apply_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '报名编号',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sex` char(2) DEFAULT NULL COMMENT '性别',
  `college` varchar(50) DEFAULT NULL COMMENT '学院',
  `grade` varchar(20) DEFAULT NULL COMMENT '年级',
  `major` varchar(50) DEFAULT NULL COMMENT '专业',
  `phone` varchar(15) DEFAULT NULL COMMENT '手机号',
  `group` varchar(20) DEFAULT NULL COMMENT '组别',
  PRIMARY KEY (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报名关系表';

/*Data for the table `apply` */

/*Table structure for table `charge_standard` */

DROP TABLE IF EXISTS `charge_standard`;

CREATE TABLE `charge_standard` (
  `csid` int(11) NOT NULL AUTO_INCREMENT COMMENT '收费标准编号',
  `standard` varchar(50) DEFAULT NULL COMMENT '收费标准',
  `acid` int(11) DEFAULT NULL COMMENT '业务类别编号',
  PRIMARY KEY (`csid`),
  KEY `acid` (`acid`),
  CONSTRAINT `charge_standard_ibfk_1` FOREIGN KEY (`acid`) REFERENCES `affair_category` (`acid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `charge_standard` */

/*Table structure for table `college` */

DROP TABLE IF EXISTS `college`;

CREATE TABLE `college` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT '学院编号',
  `name` varchar(50) DEFAULT NULL COMMENT '学院名称',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `college` */

insert  into `college`(`cid`,`name`) values (1,'农学院'),(2,'园艺园林学院'),(3,'植物保护学院'),(4,'动物科学技术学院'),(5,'动物医学院'),(6,'食品科学技术学院'),(7,'工学院'),(8,'资源环境学院'),(9,'理学院'),(10,'经济学院'),(11,'商学院'),(12,'公共管理与法学学院'),(13,'马克思主义学院'),(14,'外国语学院'),(15,'信息科学技术学院'),(16,'教育学院'),(17,'生物科学技术学院'),(18,'体育艺术学院'),(19,'国际学院'),(20,'继续教育学院'),(21,'东方科技学院');

/*Table structure for table `group_manage` */

DROP TABLE IF EXISTS `group_manage`;

CREATE TABLE `group_manage` (
  `gid` int(11) NOT NULL AUTO_INCREMENT COMMENT '小组编号',
  `name` varchar(20) NOT NULL COMMENT '组名',
  `description` varchar(200) DEFAULT NULL COMMENT '组描述',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `group_manage` */

insert  into `group_manage`(`gid`,`name`,`description`) values (1,'摄影组',NULL),(2,'平面设计组',NULL),(3,'特效组',NULL),(4,'程序组',NULL);

/*Table structure for table `honor` */

DROP TABLE IF EXISTS `honor`;

CREATE TABLE `honor` (
  `hid` int(11) NOT NULL AUTO_INCREMENT COMMENT '荣誉编号',
  `time` date DEFAULT NULL COMMENT '获奖时间',
  `img` varchar(100) DEFAULT NULL COMMENT '荣誉照片路径',
  `description` varchar(200) DEFAULT NULL COMMENT '荣誉介绍',
  PRIMARY KEY (`hid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='荣誉关系表';

/*Data for the table `honor` */

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `loginid` varchar(20) NOT NULL COMMENT '登录名',
  `password` varchar(20) NOT NULL COMMENT '密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sex` varchar(4) DEFAULT NULL COMMENT '性别',
  `img` varchar(100) DEFAULT NULL COMMENT '照片路径',
  `date` date DEFAULT NULL COMMENT '出生年月',
  `college` varchar(100) DEFAULT NULL COMMENT '学院',
  `grade` varchar(20) DEFAULT NULL COMMENT '年级',
  `major` varchar(100) DEFAULT NULL COMMENT '专业',
  `qq` varchar(15) DEFAULT NULL COMMENT 'QQ',
  `phone` varchar(15) NOT NULL COMMENT '手机号',
  `address` varchar(60) DEFAULT NULL COMMENT '家庭住址',
  `instroduction` varchar(600) DEFAULT NULL COMMENT '自我介绍',
  `job` varchar(400) DEFAULT NULL COMMENT '就业情况',
  `flag` varchar(20) DEFAULT NULL COMMENT '身份标识（表明老师还是学生）',
  `adminid` int(11) DEFAULT NULL COMMENT '用户权限',
  PRIMARY KEY (`loginid`),
  KEY `adminid` (`adminid`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`adminid`) REFERENCES `admin` (`adminid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生关系表';

/*Data for the table `member` */

/*Table structure for table `member_group` */

DROP TABLE IF EXISTS `member_group`;

CREATE TABLE `member_group` (
  `lgid` int(11) NOT NULL AUTO_INCREMENT COMMENT '成员小组编号',
  `loginid` varchar(20) DEFAULT NULL COMMENT '成员编号',
  `gid` int(11) DEFAULT NULL COMMENT '小组编号',
  PRIMARY KEY (`lgid`),
  KEY `sid` (`loginid`),
  KEY `gid` (`gid`),
  CONSTRAINT `member_group_ibfk_1` FOREIGN KEY (`loginid`) REFERENCES `member` (`loginid`),
  CONSTRAINT `member_group_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `group_manage` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生小组关系表';

/*Data for the table `member_group` */

/*Table structure for table `member_honor` */

DROP TABLE IF EXISTS `member_honor`;

CREATE TABLE `member_honor` (
  `lhid` int(11) NOT NULL AUTO_INCREMENT COMMENT '成员荣誉编号',
  `lid` varchar(20) DEFAULT NULL COMMENT '成员编号',
  `hid` int(11) DEFAULT NULL COMMENT '荣誉编号',
  PRIMARY KEY (`lhid`),
  KEY `lid` (`lid`),
  KEY `hid` (`hid`),
  CONSTRAINT `member_honor_ibfk_2` FOREIGN KEY (`hid`) REFERENCES `honor` (`hid`),
  CONSTRAINT `member_honor_ibfk_1` FOREIGN KEY (`lid`) REFERENCES `member` (`loginid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `member_honor` */

/*Table structure for table `member_product` */

DROP TABLE IF EXISTS `member_product`;

CREATE TABLE `member_product` (
  `lpid` int(11) NOT NULL AUTO_INCREMENT COMMENT '成员作品编号',
  `lid` varchar(20) DEFAULT NULL COMMENT '成员编号',
  `pid` int(11) DEFAULT NULL COMMENT '作品编号',
  PRIMARY KEY (`lpid`),
  KEY `sid` (`lid`),
  KEY `pid` (`pid`),
  CONSTRAINT `member_product_ibfk_1` FOREIGN KEY (`lid`) REFERENCES `member` (`loginid`),
  CONSTRAINT `member_product_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生作品关系表';

/*Data for the table `member_product` */

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `pid` int(11) NOT NULL AUTO_INCREMENT COMMENT '作品编号',
  `name` varchar(20) NOT NULL COMMENT '作品名称',
  `time` date DEFAULT NULL COMMENT '作品时间',
  `description` varchar(200) DEFAULT NULL COMMENT '作品介绍',
  `pro_path` varchar(100) NOT NULL COMMENT '作品路径',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='作品关系表';

/*Data for the table `product` */

/*Table structure for table `service_type` */

DROP TABLE IF EXISTS `service_type`;

CREATE TABLE `service_type` (
  `stid` int(11) NOT NULL AUTO_INCREMENT COMMENT '服务类型编号',
  `type` varchar(100) DEFAULT NULL COMMENT '服务类型',
  `acid` int(11) DEFAULT NULL COMMENT '业务类别',
  PRIMARY KEY (`stid`),
  KEY `acid` (`acid`),
  CONSTRAINT `service_type_ibfk_1` FOREIGN KEY (`acid`) REFERENCES `affair_category` (`acid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `service_type` */

/*Table structure for table `type_category` */

DROP TABLE IF EXISTS `type_category`;

CREATE TABLE `type_category` (
  `tcid` int(11) NOT NULL AUTO_INCREMENT COMMENT '服务分类编号',
  `description` varchar(100) DEFAULT NULL COMMENT '分类描述',
  `content` varchar(100) DEFAULT NULL COMMENT '具体内容',
  `stid` int(11) DEFAULT NULL COMMENT '服务类型编号',
  `csid` int(11) DEFAULT NULL COMMENT '收费标准编号',
  PRIMARY KEY (`tcid`),
  KEY `stid` (`stid`),
  KEY `csid` (`csid`),
  CONSTRAINT `type_category_ibfk_2` FOREIGN KEY (`csid`) REFERENCES `charge_standard` (`csid`),
  CONSTRAINT `type_category_ibfk_1` FOREIGN KEY (`stid`) REFERENCES `service_type` (`stid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `type_category` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
