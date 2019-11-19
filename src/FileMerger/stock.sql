DROP TABLE IF EXISTS `delivery_diff_apply_detail`;

CREATE TABLE `delivery_diff_apply_detail` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
    `size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
    `delivery_unit` VARCHAR(45) NOT NULL COMMENT '配送单位',
	`delivery_qty` DECIMAL NOT NULL COMMENT '配送数量',
    `diff_qty` DECIMAL NOT NULL COMMENT '差异数量',
    `price` DECIMAL NOT NULL COMMENT '单价',
    `amount` DECIMAL NOT NULL COMMENT '金额',
    `tax_rate` DECIMAL NOT NULL COMMENT '税率',
    `tax_amount` DECIMAL NOT NULL COMMENT '税额',
    `refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
    `retail_price` DECIMAL NOT NULL COMMENT '零售价',
    `stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配送差异申请单商品明细';

DROP TABLE IF EXISTS `delivery_return`;

CREATE TABLE `delivery_return` (
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `ref_delivery_sheet_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '引用配送单号',
    `ref_delivery_return_apply_sheet_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '引用配退申请单号',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '配退机构',
    `delivery_branch_id` VARCHAR(45) NOT NULL COMMENT '配送中心',
    `store_id` VARCHAR(45) NOT NULL COMMENT '出库仓库',
	`total_amount` DECIMAL NOT NULL COMMENT '单据金额',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`create_oper_id` INT NOT NULL COMMENT '制单人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper_id` INT NOT NULL COMMENT '审核人',
	`approve_oper_name` VARCHAR(45) NOT NULL,
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '配退单';

DROP TABLE IF EXISTS `delivery_diff_in`;

CREATE TABLE `delivery_diff_in` (
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `ref_delivery_sheet_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '引用配送单号',
    `ref_delivery_diff_apply_sheet_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '引用配送差异申请单',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '入库机构',
    `store_id` VARCHAR(45) NOT NULL COMMENT '入库仓库',
	`total_amount` DECIMAL NOT NULL COMMENT '单据金额',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`create_oper_id` INT NOT NULL COMMENT '制单人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper_id` INT NOT NULL COMMENT '审核人',
	`approve_oper_name` VARCHAR(45) NOT NULL,
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '配送差异入库单';

DROP TABLE IF EXISTS `delivery_return_detail`;

CREATE TABLE `delivery_return_detail` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
    `size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
    `delivery_unit` VARCHAR(45) NOT NULL COMMENT '配送单位',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `price` DECIMAL NOT NULL COMMENT '单价',
    `amount` DECIMAL NOT NULL COMMENT '金额',
    `tax_rate` DECIMAL NOT NULL COMMENT '税率',
    `tax_amount` DECIMAL NOT NULL COMMENT '税额',
    `refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
    `retail_price` DECIMAL NOT NULL COMMENT '零售价',
    `stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配退单商品明细';

DROP TABLE IF EXISTS `delivery_diff_out`;

CREATE TABLE `delivery_diff_out` (
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `ref_delivery_sheet_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '引用配送单号',
    `ref_delivery_diff_apply_sheet_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '引用配送差异申请单',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '入库机构',
    `store_id` VARCHAR(45) NOT NULL COMMENT '入库仓库',
	`total_amount` DECIMAL NOT NULL COMMENT '单据金额',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`create_oper_id` INT NOT NULL COMMENT '制单人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper_id` INT NOT NULL COMMENT '审核人',
	`approve_oper_name` VARCHAR(45) NOT NULL,
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '配送差异出库单';

DROP TABLE IF EXISTS `delivery_receive_detail_batch`;

CREATE TABLE `delivery_receive_detail_batch` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `detail_id` BIGINT NOT NULL COMMENT '单据明细id',
    `batch_id` VARCHAR(45) NOT NULL COMMENT '批次号',
    `refer_batch_qty` DECIMAL NOT NULL COMMENT '剩余库存数量',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `expire_date` DATE NOT NULL COMMENT '过期日期',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配送收货单商品批次明细';

DROP TABLE IF EXISTS `delivery_return_receive`;

CREATE TABLE `delivery_return_receive` (
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `ref_delivery_return_sheet_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '引用配退单号',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '配退机构',
    `delivery_branch_id` VARCHAR(45) NOT NULL COMMENT '配送中心',
    `store_id` VARCHAR(45) NOT NULL COMMENT '入库仓库',
	`total_amount` DECIMAL NOT NULL COMMENT '单据金额',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`create_oper_id` INT NOT NULL COMMENT '制单人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper_id` INT NOT NULL COMMENT '审核人',
	`approve_oper_name` VARCHAR(45) NOT NULL,
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '配退收货单';

DROP TABLE IF EXISTS `delivery`;

CREATE TABLE `delivery` (
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `delivery_branch_id` VARCHAR(45) NOT NULL COMMENT '配送中心',
    `store_id` VARCHAR(45) NOT NULL COMMENT '出库仓库',
    `receive_branch_id` VARCHAR(45) NOT NULL COMMENT '收货机构',
	`total_amount` DECIMAL NOT NULL COMMENT '单据金额',
	`receive_status` INT NOT NULL DEFAULT 0 COMMENT '收货状态（0-未收货、1-部分收货、2-已收货）',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`create_oper_id` INT NOT NULL COMMENT '制单人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper_id` INT NOT NULL COMMENT '审核人',
	`approve_oper_name` VARCHAR(45) NOT NULL,
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '配送出库单';

DROP TABLE IF EXISTS `item_stock_flow`;

CREATE TABLE `item_stock_flow` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
    `qty` DECIMAL NOT NULL COMMENT '库存数量',
    `price` DECIMAL NOT NULL COMMENT '出入库价格',
    `amount` DECIMAL NOT NULL COMMENT '出入库金额',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品库存流水';
DROP TABLE IF EXISTS `delivery_diff_in_detail_batch`;

CREATE TABLE `delivery_diff_in_detail_batch` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `detail_id` BIGINT NOT NULL COMMENT '单据明细id',
    `batch_id` VARCHAR(45) NOT NULL COMMENT '批次号',
    `refer_batch_qty` DECIMAL NOT NULL COMMENT '剩余库存数量',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `expire_date` DATE NOT NULL COMMENT '过期日期',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配送差异入库单商品批次明细';

DROP TABLE IF EXISTS `delivery_diff_out_detail`;

CREATE TABLE `delivery_diff_out_detail` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
    `size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
    `delivery_unit` VARCHAR(45) NOT NULL COMMENT '配送单位',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `price` DECIMAL NOT NULL COMMENT '单价',
    `amount` DECIMAL NOT NULL COMMENT '金额',
    `tax_rate` DECIMAL NOT NULL COMMENT '税率',
    `tax_amount` DECIMAL NOT NULL COMMENT '税额',
    `refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
    `retail_price` DECIMAL NOT NULL COMMENT '零售价',
    `stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配送差异出库单商品明细';

DROP TABLE IF EXISTS `delivery_return_apply`;

CREATE TABLE `delivery_return_apply` (
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `ref_sheet_id` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '引用配送单号',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '入库机构',
    `delivery_branch_id` VARCHAR(45) NOT NULL COMMENT '配送中心',
    `store_id` VARCHAR(45) NOT NULL COMMENT '入库仓库',
	`total_amount` DECIMAL NOT NULL COMMENT '单据金额',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`create_oper_id` INT NOT NULL COMMENT '制单人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper_id` INT NOT NULL COMMENT '审核人',
	`approve_oper_name` VARCHAR(45) NOT NULL,
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '配退申请单';

DROP TABLE IF EXISTS `delivery_diff_in_detail`;

CREATE TABLE `delivery_diff_in_detail` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
    `size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
    `delivery_unit` VARCHAR(45) NOT NULL COMMENT '配送单位',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `price` DECIMAL NOT NULL COMMENT '单价',
    `amount` DECIMAL NOT NULL COMMENT '金额',
    `tax_rate` DECIMAL NOT NULL COMMENT '税率',
    `tax_amount` DECIMAL NOT NULL COMMENT '税额',
    `refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
    `retail_price` DECIMAL NOT NULL COMMENT '零售价',
    `stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配送差异入库单商品明细';

DROP TABLE IF EXISTS `delivery_receive`;

CREATE TABLE `delivery_receive` (
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `ref_sheet_id` VARCHAR(45) NOT NULL COMMENT '引用配送出库单号',
    `delivery_branch_id` VARCHAR(45) NOT NULL COMMENT '配送中心',
    `store_id` VARCHAR(45) NOT NULL COMMENT '出库仓库',
    `receive_branch_id` VARCHAR(45) NOT NULL COMMENT '收货机构',
	`total_amount` DECIMAL NOT NULL COMMENT '单据金额',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`create_oper_id` INT NOT NULL COMMENT '制单人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper_id` INT NOT NULL COMMENT '审核人',
	`approve_oper_name` VARCHAR(45) NOT NULL,
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '配送收货单';

DROP TABLE IF EXISTS `delivery_detail`;

CREATE TABLE `delivery_detail` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
    `size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
    `delivery_unit` VARCHAR(45) NOT NULL COMMENT '配送单位',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `price` DECIMAL NOT NULL COMMENT '单价',
    `amount` DECIMAL NOT NULL COMMENT '金额',
    `tax_rate` DECIMAL NOT NULL COMMENT '税率',
    `tax_amount` DECIMAL NOT NULL COMMENT '税额',
    `refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
    `retail_price` DECIMAL NOT NULL COMMENT '零售价',
    `stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配送出库单商品明细';

DROP TABLE IF EXISTS `delivery_return_apply_detail`;

CREATE TABLE `delivery_return_apply_detail` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
    `size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
    `delivery_unit` VARCHAR(45) NOT NULL COMMENT '配送单位',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `price` DECIMAL NOT NULL COMMENT '单价',
    `amount` DECIMAL NOT NULL COMMENT '金额',
    `tax_rate` DECIMAL NOT NULL COMMENT '税率',
    `tax_amount` DECIMAL NOT NULL COMMENT '税额',
    `refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
    `retail_price` DECIMAL NOT NULL COMMENT '零售价',
    `stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配退申请单商品明细';

DROP TABLE IF EXISTS `delivery_diff_apply`;

CREATE TABLE `delivery_diff_apply` (
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `ref_sheet_id` VARCHAR(45) NOT NULL COMMENT '引用配送出库单号',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '申请机构',
    `store_id` VARCHAR(45) NOT NULL COMMENT '出库仓库',
    `diff_reason` VARCHAR(45) NOT NULL COMMENT '差异原因',
	`total_amount` DECIMAL NOT NULL COMMENT '单据金额',
	`approve_status` INT NOT NULL DEFAULT 0 COMMENT '审核状态（0-草稿、1-为审核、2-审核通过、3-已驳回）',
	`create_oper_id` INT NOT NULL COMMENT '制单人',
	`create_oper_name` VARCHAR(45) NOT NULL,
	`create_time` DATETIME NOT NULL COMMENT '制单时间',
	`approve_oper_id` INT NOT NULL COMMENT '审核人',
	`approve_oper_name` VARCHAR(45) NOT NULL,
	`approve_time` DATETIME NOT NULL COMMENT '审核时间',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`sheet_id`))
ENGINE = InnoDB
COMMENT = '配送差异申请单';

DROP TABLE IF EXISTS `delivery_diff_out_detail_batch`;

CREATE TABLE `delivery_diff_out_detail_batch` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `detail_id` BIGINT NOT NULL COMMENT '单据明细id',
    `batch_id` VARCHAR(45) NOT NULL COMMENT '批次号',
    `refer_batch_qty` DECIMAL NOT NULL COMMENT '剩余库存数量',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `expire_date` DATE NOT NULL COMMENT '过期日期',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配送差异出库单商品批次明细';

DROP TABLE IF EXISTS `delivery_detail_batch`;

CREATE TABLE `delivery_detail_batch` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `detail_id` BIGINT NOT NULL COMMENT '单据明细id',
    `batch_id` VARCHAR(45) NOT NULL COMMENT '批次号',
    `refer_batch_qty` DECIMAL NOT NULL COMMENT '剩余库存数量',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `expire_date` DATE NOT NULL COMMENT '过期日期',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配送出库单商品批次明细';

DROP TABLE IF EXISTS `delivery_return_detail_batch`;

CREATE TABLE `delivery_return_detail_batch` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `detail_id` BIGINT NOT NULL COMMENT '单据明细id',
    `batch_id` VARCHAR(45) NOT NULL COMMENT '批次号',
    `refer_batch_qty` DECIMAL NOT NULL COMMENT '剩余库存数量',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `expire_date` DATE NOT NULL COMMENT '过期日期',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配退单商品批次明细';

DROP TABLE IF EXISTS `delivery_receive_detail`;

CREATE TABLE `delivery_receive_detail` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
    `size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
    `delivery_unit` VARCHAR(45) NOT NULL COMMENT '配送单位',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `price` DECIMAL NOT NULL COMMENT '单价',
    `amount` DECIMAL NOT NULL COMMENT '金额',
    `tax_rate` DECIMAL NOT NULL COMMENT '税率',
    `tax_amount` DECIMAL NOT NULL COMMENT '税额',
    `refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
    `retail_price` DECIMAL NOT NULL COMMENT '零售价',
    `stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配送收货单商品明细';

DROP TABLE IF EXISTS `delivery_return_receive_detail_batch`;

CREATE TABLE `delivery_return_receive_detail_batch` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `detail_id` BIGINT NOT NULL COMMENT '单据明细id',
    `batch_id` VARCHAR(45) NOT NULL COMMENT '批次号',
    `refer_batch_qty` DECIMAL NOT NULL COMMENT '剩余库存数量',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `expire_date` DATE NOT NULL COMMENT '过期日期',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配退收获单商品批次明细';

DROP TABLE IF EXISTS `item_batch_stock`;

CREATE TABLE `item_batch_stock` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `batch_id` VARCHAR(45) NOT NULL COMMENT '批次号',
    `barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
    `store_id` VARCHAR(45) NOT NULL COMMENT '仓库',
    `qty` DECIMAL NOT NULL COMMENT '库存数量',
    `cost_price` DECIMAL NOT NULL COMMENT '成本价',
    `cost_amount` DECIMAL NOT NULL COMMENT '成本金额',
    `expire_date` DATETIME NOT NULL COMMENT '过期日期',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品批次库存';
DROP TABLE IF EXISTS `delivery_return_receive_detail`;

CREATE TABLE `delivery_return_receive_detail` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `sheet_id` VARCHAR(45) NOT NULL COMMENT '单据号',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `item_barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `item_name` VARCHAR(45) NOT NULL COMMENT '商品名称',
    `size` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '规格',
    `delivery_unit` VARCHAR(45) NOT NULL COMMENT '配送单位',
	`qty` DECIMAL NOT NULL COMMENT '数量',
    `price` DECIMAL NOT NULL COMMENT '单价',
    `amount` DECIMAL NOT NULL COMMENT '金额',
    `tax_rate` DECIMAL NOT NULL COMMENT '税率',
    `tax_amount` DECIMAL NOT NULL COMMENT '税额',
    `refer_stock_qty` DECIMAL NOT NULL COMMENT '库存数量',
    `retail_price` DECIMAL NOT NULL COMMENT '零售价',
    `stock_qty` DECIMAL NOT NULL COMMENT '基本数量',
	`stock_unit` VARCHAR(45) NOT NULL COMMENT '库存单位',
	`memo` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '配退收货单商品明细';

DROP TABLE IF EXISTS `item_stock`;

CREATE TABLE `item_stock` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增编码',
    `item_id` VARCHAR(45) NOT NULL COMMENT '商品编码',
    `barcode` VARCHAR(45) NOT NULL COMMENT '商品条码',
    `branch_id` VARCHAR(45) NOT NULL COMMENT '机构',
    `store_id` VARCHAR(45) NOT NULL COMMENT '仓库',
    `qty` DECIMAL NOT NULL COMMENT '库存数量',
    `cost_price` DECIMAL NOT NULL COMMENT '成本价',
    `cost_amount` DECIMAL NOT NULL COMMENT '成本金额',
    PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品库存';
