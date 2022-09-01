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

);

INSERT INTO product VALUES('P1234', 'iPhone 6s', 800000, '1334X750 Renina HD display, 8-megapixel iSight Camera','Smart Phone', 'Apple', 1000, 'new', 'P1234.png');
INSERT INTO product VALUES('P1235', 'LG PC gram', 1500000, '3.3-inch,IPS LED display, 5rd Generation Intel Core processors', 'Notebook', 'LG', 1000, 'new', 'P1235.png');
INSERT INTO product VALUES('P1236', 'Galaxy Tab S', 900000, '3.3-inch, 212.8*125.6*6.6mm,  Super AMOLED display, Octa-Core processor', 'Tablet', 'Samsung', 1000, 'new', 'P1236.png');


INSERT INTO product VALUES('P0000', 'luckyBags', 5000, 'Bags of Luck', 'goods', 'sw', 1000, 'new', 'P0000.png');
INSERT INTO product VALUES('P0001', 'deco', 900000, 'Table Decorations', 'goods', 'sw', 1000, 'new', 'P0001.png');
INSERT INTO product VALUES('P0002', 'miniTable', 300000, 'Muti Use Table', 'goods', 'sw', 1000, 'new', 'P0002.png');
INSERT INTO product VALUES('P0003', 'shellDeco', 20000, 'Shell shaped necklace keeper', 'goods', 'sw', 1000, 'new', 'P0003.png');
INSERT INTO product VALUES('P0004', 'MoodyLamp', 800000, 'Lamp: 2 options(blue, orange)', 'goods', 'sw', 1000, 'new', 'P0004.png');


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
	CONSTRAINT FK__user FOREIGN KEY (userID) REFERENCES user(userID) ON UPDATE CASCADE ON DELETE NO ACTION
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
	CONSTRAINT FK__order FOREIGN KEY (orderID) REFERENCES `order`(orderID) ON UPDATE CASCADE ON DELETE NO ACTION
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
	CONSTRAINT FK_userID FOREIGN KEY (userID) REFERENCES `user` (userID) ON UPDATE CASCADE ON DELETE NO ACTION
);

INSERT INTO `user` (`userID`, `password`, `username`, `postcode`, `address`, `detailAddress`, `extraAddress`, `telno`, `email`) VALUES ('almond123', 'almond123!', '이몬드', '04536', '서울 중구 명동길 48', '101동 1301호', ' (명동2가)', '010-9844-2101', 'alomond@naver.com');
INSERT INTO `user` (`userID`, `password`, `username`, `postcode`, `address`, `detailAddress`, `extraAddress`, `telno`, `email`) VALUES ('choco', 'choco123!', '박초코', '13607', '경기 성남시 분당구 내정로 54', '205동 1205호', ' (정자동, 한솔마을주공6단지아파트)', '010-6941-2352', 'choco@gmail.com');
INSERT INTO `user` (`userID`, `password`, `username`, `postcode`, `address`, `detailAddress`, `extraAddress`, `telno`, `email`) VALUES ('dudwn1814', 'dksdud18145!', '안영주', '12120', '경기 남양주시 퇴계원읍 퇴계원로119번길 6-2', '201호', ' (월드아파트)', '010-2466-1018', 'dudwn1814@gmail.com');
INSERT INTO `user` (`userID`, `password`, `username`, `postcode`, `address`, `detailAddress`, `extraAddress`, `telno`, `email`) VALUES ('linux', 'linux123!', '이눅스', '13524', '경기 성남시 분당구 대왕판교로606번길 45', '1305동 1105호', ' (삼평동)', '010-1305-1105', 'nuxLee@gmail.com');
INSERT INTO `user` (`userID`, `password`, `username`, `postcode`, `address`, `detailAddress`, `extraAddress`, `telno`, `email`) VALUES ('star', 'star123!', '문별', '04766', '서울 성동구 서울숲길 25', '808호', ' (성수동1가, 현대아파트)', '010-3812-7261', 'star@kccl.go.kr');
INSERT INTO `user` (`userID`, `password`, `username`, `postcode`, `address`, `detailAddress`, `extraAddress`, `telno`, `email`) VALUES ('zero', 'zero123!', '최영', '21999', '인천 연수구 갯벌로 169', '401동', ' (송도동)', '010-9718-1254', 'zero0@naver.com');

-- 8. 제품 카테고리별 Veiw 생성 코드
CREATE VIEW FRAME AS SELECT * FROM product WHERE p_category = 'FRAME';
CREATE VIEW HOMEWARE AS SELECT * FROM product WHERE p_category = 'HOMEWARE';
CREATE VIEW OBJECT AS SELECT * FROM product WHERE p_category = 'OBJECT';
CREATE VIEW TEXTILE AS SELECT * FROM product WHERE p_category = 'TEXTILE';
