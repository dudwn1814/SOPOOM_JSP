
-- utf-8설정 한 후 진행해야함

create database inventory;
USE inventory;

-- 재고 테이블  
CREATE TABLE IF NOT EXISTS product(
	p_id VARCHAR(50) NOT NULL,
	p_name VARCHAR(50),
	p_unitPrice  INTEGER,
	p_description TEXT,
   	p_category VARCHAR(50),
	p_manufacturer VARCHAR(50),
	p_unitsInStock INTEGER,
	p_condition VARCHAR(20),
	p_fileName  VARCHAR(200),
	PRIMARY KEY (p_id)

);

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
   pID VARCHAR(50) NOT NULL,
   count INT(100) NOT NULL DEFAULT 1,
   CONSTRAINT orderID_nn FOREIGN KEY (orderID) REFERENCES `order`(orderID) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT pID_nn FOREIGN KEY (pID) REFERENCES product(p_id) ON UPDATE NO ACTION ON DELETE CASCADE
);


-- 배송 테이블
-- 0904 서영: cascade 안되면 삭제가 안되서 수정했습니다
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
	p_id VARCHAR(50) NOT NULL ,
	INDEX FK_pid (p_id) USING BTREE,
	INDEX FK_userID (userID) USING BTREE,
	CONSTRAINT FK_pid FOREIGN KEY (p_id) REFERENCES product (p_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_userID FOREIGN KEY (userID) REFERENCES `user` (userID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 찜 목록 테이블
CREATE TABLE dibs (
	userID VARCHAR(50) NOT NULL,
	p_id VARCHAR(50) NOT NULL,
	CONSTRAINT `FK_dibs_p_idID` FOREIGN KEY (`p_id`) REFERENCES `inventory`.`product` (`p_id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_dibs_userID` FOREIGN KEY (`userID`) REFERENCES `inventory`.`user` (`userID`) ON UPDATE CASCADE ON DELETE CASCADE
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

INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('uncatchable', '잡아보아도 잡히지 않는 - Shunita', 600000, '※구성\r\nartist : 슈니따 | Shunita\r\nmaterial : 장지 캔버스에 과슈, 아크릴\r\nsize : 530*455 mm\r\nweight : 800g\r\nshipment : 2-3일(출고)', 'FRAME', 'shunita', 3, 'New', '50e3ad21bba847e78140d06d710d3027.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('the_new_candle_and_hockney', 'The New Candle and Hockney - Haerri Kim', 350000, 'artist : Haerri Kim | 김혜리\r\nmaterial : Acrylic on canvas board\r\nsize : 300*300mm\r\nweight :100g\r\nshipment : 출고까지 최대 5-7일\r\n', 'FRAME', 'haerrikim', 8, 'New', 'f55b872fee634742b05d6615d7db2594.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('pandora_box', ' Pandora box - Shunita', 600000, '※구성\r\nartist : 슈니따 | Shunita\r\nmaterial : Acrylic & gouache on canvas\r\nsize : 450*450mm\r\nweight : 300g\r\nshipment : 출고까지 최대 3일', 'FRAME', 'shunita', 2, 'New', '03572409b02a471583adc8b70f381765.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('our_lady_of_sorrows', 'our lady of sorrows - Haaeri Kim', 350000, 'artist : Haerri Kim | 김혜리\r\nmaterial : Oil on canvas\r\nsize : 450*450mm\r\nweight :300g\r\nshipment : 출고까지 최대 5-7일', 'FRAME', 'Haerri Kim', 5, 'New', '4a5dc924376440bfa6a3dc8736b54360.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('collage_05', 'Collage 05 - ABANG', 400000, '※구성\r\nartist : 아방 | ABANG\r\nmaterial : 콜라주/알루미늄 프레임\r\nsize : 250*350mm\r\nweight : 850g\r\nshipment : 출고까지 최대 3일', 'FRAME', 'abang', 2, 'New', '106b07b8027a4e378d43970a8ebba227.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('collage_04', 'Collage 04 - ABANG', 400000, '※구성\r\nartist : 아방 | ABANG\r\nmaterial : 콜라주/알루미늄 프레임\r\nsize : 250*350mm\r\nweight : 850g\r\nshipment : 출고까지 최대 3일\r\n', 'FRAME', 'abang', 4, 'New', 'f82d4fe3fcb3491ca40df61fad4e0ccf.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('a_world_you_dont_know_still_exists', 'A world you don’t know still exists - MINISON', 650000, 'artist : MINISON | 손민희\r\nmaterial : Oilpastel on paper\r\nsize : 594*420mm\r\nweight :1.2kg\r\nshipment : 출고까지 최대 5-7일', 'FRAME', 'minison', 3, 'New', '9dc18745940643a1b62af4bcbd473099.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('under_the_sea_series_lamp_03', 'Under The Sea series : Lamp 03 - 황다영', 2500000, '※구성\r\nartist : 황다영\r\nmaterial : Mixed media (Colored stones and regin)\r\nsize : 780*400*200 mm\r\nweight : 8kg\r\nshipment : 출고까지 최대 5-7일', 'HOMEWARE', 'dayeonghwang', 1, 'New', '3b7a5bdef10245ff8976d7a45cb63053.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('soapfish_02', 'Soapfish 02 - HAN LEE', 220000, '※구성\r\nartist : 이한빈 | HAN LEE\r\nmaterial : Tufting (wool & acrylic textile)\r\nsize : 610*270mm\r\nweight : 500g\r\nshipment : 출고까지 최대 3일', 'HOMEWARE', 'han_lee', 1, 'New', 'cb8140a071b14438ad911805618abfd7.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('soapfish_01', 'Soapfish 01 - HAN LEE', 220000, '※구성\r\nartist : 이한빈 | HAN LEE\r\nmaterial : Tufting (wool & acrylic textile)\r\nsize : 600*290mm\r\nweight : 500g\r\nshipment : 출고까지 최대 3일', 'HOMEWARE', 'han_lee', 5, 'New', 'dbe3d164fe354a1e98067430b380c420.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('premium_round_resin_lamp', '프리미엄 원형 레진 램프 오브제 I - JOONUM', 350000, 'artist : JOONUM | 준엄\r\nmaterial : Resin, Hardwood(Bottom : 소태나무 / Stand : 참죽나무)\r\nsize : 450*350*150mm\r\nweight : 4kg\r\nshipment : 출고까지 최대 5-7일', 'HOMEWARE', 'joonum', 8, 'New', 'b07513b2262e462a9c56d22e3738734f.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('moss_planet_cover', '이끼행성 Cover - HAN LEE', 90000, '※구성\r\nartist : 이한빈 | HAN LEE\r\nmaterial : Tufting (wool & acrylic textile)\r\nsize : 125*145mm (π 400mm)\r\nweight : 200g\r\nshipment : 출고까지 최대 3일', 'HOMEWARE', 'han_lee', 5, 'New', '09430ce55851402b9495e4248acf9b5f.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('moss_planet', '이끼행성 - HAN LEE', 55000, '※구성\r\nartist : 이한빈 | HAN LEE\r\nmaterial : Tufting (wool & acrylic textile)\r\nsize : ø125mm\r\nweight : 100g\r\nshipment : 출고까지 최대 3일', 'HOMEWARE', 'han_lee', 55000, 'New', 'eb804681020d4e23960e19bfc99dd8b0.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('a-handful-of-light', '한 줌의 빛 I - JOONUM', 450000, '※구성\r\nartist : JOONUM | 준엄\r\nmaterial : Resin, Hardwood(Bottom : 호두나무 / Stand : 참죽나무 / Circle : 화이트 오크 / Main : 말채나무 보호수 원목(650년))\r\nsize : 450*350*150mm\r\nweight : 4kg\r\nshipment : 출고까지 최대 5-7일', 'HOMEWARE', 'joonum', 4, NULL, 'abce1d672adf47c19d3c8fb81e4d7bfe.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('tomatoes_under_sunlight', '볕을 고루 받은 - SINGA!', 170000, '※구성\r\nartist : 신가은 | SINGA!\r\nmaterial : 도자, 캐스팅, 슬랩빌딩, 산화소성\r\nsize : 85*85*80mm\r\nweight : 97g\r\nshipment : 2-3일(출고)', 'OBJECT', 'singa', 1, 'New', '09e66bdd30974b8b88214136b30775b9.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('sample-triangle-white', 'Sample_Triangle (White) - 이지현', 70000, '※구성\r\nartist : 이지현 | Lee Jihyun\r\nmaterial : Resin clay on glass flask\r\nsize : 70*70*120mm\r\nweight : 64g\r\nshipment : 주문생산 (7일)', 'OBJECT', 'leejihyun', 6, 'New', 'a74d961eae5840989b7f259288e4f860.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('sample-triangle-black', 'Sample_Triangle (Black) - 이지현', 70000, '※구성\r\nartist : 이지현 | Lee Jihyun\r\nmaterial : Resin clay on glass flask\r\nsize : 70*70*120mm\r\nweight : 64g\r\nshipment : 주문생산 (7일)', 'OBJECT', 'leejihyun', 11, NULL, 'e95c7d3ea3f74441be5bac550de0f55a.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('fully_grown_and_jujube_tomatoes', '완숙이랑 막 자란 대추방울 - SINGA!', 170000, '※구성\r\nartist : 신가은 | SINGA!\r\nmaterial : 도자, 캐스팅, 슬랩빌딩, 산화소성\r\nsize : 105*105*130mm\r\nweight : 241g\r\nshipment : 2-3일(출고)', 'OBJECT', 'singa', 7, 'New', '0b57cd14daf94b08b17eccc0ed09df32.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('flowerpot', '화분 - Qwaya', 50000, '※구성\r\nartist : 콰야 | Qwaya\r\nmaterial : 세라믹 위 채색\r\nsize : 40*20*20mm\r\nweight : 50g\r\nshipment : 2-3일 (출고)', 'OBJECT', 'qwaya', 6, 'New', '30fcde2586044cf495afe23fcf31e17e.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('drop_pierre_flot', 'Drop Pierre ‘Flot’ - 보설', 54000, 'artist : 보설 | Boseol\r\nmaterial : Acrylic & varnish on stone\r\nsize : 90*120*80mm\r\nweight : 1kg\r\nshipment : 출고까지 최대 3일', 'OBJECT', 'boseol', 13, 'New', '6b3897dcd942434ba912770a09880022.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('ceramic_1', '주도하는 존재 - Shunita', 150000, '※구성\r\nartist : 슈니따 | Shunita\r\nmaterial : 점토, 세라믹 페인트\r\nsize : 140*110*80mm\r\nweight : 530g\r\nshipment : 2-3일(출고)', 'OBJECT', 'shunita', 4, 'New', 'a1449c4ffa9041c4adcba4d326e8d017.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('Tufting_Rug_E', 'Tufting Rug Edition(E) - 성립', 1500000, '※구성\r\nartist : 성립 | Seonglib\r\nmaterial : 터프팅\r\nsize : 120*150cm\r\nweight : 8kg\r\nshipment : 출고까지 최대 5-7일', 'TEXTILE', 'Seonglib_E', 9, 'New', '32e54846bbd3430aa0a726b4174097a4.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('Tufting_Rug', 'Tufting Rug Edition(D) - 성립', 1500000, '※구성\r\nartist : 성립 | Seonglib\r\nmaterial : 터프팅\r\nsize : 120*150cm\r\nweight : 8kg\r\nshipment : 출고까지 최대 5-7일', 'TEXTILE', 'Seonglib_D', 9, 'New', '5af5f55882624eaea873fa64f5a38bc4.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('Tufting_Mirror_s', 'Tufting_Mirror_s_Damda', 100000, 'artist : 담다 | Damda\r\nmaterial : 터프팅/아크릴 거울\r\nsize : 30*30cm\r\nweight : 1kg\r\nshipment : 2-3일(출고)', 'TEXTILE', 'Damda', 3, 'New', '8d264c7c7804475793660ee1a7c75625.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('Tufting_Mirror_l', 'Tufting Mirror (L) - Damda', 180000, 'artist : 담다 | Damda\r\nmaterial : 터프팅/아크릴 거울\r\nsize : 50*50cm\r\nweight : 1.5kg\r\nshipment : 2-3일(출고)', 'TEXTILE', 'Damda', 2, 'New', '9f417b217f154e5f9ded2f103a0a165f.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('grove_black_2', 'Grove (Black) 2 - FIVECOMMA', 168000, '※구성\r\nartist : FIVECOMMA\r\nmaterial : Mixed yarn by tapestry\r\nsize : 450*300mm\r\nweight : 250g\r\nshipment : 주문생산 (7-14일)', 'TEXTILE', 'fivecomma', 6, 'New', '3853cc4a9ea6464184f5c149611d32cf.jpg');
INSERT INTO `product` (`p_id`, `p_name`, `p_unitPrice`, `p_description`, `p_category`, `p_manufacturer`, `p_unitsInStock`, `p_condition`, `p_fileName`) VALUES ('colore_vase_1', 'coloré vase (yellow) - HUAXAUH', 105000, '※구성\r\nartist : 화아 | HUAXAUH\r\nmaterial : 특수사 와이어, 니팅\r\nsize : 90x90x140mm\r\nweight : 100g\r\nshipment : 2-3일(출고)', 'TEXTILE', 'HUAXAUH', 2, NULL, '503533c02e034c53bd55ec61f164ae0f.jpg');

