/*
 Navicat Premium Data Transfer

 Source Server         : win7_3396_v5.7
 Source Server Type    : MySQL
 Source Server Version : 50714
 Source Host           : localhost:3396
 Source Schema         : breadroll-education

 Target Server Type    : MySQL
 Target Server Version : 50714
 File Encoding         : 65001

 Date: 11/08/2021 21:15:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `article_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `article_title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `reading_count` int(10) NULL DEFAULT 0 COMMENT '阅读量',
  `publish_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发布时间',
  `text` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `cover_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '封面url',
  `type_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类',
  `publish_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发布状态',
  `audit_state` int(1) NOT NULL DEFAULT -1 COMMENT '审核状态',
  `reprint_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '转载链接',
  `publisher` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布人',
  `publisher_id` int(10) NOT NULL COMMENT '发布人id',
  `delete_state` tinyint(1) NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`article_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '[Linux] 宝塔面板命令及各软件安装目录', 12, '2021-06-06 20:57:43', '## 安装宝塔\r\n\r\nCentos安装脚本\r\n\r\n```shell\r\nyum install -y wget && wget -O install.sh http://download.bt.cn/install/install.sh && sh install.sh\r\n```\r\n\r\nUbuntu/Deepin安装脚本\r\n\r\n```shell\r\nwget -O install.sh http://download.bt.cn/install/install-ubuntu.sh && sudo bash install.sh\r\n```\r\n\r\nDebian安装脚本\r\n\r\n```shell\r\nwget -O install.sh http://download.bt.cn/install/install-ubuntu.sh && bash install.sh\r\n```\r\n\r\nFedora安装脚本\r\n\r\n```shell\r\nwget -O install.sh http://download.bt.cn/install/install.sh && bash install.sh\r\n```\r\n\r\n\r\n\r\n## 管理宝塔\r\n\r\n停止\r\n\r\n```shell\r\n/etc/init.d/bt stop\r\n```\r\n\r\n启动\r\n\r\n```shell\r\n/etc/init.d/bt start\r\n```\r\n\r\n重启\r\n\r\n```shell\r\n/etc/init.d/bt restart\r\n```\r\n\r\n卸载\r\n\r\n```shell\r\n/etc/init.d/bt stop && chkconfig --del bt && rm -f /etc/init.d/bt && rm -rf /www/server/panel\r\n```\r\n\r\n查看当前面板端口\r\n\r\n```shell\r\ncat /www/server/panel/data/port.pl\r\n```\r\n\r\n修改面板端口，如要改成8881（centos 6 系统）\r\n\r\n```shell\r\necho \'8881\' > /www/server/panel/data/port.pl && /etc/init.d/bt restart\r\niptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 8881 -j ACCEPT\r\nservice iptables save\r\nservice iptables restart\r\n```\r\n\r\n修改面板端口，如要改成8881（centos 7 系统）\r\n\r\n```shell\r\necho \'8881\' > /www/server/panel/data/port.pl && /etc/init.d/bt restart\r\nfirewall-cmd --permanent --zone=public --add-port=8881/tcp\r\nfirewall-cmd --reload\r\n```\r\n\r\n强制修改MySQL管理(root)密码，如要改成123456\r\n\r\n```shell\r\ncd /www/server/panel && python tools.pyc root 123456\r\n```\r\n\r\n修改面板密码，如要改成123456\r\n\r\n```shell\r\ncd /www/server/panel && python tools.pyc panel 123456\r\n```\r\n\r\n站点配置文件位置\r\n\r\n```shell\r\n/www/server/panel/vhost\r\n```\r\n\r\n删除域名绑定面板\r\n\r\n```shell\r\nrm -f /www/server/panel/data/domain.conf\r\n```\r\n\r\n清理登陆限制\r\n\r\n```shell\r\nrm -f /www/server/panel/data/*.login\r\n```\r\n\r\n查看面板授权IP\r\n\r\n```shell\r\ncat /www/server/panel/data/limitip.conf\r\n```\r\n\r\n关闭访问限制\r\n\r\n```shell\r\nrm -f /www/server/panel/data/limitip.conf\r\n```\r\n\r\n查看许可域名\r\n\r\n```shell\r\ncat /www/server/panel/data/domain.conf\r\n```\r\n\r\n关闭面板SSL\r\n\r\n```shell\r\nrm -f /www/server/panel/data/ssl.pl && /etc/init.d/bt restart\r\n```\r\n\r\n查看面板错误日志\r\n\r\n```shell\r\ncat /tmp/panelBoot\r\n```\r\n\r\n查看数据库错误日志\r\n\r\n```shell\r\ncat /www/server/data/*.err\r\n```\r\n\r\n站点配置文件目录(nginx)\r\n\r\n```shell\r\n/www/server/panel/vhost/nginx\r\n```\r\n\r\n站点配置文件目录(apache)\r\n\r\n```shell\r\n/www/server/panel/vhost/apache\r\n```\r\n\r\n站点默认目录\r\n\r\n```shell\r\n/www/wwwroot\r\n```\r\n\r\n数据库备份目录\r\n\r\n```shell\r\n/www/backup/database\r\n```\r\n\r\n站点备份目录\r\n\r\n```shell\r\n/www/backup/site\r\n```\r\n\r\n站点日志\r\n\r\n```shell\r\n/www/wwwlogs\r\n```\r\n\r\n\r\n\r\n## Nginx服务管理\r\n\r\nnginx安装目录\r\n\r\n```shell\r\n/www/server/nginx\r\n```\r\n\r\n启动\r\n\r\n```shell\r\n/etc/init.d/nginx start\r\n```\r\n\r\n停止\r\n\r\n```shell\r\n/etc/init.d/nginx stop\r\n```\r\n\r\n重启\r\n\r\n```shell\r\n/etc/init.d/nginx restart\r\n```\r\n\r\n启载\r\n\r\n```shell\r\n/etc/init.d/nginx reload\r\n```\r\n\r\nnginx配置文件\r\n\r\n```shell\r\n/www/server/nginx/conf/nginx.conf\r\n```\r\n\r\n\r\n\r\n## Apache服务管理\r\n\r\napache安装目录\r\n\r\n```shell\r\n/www/server/httpd\r\n```\r\n\r\n启动\r\n\r\n```shell\r\n/etc/init.d/httpd start\r\n```\r\n\r\n停止\r\n\r\n```shell\r\n/etc/init.d/httpd stop\r\n```\r\n\r\n重启\r\n\r\n```shell\r\n/etc/init.d/httpd restart\r\n```\r\n\r\n启载\r\n\r\n```shell\r\n/etc/init.d/httpd reload\r\n```\r\n\r\napache配置文件\r\n\r\n```shell\r\n/www/server/apache/conf/httpd.conf\r\n```\r\n\r\n\r\n\r\n## MySQL服务管理\r\n\r\nmysql安装目录\r\n\r\n```shell\r\n/www/server/mysql\r\n```\r\n\r\nphpmyadmin安装目录\r\n\r\n```shell\r\n/www/server/phpmyadmin\r\n```\r\n\r\n数据存储目录\r\n\r\n```shell\r\n/www/server/data\r\n```\r\n\r\n启动\r\n\r\n```shell\r\n/etc/init.d/mysqld start\r\n```\r\n\r\n停止\r\n\r\n```shell\r\n/etc/init.d/mysqld stop\r\n```\r\n\r\n重启\r\n\r\n```shell\r\n/etc/init.d/mysqld restart\r\n```\r\n\r\n启载\r\n\r\n```shell\r\n/etc/init.d/mysqld reload\r\n```\r\n\r\nmysql配置文件\r\n\r\n```shell\r\n/etc/my.cnf\r\n```\r\n\r\nmysql日志文件\r\n\r\n```shell\r\n# 默认在/www/server/data目录\r\n# 可以直接输入cat /www/server/data/*.err查看错误日志 \r\n```\r\n\r\n \r\n\r\n## FTP服务管理\r\n\r\nftp安装目录\r\n\r\n```shell\r\n/www/server/pure-ftpd\r\n```\r\n\r\n启动\r\n\r\n```shell\r\n/etc/init.d/pure-ftpd start\r\n```\r\n\r\n停止\r\n\r\n```shell\r\n/etc/init.d/pure-ftpd stop\r\n```\r\n\r\n重启\r\n\r\n```shell\r\n/etc/init.d/pure-ftpd restart\r\n```\r\n\r\nftp配置文件\r\n\r\n```shell\r\n/www/server/pure-ftpd/etc/pure-ftpd.conf\r\n```\r\n\r\n\r\n\r\n## PHP服务管理\r\n\r\nphp安装目录\r\n\r\n```shell\r\n/www/server/php\r\n```\r\n\r\n启动(请根据安装PHP版本号做更改，例如：/etc/init.d/php-fpm-54 start)\r\n\r\n```shell\r\n/etc/init.d/php-fpm-{52|53|54|55|56|70|71} start\r\n```\r\n\r\n停止(请根据安装PHP版本号做更改，例如：/etc/init.d/php-fpm-54 stop)\r\n\r\n```shell\r\n/etc/init.d/php-fpm-{52|53|54|55|56|70|71} stop\r\n```\r\n\r\n重启(请根据安装PHP版本号做更改，例如：/etc/init.d/php-fpm-54 restart)\r\n\r\n```shell\r\n/etc/init.d/php-fpm-{52|53|54|55|56|70|71} restart\r\n```\r\n\r\n启载(请根据安装PHP版本号做更改，例如：/etc/init.d/php-fpm-54 reload)\r\n\r\n```shell\r\n/etc/init.d/php-fpm-{52|53|54|55|56|70|71} reload\r\n```\r\n\r\n配置文件(请根据安装PHP版本号做更改，例如：/www/server/php/52/etc/php.ini)\r\n\r\n```shell\r\n/www/server/php/{52|53|54|55|56|70|71}/etc/php.ini\r\n```\r\n\r\n\r\n\r\n## Redis服务管理\r\n\r\nredis安装目录\r\n\r\n```shell\r\n/www/server/redis\r\n```\r\n\r\n启动\r\n\r\n```shell\r\n/etc/init.d/redis start\r\n```\r\n\r\n停止\r\n\r\n```shell\r\n/etc/init.d/redis stop\r\n```\r\n\r\nredis配置文件\r\n\r\n```shell\r\n/www/server/redis/redis.conf\r\n```\r\n\r\n\r\n\r\n## Memcached服务管理\r\n\r\nmemcached安装目录\r\n\r\n```shell\r\n/usr/local/memcached\r\n```\r\n\r\n启动\r\n\r\n```shell\r\n/etc/init.d/memcached start\r\n```\r\n\r\n停止\r\n\r\n```shell\r\n/etc/init.d/memcached stop\r\n```\r\n\r\n重启\r\n\r\n```shell\r\n/etc/init.d/memcached restart\r\n```\r\n\r\n启载\r\n\r\n```shell\r\n/etc/init.d/memcached reload\r\n```\r\n', '/upload/article/1622984255574jn2.png', 'Web后端', 1, 1, 'https://blog.qiudb.top/index.php/archives/22/', 'admin', 1, 0);
INSERT INTO `article` VALUES (2, '[Mybatis] selectKey的用法', 6, '2021-06-06 20:59:10', '### 功能介绍\r\n> selectKey返回最近一次插入的Id，用于获取插入记录之后的自增Id\r\n> Id通过传入对象的get方法可以得到\r\n\r\n```xml\r\n<insert id=\"insert\" parameterType=\"com.qiu.user\">\r\n    <selectKey keyProperty=\"id\" order=\"AFTER\" resultType=\"java.lang.Integer\">\r\n        SELECT LAST_INSERT_ID()\r\n    </selectKey>\r\n    insert into user (username,password) values(#{username},#{password})\r\n</insert>\r\n```\r\n\r\n### 属性详解\r\n\r\n| 属性          | 描述                                                         |\r\n| ------------- | ------------------------------------------------------------ |\r\n| keyProperty   | selectKey 语句结果应该被设置的目标属性                       |\r\n| resultType    | 结果的类型                                                   |\r\n| order         | 设置为 BEFORE 或 AFTER，如果设置为 BEFORE,那么它会先选择主键,设置 keyProperty 然后执行插入语句；如果设置为 AFTER,那么先执行插入语句,然后是 selectKey 元素。 |\r\n| statementType | 和前面的相同,MyBatis 支持 STATEMENT ,PREPARED 和CALLABLE语句的映射类型,分别代表 PreparedStatement 和CallableStatement 类型。 |\r\n\r\n\r\n', '/upload/article/1622984341022jn4.png', 'Web后端', 1, 1, '', 'admin', 1, 0);
INSERT INTO `article` VALUES (3, '没有高并发经验，却被问到如何设计一个秒杀场景，该怎么办？', 25, '2021-06-07 15:10:18', '> 从读者的描述，可以看出高并发处理的经验，在面试中占据着举足轻重的地位，关于高并发相关的面试题，一直都是面试热题，因为这类面试题能够更加直观地体现候选人的技术水平与深度。如何解决高并发场景下的问题，永远都不会过时。\r\n\r\n## 核心要素\r\n何为高并发？\r\n\r\n高并发指的是在同一时刻，有大量用户的请求同时到达服务器，而服务器需要在有限的资源内处理这些请求，并尽可能快地响应用户请求。\r\n\r\n在秒杀场景中，我们需要从在大量并发请求过程中提升服务器的处理性能，在处理过程中数据处理不能存错，同时在整个秒杀链路中需要满足高可用性，即在秒杀过程中，服务不能突然掉链子，需要满足秒杀场景活动生命周期的完成。\r\n\r\n我们可以总结出秒杀场景中有三个核心要素：\r\n\r\n1. 高性能；\r\n2. 一致性；\r\n3. 高可用性。\r\n\r\n## 如何提高性能？\r\n秒杀场景核心的问题是如何解决海量请求带来的性能问题，那么我们如何在有限的资源下，尽最大的限度去提高服务器访问性能？按照我以往的经验，我大致总结有这几点：热点数据处理、流量削峰、资源隔离、服务器优化。\r\n\r\n### 热点数据处理\r\n **1、什么是热点数据？** \r\n\r\n我理解的热点数据指的是用户请求量非常高的那些数据，在秒杀场景中，热点数据就是那些要被秒杀的商品数据。\r\n\r\n这些热点请求会大量占用服务器的资源，如果不对这些数据进行处理，那么会严重占用资源，进而影响系统的性能，导致其他业务也受影响。\r\n\r\n热点数据又可以分为“静态热点数据”和“动态热点数据”。\r\n\r\n **2、静态热点数据** \r\n\r\n静态热点数据指的是可以提前预知的热点数据，比如本文所说的秒杀场景，需要参与本次秒杀的商家提前报名，并将秒杀的商品录入热点分析系统中。业务系统通过这次提前录入的热点数据，进行预加载，甚至可以将数据放入本地缓存中，这样做的好处可以有效缓解避缓存集群的压力，避免流量集中时压垮缓存集群。\r\n\r\n可能有人会问如何更新本地缓存？\r\n\r\n我的做法是将热点数据录入热点分析平台，本地对热点数据进行订阅，并根据订阅规则去更新本地缓存即可。\r\n\r\n **3、动态热点数据** \r\n\r\n动态指的就是不能提前预知哪些数据是热点的，需要通过数据收集与分析，或者通过大数据平台预测。\r\n\r\n我的做法是通过在网关平台中做一个用于收集日志的异步日志收集系统，通过采集商品请求的日志，处理后发送到热点分析平台，热点分析平台通过一些列的分析计算将这些热点商品进行热点数据处理，后端通过订阅这些热点数据就可以识别哪些商品是热点数据了。\r\n![kpm9ukij.png](https://blog.qiudb.top/usr/uploads/2021/06/590379398.png)\r\n\r\n\r\n\r\n## 流量削峰\r\n在服务器资源固定的情况下，说明处理能力是有峰值存在的，如果不对请求处理进行处理的话，很可能会在流量峰值的瞬间压垮服务器，但流量峰值存在的时间不长，其实服务器的处理能力大部分时间都是处于闲置状态，那么我们可不可以将峰值集中的请求分散到其他时间呢？\r\n\r\n1、消息队列\r\n\r\n消息队列除了在解耦、异步场景之外，最大的作用场景是用于流量削峰，面对海量流量请求，可以将这些请求数据用异步的方式先存放在消息队列中，而消息队列一般都能够存储大量消息，消息会被消费端订阅消费，这样就有效地将峰值均摊到其他时间进行处理了。\r\n![kpm9u70m.png](https://blog.qiudb.top/usr/uploads/2021/06/3441574254.png)\r\n\r\n\r\n如上，消息队列就像我们平常见到的水库一样，当洪水来临时，拦住并对其进行储蓄，以减少对下游的冲击，避免了洪水的灾害。\r\n\r\n目前有大量优秀的开源消息队列框架，如 RocketMQ、Kafka 等，而我之前在中通时主要负责消息平台的建设与维护工作，中通每天面对几千万的订单流量依然那么稳固，其中消息队列起了很大的“防洪”作用！\r\n\r\n2、答题\r\n\r\n除了利用消息队列对请求进行“储蓄”达到削峰的目的之外，还可以通过在用户发起请求前，对用户进行一些校验操作，比如答题、输入验证码等等，这种答题机制，除了可以防止买家在秒杀过程中使用作弊脚本之外，在秒杀场景中最主要的作还是将请求分散到各个时间点，秒杀场景一般都是集中在某个点进行，比如 0 点时刻，如果没有答题机制，几乎所有的流量都在 0 点时刻涌入服务器中，如果有答题机制，就能延缓用户的请求，从而达到请求分散到各个时间点的目的。\r\n\r\n## 如何保持一致性？\r\n秒杀场景，本质上就是在海量买家同时请求购买时，能够准确并将商品卖出去。\r\n\r\n在秒杀的高并发读写请求过程中，需要保证商品不会发生“超卖”现象，因为秒杀的商品是数量一定的，但会有成千上万个用户在同一时间下单购买，在减扣库存过程中如何保证商品数量的准确性至关重要。\r\n\r\n## 减扣库存方案分析\r\n我在以前在做秒杀项目的时，分析过几种减扣库存的方式，我简单分析下。\r\n\r\n1、下单减扣库存\r\n\r\n买家只要完成下单，立即减扣商品库存，这种方式实现是最简单而且也是最精准的，通常可以在下单时利用数据库事务能力即可保证减扣库存的准确性，但需要考虑买家下单后不付款的情况。\r\n\r\n2、付款减扣库存\r\n\r\n即买家下单后，并不立即减库存，而是等到有用户付款后才真正减库存，否则库存一直保留给其他买家。但因为付款时才减库存，如果并发比较高，有可能出现买家下单后付不了款的情况，因为可能商品已经被其他人买走了。\r\n\r\n当只有买家下单后，并且已完成付款，才执行库存的减扣，这种方式好处是避免了买家不付款导致实际没有卖出这么多商品的情况，但这种方式会造成用户体验不好，因为这会导致有些用户付款时商品有可能被人买走了导致付款失败的问题。\r\n\r\n3、预扣库存\r\n\r\n这种方式结合以上两种方式的优点，当买家下单后，预扣库存，只会其保留一定的时间，比如 10 分钟，在这段时间内如果买家不付款，则将库存自动释放，其它买家可以继续抢购。这种做法需要买家付款前，再做一次商品库是否还有保留，如果没有保留，则再次尝试预扣，预扣失败则不允许继续付款；如果有保留，付款完成后执行真正的减扣库存动作。\r\n\r\n但预扣库存依然没有彻底解决减扣库存链路中存在的问题，比如有些买家可以在释放的瞬间立马又重新下单一次，相当于将库存无限地保留下去，因此我们还需要将记录用户下单次数，如果连续下单超过一定次数，或者超过下单并不付款次数，就拦截用户下单请求。\r\n\r\n总结：\r\n\r\n一般最简单的做法就是使用下单减库存的方式（我之前的项目中就是用的这种），我当初的考虑是因为在秒杀场景中，商品的性价比通常很高，秒杀就是创造一种只有少量买家能买到的场景，一般来说买家只要“秒”到商品了，极少情况会出现退款的，即使发生了少量退款，造成实际卖出去的商品会比数据上少，也是可以通过候补来解决。\r\n\r\n## 如何减扣库存？\r\n减扣库存动作应该放在哪里执行？\r\n\r\n下面我具体分析一下减扣库存的几种实现方式：\r\n\r\n如果链路涉及的逻辑比较简单的，比如下单减库存这种方式，最简单的做法就是在下单时，利用数据库的本地事务机制进行对库存的减扣，比如使用 where 库存 >0不满足就回滚；\r\n将库存数量值放在缓存中，比如 Redis，并做持久化处理。\r\n需要注意的是，如果遇到减扣库存的逻辑很复杂，比如减扣库存之后需要在同一个事务中做一些其他事情，那么就不能使用第二种方式了，只能使用第一种方式在数据库层面上面操作，以保证同在一个事务中。面对这种情况，你可以将热点数据进行数据库隔离，把这些热点商品单独放在一个数据库中。\r\n\r\n## 如何实现高可用性？\r\n最后，为了保证秒杀系统的高可用性，必须要对系统进行兜底处理，以便遇到极端的情况系统依然能够运转，通常的做法有服务降级、服务限流、拒绝请求等方式处理。\r\n\r\n### 服务降级\r\n当请求量达到系统承受的能力时，需要对系统的一些非核心功能进行关闭操作，尽可能将资源留给秒杀核心链路。\r\n\r\n比如在秒杀系统中，还存在其他非核心的功能，我们可以在系统中设计一些动态开关，比如在网关层在路由开关，将这些非核心的请求直接在最外层拒掉。\r\n\r\n还有就是对页面展示的数据进行精简化，用降低用户体验换取核心链路的稳定运行。\r\n\r\n### 服务限流\r\n限流的目的是通过对并发访问/请求进行限速或者一个时间窗口内的的请求进行限速来保护系统，常用的有 QPS 限流，用户请求排队限流，需要设置过期时间，一旦超过过期时间则丢弃，这样做是为了用户请求可以做到快速失败的效果，这种机制在 RocketMQ 中也有相关的应用，RocketMQ broker 会对客户端请求进行排队限流处理，当请求在队列中超过了过期时间，则丢弃，客户端快速失败进行第二轮重试。\r\n\r\n### 拒绝请求\r\n如果服务降级、服务限流都不能解决问题，最后的兜底，那就是直接拒绝用户请求，比如直接给用户返回 “服务器繁忙，请稍后再试”等提示文案。只会发生在服务器负载过载时会启动，因此只会发生短暂不可用时刻，由于此时服务依然还在稳定运行中，等负载下降时，可以快速恢复正常服务。\r\n![kpm9vpuf.png](https://blog.qiudb.top/usr/uploads/2021/06/3367845184.png)\r\n\r\n', '/upload/article/1623051172961jn1.png', 'Web后端', 1, 1, 'https://www.jianshu.com/p/aaafc99ac58d', 'admin', 1, 0);
INSERT INTO `article` VALUES (4, '都二十多年了，你的梦为什么还没碎！', 4, '2021-06-07 15:40:32', '![kpmaxnp4.png](https://blog.qiudb.top/usr/uploads/2021/06/2003768476.png)\r\n散去热闹的大街上，一个男子步履蹒跚的在往前挪去，他好像漫无目的一般，不知在这街上行走了多久，风吹落了他手上的一张纸，被大风带往远方……\r\n\r\n01\r\n\r\n今天阿梅大学同学二十年聚会的日子，阿梅早早的就起床梳洗打扮起来，虽然不再年轻，但是在丈夫的爱护下，还是保养得像个30多岁的人一样。\r\n阿亮见阿梅这么早就起来打扮，知道她要去参加同学聚会，看了眼扭过头准备继续睡去，“你快点起来，今天周末牛牛要参加一个培训班，你待会记得陪牛牛去见见老师”耳边传来了阿梅的声音。\r\n见丈夫在床上躺着，阿梅不觉皱了皱眉，有几丝皱纹浮现出来，丈夫是木讷的人，不怎么会说话，在阿梅看来结婚20多年夫妻感情一直都是平平淡淡不见增长，但阿亮为人老实，肯吃苦，当时阿梅也是见他老实肯干才嫁给他的。\r\n\r\n​02\r\n\r\n来的酒楼，阿梅一眼便寻到了自己的好友莉莉，走过去拉起家常来，陆续有同学到来，各种三五一伙的聊起来，气氛顿时火热起来。\r\n终于同学到齐了，在班长的致辞后，大家便马上找好自己的座位，为接下来的大餐做好准备，阿梅莉莉一时没找到两个连在一起的位置。\r\n“阿梅，过来坐”后面传来一个的男人的声音，阿梅扭头望去，只见左后方一个男子，他的身边刚好有两个空位，但是看到这个男人的瞬间，阿梅静止了。\r\n他还是那么忧郁，棱角分明的脸型配上那双深沉的眸子，仿佛要吧人吸进去一样，“阿梅你发什么愣啊，待会位置没了”，耳边传来莉莉不满的声音，说完拉着阿梅就走了过去。\r\n\r\n03\r\n\r\n再次坐在他是身边，阿梅发现自己是内心还是难以平静，他是阿梅大学的同桌周杰，看着周杰的样子，他好像变一般，只是年岁增长和多了胡茬而已，让他更增几分魅力，只是他的眼角似有似无的流露出些许疲惫。\r\n除了周杰和阿梅，谁都不知道阿梅曾经给周杰表过白，而且还被周杰拒绝了，为此阿梅曾经难过了很久，一顿饭下来谁也没主动说话，默默的吃着。\r\n“现在过得怎么样?”，耳边传来了周杰的声音，在丈夫的细心呵护下，虽不是那些豪门那般享福，但阿梅也没怎么受过苦，算是普通人里面很幸福的了，但木讷的丈夫让阿梅觉得他真的是不懂浪漫，粗人一个。\r\n“还行”，鬼使神差的阿梅不知道自己怎么说出这两个字的，“你呢？周杰”。\r\n“不怎么样，前年和老婆离婚了，我两感情不和，女儿跟了她，我带着儿子生活，自己开了个咖啡店生活也算过意的去……”，外貌没怎么变的周杰好像变了，他不在如大学时那般沉默少言，是个话痨般在诉说着他最近的生活。\r\n\r\n04\r\n\r\n饭局结束，班长见大家都还聊得火热，便提议去KTV唱歌，马上便得到了大家的同意，一行人便涌向了附近的KTV。\r\n阿梅和莉莉坐在女生堆里聊着天，男生们拿着麦在一旁鬼哭狼嚎，偶尔也会有女生唱上一首，这时大家便会安静下来，让耳朵享受这动听的歌声，相比较于五音不全的男生们，这确实算得上天籁。\r\n一曲结束，响起一片掌声，女生不好意思的低下了头，拿着话筒小声说道：“谁想唱歌，谁想唱歌”。\r\n一道身影快速上前接过话筒，是周杰阿梅一眼便瞧了出来，““这一刻突然觉得好熟悉 像昨天今天同时在放映 我这句语气原来好像你 不就是我们爱过的证据 差一点骗了自己骗了你 爱与被爱不一定成正比 我知道被疼是一种运气 但我无法完全交出自己 努力为你改变 却变不了预留的伏线 以为在你身边那也算永远 仿佛还是昨天 可是昨天已非常遥远 但闭上我双眼我还看得见 可惜不是你 陪我到最后……”\r\n\r\n05\r\n\r\n阿梅听得入迷了，连唱完歌后周杰怎么坐在自己身边都没察觉，“喝一杯嘛”，周杰说道，阿梅没有犹豫的举起了酒杯，她心里那个二十几年的梦好像又活了过来，在酒精的刺激下两人开始聊了起来，阿梅诉说着对老公，以及生活的不满，周杰诉说着对前妻的对生活的不满，他们各种说着自己的，没有在听对方得，又好像都听进去，不知道喝了多少杯，阿梅觉得自己晕乎乎的，看着声旁的周杰，两人紧紧搂在一起，嘴慢慢的吻在一起,在同学们没有注意间阿梅和周杰走出来KTV，去了附近的酒店。\r\n\r\n06\r\n\r\n已经11点了，阿亮着急的在家里坐立不安，阿梅还没回来，她从没这么晚没有回来过。电话也打不通，阿梅同学的电话阿亮知道的几个也打了没打通，由于阿梅没有告诉他聚会的地点在哪，阿亮也只能不安的等待，慢慢在困意中慢慢睡去。\r\n第二天，一醒阿亮看到阿梅还没有回来，阿亮急了马上拨打了阿梅好姐妹莉莉的电话，嘟，嘟，没响两声便被接通了，\r\n“莉莉，你有没有看到阿梅”，\r\n​“啊，阿梅姐不是昨天还没唱完歌就走的嘛，怎么她没回去？”\r\n“什么，阿梅回来”\r\n“对了她好像和她一起同桌一起走的，我还以为他送阿梅姐回家呢”\r\n​……\r\n\r\n07\r\n\r\n结束和莉莉的通话，不安的阿亮立即报了警，警察很快查明阿梅和一名男子住进了附近一家酒店，并住在一间房内，听到这个消息的时候阿亮傻了，不敢相信的阿亮傻了，阿亮恳请警察带他一起去，要是阿梅被欺负的话，阿亮想着就算是有警察，自己也要打死那个王八蛋。\r\n和警察来到房间门口，叫来一个服务员说酒店送早餐，没打开了，一个男的搂着阿梅，阿梅正幸福的靠在男子怀里站在门后正准备让出一条路，当见到门外这么多人的时候，里面的人傻了，站在外面的阿亮也傻了，他那捏的发紫的拳头，无力的撒开了。\r\n阿亮不知道自己怎么和大家回到的警局，一路上阿亮的脑子都是乱哄哄的，耳朵也嗡嗡直响，像得了耳鸣一样。\r\n\r\n08\r\n\r\n阿亮想不通，自己对阿梅这么好，为啥阿梅要对不起他，阿亮可以忍受阿梅的各种毛病只要她开心就好，但突然那么一瞬间阿亮觉得阿梅变得暗淡了。\r\n警察安排阿亮阿梅见面，两人坐着谁都没说话，沉寂了好久，阿亮突然吼道：“都20多年了，你的梦还没碎嘛，我知道你当初追求者那么多，嫁给我你有点不甘心，但我这么努力对你好还不够嘛？还不够嘛？…被爱的人都是祖宗！”\r\n在警察局里阿亮和阿梅协议离了婚，阿梅的背叛让阿亮难以接受，拿着离婚协议的阿亮像门外走去，阳光下，那道背影好像变得有点佝偻了，仿佛老了一般。\r\n\r\n09\r\n\r\n抽烟的人，永远闻不到自己身上的烟味，就好像被爱的人，她用永远都不知道…，她永远都不知道，爱你的人有多辛苦。\r\n她​所有的迷恋都是凭借幻觉，所有的理解都是包含误解，永远无法感通深受。', '/upload/article/1623051598963853453726.jpg', '求职应聘', 1, 1, 'https://www.vvhan.com/20yeardrem.html', 'admin', 1, 0);
INSERT INTO `article` VALUES (5, 'Win10快捷键 你也是热键大师', 4, '2021-06-07 15:53:48', '## 虚拟桌面\r\n### 创建虚拟桌面  Win+Ctrl+D\r\n虚拟桌面，就像你使用第二台电脑去做另一个项目一样。\r\n### 关闭虚拟桌面  Win+Ctrl+F4\r\n关闭当前正在打开的虚拟桌面\r\n### 切换虚拟桌面  Win+Ctrl+方向键\r\n可以左右来回切换桌面\r\n\r\n## 全窗口最小化  Win+M\r\n顾名思义，不用鼠标一个一个点击最小化，直接全部最小化\r\n\r\n## 快速打开任务栏程序  Win+1-9 （0是第十个窗口）\r\n按任务栏程序打开顺序，调出相应软件\r\n\r\n## 将屏幕向左右分屏  Win+⬅（➡）\r\n将当前窗口向两侧分屏，实现多任务工作；适用于写文档论文之类文档办公；\r\n\r\n## 快速切换窗口  Alt+Tab\r\n快速的切换正在运行的程序，即便在全屏状态也一样快速切换\r\n\r\n## 在鼠标位置放大  Win+ +-\r\n在鼠标处按住win++实现放大镜的放大功能，-为缩小功能；有助于放大字体图片等等\r\n\r\n## 屏幕区域截图  Win+Shift+S\r\n区域化截图，捕捉视频中的一些美好瞬间，截图后需要保存\r\n\r\n## 锁屏 - Win+L\r\n当你暂时离开电脑时，不用关机这个快捷键可以实现一键屏锁\r\n\r\n## 打开任务管理器  Ctrl+Shift+Esc\r\n电脑死机的必备方法\r\n', '/upload/article/162305242048415.png', '办公软件', 1, 1, '', 'admin', 1, 0);
INSERT INTO `article` VALUES (6, '要学会征服自己', 4, '2021-06-07 15:55:29', '　　有人这样说过：征服世界，并不伟大，一个征服自己，才是世界上最伟大的人。从这句话里我回忆起一个这样的故事。\r\n\r\n　　据说：在闻名世界的威斯特敏斯特大教堂的地下室墓碑林中，有一块墓碑上面写着：“当我年轻的时候，我的想象力从没有受到限制，我梦想改变这个世界。当我成熟以后，我发现我不能够改变这个世界，我将目光缩短了些，决定只改变我的国家。当我进入暮年以后，我发现我不能够改变我的国家，我的最后愿望仅仅是改变一下我的家庭。但是，这也不可能。当我躺在床上，行将就木时，我突然意识到，如果一开始我仅仅去改变我自己，然后作为一个榜样，我可能改变我的家庭;在家人的帮助和鼓励下，我可能能为国家做一些事情。然后，谁知道呢?我可能、甚至改变这个世界。”\r\n\r\n　　年轻时的南非人曼德拉看到这段话后，触动了他对人生的思考，他茅塞顿开，从中领悟到了人生的真谛。回到南非以后，曼德拉改变了他自己原来的一些想法和做法，首先从改变自己的思想和处世作风做起，下决心先改变一下自己。历经几十年的磨难和奋斗，他不仅改变了自己，更是改变了自己的国家。\r\n\r\n　　曼德拉的故事让我陷入了深思。在我们身边，经常会听到一些人抱怨的声音，他们往往把自己的失意或失败归咎于周边的环境和他人，甚至总想着要去改变别人来适应自己。其实，上面这个故事告诉我们，征服世界，并不一定伟大。一个人能征服自己，才是世界上最伟大的人。要知道人生最大的敌人就是自己。一个人要想有所作为，就要把挑剔的眼光盯在自己的身上，以科学发展的眼光去审视自己，解剖自己，征服自己。\r\n\r\n　　我本人就是一个这样的典型，从我在1957年踏进监狱的那一天起，我当时虽然有些小小的恐惧，但是我还是没有真正胆怯，因为过去二十几年的社会实践的生活历程告诉我，世上没有走不通的路，也没有过不去的桥。既然进了这个门槛儿，恐怕就没了回头的路，你不想往前走，那是绝对不可能。再说从1954年起，我就已经一再接受所谓上级的审查，从他们的话里话外，我也听得出这可不是什么善茬，倒霉的日子正在等候着我。迟早会到那天。早到晚到还有什么区别吗?\r\n\r\n　　换做其他人，走进牢房总是会心惊胆战的，可是我呢?饭照吃，是稀饭，加上两根萝卜干。觉照睡，只是不是家里的弹簧床，而是硬蹦蹦的水泥地上。好就好在睡着了还没做噩梦。当然我明明晓得这是一步险棋，不过我还连想起这句话：好道儿坏道儿还得人去走。今天过去了，还有明天。这其实就是我学会去征服自己的第一步。\r\n\r\n　　虽然我也知道我是不可能成为一个什么大人物，但我也绝不会是个等闲之辈，我一直到现在仍旧在试图创造奇迹，什么样的奇迹，我现在一时还说不清。但是其中最重要的一点就是，我在做，我在行动，我在付出。我一直还在坚持以实际行动来征服自己。这就够了。', '/upload/article/162305254413216.png', '求职应聘', 1, 1, 'https://zhuanlan.zhihu.com/p/266506148', 'admin', 1, 0);
INSERT INTO `article` VALUES (7, '战胜自己，超越自己', 9, '2021-06-07 15:59:57', '　　每个人都有一个梦想，但不是每个人都能实现梦想，都说梦想和现实相距太远，似乎梦想就是遥不可及，就是雾里看花水中捞月，面对残酷的现实，梦想只有夭折才使我们踏实。其实阻碍我们前进的就是自己，觉得梦想遥远的是自己，觉得梦想之路坎坷的是自己，觉得人言可畏的是自己，放弃梦想的也是自己，我们把自己圈在一个自己设计的围墙里，局限在自己思维的界线中，然后怎么也突不破这道沟壑，成为自己的俘虏，败给自己。\r\n\r\n　　有人说：心有多大，舞台就有多大，没有做不到，只有想不到。只要我们想到了就要对自己说，我可以，我一定行。勇于面对自己的不足，超越自己的格局，承担失败，吸取纰漏，重头再来。如果你一败涂地，从此一蹶不振，那你只能望洋兴叹，遗憾终生。\r\n\r\n　　一位辽宁的农民，他非常喜欢唱歌，他在农田里歌唱，在泥泞的山路上歌唱，在脏乱的鸡舍里歌唱，一唱就是十三年。但是很多人说他的嗓音不适合唱歌，可他不想放弃，妈妈的支持给了他极大的鼓舞，他来到《中国好声音》，只想问问老师们，他的嗓音究竟有没有，能够唱出自己的未来?一曲悠扬，深情的英文歌曲还没唱完，三位权威老师就转过来急不可待的想知道，那个奇特的嗓音，是什么样的女孩唱出来的，当他们转过来的那一刻似乎都惊呆了，原来他是位帅气，清亮的小伙子。那英的第一句评价就是唱的太迷人了，庾澄庆给予音色特别的肯定，杨坤也说“该发光发亮的时候到了，如果能出来，那就是独树一帜的”是啊，老天爷给了他一个非常独特的嗓音，同时又让他生活在反差极大的环境里，难道不是一种历练吗?如果在他听到别人的“判决”后就放弃梦想，如今他依旧是无人问津的泥腿子。十三年一直坚持着这个梦想，那就是回报自己的坚持和父母的期望，梦想其实很简单，做起来却很曲折漫长，他超越了自己，农民一样可以高歌嘹亮，一样可以站在舞台中央，拥抱梦幻的霓虹和热烈的掌声。\r\n\r\n　　来自台北板桥的盲女，一位街头表演者，已经三十六岁，她不漂亮，甚至很丑，身材很胖，而且是盲人。可那声音就是第二个邓丽君，情悠悠独上西楼，别有一番滋味在心头，让人想象一位超凡脱俗的人间仙女，一袭白衣，飘飘裙带，身姿婉约婀娜，明亮的双眸似清澈的湖水，站在阁楼上望着月亮，犹唱情丝千缕万古柔肠!可当老师们都激情转身后，个个惊呆了，是大失所望?还是出乎意料?又是感动又是震惊，傻了，惊呆，幸福的感觉一起袭来，甚至含着泪水。她虽盲人，却那么自信，她说自己在唱歌的时候就是一个灿烂的发光体，她的梦想却只是要与自己喜欢的那英同唱一首歌，“输赢的代价是彼此粉身碎骨，外表健康的你心里伤痕无数，顽强的我是这场战役的俘虏”上天帮她关上了一扇窗，可又给她打开了一扇门，我想上天是公平的，盲女虽眼前是黑暗的，但是她的内心确是五彩缤纷，她不会因为自己的残疾，来让别人怜悯，她战胜自己看不见的局限，超越自己的自身的缺陷，来到灯火辉煌的舞台，以柔美深情的歌声，带给所有人耀眼的光亮，也许这就是残缺的完美，遗憾的圆满，她的前途是无限光明的，因为她战胜了自己。\r\n\r\n　　贵州的小女孩，她只有一米四八的身高，在妈妈的肚子里就喜欢唱歌，妈妈都说她那么矮还想做明星，摄像机都照不到她。可她的身体里却有一个等待爆发的小原子弹，她要突破自己，用“真实”的身高来证明自己，男朋友的贬低和瞧不起，使她更有力量去完成自己的歌唱事业，她的梦想就是成为歌坛的小巨人，用歌声证明自己的高大，谁不想有个亭亭玉立的身姿，谁不想有付如花似玉的容颜，老天不给你，他就会在其他方面让你有潜质，只要自己不拘泥在那些所谓的缺憾里，找到自己的亮点，持之以恒的去努力，你的潜能就会挖掘出来，成为闪闪发光的金子!\r\n\r\n　　还有那么多战胜自己，实现梦想的人，不光是在歌坛，还有奥运健儿，学术精英，设计人才等等各行各业，他们未必都是天才，他们不一定从小就在这个行业里是佼佼者，但是我确定，他们都有乐观自信的心态，坚持不懈不畏坎坷的决心，风雨中不改信念，激流中不退热情，艰苦时不忘初衷。脚踏荆棘面不改色，汗流浃背一笑而过，满目苍怡泰然自若。\r\n\r\n　　战胜自己，终有一天，你会扇动着梦想的翅膀，飞翔在蔚蓝的天空!', '/upload/article/1623052795593167.png', '求职应聘', 1, 1, 'https://lizhi.7139.com/4967/29/7460.html', 'admin', 1, 0);
INSERT INTO `article` VALUES (8, '起点绝不是终点', 1, '2021-06-07 16:27:38', '　　也许你尚未做好独自前行的准备，但你需要知道，我所置身的那个充满挑战与神奇的商业世界，是你新生活的出发地，你将从那里开始参加你不曾享用而又关乎你未来的人生盛宴。至于你如何使用摆放在你生命面前的刀叉，和如何品味命运天使奉上的每一道菜肴，那完全要靠你自己。\r\n\r\n　　当然，我期望你在不远的将来就能卓尔不群，并胜我一筹。而我决定将你留在我身边，无非是想把你带到你事业生涯的高起点，让你无须艰难攀爬便可享有迅速腾达的机会。这当然没有什么值得你庆幸和炫耀的，更无须你感激。美利坚合众国的建国信念是人人生而平等，但这种平等是权利与法律意义上的平等，与经济和文化优势无关。想想看，我们这个世界就如同一座高山，当你的父母生活在山顶上时，注定你不会生活在山脚下;当你的父母生活在山脚下时，注定你不会生活在山顶上。在多数情况下，父母的位置决定了孩子的人生起点。\r\n\r\n　　但这并不意味着，每个人的起点不同，其人生结果也不同。在这个世界上，永远没有穷、富世袭之说，也永远没有成、败世袭之说，有的只是我奋斗我成功的真理。我坚信，我们的命运由我们的行动决定，而绝非完全由我们的出身决定。\r\n\r\n　　就像你所知道的那样，在我小的时候，家境十分贫寒，记得我刚上中学时所用的书本都是好心的邻居为我买的，我的人生开始时也只是一个周薪只有5 元钱的簿记员，但经由不懈的奋斗我却建立了一个令人艳羡的石油王国。在他人眼里这似乎是个传奇，我却认为这是对我持之以恒、积极奋斗的回报，是命运之神对我艰苦付出的奖赏。\r\n\r\n　　约翰，机会永远都会不平等，但结果却可能平等。在历史上，无论是在政界还是在商界，尤其在商界，白手起家的事例俯拾皆是，他们都曾因贫穷而少有机会，他们却都因奋斗而功成名就。然而，历史上也充斥着富家子弟拥有所有优势，却走向失败的事例。麻州的一项统计数字说，十七个有钱人的孩子里面，竟然没有一个在离开这个世界时还是富翁。\r\n\r\n　　而在很久以前，社会上便流传着一个讽刺富家子弟无能的故事，说在费城的一个小酒吧里，一位客人谈起某位百万富翁，说：“他是白手起家的百万富翁。”“是啊，”旁边一位比较精明的先生回答说，：“他继承了两千万，然后他把这笔钱变成了一百万。”\r\n\r\n　　这是一个令人痛心的故事。但在我们今天这年社会，富家子弟正处在一种不进则退的窘境之中，他们中的很多人注定要受人同情和怜悯，甚至要下地狱。\r\n\r\n　　家族的荣耀与成功的历史，不能保证其子孙后代的未来将会美好。我承认早期的优势的确大有帮助，但它不能保证最后会赢得胜利。我曾不止一次地思考这个对富家子弟而言带有悲哀性的问题，我似乎觉得，富家子弟开始承担了优势，却很少有机会去学习和发展生存所需要的技巧。而出身低贱的人因迫切需要解救自身，便会积极发挥创意和能力，且珍视和抢占各种机会。我还观察到，富家子弟缺乏贫贱之人的那种要拯救自己的野心，也只得祈祷上帝赐予他成就了。\r\n\r\n　　所以，在你和你的姐姐们很小的时候，我就有意识地不让你们知道你们的父亲是个富人，我向你们灌输最多的是诸如节俭、个人奋斗等价值观念，因为我知道给人带来伤害最快捷的途径就是给钱，它可以让人腐化堕落、飞扬跋扈、不可一世，失去最美好的快乐。我不能用财富埋葬我心爱的孩子，愚蠢地让你们成为不思进取、只知依赖父母的果实的无能者。\r\n\r\n　　一个真正快乐的人，是能够享受他的创造的人。那些像海绵一样，只取不予的人，只会失去快乐。我相信没有不渴望过上快乐、高贵生活的人，但真正懂得高贵快乐生活从何而来的人却不多。在我看来，高贵快乐的生活，不是来自高贵的血统，也不是来自高贵的生活方式，而是来自高贵的品格——自立精神，看看那些赢得世人尊重、处处施展魅力的高贵的人，我们就知道自立的可贵。', '/upload/article/162305445298013.png', '求职应聘', 1, 1, '', 'admin', 1, 0);
INSERT INTO `article` VALUES (9, '手机的构图和相机的构图有区别吗？', 2, '2021-06-07 17:26:41', '什么是构图呢？简单地说就是你画面中有各种各样的元素，这些元素在你画面中出现的位置就是构图。\r\n\r\n所以这么看来手机和相机的构图并没有什么本质的不同。\r\n\r\n一张照片中，人物没走到既定位置，相机是端着等，手机也是端着等。一样。\r\n\r\n一张照片中，画面三分法好看的时候，相机是上下移动或者摇动，手机也是。一样。\r\n\r\n一张照片中，拍摄建筑一般端端正正，相机要端平，手机也是。一样。\r\n\r\n可以说摄影技巧4个方面：取景、曝光、虚实、构图，从原理上，相机和手机没有本质的不同，而构图这个方面，相机和手机的操作方法都是一模一样。就在你的想法，以及你的手上。\r\n\r\n **结论就是：没有任何区别。** \r\n\r\n该三分三分，该居中居中，该端平端平……如果你不懂，那你就没看过我写的关于构图部分的教程。订阅号回复关键词：摄影。你可以看到。\r\n\r\n似乎就讲完了……\r\n\r\n但是也没有。\r\n\r\n手机对于辅助构图有一些功能可以说说。首先就是三分辅助线。\r\n\r\n但凡是个手机里面一定有三分辅助线。打开拍照功能，在设置里面看看。三分辅助线可以很好帮助你进行三分法构图。\r\n\r\n常规构图两种方法——三分和居中。居中实在不需要什么辅助。所以开着三分辅助线就行了。\r\n\r\n三分辅助线还有一个好用处，就是可以帮助你确定画面水平。比如你用肯定平的线——海平线啊，地平线啊，建筑啊……去卡一下辅助线。基本就可以确定端平了。\r\n![kpmeshcl.png](https://blog.qiudb.top/usr/uploads/2021/06/298016999.png)\r\n\r\n\r\n说到端平，其实手机里面本身就有可以测试手机角度的机构。所以你手机横屏、竖屏可以识别，自己切换。那么手机里面拍摄时有个实时水平仪就很简单啊。\r\n\r\n但是我惊讶发现，不是每款手机都有这个功能。\r\n\r\n如果有的话，我建议在设置中打开这个功能。可以很好地帮我们端平手机。\r\n\r\n对于手机构图最重要的就是这两个辅助功能了。\r\n\r\n此外，我见过有的手机有各种各样的构图辅助线。比如著名的……\r\n\r\n黄金螺旋。\r\n![kpmeqs00.png](https://blog.qiudb.top/usr/uploads/2021/06/772856579.png)\r\n\r\n\r\n我就想问问，黄金螺旋线，是穿过你认为重要的元素，还是切你认为重要的元素，还是包住你认为重要的元素？\r\n\r\n谁先把这个问题给我回答了？', '/upload/article/162305799498512.png', '办公软件', 1, 1, '', 'admin', 1, 0);
INSERT INTO `article` VALUES (10, '摄影，重要不只是景深', 3, '2021-06-07 17:29:12', '摄影是简简单单的一个动作，摄影是费尽心血的一个思路，摄影是对外部世界的汲取，摄影也是内心世界的展示。正如著名的摄影师皮特·亚当斯所说：伟大的摄影作品，重要的是情深，而不是景深。\r\n![kpmeve0s.png](https://blog.qiudb.top/usr/uploads/2021/06/2177641190.png)\r\n\r\n\r\n摄影是一种艺术创作，需要创作者对光影、构图有着敏锐的感受。我更同意这样一种说法，摄影是时光的暂停键。人的一生不断在流逝的时光里穿行，不断经历一个又一个值得回忆的宝贵瞬间，而我们总是借助摄影的方式抓住这些闪光瞬间。\r\n\r\n但摄影在给予我幸福的同时，同时也让我感受到了某种不幸，那就是我遇到了自己拍摄作品的瓶颈，我没办法再拍出让自己满意的东西。那段时间，我甚至经常在自我反思，反思自己的心态是不是过于浮躁了。为了寻求创作上的突破，我选择继续学习。万门出品的《如何让你的照片惊艳朋友圈？》这门课给了我极大的启发。这门课的老师是一位从业经验丰富的摄影界大佬，他拍摄过许多社会名流，有许多经典的摄影作品。\r\n\r\n在课堂上，老师以自身经验为大家讲解了什么是美，我特别欣赏他的一个观点，他认为构图不存在最好的方式，摄影也没有根本的原则，全世界的人都按照一个所谓标准去构图，那么摄影也失去了意义。“不可替代性”才是摄影的价值。\r\n\r\n课上有提到许多实用的手机拍摄指南和技巧，比如说寻找线条和图形之间存在的韵律、拍摄局部特写、给图片做减法、去掉无用的元素、适当的留白等等。除此之外，老师还分析各种比例图片在视觉上的优势和不足，同时也真诚地推荐了各种适合拍摄的手机和好用的修图工具。\r\n\r\n学习完这门课程后，我开始调整自己的创作心态，不再过于拘泥于所谓的拍摄流程。创作中不急不躁，让创作随着灵感走，作品质量和以前相比也有着一定的提升。但是，摄影作为一门技术，需要慢慢积累、多多学习，摄影，已经成为了我生活中的一部分。作为一种兴趣爱好，我比以往更加能感受到它的活力。每一幅作品，都附着着我的语言，用无声的方式把我的想法传达给这个世界。\r\n\r\n在此我也非常乐意与大家分享我在学习课程之后的一些习作。通过学习这门课程，我更认识到摄影是一种人生修行，需要创作者平心静气，时时刻刻留意生活中的美。好的摄影师应该是一位优秀的画家，也应该是一位生活的诗人。\r\n![kpmew2lz.png](https://blog.qiudb.top/usr/uploads/2021/06/477353183.png)\r\n\r\n', '/upload/article/1623058123247aa.png', '办公软件', 1, 1, '', 'admin', 1, 0);

-- ----------------------------
-- Table structure for article_audit
-- ----------------------------
DROP TABLE IF EXISTS `article_audit`;
CREATE TABLE `article_audit`  (
  `audit_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '审核ID',
  `article_id` int(10) NOT NULL COMMENT '文章ID',
  `article_title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章名',
  `reviewer_id` int(10) NULL DEFAULT NULL COMMENT '审核人ID',
  `reviewer` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `publisher_id` int(10) NOT NULL COMMENT '发布人ID',
  `publisher` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布人',
  `audit_state` int(1) NOT NULL DEFAULT 0 COMMENT '审核状态',
  `audit_time` timestamp(0) NULL DEFAULT NULL COMMENT '审核时间',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核备注',
  PRIMARY KEY (`audit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章审核表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_audit
-- ----------------------------
INSERT INTO `article_audit` VALUES (1, 1, '[Linux] 宝塔面板命令及各软件安装目录', 1, 'admin', 1, 'admin', 1, '2021-06-06 21:00:25', 0, '审核通过');
INSERT INTO `article_audit` VALUES (2, 2, '[Mybatis] selectKey的用法', 1, 'admin', 1, 'admin', 1, '2021-06-06 21:00:36', 0, '审核通过');
INSERT INTO `article_audit` VALUES (3, 3, '没有高并发经验，却被问到如何设计一个秒杀场景，该怎么办？', 1, 'admin', 1, 'admin', 3, '2021-06-07 15:31:55', 0, '审核通过');
INSERT INTO `article_audit` VALUES (4, 4, '都二十多年了，你的梦为什么还没碎！', 1, 'admin', 1, 'admin', 1, '2021-06-07 15:45:00', 0, '审核通过');
INSERT INTO `article_audit` VALUES (5, 5, 'Win10快捷键 你也是热键大师', 1, 'admin', 1, 'admin', 1, '2021-06-07 16:00:23', 0, '审核通过');
INSERT INTO `article_audit` VALUES (6, 7, '战胜自己，超越自己', 1, 'admin', 1, 'admin', 1, '2021-06-07 16:00:30', 0, '审核通过');
INSERT INTO `article_audit` VALUES (7, 6, '要学会征服自己', 1, 'admin', 1, 'admin', 1, '2021-06-07 16:01:00', 0, '审核通过');
INSERT INTO `article_audit` VALUES (8, 8, '起点绝不是终点', 1, 'admin', 1, 'admin', 1, '2021-06-07 16:29:48', 0, '审核通过');
INSERT INTO `article_audit` VALUES (9, 9, '手机的构图和相机的构图有区别吗？', 1, 'admin', 1, 'admin', 1, '2021-06-07 17:31:10', 0, '审核通过');
INSERT INTO `article_audit` VALUES (10, 10, '摄影，重要不只是景深', 1, 'admin', 1, 'admin', 1, '2021-06-07 17:31:27', 0, '审核通过');

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `banner_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '轮播图Id',
  `course_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  `course_id` int(10) NOT NULL COMMENT '课程ID',
  `banner_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宣传图url',
  `banner_state` tinyint(1) NOT NULL DEFAULT 1 COMMENT '轮播图状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`banner_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '轮播图表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES (1, '人像修图入门课', 9, '/upload/banner/1623214262553aaa.jpg', 1, 0);
INSERT INTO `banner` VALUES (2, 'Excel“脱白课”：基础入门', 3, '/upload/banner/1623214384189bbb.jpg', 1, 0);
INSERT INTO `banner` VALUES (3, 'Python基础趣讲精练', 10, '/upload/banner/1623214396312cc.jpg', 1, 0);
INSERT INTO `banner` VALUES (4, '证券投资入门：组合决策与管理', 4, '/upload/banner/1623214421892ccc.jpg', 1, 0);

-- ----------------------------
-- Table structure for coach_apply
-- ----------------------------
DROP TABLE IF EXISTS `coach_apply`;
CREATE TABLE `coach_apply`  (
  `coach_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '特训班ID',
  `course_id` int(10) NOT NULL COMMENT '课程ID',
  `course_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  `start_time` timestamp(0) NULL DEFAULT NULL COMMENT '开课时间',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `user_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `user_email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `coach_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '报名时间',
  `apply_state` int(1) NOT NULL DEFAULT 0 COMMENT '报名状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`coach_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '特训班报名表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coach_apply
-- ----------------------------
INSERT INTO `coach_apply` VALUES (4, 19, 'MySQL高级', '2021-09-01 00:00:00', 1, 'zhangsan', '18638614155', '1679232425@qq.com', '2021-08-11 19:49:27', 1, 0);
INSERT INTO `coach_apply` VALUES (5, 20, 'springboot', '2022-08-01 00:00:00', 1, '汪尼玛', '18638614155', '2827724252@qq.com', '2021-08-11 19:56:26', 0, 0);

-- ----------------------------
-- Table structure for coin_record
-- ----------------------------
DROP TABLE IF EXISTS `coin_record`;
CREATE TABLE `coin_record`  (
  `record_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `record_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  `vary` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变化',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注（原因）',
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coin_record
-- ----------------------------
INSERT INTO `coin_record` VALUES (1, 1, '2021-06-06 19:44:16', '+50', '注册账户赠送50花卷币');
INSERT INTO `coin_record` VALUES (2, 1, '2021-06-06 19:45:24', '+15', '签到奖励');
INSERT INTO `coin_record` VALUES (3, 1, '2021-06-07 16:55:21', '+20', '签到奖励');
INSERT INTO `coin_record` VALUES (4, 1, '2021-06-07 18:41:06', '+100000', '开通终身会员赠送100000花卷币');
INSERT INTO `coin_record` VALUES (5, 2, '2021-06-07 19:16:46', '+50', '注册账户赠送50花卷币');
INSERT INTO `coin_record` VALUES (6, 2, '2021-06-07 19:17:20', '+15', '签到奖励');
INSERT INTO `coin_record` VALUES (7, 2, '2021-06-07 19:17:52', '+600', '开通月会员赠送600花卷币');
INSERT INTO `coin_record` VALUES (8, 1, '2021-06-08 20:53:07', '-2000', '下载《阿里巴巴Java开发手册泰山版》扣除2000花卷币');
INSERT INTO `coin_record` VALUES (9, 1, '2021-06-08 20:54:49', '-800', '下载《钉钉扫码登录》扣除800花卷币');
INSERT INTO `coin_record` VALUES (10, 1, '2021-06-08 20:56:12', '-800', '下载《钉钉扫码登录》扣除800花卷币');
INSERT INTO `coin_record` VALUES (11, 1, '2021-06-08 20:58:29', '-800', '下载《钉钉扫码登录》扣除800花卷币');
INSERT INTO `coin_record` VALUES (12, 1, '2021-06-08 20:59:37', '+25', '签到奖励');
INSERT INTO `coin_record` VALUES (13, 2, '2021-06-08 21:01:12', '+20', '签到奖励');
INSERT INTO `coin_record` VALUES (14, 1, '2021-06-09 14:56:45', '-2000', '下载《阿里巴巴Java开发手册泰山版》扣除2000花卷币');
INSERT INTO `coin_record` VALUES (15, 1, '2021-06-09 14:57:45', '+30', '签到奖励');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `course_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `course_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  `type_id` int(10) NOT NULL COMMENT '类别ID',
  `type_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类别名称',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程简介',
  `teacher_id` int(10) NOT NULL COMMENT '讲师ID',
  `vip_state` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否VIP',
  `online` tinyint(1) NOT NULL COMMENT '是否线上',
  `start_time` timestamp(0) NULL DEFAULT NULL COMMENT '开课时间',
  `course_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程时长',
  `put_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '上架时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `publisher` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布人',
  `publisher_id` int(10) NOT NULL COMMENT '发布人ID',
  `price` double NULL DEFAULT 0 COMMENT '课程价格',
  `publish_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发布状态',
  `audit_state` int(10) NOT NULL DEFAULT -1 COMMENT '审核状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  `play_count` int(10) NOT NULL DEFAULT 0 COMMENT '课程播放量',
  `cover_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程封面URL',
  PRIMARY KEY (`course_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '课程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'HTML5+CSS3零基础教学', 3, 'Web前端', '本课程以项目实战为核心，通过实际商业项目的深度讲解剖析，帮助学员掌握HTML5和CSS3知识体系、经典布局等必备技能。通过一个又一个细致经典的案例，带领学员感受真实的HTML5+CSS3开发场景。', 1, 1, 1, NULL, NULL, '2021-06-06 20:19:43', '2021-06-09 14:46:16', 'admin', 1, 0, 1, 1, 0, 19, '/upload/course/HTML5+CSS3零基础教学/16232211726288.jpg');
INSERT INTO `course` VALUES (2, 'JavaScript零基础进阶班', 3, 'Web前端', '本课程从前端工程师的职业发展和JavaScript的发展历程入手，从基本的环境配置讲起，告诉你如何搭建开发环境，细致讲解每一个例子，让你在观看代码编写的过程中，学会程序开发的基本步骤，掌握核心概念，在实战演练中实现从零基础到达精通的跨越。', 1, 1, 1, NULL, NULL, '2021-06-06 20:28:50', '2021-06-09 14:46:29', 'admin', 1, 0, 0, -1, 0, 0, '/upload/course/JavaScript零基础进阶班/16232211866479.jpg');
INSERT INTO `course` VALUES (3, 'Excel“脱白课”：基础入门', 6, '办公软件', 'Excel是职场人的必备技能，工作中的常用工具，掌握Excel技巧可以倍数提升工作效率。想要提升Excel技能，但是基础薄弱，很多内容看不懂。你需要的是一门可以从基础入手、稳扎稳打学习，一步步走入Excel神奇世界的课程。', 5, 0, 1, NULL, NULL, '2021-06-06 20:34:47', '2021-06-09 14:46:48', 'admin', 1, 0, 1, 1, 0, 10, '/upload/course/Excel“脱白课”：基础入门/162322120574421.jpg');
INSERT INTO `course` VALUES (4, '证券投资入门：组合决策与管理', 6, '办公软件', '本课程将从宏观定性分析开始，通过多种定量方法循序渐进讲解。从大类资产配置、核心+卫星模式、标的证券选择、交易周期决策四个维度逐步建立起投资组合的框架，再通过动态管理方法和绩效的持续改进来对组合进行持续管理，最终完成投资组合管理的流程闭环，建立一套行之有效的规程。来本课程，帮你找到最适合自己的投资道路！', 4, 1, 1, NULL, NULL, '2021-06-06 20:39:42', '2021-06-09 14:47:00', 'admin', 1, 0, 1, 1, 0, 10, '/upload/course/证券投资入门：组合决策与管理/162322121827425.jpg');
INSERT INTO `course` VALUES (5, 'MySQL零基础特训班', 4, 'Web后端', '本课程主要针对零基础学员，从MySQL数据库的使用环境及工具入手，把课程分为数据库入门、数据库建模、数据库分析、数据库优化及整合四个阶段。以详尽细致、通俗易懂的原则讲解数据库的基本知识，在实例讲解的过程中，带领大家学习如何使用和设计数据库，深入了解SQL基本语法，规范使用SQL语言，在实战演练中实现从零基础到精通的跨越。', 1, 1, 0, '2021-06-30 00:00:00', '168.5', '2021-06-06 20:42:22', '2021-06-09 13:31:03', 'admin', 1, 3998, 1, 1, 0, 0, '/upload/course/MySQL零基础特训班/1623216660794a4.jpg');
INSERT INTO `course` VALUES (6, 'BEC商务英语一月特训班', 5, '求职应聘', '我们不难发现，在中国市场逐渐融入国际经济市场的同时，也有大批外资公司纷纷涌进我国，这使得商务英语的人才需求急剧增加。如果你也想进入外企，提高自己的英语能力水平，本课程将会是你的优质之选。课程摒弃了传统教学方式，结合商务英语类话题，通过大量听力、真题及口语练习素材，给你提供自由发挥的空间，激发学习积极性，让你在听、说、读、写方面得到快速提升。课程授课氛围轻松愉悦，培养学习能动性，帮你养成持续学习的习惯！', 3, 1, 0, '2021-06-23 00:00:00', '180', '2021-06-06 20:44:05', '2021-06-09 13:30:30', 'admin', 1, 3998, 1, 1, 0, 0, '/upload/course/BEC商务英语一月特训班/1623216626162a1.jpeg');
INSERT INTO `course` VALUES (7, '数据结构与算法进阶班', 1, '计算机专业基础', '本门课程将系统化讲解数据结构与算法进阶知识及面试必考内容。讲解过程遵循通俗易懂、详尽细致、知行统一的原则，将复杂难懂的知识点简单化、实用化，以满足学员理论联系实践的实操需要。另外，本次学习还将带你探索计算机行业内情、了解岗位需求，知己知彼，方能百战百胜。', 2, 1, 0, '2021-06-29 00:00:00', '180', '2021-06-06 20:45:41', '2021-06-09 13:30:39', 'admin', 1, 3998, 1, 1, 0, 0, '/upload/course/数据结构与算法进阶班/1623216637305a2.jpg');
INSERT INTO `course` VALUES (8, '经济金融一月特训班', 5, '求职应聘', '本课程覆盖经济和金融专业本科期间的11门核心课程，包括：微观经济学、博弈论与信息经济学、宏观经济学、货币银行学、财政学、计量经济学、会计学、公司金融学、投资学、衍生品定价、固定收益。旨在通过27天的学习，帮助学生理解经济和金融主干知识及其结构联系，搭建一套完整的知识框架，养成正确的学科思维，从而使获取新知的速度更快、吸收度更高，为深入学习打下扎实的基础！', 4, 1, 0, '2021-06-29 00:00:00', '135.5', '2021-06-06 20:46:50', '2021-06-09 13:30:51', 'admin', 1, 3998, 1, 1, 0, 0, '/upload/course/经济金融一月特训班/1623216646714a3.jpg');
INSERT INTO `course` VALUES (9, '人像修图入门课', 1, '计算机专业基础', '本课程主要针对零基础学员，讲解关于人像修图的思路和流程，包含ACR转图、PS调整、优秀作品分析、流行色彩风格、质感皮肤、形体液化等。学完之后可以让你快速掌握人像修图各环节的方法和技巧。为了方便学员学习，教程中使用到的原片均可供学员下载、练习和使用。', 6, 0, 1, NULL, NULL, '2021-06-07 11:14:15', '2021-06-09 14:47:18', 'admin', 1, 0, 1, 1, 0, 5, '/upload/course/人像修图入门课/162322123591228.jpg');
INSERT INTO `course` VALUES (10, 'Python基础趣讲精练', 2, '人工智能', 'Python是时下最热门的编程语言之一，爬虫批量抓取和处理信息、用于商业决策的数据分析、数倍提高效率的办公自动化、快速开发Web应用的框架、创造神迹的人工智能技术……作为一门随处可用的胶水语言，无论是专业程序开发、测试、运维人员，还是普通的职场白领，掌握Python都能大大提高个人效能，促进事业提升！', 7, 0, 1, NULL, NULL, '2021-06-07 11:21:45', '2021-06-09 14:47:49', 'admin', 1, 0, 1, 1, 0, 7, '/upload/course/Python基础趣讲精练/162322126746528.jpg');
INSERT INTO `course` VALUES (11, '计算机基础', 1, '计算机专业基础', '每一个程序员都应该花时间学习的基础课！', 1, 0, 1, NULL, NULL, '2021-06-07 11:40:39', '2021-06-09 14:48:04', 'admin', 1, 0, 1, 1, 0, 3, '/upload/course/计算机基础/162322128241929.jpg');
INSERT INTO `course` VALUES (12, 'Python零基础10天进阶班', 2, '人工智能', 'Python 是一种高级编程语言，它优雅而不失实用，语法简单易学，又具有极高的可读性和灵活性，相比“前编程明星”C++和Java等更简单易操作。KDnuggets调查显示，目前Python已成为最受AI从业者欢迎的语言。学会Python已经是程序猿必备技能！', 6, 1, 1, NULL, NULL, '2021-06-07 11:48:33', '2021-06-09 14:48:20', 'admin', 1, 0, 1, 1, 0, 9, '/upload/course/Python零基础10天进阶班/162322129840531.jpg');
INSERT INTO `course` VALUES (13, '程序员成长攻略零基础特训班', 1, '计算机专业基础', '本课程包括软件工程理论、敏捷开发理论等基础知识，结合一线互联网公司的实际工作经验，列举市场对程序员的最新技术要求，提出并讲解五层塔模型，重点介绍程序员在工作中的方法论，给出程序员成长的四类基本技能：技术技能，工作技能，管理技能和商业技能，并做一一讲解，提高职业素养，帮助认知升级。本课程从专业基础到核心技能，再到职场素养，全面培训，促进认知升级，帮助程序员更好更快成长。', 6, 1, 0, '2021-07-14 00:00:00', '49.5', '2021-06-07 12:11:44', '2021-06-09 13:32:34', 'admin', 1, 1998, 1, 1, 0, 0, '/upload/course/程序员成长攻略零基础特训班/1623216752364a8.jpg');
INSERT INTO `course` VALUES (14, '商业数据分析特训班', 2, '人工智能', '数字化正在变革我们认知的所有行业，传统的商业逻辑和商业模式逐渐被无边界的用户需求和跨界竞争所颠覆，交叉的商业价值挖掘，需要大量的数据作为支撑。数据人才已经成为各企业争夺未来市场的标配。\r\n\r\n基于市场对人才的需求分析，万门联合北美数据分析团队，推出一门从基础到实战的商业数据分析课程，内容涵盖Excel数据分析、Python数据分析、基础统计学、 SQL基础、数据可视化、机器学习基础、市场营销分析、A/B测试、游戏数据分析、电商数据分析、零售数据分析等，并结合企业真实数据场景，一步步带你走入数据分析的大门。', 7, 1, 0, '2021-07-12 00:00:00', '132.4', '2021-06-07 12:14:05', '2021-06-09 13:31:16', 'admin', 1, 3998, 1, 1, 0, 0, '/upload/course/商业数据分析特训班/1623216674051a5.jpg');
INSERT INTO `course` VALUES (15, '云计算与大数据零基础特训班', 2, '人工智能', '互联网时代，云计算和大数据成为热门技术。大数据人才缺口已高达百万，未来将达到千万。业内人才需求量远远大于从业者的增长，因此，大数据人才需求将出现“井喷”现象。想要抓住这个绝佳的入行时机？你大可从学习这门课开始！', 6, 1, 0, '2022-07-12 00:00:00', '180', '2021-06-07 12:16:31', '2021-06-09 13:32:50', 'admin', 1, 3998, 1, 1, 0, 0, '/upload/course/云计算与大数据零基础特训班/1623216768214a10.jpg');
INSERT INTO `course` VALUES (16, '机械设计制造及自动化一月特训班', 7, '机械设计', '本课程将为你理清机械专业的课程脉络，从如何学习机械制图到机械制造过程，从机械原理到机械设计。讲师从基础开始，讲述一件机械产品从图纸上的平面线框，到成为满足使用需求的机械运动系统的全过程，助你了解机械设计制造的相关知识。', 4, 1, 0, '2021-07-21 00:00:00', '168.5', '2021-06-07 12:20:16', '2021-06-09 13:32:42', 'admin', 1, 2998, 1, 1, 0, 0, '/upload/course/机械设计制造及自动化一月特训班/1623216760394a9.jpg');
INSERT INTO `course` VALUES (17, 'AJAX+jQuery实战提高特训班', 3, 'Web前端', 'AJAX+jQuery是前端工程师的高级进阶技能，涉及较多的JavaScript语言技术以及计算机网络的底层技术，需要系统的学习和在实战中的大量积累和磨练才能掌握。\r\n\r\n本课程针对有一定基础的同学开设，首先讲解怎样零基础用jQ实现瀑布流，帮助学员形成基础认知，接着重点介绍jQuery对象和选择器、jQuery源代码Sizzle、AJAX等具体知识内容，最后提供电商网站的案例实战，帮助理解知识点。本课程从宏观概览到微观知识点详解，从理论知识到案例实战，全面培训，提高素养，帮你牢牢掌握前端工程师的高级进阶技能。', 1, 1, 0, '2021-07-13 00:00:00', '30.2', '2021-06-07 12:21:27', '2021-06-09 13:31:52', 'admin', 1, 798, 1, 1, 0, 0, '/upload/course/AJAX+jQuery实战提高特训班/1623216709840a6.jpg');
INSERT INTO `course` VALUES (18, 'Java零基础特训班', 3, 'Web前端', '本门课程基于Java 8新特性，围绕网站开发主题，帮助零基础学员从基础上了解Java语言本身及计算机工程开发全貌。课程将结合一线互联网项目实战经验，助你掌握核心技术，无惧开发框架，同时养成知识迁移能力，为后续通往大数据、移动开发等多领域深入学习奠定基础，带你从零基础入手，快速入门计算机工程和软件开发工程！', 1, 1, 0, '2021-07-13 00:00:00', '168.5', '2021-06-07 12:24:40', '2021-06-09 13:32:08', 'admin', 1, 998, 1, 1, 0, 0, '/upload/course/Java零基础特训班/1623216724026a7.jpg');
INSERT INTO `course` VALUES (19, 'MySQL高级', 1, '计算机专业基础', 'sql调优 服务器部署', 2, 1, 0, '2021-09-01 00:00:00', '150', '2021-08-11 19:37:07', '2021-08-11 19:37:07', 'admin', 1, 688, 1, 1, 0, 0, '/upload/course/MySQL高级/1628681815897mysql.jpg');
INSERT INTO `course` VALUES (20, 'springboot', 1, '计算机专业基础', 'springboot集成', 1, 1, 0, '2022-08-01 00:00:00', '150', '2021-08-11 19:44:37', '2021-08-11 19:44:37', 'admin', 1, 188, 1, 1, 0, 0, '/upload/course/springboot/1628682268826java.jpg');

-- ----------------------------
-- Table structure for course_audit
-- ----------------------------
DROP TABLE IF EXISTS `course_audit`;
CREATE TABLE `course_audit`  (
  `audit_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '审核ID',
  `course_id` int(10) NOT NULL COMMENT '课程ID',
  `course_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名',
  `reviewer_id` int(10) NULL DEFAULT NULL COMMENT '审核人ID',
  `reviewer` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `publisher_id` int(10) NOT NULL COMMENT '发布人ID',
  `publisher` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布人',
  `audit_state` int(1) NOT NULL DEFAULT 0 COMMENT '审核状态',
  `audit_time` timestamp(0) NULL DEFAULT NULL COMMENT '审核时间',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核备注',
  PRIMARY KEY (`audit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '课程审核表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_audit
-- ----------------------------
INSERT INTO `course_audit` VALUES (1, 1, 'HTML5+CSS3零基础特训班', 1, 'admin', 1, 'admin', 3, '2021-06-06 20:59:57', 0, '审核通过');
INSERT INTO `course_audit` VALUES (2, 2, 'JavaScript零基础进阶班', 1, 'admin', 1, 'admin', 3, '2021-06-06 21:00:04', 0, '审核通过');
INSERT INTO `course_audit` VALUES (3, 3, 'Excel“脱白课”：基础入门', 1, 'admin', 1, 'admin', 3, '2021-06-06 21:00:09', 0, '审核通过');
INSERT INTO `course_audit` VALUES (4, 4, '证券投资入门：组合决策与管理', 1, 'admin', 1, 'admin', 3, '2021-06-06 21:00:14', 0, '审核通过');
INSERT INTO `course_audit` VALUES (5, 9, '人像修图入门课', 1, 'admin', 1, 'admin', 3, '2021-06-07 11:23:55', 0, '审核通过');
INSERT INTO `course_audit` VALUES (6, 10, 'Python基础趣讲精练', 1, 'admin', 1, 'admin', 3, '2021-06-07 11:24:35', 0, '审核通过');
INSERT INTO `course_audit` VALUES (7, 11, '计算机基础', 1, 'admin', 1, 'admin', 3, '2021-06-07 11:46:48', 0, '审核通过');
INSERT INTO `course_audit` VALUES (8, 12, 'Python零基础10天进阶班', 1, 'admin', 1, 'admin', 3, '2021-06-07 11:53:06', 0, '审核通过');
INSERT INTO `course_audit` VALUES (26, 1, 'HTML5+CSS3零基础教学', NULL, NULL, 1, 'admin', 3, NULL, 0, NULL);
INSERT INTO `course_audit` VALUES (27, 2, 'JavaScript零基础进阶班', NULL, NULL, 1, 'admin', 3, NULL, 0, NULL);
INSERT INTO `course_audit` VALUES (28, 3, 'Excel“脱白课”：基础入门', 1, 'admin', 1, 'admin', 1, '2021-06-09 14:52:49', 0, '审核通过');
INSERT INTO `course_audit` VALUES (29, 4, '证券投资入门：组合决策与管理', 1, 'admin', 1, 'admin', 1, '2021-06-09 14:52:56', 0, '审核通过');
INSERT INTO `course_audit` VALUES (30, 9, '人像修图入门课', 1, 'admin', 1, 'admin', 1, '2021-06-09 14:53:04', 0, '审核通过');
INSERT INTO `course_audit` VALUES (31, 10, 'Python基础趣讲精练', 1, 'admin', 1, 'admin', 1, '2021-06-09 14:53:12', 0, '审核通过');
INSERT INTO `course_audit` VALUES (32, 11, '计算机基础', 1, 'admin', 1, 'admin', 1, '2021-06-09 14:53:20', 0, '审核通过');
INSERT INTO `course_audit` VALUES (33, 12, 'Python零基础10天进阶班', 1, 'admin', 1, 'admin', 1, '2021-06-09 14:53:31', 0, '审核通过');
INSERT INTO `course_audit` VALUES (34, 1, 'HTML5+CSS3零基础教学', 1, 'admin', 1, 'admin', 1, '2021-06-09 14:53:42', 0, '审核通过');

-- ----------------------------
-- Table structure for course_list
-- ----------------------------
DROP TABLE IF EXISTS `course_list`;
CREATE TABLE `course_list`  (
  `list_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '课程目录ID',
  `list_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程目录名称',
  `course_id` int(10) NOT NULL COMMENT '课程ID',
  `course_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  `video_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '视频url',
  `time_minute` int(10) NOT NULL COMMENT '视频分钟',
  `time_second` int(10) NOT NULL COMMENT '视频秒数',
  `lock_state` tinyint(1) NOT NULL COMMENT '是否锁定',
  `delete_state` int(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`list_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '课程目录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_list
-- ----------------------------
INSERT INTO `course_list` VALUES (1, '1.1 讲师介绍', 1, 'HTML5+CSS3零基础教学', '/upload/course/HTML5+CSS3零基础教学/1623221454075HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (2, '1.2 课程介绍', 1, 'HTML5+CSS3零基础教学', '/upload/course/HTML5+CSS3零基础教学/1623221465639HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (3, '1.3 前端工程师的职业发展', 1, 'HTML5+CSS3零基础教学', '/upload/course/HTML5+CSS3零基础教学/1623221474201HEBTU.mp4', 0, 17, 1, 0);
INSERT INTO `course_list` VALUES (4, '1.4 HTML江湖', 1, 'HTML5+CSS3零基础教学', '/upload/course/HTML5+CSS3零基础教学/1623221488140HEBTU.mp4', 0, 17, 1, 0);
INSERT INTO `course_list` VALUES (5, '1.5 总结', 1, 'HTML5+CSS3零基础教学', '/upload/course/HTML5+CSS3零基础教学/1623221498918HEBTU.mp4', 0, 17, 1, 0);
INSERT INTO `course_list` VALUES (6, '1.1 自我介绍与参考书目', 2, 'JavaScript零基础进阶班', '/upload/course/JavaScript零基础进阶班/1623221521641HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (7, '1.2 前端工程师职业发展知识点', 2, 'JavaScript零基础进阶班', '/upload/course/JavaScript零基础进阶班/1623221531333HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (8, '1.3 JavaScript简介知识点', 2, 'JavaScript零基础进阶班', '/upload/course/JavaScript零基础进阶班/1623221540295HEBTU.mp4', 0, 17, 1, 0);
INSERT INTO `course_list` VALUES (9, '1.1 认识Excel', 3, 'Excel“脱白课”：基础入门', '/upload/course/Excel“脱白课”：基础入门/1622982914277HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (10, '1.2 表格格式设计', 3, 'Excel“脱白课”：基础入门', '/upload/course/Excel“脱白课”：基础入门/1622982942772HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (11, '1.3 表格视图设计', 3, 'Excel“脱白课”：基础入门', '/upload/course/Excel“脱白课”：基础入门/1622982969428HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (12, '1.1 课程概论：目标与效用', 4, '证券投资入门：组合决策与管理', '/upload/course/证券投资入门：组合决策与管理/1622983206629HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (13, '1.2 定性分析：明确个人投资预期与风险承', 4, '证券投资入门：组合决策与管理', '/upload/course/证券投资入门：组合决策与管理/1622983226211HEBTU.mp4', 0, 17, 1, 0);
INSERT INTO `course_list` VALUES (14, '1.3 评估成本与支出的刚性约束', 4, '证券投资入门：组合决策与管理', '/upload/course/证券投资入门：组合决策与管理/1622983252842HEBTU.mp4', 0, 17, 1, 0);
INSERT INTO `course_list` VALUES (15, '1. 了解—商业修图应用领域', 9, '人像修图入门课', '/upload/course/人像修图入门课/1623035714447HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (16, '2. 准备—设备与软件', 9, '人像修图入门课', '/upload/course/人像修图入门课/1623035744763HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (17, '3. 初步—完美还原色彩', 9, '人像修图入门课', '/upload/course/人像修图入门课/1623035771679HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (18, '1. 趣识计算机与编程', 10, 'Python基础趣讲精练', '/upload/course/Python基础趣讲精练/1623036140095HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (19, '2. Python编程里的“量”', 10, 'Python基础趣讲精练', '/upload/course/Python基础趣讲精练/1623036162294HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (20, '3. Python的逻辑与循环', 10, 'Python基础趣讲精练', '/upload/course/Python基础趣讲精练/1623036185671HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (21, '4. 实践与探讨', 10, 'Python基础趣讲精练', '/upload/course/Python基础趣讲精练/1623036204143HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (22, '1.1 C语言:课前导读', 11, '计算机基础', '/upload/course/计算机基础/1623037353611HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (23, '1.2 程序与设计语言', 11, '计算机基础', '/upload/course/计算机基础/1623037393806HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (24, '1.3 C语言的发展与特点', 11, '计算机基础', '/upload/course/计算机基础/1623037436410HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (25, '1. 课程介绍', 12, 'Python零基础10天进阶班', '/upload/course/Python零基础10天进阶班/1623037735988HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (26, '2. 软件下载及安装', 12, 'Python零基础10天进阶班', '/upload/course/Python零基础10天进阶班/1623037793898HEBTU.mp4', 0, 17, 0, 0);
INSERT INTO `course_list` VALUES (27, '3. 计算机语言与程序', 12, 'Python零基础10天进阶班', '/upload/course/Python零基础10天进阶班/1623037831200HEBTU.mp4', 0, 17, 1, 0);
INSERT INTO `course_list` VALUES (28, '4. Python介绍', 12, 'Python零基础10天进阶班', '/upload/course/Python零基础10天进阶班/1623037855616HEBTU.mp4', 0, 17, 1, 0);

-- ----------------------------
-- Table structure for course_preview
-- ----------------------------
DROP TABLE IF EXISTS `course_preview`;
CREATE TABLE `course_preview`  (
  `preview_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '课程预告ID',
  `course_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程介绍',
  `start_time` date NULL DEFAULT NULL COMMENT '开课时间',
  `time_length` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '预计时长',
  `teacher_id` int(10) NOT NULL COMMENT '讲师ID',
  `teacher_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '讲师姓名',
  `teacher_des` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '讲师介绍',
  `preview_state` tinyint(1) NOT NULL DEFAULT 1 COMMENT '预告状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`preview_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '课程预告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_preview
-- ----------------------------
INSERT INTO `course_preview` VALUES (1, '计算机二级Python备考指南', 'Python是一种计算机程序设计语言。是一种面向对象的动态类型语言，最初被设计用于编写自动化脚本，随着版本的不断更新和语言新功能的添加，越来越多被用于独立的、大型项目的开发。', '2021-06-23', '18', 1, '王立', '曾经在微软、阿里工作十年以上，参与友盟、芒果移动的收购过程，在离职前最后职位是芒果移动的总负责人\r\n曾经为百变空间CTO联合创始人董事、连续创业者，现在为立芳教育创始人\r\n拥有18项发明专利', 1, 0);
INSERT INTO `course_preview` VALUES (2, 'Excel实战：打造高质量商务图表', '学好Excel各项操作技巧可大幅提高工作效率，如果你经常要用数据向老板汇报业绩、沟通工作，学会用Excel做商务图表，可以帮你解决90%的展示汇报问题！如何用Excel制作高大上的商务动态图表？来本课程，学习商务图表的制作方法。', '2021-06-29', '10.9', 5, '凌祯', '畅销Office课程资深培训讲师\r\n网易云课堂授权讲师\r\n美国PMI认证PMP（项目管理经理）\r\n《数据呈现之美：Excel商务图表实战大全》作者', 1, 0);
INSERT INTO `course_preview` VALUES (3, 'Vue基础特训营', 'Vue.Js是一套用于构建用户界面的渐进式JavaScript框架。因其体积小、易上手、生态丰富、灵活性强且运行效率高等特点，使其成为了目前各大互联网公司最受欢迎的前端开发框架之一，可以说Vue.Js的使用是现如今前端开发工程师的必备技能。', '2021-06-30', '10', 2, '吴海洋', '米修科技创始人、教学总监\r\n曾任用友软件、优步中国前端主程\r\n6年互联网行业开发经验、4年教学经验', 1, 0);
INSERT INTO `course_preview` VALUES (4, 'Go语言基础', '本课程将从基本语法讲起，逐渐深入，帮助同学深度理解Go语言。讲师将带大家分析Go语言面向接口、面向对象、错误处理、Goroutine 与 Channel类型等知识，并构建秒杀系统实战，步步深入，带你快速掌握Go语言！', '2021-06-29', '18', 1, '王立', '曾经在微软、阿里工作十年以上，参与友盟、芒果移动的收购过程，在离职前最后职位是芒果移动的总负责人\r\n曾经为百变空间CTO联合创始人董事、连续创业者，现在为立芳教育创始人\r\n拥有18项发明专利', 1, 0);
INSERT INTO `course_preview` VALUES (5, 'Vue实战-仿饿了么点餐App', '如果你掌握了Vue基础，却在进阶之路上遇到了瓶颈，那这门课就是你快速提升前端技术的突破口。\r\n本课选取真实饿了么点餐App为实战案例，运用前端框架Vue来实现，从整体架构分析开始，环境搭建、具体开发、以及最终的项目上线，完整呈现一个前端项目开发的全过程。', '2021-06-28', '18', 2, '吴海洋', '米修科技创始人、教学总监\r\n曾任用友软件、优步中国前端主程\r\n6年互联网行业开发经验、4年教学经验', 1, 0);
INSERT INTO `course_preview` VALUES (6, 'Web安全基础', '课程内包含大量的实际项目案例，采用一讲一实战的教学模式，通过案例阐述Web安全知识在实际项目中的应用，让学员深入理解各种漏洞的原理、测试、预防措施，为学员建立完整的Web安全基础概念体系，掌握Web安全知识，一步步走进网络安全世界。', '2021-06-28', '18', 1, '王立', '曾经在微软、阿里工作十年以上，参与友盟、芒果移动的收购过程，在离职前最后职位是芒果移动的总负责人\r\n曾经为百变空间CTO联合创始人董事、连续创业者，现在为立芳教育创始人\r\n拥有18项发明专利', 1, 0);

-- ----------------------------
-- Table structure for course_type
-- ----------------------------
DROP TABLE IF EXISTS `course_type`;
CREATE TABLE `course_type`  (
  `type_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '类别ID',
  `type_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类别名称',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类别描述',
  `type_state` tinyint(1) NOT NULL DEFAULT 1 COMMENT '类别状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '课程类别' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_type
-- ----------------------------
INSERT INTO `course_type` VALUES (1, '计算机专业基础', '计算机专业基础包括数据结构，操作系统，计算机原理，计算机网络等基础课程', 1, 0);
INSERT INTO `course_type` VALUES (2, '人工智能', '带你了解人工智能从感知走向认知的发展趋势，解读深度学习中的关键技术！', 1, 0);
INSERT INTO `course_type` VALUES (3, 'Web前端', '带你学会HTML5+CSS3 亲自动手开发静态网站，深度讲解Vue3.0新特性，提升你的核心竞争力！', 1, 0);
INSERT INTO `course_type` VALUES (4, 'Web后端', '深入讲解Web安全方面的基础知识，帮助掌握漏洞原理和预防措施；关注网络安全，重视和保护个人隐私安全。', 1, 0);
INSERT INTO `course_type` VALUES (5, '求职应聘', '讲解商科三大就业方向，助你规划职业生涯路线；详解求职、入职、离职时各类法律风险，以及劳动法及维权知识，帮助学员提高防范意识。', 1, 0);
INSERT INTO `course_type` VALUES (6, '办公软件', '带你掌握Word实用技巧，摆脱低级操作，大大提升工作效率！旨在帮助大家快速、高效地掌握各类常用Excel函数，并应用到具体的实践中。', 1, 0);
INSERT INTO `course_type` VALUES (7, '机械设计', '机械设计制造及自动化涉及机械行业中的设计制造、科技开发、应用研究、运行管理和经营销售等诸多的方向，这些方向需要有专业的课程教导学员学习。', 1, 0);

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `department_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `department_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门名称',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门描述',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `department_state` tinyint(1) NULL DEFAULT 1 COMMENT '部门状态',
  `delete_state` tinyint(1) NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`department_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '人事部门', '负责公司人力资源工作的规划、建立、考勤、劳动纪律等人事程序或规章制度；做好各岗位的职位说明书，并根据公司职位调整组要进行相应的变更；建立并及时更新员工档案；', '2021-06-07 20:06:34', 1, 0);
INSERT INTO `department` VALUES (2, '营销部门', '完成公司制定的营销指标、营销策略、计划的拟订、实施和改进；负责市场调研、市场分析工作，制定业务推进计划；向顾客介绍产品，与顾客洽谈合同和签订合同，确保所签合同规范、有效和可行；', '2021-06-06 19:29:25', 1, 0);
INSERT INTO `department` VALUES (3, '课程部门', '完成公司制定的课程计划，保证课程质量，并及时更新课程信息', '2021-06-06 19:33:21', 1, 0);
INSERT INTO `department` VALUES (4, '审核部门', '负责公司内的课程、资料、文章等审核信息，确保质量问题', '2021-06-06 19:34:14', 1, 0);

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `manager_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `manager_account` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员账户',
  `manager_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员姓名',
  `pass_word` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员密码',
  `manager_gender` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `manager_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `id_card` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `department_id` int(10) NOT NULL COMMENT '部门ID',
  `department_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门名称',
  `register_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `locked_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '锁定状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  `avatar_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像URL',
  PRIMARY KEY (`manager_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (1, '2827724252@qq.com', 'admin', '$2a$10$/chbYdHe2ri8dmFpFJkeR.tEfDhorgiFO/SLXH1gr0r5BJAoj9af2', '女', '15617520389', '131121200001121415', 1, '人事部门', '2021-06-07 20:20:56', '2021-06-06 19:18:34', 0, 0, '/upload/avatar/1623041224595admin.jpg');
INSERT INTO `manager` VALUES (2, '1325554003@qq.com', '马英发', '$2a$10$MYqhhe6pilRZHrDTcTH7ruhgImXS7f62J7S9AgiEbQbluo5951lFS', '男', '18103283685', '131121200005521413', 1, '人事部门', '2021-06-07 12:54:11', '2021-06-06 19:37:43', 0, 0, '/upload/avatar/1623041649638Cache_50417400136e014.jpg');
INSERT INTO `manager` VALUES (3, '2478448784@qq.com', '郑瑞超', '$2a$10$BZ0qvYZtEnMPBhoQbSmCzesizNxNVLUcw..RuOmxgkmetMdGc94UG', NULL, NULL, NULL, 3, '课程部门', '2021-06-07 20:07:08', '2021-06-06 19:38:55', 0, 0, NULL);

-- ----------------------------
-- Table structure for manager_role
-- ----------------------------
DROP TABLE IF EXISTS `manager_role`;
CREATE TABLE `manager_role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `manager_id` int(10) NOT NULL COMMENT '管理员ID',
  `role_id` int(10) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员-角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager_role
-- ----------------------------
INSERT INTO `manager_role` VALUES (1, 1, 1);
INSERT INTO `manager_role` VALUES (2, 2, 5);
INSERT INTO `manager_role` VALUES (3, 2, 15);
INSERT INTO `manager_role` VALUES (4, 2, 17);
INSERT INTO `manager_role` VALUES (5, 3, 8);
INSERT INTO `manager_role` VALUES (6, 3, 10);
INSERT INTO `manager_role` VALUES (7, 3, 11);
INSERT INTO `manager_role` VALUES (8, 3, 12);
INSERT INTO `manager_role` VALUES (9, 3, 13);
INSERT INTO `manager_role` VALUES (10, 3, 14);

-- ----------------------------
-- Table structure for my_message
-- ----------------------------
DROP TABLE IF EXISTS `my_message`;
CREATE TABLE `my_message`  (
  `message_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `publish_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发布时间',
  `read_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已读',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '超链接',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '个人消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of my_message
-- ----------------------------
INSERT INTO `my_message` VALUES (1, 1, '新用户注册通知', '尊敬的用户：【马英发】您好，欢迎您加入花卷教育平台！赠送您50花卷币，快去个人中心完善信息吧！', '2021-06-06 19:44:15', 1, '#/accountCenter', 0);
INSERT INTO `my_message` VALUES (2, 1, '开通终身会员成功', '恭喜您，终身会员开通成功！赠送您100000花卷币，可到订单中心查看详情！', '2021-06-07 18:41:06', 1, '#/orderCenter', 0);
INSERT INTO `my_message` VALUES (3, 2, '新用户注册通知', '尊敬的用户：【郑瑞超】您好，欢迎您加入花卷教育平台！赠送您50花卷币，快去个人中心完善信息吧！', '2021-06-07 19:16:46', 0, '#/accountCenter', 0);
INSERT INTO `my_message` VALUES (4, 2, '开通月会员成功', '恭喜您，月会员开通成功！赠送您600花卷币，可到订单中心查看详情！', '2021-06-07 19:17:52', 0, '#/orderCenter', 0);
INSERT INTO `my_message` VALUES (5, 1, '扣除花卷币', '您兑换学习资源 <strong>《阿里巴巴Java开发手册泰山版》</strong> ，扣除2000花卷币', '2021-06-08 20:53:07', 1, '#/breadRollGold', 0);
INSERT INTO `my_message` VALUES (6, 1, '扣除花卷币', '您兑换学习资源 <strong>《钉钉扫码登录》</strong> ，扣除800花卷币', '2021-06-08 20:54:49', 1, '#/breadRollGold', 0);
INSERT INTO `my_message` VALUES (7, 1, '扣除花卷币', '您兑换学习资源 <strong>《钉钉扫码登录》</strong> ，扣除800花卷币', '2021-06-08 20:56:12', 1, '#/breadRollGold', 0);
INSERT INTO `my_message` VALUES (8, 1, '扣除花卷币', '您兑换学习资源 <strong>《钉钉扫码登录》</strong> ，扣除800花卷币', '2021-06-08 20:58:28', 1, '#/breadRollGold', 0);
INSERT INTO `my_message` VALUES (9, 1, '扣除花卷币', '您兑换学习资源 <strong>《阿里巴巴Java开发手册泰山版》</strong> ，扣除2000花卷币', '2021-06-09 14:56:45', 0, '#/breadRollGold', 0);
INSERT INTO `my_message` VALUES (10, 1, '特训班报名成功', '恭喜您，<strong>《MySQL高级》</strong>报名成功！', '2021-08-11 19:38:45', 0, '#/orderCenter', 0);
INSERT INTO `my_message` VALUES (11, 1, '特训班报名成功', '恭喜您，<strong>《springboot》</strong>报名成功！', '2021-08-11 19:45:53', 0, '#/orderCenter', 0);
INSERT INTO `my_message` VALUES (12, 1, '特训班报名成功', '恭喜您，<strong>《springboot》</strong>报名成功！', '2021-08-11 19:45:54', 0, '#/orderCenter', 0);
INSERT INTO `my_message` VALUES (13, 1, '特训班报名成功', '恭喜您，<strong>《MySQL高级》</strong>报名成功！', '2021-08-11 19:49:27', 0, '#/orderCenter', 0);
INSERT INTO `my_message` VALUES (14, 1, '特训班报名成功', '恭喜您，<strong>《springboot》</strong>报名成功！', '2021-08-11 19:56:26', 0, '#/orderCenter', 0);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `order_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单编号',
  `order_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单名称',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `course_id` int(11) NULL DEFAULT NULL COMMENT '特训班ID',
  `pay_price` int(10) NOT NULL COMMENT '支付金额',
  `order_state` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单状态',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, '2ce105b4-3db8-46a4-8005-31c3833fae63', '开通终身会员', 1, '2021-06-07 18:41:06', NULL, 9999, '已支付');
INSERT INTO `order` VALUES (2, '531bc8be-07fb-47bf-a10f-6dfd56379c34', '开通月会员', 2, '2021-06-07 19:17:52', NULL, 60, '已支付');
INSERT INTO `order` VALUES (3, 'ccea520f-6bdb-49bd-a7d6-7eb81f94b621', '报名MySQL高级', 1, '2021-08-11 19:38:45', 19, 688, '已支付');
INSERT INTO `order` VALUES (4, '35065c75-0781-4e40-863a-c3e6bdb35693', '报名springboot', 1, '2021-08-11 19:45:53', 20, 188, '已支付');
INSERT INTO `order` VALUES (5, '35065c75-0781-4e40-863a-c3e6bdb35693', '报名springboot', 1, '2021-08-11 19:45:54', 20, 188, '已支付');
INSERT INTO `order` VALUES (6, '7ed76fc6-cc38-4164-82fb-9ae94d059d15', '报名MySQL高级', 1, '2021-08-11 19:49:27', 19, 688, '已支付');
INSERT INTO `order` VALUES (7, 'ff9b6baa-df98-478b-8d88-edbe6df84b70', '报名springboot', 1, '2021-08-11 19:56:26', 20, 188, '已支付');

-- ----------------------------
-- Table structure for resource_audit
-- ----------------------------
DROP TABLE IF EXISTS `resource_audit`;
CREATE TABLE `resource_audit`  (
  `audit_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '审核ID',
  `resource_id` int(10) NOT NULL COMMENT '资料ID',
  `resource_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资料名',
  `reviewer_id` int(10) NULL DEFAULT NULL COMMENT '审核人ID',
  `reviewer` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `publisher_id` int(10) NOT NULL COMMENT '发布人ID',
  `publisher` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布人',
  `audit_state` int(1) NOT NULL DEFAULT 0 COMMENT '审核状态',
  `audit_time` timestamp(0) NULL DEFAULT NULL COMMENT '审核时间',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核备注',
  PRIMARY KEY (`audit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资料审核表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resource_audit
-- ----------------------------
INSERT INTO `resource_audit` VALUES (1, 1, '阿里巴巴Java开发手册泰山版', 1, 'admin', 1, 'admin', 1, '2021-06-06 21:00:45', 0, '审核通过');
INSERT INTO `resource_audit` VALUES (2, 2, 'thymeleaf文档', 1, 'admin', 1, 'admin', 1, '2021-06-06 21:00:52', 0, '审核通过');
INSERT INTO `resource_audit` VALUES (3, 3, '钉钉扫码登录', 1, 'admin', 1, 'admin', 1, '2021-06-06 21:00:48', 0, '审核通过');
INSERT INTO `resource_audit` VALUES (4, 4, '[Linux]宝塔面板命令及各软件安装路径大全', 1, 'admin', 1, 'admin', 1, '2021-06-06 21:00:55', 0, '审核通过');
INSERT INTO `resource_audit` VALUES (5, 5, 'JSP实用教程 第3版', 1, 'admin', 1, 'admin', 1, '2021-06-07 12:36:41', 0, '审核通过');
INSERT INTO `resource_audit` VALUES (6, 6, '2020年计算机考研真题', 1, 'admin', 1, 'admin', 1, '2021-06-07 12:37:45', 0, '审核通过');

-- ----------------------------
-- Table structure for resource_list
-- ----------------------------
DROP TABLE IF EXISTS `resource_list`;
CREATE TABLE `resource_list`  (
  `resource_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '资料ID',
  `resource_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资料名称',
  `bread_coin` int(10) NOT NULL COMMENT '所需花卷币',
  `file_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件类型',
  `file_size` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件大小',
  `uploader` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '上传人',
  `file_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件url',
  `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注',
  `publish_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发布状态',
  `audit_state` int(1) NOT NULL DEFAULT -1 COMMENT '审核状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '学习资料表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resource_list
-- ----------------------------
INSERT INTO `resource_list` VALUES (1, '阿里巴巴Java开发手册泰山版', 2000, '.pdf', '1480.53KB', 'admin', 'material/1622983935096阿里巴巴Java开发手册泰山版.pdf', '阿里巴巴Java开发手册泰山版', 1, 1, 0);
INSERT INTO `resource_list` VALUES (2, 'thymeleaf文档', 1200, '.pdf', '656.4KB', 'admin', 'material/1622983992111thymeleaf文档.pdf', 'thymeleaf官方文档', 1, 1, 0);
INSERT INTO `resource_list` VALUES (3, '钉钉扫码登录', 800, '.pdf', '215.33KB', 'admin', 'material/1622984014294钉钉扫码登录.pdf', '整合钉钉三方登录', 1, 1, 0);
INSERT INTO `resource_list` VALUES (4, '[Linux]宝塔面板命令及各软件安装路径大全', 1500, '.pdf', '195.97KB', 'admin', 'material/1622984049769[Linux]宝塔面板命令及各软件安装路径大全.pdf', '[Linux]宝塔面板命令及各软件安装路径大全', 1, 1, 0);
INSERT INTO `resource_list` VALUES (5, 'JSP实用教程 第3版', 2000, '.pdf', '69263.63KB', 'admin', 'material/1623040134387JSP实用教程 第3版.pdf', '本书是一本实用教程，配备了大量的例题，叙述详细，通俗易懂', 1, 1, 0);
INSERT INTO `resource_list` VALUES (6, '2020年计算机考研真题', 2500, '.pdf', '745.55KB', 'admin', 'material/16230405692242020年计算机考研真题.pdf', '2020年计算机考研真题', 1, 1, 0);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  `role_url` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限路径',
  `role_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限类别',
  `add_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  `role_describe` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `role_state` tinyint(1) NOT NULL DEFAULT 1 COMMENT '角色状态',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'admin', '/**/**', '超级权限', '2021-06-07 20:06:48', '超级管理员权限', 1);
INSERT INTO `role` VALUES (5, 'manager', '/manager/**', '人事管理', '2021-06-07 20:08:27', '员工管理权限', 1);
INSERT INTO `role` VALUES (8, 'course', '/course/**', '课程管理', '2021-05-31 10:03:27', '课程管理权限', 1);
INSERT INTO `role` VALUES (9, 'data', '/data/**', '营销管理', '2021-05-31 10:04:07', '数据分析权限', 1);
INSERT INTO `role` VALUES (10, 'directory', '/directory/**', '课程管理', '2021-05-31 10:03:32', '课程目录权限', 1);
INSERT INTO `role` VALUES (11, 'type', '/type/**', '课程管理', '2021-05-31 10:03:33', '课程类别权限', 1);
INSERT INTO `role` VALUES (12, 'teacher', '/teacher/**', '人事管理', '2021-06-07 20:07:57', '讲师管理权限', 1);
INSERT INTO `role` VALUES (13, 'special', '/special/**', '课程管理', '2021-05-31 10:03:37', '特训班管理权限', 1);
INSERT INTO `role` VALUES (14, 'preview', '/preview/**', '课程管理', '2021-05-31 10:03:47', '课程预告管理权限', 1);
INSERT INTO `role` VALUES (15, 'department', '/department/**', '人事管理', '2021-06-06 19:36:49', '部门管理权限', 1);
INSERT INTO `role` VALUES (16, 'role', '/role/**', '人事管理', '2021-06-06 19:36:50', '角色管理权限', 1);
INSERT INTO `role` VALUES (17, 'user', '/user/**', '人事管理', '2021-06-06 19:36:56', '用户管理权限', 1);
INSERT INTO `role` VALUES (18, 'message', '/message/**', '营销管理', '2021-05-31 10:04:04', '公告管理权限', 1);
INSERT INTO `role` VALUES (19, 'vip', '/vip/**', '营销管理', '2021-05-31 10:04:08', 'VIP管理权限', 1);
INSERT INTO `role` VALUES (20, 'banner', '/banner/**', '营销管理', '2021-05-31 10:04:12', '轮播图管理权限', 1);
INSERT INTO `role` VALUES (21, 'orderInfo', '/orderInfo/**', '营销管理', '2021-05-31 10:04:17', '订单管理权限', 1);
INSERT INTO `role` VALUES (22, 'courseAudit', '/courseAudit/**', '审核管理', '2021-05-31 10:04:22', '课程审核权限', 1);
INSERT INTO `role` VALUES (23, 'resourceAudit', '/resourceAudit/**', '审核管理', '2021-05-31 10:04:23', '资料审核权限', 1);
INSERT INTO `role` VALUES (24, 'articleAudit', '/articleAudit/**', '审核管理', '2021-05-31 10:04:26', '文章审核权限', 1);
INSERT INTO `role` VALUES (25, 'specialAudit', '/specialAudit/**', '审核管理', '2021-05-31 10:04:27', '特训班审核权限', 1);
INSERT INTO `role` VALUES (26, 'resource', '/resource/**', '资料管理', '2021-05-31 10:04:32', '资料管理权限', 1);
INSERT INTO `role` VALUES (27, 'article', '/article/**', '文章管理', '2021-05-31 10:04:49', '锦囊管理权限', 1);

-- ----------------------------
-- Table structure for special_audit
-- ----------------------------
DROP TABLE IF EXISTS `special_audit`;
CREATE TABLE `special_audit`  (
  `audit_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '审核ID',
  `course_id` int(10) NOT NULL COMMENT '课程ID',
  `course_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名',
  `reviewer_id` int(10) NULL DEFAULT NULL COMMENT '审核人ID',
  `reviewer` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `publisher_id` int(10) NOT NULL COMMENT '发布人ID',
  `publisher` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布人',
  `audit_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '审核状态',
  `audit_time` timestamp(0) NULL DEFAULT NULL COMMENT '审核时间',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核备注',
  PRIMARY KEY (`audit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of special_audit
-- ----------------------------
INSERT INTO `special_audit` VALUES (1, 5, 'MySQL零基础特训班', 1, 'admin', 1, 'admin', 3, '2021-06-06 21:01:19', 0, '审核通过');
INSERT INTO `special_audit` VALUES (2, 6, 'BEC商务英语一月特训班', 1, 'admin', 1, 'admin', 3, '2021-06-06 21:01:23', 0, '审核通过');
INSERT INTO `special_audit` VALUES (3, 7, '数据结构与算法进阶班', 1, 'admin', 1, 'admin', 3, '2021-06-06 21:01:31', 0, '审核通过');
INSERT INTO `special_audit` VALUES (4, 8, '经济金融一月特训班', 1, 'admin', 1, 'admin', 3, '2021-06-06 21:01:38', 0, '审核通过');
INSERT INTO `special_audit` VALUES (5, 14, '商业数据分析特训班', 1, 'admin', 1, 'admin', 3, '2021-06-07 12:14:40', 0, '审核通过');
INSERT INTO `special_audit` VALUES (6, 13, '程序员成长攻略零基础特训班', 1, 'admin', 1, 'admin', 3, '2021-06-07 12:14:47', 0, '审核通过');
INSERT INTO `special_audit` VALUES (7, 17, 'AJAX+jQuery实战提高特训班', 1, 'admin', 1, 'admin', 3, '2021-06-07 12:25:07', 0, '审核通过');
INSERT INTO `special_audit` VALUES (8, 18, 'Java零基础特训班', 1, 'admin', 1, 'admin', 3, '2021-06-07 12:25:15', 0, '审核通过');
INSERT INTO `special_audit` VALUES (9, 16, '机械设计制造及自动化一月特训班', 1, 'admin', 1, 'admin', 3, '2021-06-07 12:25:21', 0, '审核通过');
INSERT INTO `special_audit` VALUES (10, 15, '云计算与大数据零基础特训班', 1, 'admin', 1, 'admin', 3, '2021-06-07 12:25:26', 0, '审核通过');
INSERT INTO `special_audit` VALUES (11, 6, 'BEC商务英语一月特训班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:33:20', 0, '审核通过');
INSERT INTO `special_audit` VALUES (12, 7, '数据结构与算法进阶班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:33:26', 0, '审核通过');
INSERT INTO `special_audit` VALUES (13, 8, '经济金融一月特训班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:33:31', 0, '审核通过');
INSERT INTO `special_audit` VALUES (14, 5, 'MySQL零基础特训班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:33:38', 0, '审核通过');
INSERT INTO `special_audit` VALUES (15, 14, '商业数据分析特训班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:33:43', 0, '审核通过');
INSERT INTO `special_audit` VALUES (16, 17, 'AJAX+jQuery实战提高特训班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:34:18', 0, '审核通过');
INSERT INTO `special_audit` VALUES (17, 18, 'Java零基础特训班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:34:05', 0, '审核通过');
INSERT INTO `special_audit` VALUES (18, 13, '程序员成长攻略零基础特训班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:33:59', 0, '审核通过');
INSERT INTO `special_audit` VALUES (19, 16, '机械设计制造及自动化一月特训班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:33:54', 0, '审核通过');
INSERT INTO `special_audit` VALUES (20, 15, '云计算与大数据零基础特训班', 1, 'admin', 1, 'admin', 1, '2021-06-09 13:33:49', 0, '审核通过');
INSERT INTO `special_audit` VALUES (21, 19, 'MySQL高级', 1, 'admin', 1, 'admin', 1, '2021-08-11 19:37:41', 0, '666');
INSERT INTO `special_audit` VALUES (22, 20, 'springboot', 1, 'admin', 1, 'admin', 1, '2021-08-11 19:45:04', 0, '6');

-- ----------------------------
-- Table structure for study_record
-- ----------------------------
DROP TABLE IF EXISTS `study_record`;
CREATE TABLE `study_record`  (
  `record_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '学习记录ID',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `course_id` int(10) NOT NULL COMMENT '课程ID',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `record_id`(`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '学习记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of study_record
-- ----------------------------
INSERT INTO `study_record` VALUES (1, 1, 1, '2021-08-11 19:53:37', 0);
INSERT INTO `study_record` VALUES (2, 1, 3, '2021-08-11 19:54:27', 0);
INSERT INTO `study_record` VALUES (3, 1, 9, '2021-06-09 14:57:27', 0);
INSERT INTO `study_record` VALUES (4, 1, 11, '2021-06-07 18:36:33', 0);
INSERT INTO `study_record` VALUES (5, 1, 10, '2021-06-07 18:37:40', 0);
INSERT INTO `study_record` VALUES (6, 1, 4, '2021-06-07 18:38:39', 0);
INSERT INTO `study_record` VALUES (7, 1, 12, '2021-06-07 18:38:30', 0);
INSERT INTO `study_record` VALUES (8, 2, 1, '2021-06-07 19:18:31', 0);

-- ----------------------------
-- Table structure for system_message
-- ----------------------------
DROP TABLE IF EXISTS `system_message`;
CREATE TABLE `system_message`  (
  `message_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `publisher_id` int(10) NOT NULL COMMENT '发布人ID',
  `publisher` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布人',
  `publish_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发布时间',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '超链接',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_message
-- ----------------------------
INSERT INTO `system_message` VALUES (1, '净网2021 · 严打不良信息传播行为  ', '【花卷教育】在此特别提示，请您务必严格遵守国家法律法规及【“花卷教育”平台许可及服务协议】，如果您有任何违背相关法律规定及协议约定行为，包括但不限于上传、传播或存储等宣扬暴力恐怖、色情等违法内容的，我公司将依据国家法律法规进行处理并保留追求您法律责任的权利。\r\n\r\n\r\n请广大用户加强自律，相互监督，与花卷教育共同营建积极健康的绿色网络环境！', 1, 'admin', '2021-06-07 14:06:13', NULL, 0);
INSERT INTO `system_message` VALUES (2, '月会员价格恢复60元通知！  ', '通知：我们将于2021.06.07日，将花卷教育月会员价格从活动价45元/月正式恢复为60元/月！\r\n\r\n近期新功能通知：\r\n1. 加入直播教学功能\r\n2. 客服功能准备开始内测\r\n3. 加入学生与讲师线上沟通功能', 1, 'admin', '2021-06-07 14:31:52', '#/memberDetails', 0);
INSERT INTO `system_message` VALUES (3, '课程观看', '《HTML5+CSS3零基础教学》开课了！  带领学员感受真实的HTML5+CSS3开发场景、经典布局等必备技能，快来看课吧！', 1, 'admin', '2021-06-07 14:39:16', '#/courseDetail?id=1', 0);
INSERT INTO `system_message` VALUES (4, '新资料来袭', '《阿里巴巴Java开发手册泰山版》始于阿里内部规约，在全球Java开发者共同努力下，已成为业界普遍遵循的开发规范。', 1, 'admin', '2021-06-07 14:46:13', '#/learnMaterials', 0);
INSERT INTO `system_message` VALUES (5, '学习锦囊', '没有高并发经验，却被问到如何设计一个秒杀场景，该怎么办？', 1, 'admin', '2021-06-07 15:28:22', '#/articleDetail?id=3', 0);
INSERT INTO `system_message` VALUES (6, '免责声明', '本网站所提供的信息，只供课程设计使用，不用于任何商业行为', 1, 'admin', '2021-06-07 20:14:23', '', 0);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `teacher_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '讲师ID',
  `teacher_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '讲师姓名',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '讲师介绍',
  `avatar_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '头像',
  `teacher_gender` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `teacher_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '讲师电话',
  `id_card` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证',
  `entry_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '入职时间',
  `leave_time` timestamp(0) NULL DEFAULT NULL COMMENT '离职时间',
  `teacher_state` tinyint(1) NOT NULL DEFAULT 1 COMMENT '讲师状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`teacher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '讲师表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (1, '王伟', '曾经在微软、阿里工作十年以上，参与友盟、芒果移动的收购过程，在离职前最后职位是芒果移动的总负责人\r\n曾经为百变空间CTO联合创始人董事、连续创业者，现在为立芳教育创始人\r\n拥有18项发明专利', '/upload/avatar/16232148181171623035583368man.png', '男', '15105284861', '151124411115562145', '2021-06-07 20:09:19', NULL, 1, 0);
INSERT INTO `teacher` VALUES (2, '吴海洋', '米修科技创始人、教学总监\r\n曾任用友软件、优步中国前端主程\r\n6年互联网行业开发经验、4年教学经验', '/upload/avatar/1623214837930wwsc.png', '男', '13733055962', '151131199901121451', '2021-06-06 20:01:24', NULL, 1, 0);
INSERT INTO `teacher` VALUES (3, '唐榕', '本科就读于南开大学英文系，研究生毕业于谢菲尔德大学\r\n对西方语言文化有多年的接触与研究，多年从事线上、线下课堂教学，经验丰富，课堂氛围活泼，讲课通俗易懂，深受学生欢迎', '/upload/avatar/1623214934581women.png', '女', '13732515962', '131121188542231411', '2021-06-06 20:04:35', NULL, 1, 0);
INSERT INTO `teacher` VALUES (4, '陈罗丹', '本科获得四川外国语大学西班牙语文学学士学位，研究生阶段在西班牙胡安卡洛斯大学，获得传媒硕士学位，目前博士在读。\r\n曾就职于中国国际广播电台。', '/upload/avatar/1623214950058wmm.png', '男', '15352152162', '151131199915421417', '2021-06-06 20:04:19', NULL, 1, 0);
INSERT INTO `teacher` VALUES (5, '凌祯', '畅销Office课程资深培训讲师\r\n网易云课堂授权讲师\r\n美国PMI认证PMP（项目管理经理）\r\n《数据呈现之美：Excel商务图表实战大全》作者', '/upload/avatar/1623214978667wm.png', '女', '13735596962', '181121199702231415', '2021-06-06 20:06:35', NULL, 1, 0);
INSERT INTO `teacher` VALUES (6, '李轩逸', '澳大利亚时尚杂志LabA4 Magazine签约修图师\r\n《人像摄影》《今日人像》修图栏目专业撰稿人\r\n修图作品曾获美国拉斯维加斯WPPI年度摄影大赛银奖\r\n作品多次发表于：《VOGUE》《时尚芭莎》《新视线》《昕薇》《风尚志》等多家时尚媒体', '/upload/avatar/16232149891541623035583368man.png', '男', '15433088441', '121151199521151241', '2021-06-07 11:13:35', NULL, 1, 0);
INSERT INTO `teacher` VALUES (7, '高正', '通俗易懂的平民Python传播者\r\n毕业于英国布莱顿大学\r\n人工智能财务解决方案专家，精通Python、Django框架、Keras神经网络框架、爬虫、RPA', '/upload/avatar/1623215027065wwsc.png', '男', '18103588224', '151121411101151214', '2021-06-07 11:30:17', NULL, 1, 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_account` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `pass_word` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `user_gender` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `user_birthday` date NULL DEFAULT NULL COMMENT '生日',
  `id_card` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `user_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `learn_target` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学习目标',
  `register_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '注册时间',
  `login_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '登录时间',
  `avatar_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `background_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '背景图片',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'TA很懒，什么都没有留下....' COMMENT '个人描述',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `locked_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '锁定状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '2827724252@qq.com', '汪尼玛', '4ea08303bb40afe4e8baa11fcd4fd674', '男', '1998-02-23', '131121199802231415', '15617520389', '计算机专业基础', '2021-06-06 19:44:15', '2021-08-11 19:54:23', '/upload/avatar/1623058843834Cache_50417400136e014.jpg', NULL, '念念不忘，必有回响', '2021-06-06 19:44:15', 0, 0);
INSERT INTO `user` VALUES (2, '2478448784@qq.com', '郑瑞超', '5a9e43b31f21519d804953b3eeaed60f', NULL, NULL, NULL, NULL, NULL, '2021-06-07 19:16:46', '2021-06-08 21:00:41', NULL, NULL, 'TA很懒，什么都没有留下....', '2021-06-07 19:16:46', 0, 0);

-- ----------------------------
-- Table structure for user_coin
-- ----------------------------
DROP TABLE IF EXISTS `user_coin`;
CREATE TABLE `user_coin`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `user_coin` int(10) NOT NULL COMMENT '用户积分',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UNIQUE`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户积分表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_coin
-- ----------------------------
INSERT INTO `user_coin` VALUES (1, 1, 93740);
INSERT INTO `user_coin` VALUES (2, 2, 685);

-- ----------------------------
-- Table structure for user_course
-- ----------------------------
DROP TABLE IF EXISTS `user_course`;
CREATE TABLE `user_course`  (
  `study_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '学习ID',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `course_id` int(10) NOT NULL COMMENT '课程ID',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`study_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户课程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_course
-- ----------------------------
INSERT INTO `user_course` VALUES (1, 1, 1, 0);

-- ----------------------------
-- Table structure for user_play
-- ----------------------------
DROP TABLE IF EXISTS `user_play`;
CREATE TABLE `user_play`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `course_id` int(10) NOT NULL COMMENT '课程id',
  `list_id` int(10) NOT NULL COMMENT '目录id',
  `play_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '播放时长',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '播放记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_play
-- ----------------------------
INSERT INTO `user_play` VALUES (1, 7, 1, 1, '3.396836');
INSERT INTO `user_play` VALUES (2, 1, 1, 2, '15.949286');
INSERT INTO `user_play` VALUES (3, 1, 9, 16, '0.715664');
INSERT INTO `user_play` VALUES (4, 1, 3, 9, '1.1964');
INSERT INTO `user_play` VALUES (5, 1, 11, 22, '12.274947');
INSERT INTO `user_play` VALUES (6, 1, 10, 19, '0.975387');

-- ----------------------------
-- Table structure for user_vip
-- ----------------------------
DROP TABLE IF EXISTS `user_vip`;
CREATE TABLE `user_vip`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `vip_id` int(10) NOT NULL COMMENT 'VIP标识',
  `open_time` datetime(0) NULL DEFAULT NULL COMMENT '开通时间',
  `expire_time` datetime(0) NULL DEFAULT NULL COMMENT '到期时间',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户 - VIP表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_vip
-- ----------------------------
INSERT INTO `user_vip` VALUES (1, 1, 4, '2021-06-07 18:41:06', '9999-12-31 08:00:00', 0);
INSERT INTO `user_vip` VALUES (2, 2, 1, '2021-06-07 19:17:52', '2021-07-07 00:00:00', 0);

-- ----------------------------
-- Table structure for vip
-- ----------------------------
DROP TABLE IF EXISTS `vip`;
CREATE TABLE `vip`  (
  `vip_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '会员id',
  `vip_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '会员名称',
  `vip_mark` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '会员标识',
  `vip_icon` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图标',
  `time_length` int(5) NOT NULL COMMENT '会员时长',
  `price` int(10) NOT NULL COMMENT '价格',
  `bread_coin` int(10) NOT NULL COMMENT '花卷币(赠送)',
  `vip_state` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'VIP状态',
  `delete_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`vip_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'VIP介绍表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vip
-- ----------------------------
INSERT INTO `vip` VALUES (1, '月会员', '海量VIP剧集随心看', '#iconhuiyuan2', 30, 60, 600, 1, 0);
INSERT INTO `vip` VALUES (2, '季会员', '海量VIP剧集随心看', '#iconhuiyuan', 91, 200, 2100, 1, 0);
INSERT INTO `vip` VALUES (3, '年会员', '海量VIP剧集随心看', '#iconhuiyuan4', 365, 700, 10000, 1, 0);
INSERT INTO `vip` VALUES (4, '终身会员', '海量VIP剧集随心看', '#iconhuiyuan1', -1, 9999, 100000, 1, 0);
INSERT INTO `vip` VALUES (6, '日会员', '开通一天的会员', '#iconhuiyuan5', 1, 20, 100, 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
