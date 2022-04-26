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