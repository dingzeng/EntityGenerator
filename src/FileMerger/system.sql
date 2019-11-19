DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '自增长编码',
  `name` VARCHAR(45) NOT NULL COMMENT '名称',
  `memo` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO `role`(`name`,memo) VALUES('部门主管','部门主管');
INSERT INTO `role`(`name`,memo) VALUES('录单员','录单员');
INSERT INTO `role`(`name`,memo) VALUES('系统管理员','系统管理员');

DROP TABLE IF EXISTS `permission_api`;

CREATE TABLE `permission_api` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `permission_code` VARCHAR(45) NOT NULL COMMENT '所属权限',
  `url` VARCHAR(45) NOT NULL COMMENT 'URL',
  `method` VARCHAR(45) NOT NULL COMMENT 'HTTP请求方式：GET、POST、PUT、DELETE',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '权限对应接口';

-- Role
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('ROLE_VIEW','/system/roles','GET');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('ROLE_VIEW','/system/role/?','GET');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('ROLE_VIEW','/system/role/?/permissions','GET');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('ROLE_CREATE','/system/role','POST');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('ROLE_UPDATE','/system/role','PUT');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('ROLE_UPDATE','system/role/?/permissions','PUT');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('ROLE_DELETE','/system/role','DELETE');

-- User
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('USER_VIEW','/system/users','GET');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('USER_VIEW','/system/user/?','GET');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('USER_CREATE','/system/user','POST');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('USER_UPDATE','/system/user/info','PUT');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('USER_UPDATE','/system/user/permission','PUT');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('USER_UPDATE','/system/user/roles','PUT');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('USER_UPDATE','/system/user/password','PUT');
INSERT INTO `permission_api`(permission_code,`url`,method) VALUES('USER_DELETE','/system/user/?','DELETE');


DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
  `branch_code` VARCHAR(8) NOT NULL COMMENT '所属机构编码',
  `username` VARCHAR(45) NOT NULL COMMENT '用户名',
  `password` VARCHAR(45) NOT NULL COMMENT '登录密码',
  `name` VARCHAR(45) NOT NULL COMMENT '姓名',
  `mobile` VARCHAR(45) NOT NULL COMMENT '手机号',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态 0-禁用、1-启用',
  `item_department_permission_flag` TINYINT NOT NULL DEFAULT 0 COMMENT '商品部门权限标记 0-授权全部、1-指定授权',
  `supplier_permission_flag` TINYINT NOT NULL DEFAULT 0 COMMENT '供应商权限标记 0-授权全部、1-指定授权',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO `user`(branch_code,username,`password`,`name`,mobile,`status`,item_department_permission_flag,supplier_permission_flag) 
values('00','admin','123456','管理员','15812345678',1,0,0);
DROP TABLE IF EXISTS `role_permission`;

CREATE TABLE `role_permission` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `permission_code` VARCHAR(45)  NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO `role_permission`(role_id,permission_code) VALUES(3,'ROLE_VIEW');
INSERT INTO `role_permission`(role_id,permission_code) VALUES(3,'ROLE_CREATE');
INSERT INTO `role_permission`(role_id,permission_code) VALUES(3,'ROLE_UPDATE');
INSERT INTO `role_permission`(role_id,permission_code) VALUES(3,'ROLE_DELETE');
INSERT INTO `role_permission`(role_id,permission_code) VALUES(3,'USER_VIEW');
INSERT INTO `role_permission`(role_id,permission_code) VALUES(3,'USER_CREATE');
INSERT INTO `role_permission`(role_id,permission_code) VALUES(3,'USER_UPDATE');
INSERT INTO `role_permission`(role_id,permission_code) VALUES(3,'USER_DELETE');
DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `code` VARCHAR(45) NOT NULL COMMENT '编码',
  `parent_code` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '父级编码',
  `path` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '菜单路径',
  `name` VARCHAR(45) NOT NULL COMMENT '菜单名称',
  `is_leaf` TINYINT NOT NULL COMMENT '是否是叶子节点',
  PRIMARY KEY (`code`))
ENGINE = InnoDB;

INSERT INTO `menu`(code,`name`,is_leaf) VALUES('01','基础档案', 0);
INSERT INTO `menu`(code,`name`,is_leaf) VALUES('02','采购业务', 0);
INSERT INTO `menu`(code,`name`,is_leaf) VALUES('03','零售业务', 0);
INSERT INTO `menu`(code,`name`,is_leaf) VALUES('04','批发业务', 0);
INSERT INTO `menu`(code,`name`,is_leaf) VALUES('08','财务管理', 0);

-- 系统管理
INSERT INTO `menu`(code,`name`,is_leaf) VALUES('09','系统管理', 0);
INSERT INTO `menu`(code,parent_code,`name`,is_leaf) VALUES('0901','09','用户管理', 0);
INSERT INTO `menu`(code,parent_code,`path`,`name`,is_leaf) VALUES('090101','0901','/system/role','角色管理', 1);
INSERT INTO `menu`(code,parent_code,`path`,`name`,is_leaf) VALUES('090102','0901','/system/user','用户管理', 1);

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
  `code` VARCHAR(45) NOT NULL,
  `menu_code` VARCHAR(45) NOT NULL COMMENT '所属菜单',
  `type` TINYINT NOT NULL COMMENT '权限类型 0-查看、1-新增、2-修改、3-删除、4-审核、9-其它',
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB
COMMENT = '操作权限';

-- Role
INSERT INTO `permission`(`code`,menu_code,`type`,`name`) VALUES('ROLE_VIEW','090101',0,'查看角色');
INSERT INTO `permission`(`code`,menu_code,`type`,`name`) VALUES('ROLE_CREATE','090101',1,'新增角色');
INSERT INTO `permission`(`code`,menu_code,`type`,`name`) VALUES('ROLE_UPDATE','090101',2,'修改角色');
INSERT INTO `permission`(`code`,menu_code,`type`,`name`) VALUES('ROLE_DELETE','090101',3,'删除角色');

-- User
INSERT INTO `permission`(`code`,menu_code,`type`,`name`) VALUES('USER_VIEW','090102',0,'查看用户');
INSERT INTO `permission`(`code`,menu_code,`type`,`name`) VALUES('USER_CREATE','090102',1,'新增用户');
INSERT INTO `permission`(`code`,menu_code,`type`,`name`) VALUES('USER_UPDATE','090102',2,'修改用户');
INSERT INTO `permission`(`code`,menu_code,`type`,`name`) VALUES('USER_DELETE','090102',3,'删除用户');

DROP TABLE IF EXISTS `sheet_log`;

CREATE TABLE `sheet_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '子增长编码',
    `sheet_type` CHAR(2) NOT NULL COMMENT '单据类型',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据编号',
    `action` VARCHAR(45) NOT NULL COMMENT '操作 create、commit、approve、reject、cancel',
    `oper_name` VARCHAR(45) NOT NULL COMMENT '操作人',
    `create_time` DATETIME NOT NULL COMMENT '操作时间',
    PRIMARY KEY (`id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

INSERT INTO user_role(user_id,role_id) VALUES(1,3);
