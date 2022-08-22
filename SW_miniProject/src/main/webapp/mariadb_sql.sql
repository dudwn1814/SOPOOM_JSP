
create database inventory;
USE inventory;

-- 재고 테이블  
create table inventory_management (
	p_id int(8) auto_increment primary key,
	p_name varchar(20) not null,
	p_price int(10) UNSIGNED not null,
	p_amount smallint(5) UNSIGNED not null,
	filename varchar(50),
	filesize int(100) UNSIGNED
)

INSERT INTO inventory_management(p_id, p_name, p_price, p_amount) VALUES(null, '조명', 50000, 3);


-- 회원 테이블
CREATE TABLE user(
	userID VARCHAR(50) NOT NULL PRIMARY KEY,
	password VARCHAR(200) NOT NULL,
	username VARCHAR(200) NOT NULL,
	postcode VARCHAR(20) NOT NULL,
	address VARCHAR(50),
	detailAddress VARCHAR(50) NOT NULL,
	extraAddress VARCHAR(50),
	telno VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL
);


-- 배송 테이블
CREATE TABLE shipping(
	shipID VARCHAR(30) NOT NULL PRIMARY KEY,
	orderID VARCHAR(50) NOT NULL,
	`name` VARCHAR(200) NOT NULL,
	postcode VARCHAR(20) NOT NULL,
	address VARCHAR(50),
	detailAddress VARCHAR(50) NOT NULL,
	extraAddress VARCHAR(50),
	telno VARCHAR(20) NOT NULL,
	`status` VARCHAR(10) NOT NULL DEFAULT '주문 완료',
	CONSTRAINT FK__order FOREIGN KEY (orderID) REFERENCES `order`(orderID) ON UPDATE CASCADE ON DELETE CASCADE
);


-- 주문 테이블
CREATE TABLE `order` (
	orderID VARCHAR(30) NOT NULL PRIMARY KEY,
	userID VARCHAR(50) NOT NULL,
	totalPrice INT(100) NOT NULL,
	orderDate TIMESTAMP NOT NULL DEFAULT current_TIMESTAMP(),
	CONSTRAINT FK__user FOREIGN KEY (userID) REFERENCES user(userID) ON UPDATE CASCADE ON DELETE CASCADE
);


-- 주문 목록
CREATE TABLE orderedItem (
	orderID VARCHAR(30) NOT NULL, 
	pID VARCHAR(30) NOT NULL,
	count INT(100) NOT NULL DEFAULT 1,
	CONSTRAINT orderID_nn FOREIGN KEY (orderID) REFERENCES `order`(orderID) ON UPDATE CASCADE ON DELETE CASCADE
	-- CONSTRAINT pID_nn FOREIGN KEY (pID) REFERENCES product(pID) ON UPDATE NO ACTION ON DELETE NO ACTION
);


