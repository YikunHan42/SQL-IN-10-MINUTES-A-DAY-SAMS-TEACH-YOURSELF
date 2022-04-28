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