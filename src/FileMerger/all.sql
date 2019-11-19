DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
    `id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `barcode` VARCHAR(45) NOT NULL COMMENT '条码',
    `name` VARCHAR(45) NOT NULL COMMENT '商品名称',
    `short_name` VARCHAR(45) NOT NULL COMMENT '简称',
    `item_cls_id` VARCHAR(45) NOT NULL COMMENT '商品类别',
    `item_cls_name` VARCHAR(45) NOT NULL,
    `item_brand_id` VARCHAR(45) NOT NULL COMMENT '商品品牌',
    `item_brand_name` VARCHAR(45) NOT NULL,
    `item_department_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '商品部门',
    `item_department_name` VARCHAR(45) NOT NULL DEFAULT '',
    `item_unit_id` INT NOT NULL COMMENT '库存单位',
    `item_unit_name` VARCHAR(45) NOT NULL,
    `primary_supplier_id` VARCHAR(45) NOT NULL COMMENT '主供应商',
    `primary_supplier_name` VARCHAR(45) NOT NULL,
    `status` INT NOT NULL DEFAULT 0 COMMENT '状态 0-正常、9-停用',
    `is_fresh` INT NOT NULL DEFAULT 0 COMMENT '生鲜标志 0-非生鲜商品、1-生鲜商品',
    `retail_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '零售价',
    `purchase_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '进货价',
    `sales_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '批发价',
    `delivery_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '配送价',
    `refer_profit_rate` DECIMAL NOT NULL DEFAULT 0 COMMENT '参考毛利率',
    `size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
    `transport_mode` INT NOT NULL DEFAULT 0 COMMENT '物流模式 0-统配、1-直配、2-自采、3-越库',
    `quality_days` INT NULL COMMENT '保质天数',
    `warning_days` INT NULL COMMENT '临期预计天数',
    `least_delivery_qty` INT NULL COMMENT '最小配送数量',
    `production_place` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '产地',
    `purchase_tax_rate` DECIMAL NULL COMMENT '进项税',
    `sales_tax_rate` DECIMAL NULL COMMENT '销项税',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    `create_oper_id` INT NOT NULL COMMENT '创建人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '创建时间',
    `last_update_oper_id` INT NOT NULL COMMENT '最后修改人',
	`last_update_oper_name` VARCHAR(45) NOT NULL,
	`last_update_time` DATETIME NOT NULL COMMENT '最后修改时间',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品';

DROP TABLE IF EXISTS `branch_group`;

CREATE TABLE `branch_group` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `name` VARCHAR(45) NOT NULL COMMENT '名称',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '店组';

DROP TABLE IF EXISTS `item_delivery_price`;

CREATE TABLE `item_delivery_price` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
    `delivery_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '配送价',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品配送价';

DROP TABLE IF EXISTS `item_package`;

CREATE TABLE `item_package` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `barcode` VARCHAR(45) NOT NULL COMMENT '条码',
    `item_unit_id` INT NOT NULL COMMENT '库存单位',
    `item_unit_name` VARCHAR(45) NOT NULL,
    `factor_qty` INT NOT NULL COMMENT '包装系数',
    `retail_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '零售价',
    `sales_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '批发价',
    `is_default_purchase_unit` TINYINT NOT NULL DEFAULT 0 COMMENT '是否为默认采购单位',
    `is_default_delivery_unit` TINYINT NOT NULL DEFAULT 0 COMMENT '是否为默认配送单位',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品多包装';

DROP TABLE IF EXISTS `item_sub`;

CREATE TABLE `item_sub` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `barcode` VARCHAR(45) NOT NULL COMMENT '条码',
    `name` VARCHAR(45) NOT NULL COMMENT '子商品名称',
    `retail_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '零售价',
    `sales_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '批发价',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '子商品';

DROP TABLE IF EXISTS `item_department`;

CREATE TABLE `item_department` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `name` VARCHAR(45) NOT NULL COMMENT '名称',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品部门';

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
    `id` VARCHAR(45) NOT NULL COMMENT '供应商编码',
    `name` VARCHAR(45) NOT NULL COMMENT '供应商名称',
    `region_id` VARCHAR(45) NOT NULL COMMENT '所属区域id',
    `sell_way` INT NOT NULL DEFAULT 0 COMMENT '经营方式（0-购销、1-联营、2-代销、3-租赁）',
    `settle_way` INT NOT NULL DEFAULT 0 COMMENT '结算方式（0-临时指定、1-货到付款、2-指定账期、3-指定日期）',
    `settle_days` INT NULL COMMENT '结算周期天数',
    `settle_date` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '结算日期',
    `status` INT NOT NULL DEFAULT 0 COMMENT '状态（0-正常、9-停用）',
    `contacts_name` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '联系人',
    `contacts_mobile` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '移动电话',
    `contacts_tel` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '固定电话',
    `contacts_email` VARCHAR(45) NOT NULL DEFAULT '' COMMENT 'Email',
    `account_bank` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '开户行',
    `account_no` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '账号',
    `tax_registration_no` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '税务登记号',
    `business_license_no` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '营业执照号',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    `create_oper_id` INT NOT NULL COMMENT '创建人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '创建时间',
    `last_update_oper_id` INT NOT NULL COMMENT '最后修改人',
	`last_update_oper_name` VARCHAR(45) NOT NULL,
	`last_update_time` DATETIME NOT NULL COMMENT '最后修改时间',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '供应商';

DROP TABLE IF EXISTS `item_purchase_price`;

CREATE TABLE `item_purchase_price` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `barcode` VARCHAR(45) NOT NULL COMMENT '条码',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
    `supplier_id` VARCHAR(45) NOT NULL COMMENT '供应商',
    `is_primary` TINYINT NOT NULL DEFAULT 0 COMMENT '是否是主供应商',
    `item_unit_id` INT NOT NULL COMMENT '包装单位',
    `item_unit_name` VARCHAR(45) NOT NULL,
    `factor_qty` INT NOT NULL COMMENT '包装系数',
    `purchase_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '进价',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品进价';

DROP TABLE IF EXISTS `store`;

CREATE TABLE `store` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '所属机构编码',
    `name` VARCHAR(45) NOT NULL COMMENT '仓库名称',
    `is_usable` TINYINT NOT NULL DEFAULT 1 COMMENT '是否可用',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '仓库';

DROP TABLE IF EXISTS `item_unit`;

CREATE TABLE `item_unit` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `name` VARCHAR(45) NOT NULL COMMENT '名称',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品单位';

DROP TABLE IF EXISTS `branch`;

CREATE TABLE `branch` (
    `id` VARCHAR(45) NOT NULL COMMENT '机构编码',
    `parent_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '上级机构编码',
    `name` VARCHAR(45) NOT NULL COMMENT '机构名称',
    `short_name` VARCHAR(45) NOT NULL COMMENT '机构简称',
    `type` INT NOT NULL COMMENT '机构类型（0-总部、1-区域中心、2-配送中心、3-自营店、4-加盟店）',
    `contacts_name` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '联系人',
    `contacts_mobile` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '移动电话',
    `contacts_tel` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '固定电话',
    `contacts_email` VARCHAR(45) NOT NULL DEFAULT '' COMMENT 'Email',
    `address` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '地址',
    `gift_store_id` INT NULL COMMENT '默认赠送仓库',
    `return_store_id` INT NULL COMMENT '默认退货仓库',
    `purchase_store_id` INT NULL COMMENT '默认进货仓库',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    `create_oper_id` INT NOT NULL COMMENT '创建人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '创建时间',
    `last_update_oper_id` INT NOT NULL COMMENT '最后修改人',
	`last_update_oper_name` VARCHAR(45) NOT NULL,
	`last_update_time` DATETIME NOT NULL COMMENT '最后修改时间',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '机构';

DROP TABLE IF EXISTS `supplier_region`;

CREATE TABLE `supplier_region` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `name` VARCHAR(45) NOT NULL COMMENT '名称',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '供应商区域';

DROP TABLE IF EXISTS `item_cls`;

CREATE TABLE `item_cls` (
    `id` VARCHAR(45) NOT NULL COMMENT '编码',
    `parent_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '上级类别编码',
    `name` VARCHAR(45) NOT NULL COMMENT '名称',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品类别';

DROP TABLE IF EXISTS `branch_group_branch`;

CREATE TABLE `branch_group_branch` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `branch_group_id` INT NOT NULL COMMENT '机构组id',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '机构编码',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '机构组机构关系';

DROP TABLE IF EXISTS `item_sub_price`;

CREATE TABLE `item_sub_price` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `barcode` VARCHAR(45) NOT NULL COMMENT '条码',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
    `retail_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '零售价',
    `sales_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '批发价',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '子商品售价';

DROP TABLE IF EXISTS `item_barcode`;

CREATE TABLE `item_barcode` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `barcode` VARCHAR(45) NOT NULL COMMENT '条码',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品多条码';

DROP TABLE IF EXISTS `item_selling_price`;

CREATE TABLE `item_selling_price` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `barcode` VARCHAR(45) NOT NULL COMMENT '条码',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
    `item_unit_id` INT NOT NULL COMMENT '包装单位',
    `item_unit_name` VARCHAR(45) NOT NULL,
    `factor_qty` INT NOT NULL COMMENT '包装系数',
    `retail_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '零售价',
    `sales_price` DECIMAL NOT NULL DEFAULT 0 COMMENT '批发价',
    `memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品售价';

DROP TABLE IF EXISTS `item_brand`;

CREATE TABLE `item_brand` (
    `id` VARCHAR(45) NOT NULL COMMENT '编码',
    `name` VARCHAR(45) NOT NULL COMMENT '名称',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品品牌';

