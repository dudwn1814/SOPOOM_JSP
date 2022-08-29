create database inventory;
USE inventory;

-- 재고 테이블  
CREATE TABLE IF NOT EXISTS product(
	p_id VARCHAR(10) NOT NULL,
	p_name VARCHAR(20),
	p_unitPrice  INTEGER,
	p_description TEXT,
   	p_category VARCHAR(20),
	p_manufacturer VARCHAR(20),
	p_unitsInStock INTEGER,
	p_condition VARCHAR(20),
	p_fileName  VARCHAR(200),
	PRIMARY KEY (p_id)
)

INSERT INTO product VALUES('P1234', 'iPhone 6s', 800000, '1334X750 Renina HD display, 8-megapixel iSight Camera','Smart Phone', 'Apple', 1000, 'new', 'P1234.png');
INSERT INTO product VALUES('P1235', 'LG PC gram', 1500000, '3.3-inch,IPS LED display, 5rd Generation Intel Core processors', 'Notebook', 'LG', 1000, 'new', 'P1235.png');
INSERT INTO product VALUES('P1236', 'Galaxy Tab S', 900000, '3.3-inch, 212.8*125.6*6.6mm,  Super AMOLED display, Octa-Core processor', 'Tablet', 'Samsung', 1000, 'new', 'P1236.png');


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

-- 관리자 계정
INSERT INTO user(userID, password, username, postcode, detailAddress, telno, email) VALUES("admin", "admin123!", "관리자", "00000", "관리자", "000-0000-0000", "admin@admin.com");


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
	pID VARCHAR(10) NOT NULL,
	count INT(100) NOT NULL DEFAULT 1,
	CONSTRAINT orderID_nn FOREIGN KEY (orderID) REFERENCES `order`(orderID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pID_nn FOREIGN KEY (pID) REFERENCES product(p_id) ON UPDATE NO ACTION ON DELETE NO ACTION
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

-- 7.카트 테이블
-- 제품 테이블의 productid, 유저 테이블의 userid와 join
CREATE TABLE cart (
	userID VARCHAR(50) NOT NULL ,
	QUANTITY INT(11) NOT NULL COMMENT '주문수량',
	p_id VARCHAR(10) NOT NULL ,
	INDEX FK_pid (p_id) USING BTREE,
	INDEX FK_userID (userID) USING BTREE,
	CONSTRAINT FK_pid FOREIGN KEY (p_id) REFERENCES product (p_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_userID FOREIGN KEY (userID) REFERENCES `user` (userID) ON UPDATE CASCADE ON DELETE CASCADE
);
