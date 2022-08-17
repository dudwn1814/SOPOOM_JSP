-- 재고 테이블  
create database inventory;
USE inventory;
create table inventory_management (
	p_id int(8) auto_increment primary key,
	p_name varchar(20) not null,
	p_price int(10) UNSIGNED not null,
	p_amount smallint(5) UNSIGNED not null
)

INSERT INTO inventory_management VALUES(null, '조명', 50000, 3);

-- 회원 테이블
CREATE TABLE member (
	userid VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	username VARCHAR(200) NOT NULL COLLATE 'utf8mb4_general_ci',
	password VARCHAR(200) NOT NULL COLLATE 'utf8mb4_general_ci',
	telno VARCHAR(20) NOT NULL COLLATE 'utf8mb4_general_ci',
	age INT(11) NULL DEFAULT NULL,
	address VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',

	PRIMARY KEY (`userid`) USING BTREE
)

COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

INSERT INTO member VALUES ('testId', 'testName', 'PASSWORD!','01022225555', 13, '서울시');

-- 배송 테이블
CREATE TABLE shipping (
	ship_id INT(8) PRIMARY KEY AUTO_INCREMENT,
	p_id INT(8),  
	u_id VARCHAR(50),

	FOREIGN KEY(p_id) REFERENCES inventory_management(p_id), 
	FOREIGN KEY(u_id) REFERENCES member(userid)
);

INSERT INTO shipping VALUES (NULL, '1', 'testID');

select s.p_id, s.u_id, m.username, m.telno, m.address 
from shipping s, member m 
where s.u_id = m.userid;
