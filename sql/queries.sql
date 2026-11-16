USE bookshop;

-- Q1：查询库存为 0 的书名和库存
-- 预期结果：《第七天》和《檀香刑》
SELECT title, stock
FROM books
WHERE stock = 0;

-- Q2：按价格降序查询前三本；同价时按 id 升序
-- 预期结果：《檀香刑》《生死疲劳》《乡村教师》
SELECT id, title, price
FROM books
ORDER BY price DESC, id ASC
LIMIT 3;

-- Q3：查询价格在 20 到 40 之间的书，包含 20 和 40
-- 预期结果：6 本书
SELECT id, title, price
FROM books
WHERE price BETWEEN 20 AND 40
ORDER BY id;

-- Q4：JOIN 查询每本书的书名、作者名和价格
-- 预期结果：8 行，每本书对应一位作者
SELECT b.title, a.name AS author, b.price
FROM books AS b
JOIN authors AS a ON b.author_id = a.id
ORDER BY b.id;

-- Q5：先查询《三体》，再把库存减 1，最后再次查询
-- 预期结果：库存大于 0 时减少 1；为 0 时不修改
SELECT id, title, stock
FROM books
WHERE id = 1;

UPDATE books
SET stock = stock - 1
WHERE id = 1 AND stock > 0;

SELECT id, title, stock
FROM books
WHERE id = 1;

-- Q6：插入临时书，确认后按条件只删除这条记录
-- 使用刚插入的 id 定位记录，避免影响其他书
INSERT INTO books (title, author_id, price, stock)
VALUES ('作业删除测试专用临时书', 1, 10.00, 1);

SET @temporary_book_id = LAST_INSERT_ID();

-- 预期结果：查到刚插入的 1 条记录
SELECT id, title
FROM books
WHERE id = @temporary_book_id;

DELETE FROM books
WHERE id = @temporary_book_id
  AND title = '作业删除测试专用临时书';

-- 预期结果：0 行
SELECT id, title
FROM books
WHERE id = @temporary_book_id;
