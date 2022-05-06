# SQL必知必会
![[SQL必知必会 (福达) (z-lib.org).pdf]]

![[挑战题及其答案—中文版.pdf]]
**注：如不同数据库SQL实现并不相同，文稿中采用MySQL版本**

## 第1课 了解SQL
### 基本概念
模式：关于数据库和表的布局及特性的信息

行：有时候会听到用户在提到行时称其为数据库记录(record)，两个术语多半可以互通，但从计算上说，行更为正确。

主键：
+ 任意两行都不具有相同主键值
+ 每一行必须具有一个主键值
+ 主键值不允许修改
+ 主键值不能重用（删除后赋给新行）


## 第2课 检索数据
### 检索单个列
```sql
SELECT prod_name
FROM Products;
```
+ 输出的数据是**未排序的**
+ 结束SQL语句用;
+ 不区分大小写

### 检索多个列
```sql
SELECT prod_id, prod_name,prod_price
FROM Products;
```

### 检索所有列
```sql
SELECT *
FROM Products;
```
使用通配符的优点在于可以检索出名字未知的列

### 检索不同的值
```sql
SELECT DISTINCT vend_id
FROM Products;
```
**注：不能部分使用`DISTINCT`，只要有一个值不同就计入**

### 限制结果
```SQL
SELECT prod_name
FROM Products
LIMIT 5 OFFSET 5;
```
+ 第一个数字是检索的行数，第二个数字是指从哪儿开始
+ 从第0行开始

**注：`LIMIT 3,4`代表`LIMIT 4 OFFSET 3`**

### 使用注释
```sql
SELECT prod_name --这是一条注释
FROM Products;
```

```sql
# 这是一条注释
SELECT prod_name
FROM Products;
```

```sql
/* SELECT prod_name --这是一条注释
FROM Products; */
SELECT prod_name
FROM Products;
```

### 挑战题
1. 编写SQL语句，从Customers表中检索所有的ID(cust_id)。
```sql
SELECT cust_id
FROM Customers;
```

2. OrderItems表包含了所有已订购的产品（有些已被订购多次）。编写SQL语句，检索并列出已订购产品(prod_id)的清单（不用列每个订单，只列出不同的清单）。提示：最终应该显示7行。
```sql
SELECT DISTINCT prod_id
FROM OrderItems;
```

3. 编写SQL语句，检索Customers表中的列，再编写另外的`SELECT`语句，仅检索顾客的ID。使用注释，注释掉一条SELECT语句，以便运行另一条`SELECT`语句。（当然，要测试这两个语句。）
```sql
/* SELECT
FROM Customers; */
SELECT ID
FROM Customers;
```

## 第3课 排序检索数据
主要涉及`ORDER BY`子句。

在不做要求时，一般以表中出现顺序显示，但如果进行过更新或删除，可能会受到影响。

**子句**的概念

`ORDER BY`可以应用于未选择的列，且应该是最后一条子句。

### 按多个列排序
```sql
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price, prod_name;
```

### 按列位置排序
```sql
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY 2, 3;
```
从1开始，是按照**选中的列**，而非所有列

### 指定排序方向
```sql
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC, prod_name;
```
默认升序排列
在多个列上降序排列需要对每一列指定`desc`关键字

### 挑战题
1. 编写SQL语句，从Customers中检索所有的顾客名称(cust_name), 并按从Z到A的顺序显示结果。
```SQL
SELECT cust_name
FROM Customers
ORDER BY cust_name DESC;
```

2. 编写SQL语句，从Orders表中检索顾客ID(cust_id)和订单号(order_num)，并先按顾客ID对结果进行排序，再按订单日期倒序排列。
```sql
SELECT cust_id, order_num
FROM Orders
ORDER BY cust_id, order_date DESC;
```

3. 显然，我们的虚拟商店更喜欢出售比较贵的物品，而且这类物品有很多。编写SQL语句，显示OrderItems表中的数量和价格(item_price)，并按数量由多到少，价格由高到低排序。
```sql
SELECT quantity, item_price
FROM OrderItems
ORDER BY quantity DESC, item_price DESC;
```

4. 下面的SQL语句有问题吗？（尝试在不运行的情况下指出）
```sql
SELECT vend_name, -- 多了,
FROM Vendors
ORDER vend_name DESC; -- 没有BY
```

## 第4课 过滤数据
	数据应该避免在客户端过滤，否则网络带宽会浪费，且应用性能会受到影响
	ORDER BY应该在WHERE之后

### `WHERE`子句操作符
| 操作符     | 说明        |
| ------- | --------- |
| \=      | 等于        |
| <>      | 不等于       |
| !=      | 不等于       |
| !<      | 不小于       |
| !>      | 不大于       |
| BETWEEN | 在指定的两个值之间 |
| IS NULL | 为空值       |

#### 不匹配检查
```sql
SELECT vend_id, prod_name
FROM Products
WHERE vend_id <> 'DL101';
```
单引号用于限定字符串

#### 范围值检查
```sql
SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 5 AND 10;
```

注： 在进行匹配过滤或非匹配过滤时，无法返回$NULL$结果。

### 挑战题
1.	编写 SQL 语句，从 Products表中检索产品ID（prod_id）和产品名称（prod_name），只返回价格为 9.49 美元的产品。
```SQL
SELECT prod_id, prod_name
FROM Products
WHERE prod_price = 9.49;
```

2.	编写 SQL 语句，从 Products表中检索产品ID（prod_id）和产品名称（prod_name），只返回价格为 9 美元或更高的产品。
```SQL
SELECT prod_id, prod_name
FROM Products
WHERE prod_price >= 9;
```

3.	结合第 3 课和第 4 课编写 SQL 语句，从 OrderItems 表中检索出所有不同订单号（order_num），其中包含 100 个或更多的产品。
```sql
SELECT DISTINCT order_num
FROM OrderItems
WHERE quantity >= 100;
```

4. 编写 SQL 语句，返回 Products表中所有价格在 3 美元到 6 美元之间的产品的名称（prod_name）和价格（prod_price），然后按价格对结果进行排序。（本题有多种解决方案，我们在下一课再讨论，不过你可以使用目前已学的知识来解决它。）
```sql
SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 3 AND 6
ORDER BY prod_price;
```

## 第5课 高级数据过滤
`AND`子句优先级大于`OR`子句，需要注意括号的使用

`IN`操作符
+ 一般比`OR`操作符执行得更快
+ 最大优点是可以包含其他`SELECT`语句，能够更动态地建立`WHERE`子句

`NOT`子句


### 挑战题
1.	编写 SQL 语句，从 Vendors表中检索供应商名称（vend_name），仅返回加利福尼亚州的供应商（这需要按国家[USA]和州[CA]进行过滤，没准其他国家也存在一个加利福尼亚州）。提示：过滤器需要匹配字符串。
```SQL
SELECT vend_name
FROM Vendors
WHERE vend_country = 'USA' and vend_state = 'CA';
```

2. 编写 SQL 语句，查找所有至少订购了总量 100 个的 BR01、BR02 或BR03 的订单。你需要返回 OrderItems 表的订单号（order_num）、产品 ID（prod_id）和数量，并按产品 ID 和数量进行过滤。提示：根据编写过滤器的方式，可能需要特别注意求值顺序。
```SQL
SELECT order_num, prod_id, quantity
FROM OrderItems
WHERE prod_id IN('BR01', 'BR02', 'BR03') AND quantity >= 100;
```

3.	现在，我们回顾上一课的挑战题。编写 SQL 语句，返回所有价格在 3美元到 6美元之间的产品的名称（prod_name）和价格（prod_price）。使用 AND，然后按价格对结果进行排序。
```sql
SELECT prod_name, prod_price
FROM Products
WHERE prod_price >= 3 AND prod_price <= 6
ORDER BY prod_price;
```

4. 下面的 SQL 语句有问题吗？（尝试在不运行的情况下指出。)
```sql
SELECT vend_name
FROM Vendors
ORDER BY vend_name
WHERE vend_country = 'USA' AND vend_state = 'CA';
```
顺序不对，应该先`WHERE`再`ORDER BY`

## 第6课 用通配符进行过滤
通配符可以创建比较特定数据的搜索模式。

### 百分号通配符
找出以词Fish起头的产品
```sql
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE 'Fish%';
```

注：部分DBMS搜索**区分大小写**

找出名字中含有bean_bag的产品
```sql
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%';
```

找出以F起头、以y结尾的所有产品
```SQL
SELECT prod_name
FROM Products
WHERE prod_name like 'F%y';
```

注：
+ **%代表搜索模式种给定位置的0个、1个或多个字符**
+ 部分DBMS多出的字符空间**以空格结尾**，会影响上述检索方式，可修改为`'F%y%'`
+ `LIKE '%'`不会匹配$NULL$

### 下划线(__)通配符
匹配单个字符

搜索两位英尺数的泰迪熊
```SQL
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '__ inch teddy bear';
```

### 方括号([])通配符
[]用来指定一个字符集，必须匹配指定位置的一个字符。

找出所有名字不以J或M开头的联系人
```sql
SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[^JM]%'
ORDER BY cust_contact;
# 或者在WHERE后添加NOT
```

### 使用技巧
+ 不要过度使用通配符，优先考虑其他操作符
+ 需要使用通配符时，将其置于搜索靠后的地方
+ 仔细检查通配符位置

### 挑战题
1.	编写SQL语句，从Products表中检索产品名称(prod_name)和描述(prod_desc)，仅返回描述中包含toy一词的产品。
```sql
SELECT prod_name, prod_desc
FROM Products
WHERE prod_desc LIKE '%toy%';
```

2.	反过来再来一次。编写SQL语句，从Products表中检索产品名称(prod_name)和描述(prod_desc)，仅返回描述中未出现toy一词的产品。这次，按产品名称对结果进行排序。
```sql
SELECT prod_name, prod_desc
FROM Products
WHERE NOT prod_desc LIKE '%toy'
ORDER BY prod_name;
```

3. 编写SQL语句，从Products表中检索产品名称(prod_name)和描述(prod_desc)，仅返回描述中同时出现toy和carrots的产品。有好几种方法可以执行此操作，但对于这个挑战题，请使用AND和两个LIKE比较。
```sql
SELECT prod_name, prod_desc
FROM Products
WHERE prod_desc LIKE '%toy%' AND prod_desc LIKE '%carrots%';
```

4. 来个比较棘手的。我没有特别向你展示这个语法，而是想看看你根据目前已学的知识是否可以找到答案。编写 SQL 语句，从 Products 表中检索产品名称（prod_name）和描述（prod_desc），仅返回在描述中以先后顺序同时出现 toy 和 carrots 的产品。提示：只需要用带有三个 % 符号的 LIKE即可。
```sql
SELECT prod_name, prod_desc
FROM Products
WHERE prod_desc LIKE '%toy%carrots%';
```

## 第7课 创建计算字段
有时数据表中存储的并非应用程序所需要的，应检索出转换、计算或格式化过的数据。

计算字段是运行时在`SELECT`语句内创建的。

### 拼接
MySQL：
```SQL
SELECT Concat(vend_name, ' (', vend_country, ')')
FROM Vendors
ORDER BY vend_name;
```

注：第二个字符串包含**一个空格**和一个左圆括号

许多数据库会统一成列宽，但**实际上不需要空格**，可以使用`RIRIM()`函数完成
```SQL
SELECT RIRIM(vend_name) + ' (' + RIRIM(vend_country) + ')'
FROM Vendors
ORDER BY vend_name;
```

上一个代码片段中`+`可以同义替换为`||`

	TRIM函数
	RTRIM()去除字符串右面的空格，同理还有LTRIM()和TRIM()

### 别名
`AS`关键字

### 执行算术运算
四则运算 `+ - * /`

注：`SELECT`语句后面不接`FROM`时，可以进行检验操作（不需要数据）

### 挑战题
1.	别名的常见用法是在检索出的结果中重命名表的列字段（为了符合特定的报表要求或客户需求）。编写 SQL 语句，从 Vendors 表中检索vend_id、vend_name、vend_address 和 vend_city，将 vend_name重命名为 vname，将 vend_city重命名为 vcity，将 vend_address重命名为 vaddress。按供应商名称对结果进行排序（可以使用原始名称或新的名称）。
```sql
SELECT vend_id,
	   vend_name as vname,
	   vend_address as vaddress,
       vend_city as vcity
FROM Vendors
ORDER BY vname;
```

2. 我们的示例商店正在进行打折促销，所有产品均降价 10%。编写 SQL语句，从 Products表中返回 prod_id、prod_price 和 sale_price。 sale_price 是一个包含促销价格的计算字段。提示：可以乘以 0.9，得到原价的 90%（即 10%的折扣）。
```sql
SELECT prod_id, 
       prod_price,
       prod_price * 0.9 AS sale_price
FROM Products;
```

## 第8课 使用函数处理数据
SQL函数在多数情况下不是可移植的

### 文本处理函数
| **函数**      | **说明**         |
|:-----------:|:--------------:|
| LEFT\(\)    | 返回字符串左边的字符     |
| LENGTH\(\)  | 返回字符串的长度       |
| LOWER\(\)   | 将字符串转换为小写      |
| LTRIM\(\)   | 去掉字符串左边的空格     |
| RIGHT\(\)   | 返回字符串右边的字符     |
| RTRIM\(\)   | 去掉字符串右边的空格     |
| SUBSTR\(\)  | 提取字符串的组成部分     |
| SOUNDEX\(\) | 返回字符串的SOUNDEX值 |
| UPPER\(\)   | 将字符串转换为大写      |

注：`SOUNDEX`是一个将任何文本串转换为描述其语音表示的字母数字模式的算法。
例：
```SQL
SELECT cust_name, cust_contact
FROM Customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');
```

返回值为Michelle Green，发音相仿

### 日期和时间处理函数
检索2020年的所有订单：
```sql
SELECT order_num
FROM Orders
WHERE YEAR(order_date) = 2020;
```

### 数值处理函数
| **函数**   | **说明**     |
|:--------:|:----------:|
| ABS\(\)  | 返回一个数的绝对值  |
| COS\(\)  | 返回一个角度的余弦  |
| EXP\(\)  | 返回一个数的指数值  |
| PI\(\)   | 返回圆周率Π的值   |
| SIN\(\)  | 返回一个角度的正弦  |
| SQRT\(\) |  返回一个数的平方根 |
| TAN\(\)  | 返回一个角度的正切  |

### 挑战题
1.	我们的商店已经上线了，正在创建顾客账户。所有用户都需要登录名，默认登录名是其名称和所在城市的组合。编写 SQL 语句，返回顾客 ID （cust_id）、顾客名称（customer_name）和登录名（user_login），其中登录名全部为大写字母，并由顾客联系人的前两个字符（cust_ contact）和其所在城市的前三个字符（cust_city）组成。例如，我的登录名是 BEOAK（Ben Forta，居住在 Oak Park）。提示：需要使用函数、拼接和别名。
```sql
SELECT cust_id,
	   cust_name,
	   CONCAT(UPPER(LEFT(cust_contact, 2), LEFT(cust_city, 3))) AS user_login
FROM Customers;
```

2. 编写 SQL 语句，返回 2020 年 1 月的所有订单的订单号（order_num）和订单日期（order_date），并按订单日期排序。你应该能够根据目前已学的知识来解决此问题，但也可以开卷查阅 DBMS 文档。
```sql
SELECT order_num, order_date
FROM ORDERS
WHERE YEAR(order_date) = 2020 AND MONTH(order_date) = 1
ORDER BY order_date;
```

## 第9课 汇总数据
### 聚集函数
| **函数**  | **说明**   |
|:-------:|:--------:|
| AVG()   | 返回某列的平均值 |
| COUNT() | 返回某列的行数  |
| MAX()   | 返回某列的最大值 |
| MIN()   | 返回某列的最小值 |
| SUM()   | 返回某列值之和  |

注：
+ `AVG()`只用于单个列，且忽略列值为$NULL$的行
+ `COUNT()`会忽略列值为$NULL$的行，`COUNT(*)`不忽略
+ `MAX`会忽略列值为$NULL$的行，再用与文本数据时返回该列排序后的最后一行
+ `MIN()`会忽略列值为$NULL$的行，再用与文本数据时返回该列排序后的最前一行
+ `SUM()`会忽略列值为$NULL$的行
+ 聚集函数利用标准算术运算符，可以用来执行多个列上的运算

### 聚集不同值
注：
+ 指定列名，`DISTINCT`只能用于`COUNT()`，不能用于`COUNT(*)`，必须使用列名，不能用于计算或表达式
+ 应用于`MAX()`和`MIN()`没有任何意义

### 挑战题
1.	编写 SQL 语句，确定已售出产品的总数（使用 OrderItems 中的quantity列）。
```SQL
SELECT SUM(quantity) AS total_quantity
FROM OrderItems;
```

2.	修改刚刚创建的语句，确定已售出产品项（prod_item）BR01 的总数。
```sql
SELECT SUM(quantity) AS total_BR01_product
FROM OrderItems
WHERE prod_id = 'BR01';
```
3. 编写 SQL 语句，确定 Products 表中价格不超过 10 美元的最贵产品的价格（prod_price）。将计算所得的字段命名为 max_price。
```sql
SELECT MAX(prod_price) AS max_price
FROM Products
WHERE prod_price <= 10;
```

## 第10课 分组数据
### 创建分组
`GROUP BY`子句
注：
+ 可以包含任意数目的列，因而可以对分组进行嵌套
+ 如果嵌套了分组，数据将在最后指定的分组上进行汇总
+ 列出的每一列都必须是检索列或有效表达式（但不能是聚集函数），`SELECT`中是表达式则`GROUP BY`必须指定相同表达式
+ 一般不允许分组列带有长度可变的数据类型（如文本或备注型字段）
+ $NULL$将作为一个分组返回
+ 必须出现在`WHERE`子句之后，`ORDER BY`子句之前

### 过滤分组
`HAVING`用于过滤分组，`WHERE`用于过滤行，分别在数据分组后和数据分组前进行过滤
```sql
SELECT cust_id, COUNT(*) AS orders
FROM Orders
WHERE prod_price >= 4
GROUP BY cust_id
HAVING COUNT(*) >= 2;
```

### 分组和排序
| **ORDER BY**           | **GROUP BY**                 |
|:----------------------:|:----------------------------:|
| 对产生的输出排序               | 对行分组，但输出可能不是分组的顺序            |
| 任何列都可以使用（甚至非选择的列也可以使用） | 只可能使用选择列或表达式列，而且必须使用每个选择列表达式 |
| 不一定需要                  | 如果与聚集函数一起使用列（或表达式），则必须使用     |
一般使用`GROUP BY`子句时，应该也给出`ORDER BY`子句，这是保证数据正确排序的唯一方法

### 挑战题
1.	OrderItems 表包含每个订单的每个产品。编写 SQL 语句，返回每个订单号（order_num）各有多少行数（order_lines），并按 order_lines对结果进行排序。
```sql
SELECT order_num, COUNT(*) AS order_lines
FROM OrderItems
GROUP BY order_num
ORDER BY order_lines;
```

2.	编写 SQL 语句，返回名为 cheapest_item 的字段，该字段包含每个供应商成本最低的产品（使用 Products 表中的 prod_price），然后从最低成本到最高成本对结果进行排序。
```sql
SELECT vend_id, MIN(prod_price) AS cheapest_item
FROM Products
GROUP BY prod_id
ORDER BY cheapest_item;
```

3. 确定最佳顾客非常重要，请编写SQL语句，返回至少含100项的所有订单的订单号（OrderItems表中的order_num）
```sql
SELECT order_num
FROM OrderItems
GROUP BY order_num
HAVING SUM(quantity) >= 100
ORDER BY order_num;
```

4.	确定最佳顾客的另一种方式是看他们花了多少钱。编写 SQL 语句，返回总价至少为 1000 的所有订单的订单号（OrderItems 表中的order_num）。提示：需要计算总和（item_price乘以 quantity）。按订单号对结果进行排序。
```sql
SELECT order_num
FROM OrderItems
GROUP BY order_num
HAVING SUM(item_price * quantity) >= 1000
ORDER BY order_num;
```

5. 下面的 SQL 语句有问题吗？（尝试在不运行的情况下指出。）
```sql
SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY items -- GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;
```
必须使用实际列