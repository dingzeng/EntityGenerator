# EntityGenerator
代码生成工具（实体模型、用于Grpc的消息模型）

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

### 添加配置文件(tasks.json)
```JSON
[
    {
        "server": "192.168.0.0",
        "port": 3306,
        "userid": "root",
        "password": "",
        "projects": [
            {
                "database": "数据库名称",
                "table": "*",
                "output": "实体类输出路径",
                "protoFile": "proto文件路径",
                "namespace": "项目程序集根命名空间"
            }
        ]
    }
]
```

### 运行效果
```
dotnet run .\tasks.json
开始生成:
-----------------Database:db_tripod_archive,Tables:*--------------------------------
Entity Class: branch
Entity Class: branch_group
Grpc Message: branch
Grpc Message: branch_group

生成完成，按任意键退出...
```

### 生成的实体类

```CSHARP
/*
	本文件代码由代码生成工具自动生成，请不要手动修改
	生成时间：2019-11-19 21:17:28
*/
using System;
using Tripod.Framework.DapperExtentions.Attributes;
using Tripod.Framework.Common;

namespace Tripod.Service.System.Model
{
	[Table("menu")]
	public partial class Menu : Entity
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

### 生成的Grpc消息模型
```
/*
	本文件代码由代码生成工具自动生成，请不要手动修改
	生成时间：2019-11-19 21:17:28
*/
syntax = "proto3";
option csharp_namespace = "Tripod.Service.System";

message MenuDTO {
	string Code = 1;
	string ParentCode = 2;
	string Path = 3;
	string Name = 4;
	int32 IsLeaf = 5;
}
```

## TODOLIST

- 支持各种数据库（目前只支持MySql数据库）
- 更灵活的输出配置
	- 自定义表名、列名到类名、属性名映射
	- 类文件模板支持