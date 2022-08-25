create database inventory;
USE inventory;

-- 1.회원 테이블
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
--2.관리자 계정
INSERT INTO user(userID, password, username, postcode, detailAddress, telno, email) VALUES("admin", "admin123!", "관리자", "00000", "관리자", "000-0000-0000", "admin@admin.com");

-- 3.재고 테이블  
create table inventory_management (
	p_id int(8) auto_increment primary key,
	p_name varchar(20) not null,
	p_price int(10) UNSIGNED not null,
	p_amount smallint(5) UNSIGNED not null,
	filename varchar(50),
	filesize int(100) UNSIGNED
)

INSERT INTO inventory_management(p_id, p_name, p_price, p_amount) VALUES(null, '조명', 50000, 3);

-- 4.주문 테이블
CREATE TABLE `order` (
	orderID VARCHAR(30) NOT NULL PRIMARY KEY,
	userID VARCHAR(50) NOT NULL,
	totalPrice INT(100) NOT NULL,
	orderDate TIMESTAMP NOT NULL DEFAULT current_TIMESTAMP(),
	CONSTRAINT FK__user FOREIGN KEY (userID) REFERENCES user(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 5.배송 테이블
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

-- 6.주문 목록
CREATE TABLE orderedItem (
	orderID VARCHAR(30) NOT NULL, 
	pID VARCHAR(30) NOT NULL,
	count INT(100) NOT NULL DEFAULT 1,
	CONSTRAINT orderID_nn FOREIGN KEY (orderID) REFERENCES `order`(orderID) ON UPDATE CASCADE ON DELETE CASCADE
	-- CONSTRAINT pID_nn FOREIGN KEY (pID) REFERENCES product(pID) ON UPDATE NO ACTION ON DELETE NO ACTION
);

--7.제품 테이블
CREATE TABLE `product` (
	`ProductID` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_general_ci',
	`Prname` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_general_ci',
	`Price` INT(11) NOT NULL,
	`Inventory` INT(3) UNSIGNED ZEROFILL NOT NULL,
	`Explanation` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`ProductID`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

	
--8.카트 테이블
--제품 테이블의 productid, 유저 테이블의 userid와 join
-- cart id는 uuid 번호로 자동 생성
CREATE TABLE `cart` (
	`CartID` VARCHAR(20) NOT NULL DEFAULT uuid_short() COMMENT '일련번호' COLLATE 'utf8mb4_general_ci',
	`userID` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`p_id` INT(11) NOT NULL,
	`QUANTITY` INT(11) NOT NULL COMMENT '주문수량',
	PRIMARY KEY (`CartID`) USING BTREE,
	INDEX `userID` (`userID`) USING BTREE,
	INDEX `p_id` (`p_id`) USING BTREE,
	CONSTRAINT `productID` FOREIGN KEY (`p_id`) REFERENCES `inventory`.`inventory_management` (`p_id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `inventory`.`user` (`userID`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;





);


