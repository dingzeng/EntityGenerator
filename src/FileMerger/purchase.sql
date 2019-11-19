DROP TABLE IF EXISTS `purchase_order_detail_branch`;

CREATE TABLE `purchase_order_detail_branch` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
	`detail_id` VARCHAR(45) NOT NULL COMMENT '明细id',
	`branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
	`refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
	`qty` DECIMAL NOT NULL COMMENT '数量',
	`memo` VARCHAR(45) NOT NULL COMMENT '备注',
	PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '采购订单分配明细';
DROP TABLE IF EXISTS `purchase_receive_detail_branch`;

CREATE TABLE `purchase_receive_detail_branch` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
	`detail_id` VARCHAR(45) NOT NULL COMMENT '明细id',
	`branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
	`refer_unreceived_qty` DECIMAL NOT NULL COMMENT '剩余配送数量',
	`qty` DECIMAL NOT NULL COMMENT '数量',
	`memo` VARCHAR(45) NOT NULL COMMENT '备注',
	PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '采购收货单分配明细';

DROP TABLE IF EXISTS `purchase_receive_detail`;

CREATE TABLE `purchase_receive_detail` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
	`item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
	`item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
	`item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
	`size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
	`purchase_unit` VARCHAR(45) NOT NULL COMMENT '采购单位',
	`qty` DECIMAL NOT NULL COMMENT '数量',
	`price` DECIMAL NOT NULL COMMENT '单价',
	`amount` DECIMAL NOT NULL COMMENT '金额',
	`tax_rate` DECIMAL NOT NULL COMMENT '税率',
	`tax_amount` DECIMAL NOT NULL COMMENT '税额',
	`refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
	`stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`produce_date` DATE NULL COMMENT '生产日期',
	`expire_date` DATE NULL COMMENT '过期日期',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
	PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '采购收货单商品明细';
DROP TABLE IF EXISTS `purchase_order_detail`;

CREATE TABLE `purchase_order_detail` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
	`item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
	`item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
	`item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
	`gift_flag` TINYINT NOT NULL DEFAULT 0 COMMENT '赠品标志',
	`size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
	`purchase_unit` VARCHAR(45) NOT NULL COMMENT '采购单位',
	`refer_purchase_price` DECIMAL NOT NULL COMMENT '参考进价',
	`qty` DECIMAL NOT NULL COMMENT '数量',
	`purchase_price` DECIMAL NOT NULL COMMENT '进价',
	`amount` DECIMAL NOT NULL COMMENT '金额',
	`tax_rate` DECIMAL NOT NULL COMMENT '税率',
	`tax_amount` DECIMAL NOT NULL COMMENT '税额',
	`refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
	`stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`retail_price` DECIMAL NOT NULL COMMENT '零售价',
	`received_qty` DECIMAL NOT NULL COMMENT '到货数量',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
	PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '采购订单商品明细';

DROP TABLE IF EXISTS `purchase_receive`;

CREATE TABLE `purchase_receive` (
	`sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
	`ref_sheet_id` VARCHAR(45) NOT NULL COMMENT '引用采购订单单据号',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`settle_status` INT NOT NULL DEFAULT 0 COMMENT '结算状态（0-未结算、1-已结算）',
	`supplier_id` VARCHAR(45) NOT NULL COMMENT '供应商',
	`receive_branch` VARCHAR(45) NOT NULL COMMENT '收货机构',
	`receive_store_id` VARCHAR(45) NOT NULL COMMENT '收货仓库',
	`total_amount` DECIMAL NOT NULL COMMENT '订货金额',
	`purchase_oper` VARCHAR(45) NOT NULL COMMENT '采购员',
	`receive_time` DATETIME NOT NULL COMMENT '收货时间',
	`create_oper` VARCHAR(45) NOT NULL COMMENT '制单人',
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper` VARCHAR(45) NOT NULL COMMENT '审核人',
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
  	PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '采购收货单';

DROP TABLE IF EXISTS `purchase_return_detail`;

CREATE TABLE `purchase_return_detail` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
	`item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
	`item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
	`item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
	`size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
	`purchase_unit` VARCHAR(45) NOT NULL COMMENT '采购单位',
	`qty` DECIMAL NOT NULL COMMENT '数量',
	`price` DECIMAL NOT NULL COMMENT '单价',
	`amount` DECIMAL NOT NULL COMMENT '金额',
	`tax_rate` DECIMAL NOT NULL COMMENT '税率',
	`tax_amount` DECIMAL NOT NULL COMMENT '税额',
	`refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
	`stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
	PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '采购退货商品明细';
DROP TABLE IF EXISTS `purchase_order`;

CREATE TABLE `purchase_order` (
	`sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
	`type` INT NOT NULL COMMENT '单据类型（0-采购订单、1-直配订单、2-越库订单、3-永续订单）',
	`receive_status` INT NOT NULL DEFAULT 0 COMMENT '收货状态（0-未收货、1-部分收货、2-已收货）',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`supplier_id` VARCHAR(45) NOT NULL COMMENT '供应商',
	`order_branch_id` VARCHAR(45) NOT NULL COMMENT '订货机构',
	`receive_expire_date` DATE NOT NULL COMMENT '收货期限',
	`total_amount` DECIMAL NOT NULL COMMENT '订货金额',
	`purchase_oper` VARCHAR(45) NOT NULL COMMENT '采购员',
	`create_oper` VARCHAR(45) NOT NULL COMMENT '制单人',
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper` VARCHAR(45) NOT NULL COMMENT '审核人',
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
  	PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '采购订单';

DROP TABLE IF EXISTS `purchase_return`;

CREATE TABLE `purchase_return` (
	`sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
	`ref_sheet_id` VARCHAR(45) NOT NULL COMMENT '引用采购收货单单据号',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`supplier_id` VARCHAR(45) NOT NULL COMMENT '供应商',
	`branch_id` VARCHAR(45) NOT NULL COMMENT '退货机构',
	`store_id` VARCHAR(45) NOT NULL COMMENT '出库仓库',
	`total_amount` DECIMAL NOT NULL COMMENT '订货金额',
	`create_oper` VARCHAR(45) NOT NULL COMMENT '制单人',
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper` VARCHAR(45) NOT NULL COMMENT '审核人',
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
  	PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '采购退货单';

DROP TABLE IF EXISTS `purchase_order_branch`;

CREATE TABLE `purchase_order_branch` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
	`branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
	PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '采购订单收货机构';
