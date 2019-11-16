# EntityGenerator
C# database entity code generator

# 使用说明:

### 创建或使用已存在的数据库表结构
```SQL
CREATE TABLE `menu` (
  `code` VARCHAR(45) NOT NULL COMMENT '编码',
  `parent_code` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '父级编码',
  `path` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '菜单路径',
  `name` VARCHAR(45) NOT NULL COMMENT '菜单名称',
  `is_leaf` TINYINT NOT NULL COMMENT '是否是叶子节点',
  PRIMARY KEY (`code`))
ENGINE = InnoDB;
```

### 运行效果
```
请输入数据库服务器地址(默认为：localhost):192.168.0.102
请输入数据库服务器端口号(默认为为:3306):33306
请输入数据库用户名:root
请输入数据库密码:123456
请输入数据库名称:db_tripod_system
请输入要生成的表名称(为空将生成数据库中所有的表):menu
请输入类命名空间：Tripod.Service.System.Model
请输入输出目录路径(默认为当前工作目录)：
开始生成:
menu ok
生成完成，按任意键退出...
```

### 生成内容
```CSHARP
using System;
using Tripod.Framework.DapperExtentions.Attributes;
using Tripod.Framework.Common;

namespace Tripod.Service.System.Model
{
	[Table("menu")]
	public class Menu : Entity
	{
		/// <summary>
		/// 编码
		/// <summary>
		[ExplicitKey]
		public string Code { get; set; }

		/// <summary>
		/// 父级编码
		/// <summary>
		public string ParentCode { get; set; }

		/// <summary>
		/// 菜单路径
		/// <summary>
		public string Path { get; set; }

		/// <summary>
		/// 菜单名称
		/// <summary>
		public string Name { get; set; }

		/// <summary>
		/// 是否是叶子节点
		/// <summary>
		public int IsLeaf { get; set; }
	}
}
```

## TODOLIST

- 支持各种数据库（目前只支持MySql数据库）
- 支持按配置文件批量生成（避免繁琐的参数输入）
- 更灵活的输出配置
	- 自定义表名、列名到类名、属性名映射
	- 类文件模板支持