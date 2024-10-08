CREATE DATABASE `bitstorm-svr-go` ;

USE `bitstorm-svr-go`;

DROP TABLE IF EXISTS `xtimer`;

CREATE TABLE `xtimer` (
                           `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'TimerId',
                           `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                           `app` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'app',
                           `name` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'name',
                           `status` tinyint NOT NULL DEFAULT '0' COMMENT '0新建，1激活，2未激活',
                           `cron` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'cron表达式',
                           `notify_http_param` varchar(8192)  COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '回调上下文',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Timer 信息';

DROP TABLE IF EXISTS `timer_task`;

CREATE TABLE `timer_task` (
                         `task_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'taskId',
                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                         `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                         `timer_id` bigint unsigned NOT NULL COMMENT 'TimerId',
                         `app` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'app',
                         `output` varchar(1028) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'output',
                         `status` tinyint NOT NULL DEFAULT '0' COMMENT '0新建，1激活，2未激活',
                         `run_timer` bigint COMMENT '运行时间',
                         `cost_time` bigint unsigned NOT NULL COMMENT '执行耗时',
                         PRIMARY KEY (`task_id`) USING BTREE,
                         UNIQUE KEY `idx_timer_id_run_timer` (`timer_id`,`run_timer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Timer Task任务信息';
