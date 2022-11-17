# **Sopoom 쇼핑몰 사이트 제작 프로젝트**

<center> <img src = "Readme_img/1.png" width="800"> </center>
<br>

## **Description**
> 2022/08/09 → 2022/08/30
<br>

---

## **Info.**
- 5인 팀 프로젝트
- 회원가입, 장바구니, 찜하기, 탈퇴하기, 관리자 페이지 등의 기능이 있는 쇼핑몰 제작.
<br>

---
## **Summury**
### 개발 환경
<center> <img src = "Readme_img/4.png" width="800"> </center>

- 개발 언어: Java 11
- 동적 웹 구현: JSP (JavaServer Pages)
- DB: MariaDB, Mybatis
- Web Server: Apache tomcat 9
- IDA : Eclips
- 협업 / 디자인 툴 : Figma
<br>
---

### **Header** : User Role 에 따른 접근 페이지 변화

<center> <img src = "Readme_img/5.png" width="800"> </center>

- Role 에 상관 없는 접근 페이지 : 랜딩, 로그인, 상품 정보 페이지
- 관리자 기능: 상품 등록, 재고관리, 회원관리, 배송관리
- 회원 기능: 상품 주문, 쇼핑카트, 결제, 마이페이지 주문정보 확인
- 비회원 기능: 회원가입

### **User flow**

### **Database Schema**
<center> <img src = "Readme_img/6.png" width="800"> </center>

#### **Table**
User, Product, Cart, Order, Ordereditem, Shipping <br>
> 각 페이지에 필요한 기능을 User Flow Map 을 이용해 분석하고,<br>
> 그에 알맞는 기능을 팀원들과 논의 후 Table 을 구성하였다.<br>
> Cart Table을 따로 만들어 유저가 어떤 물건들을 카트에 담았다 뺐는지 기록을 남길 수 있게 함으로써 이후 추가적인 데이터 분석을 가능하도록 했다.<br>
> Sipping Table 을 따로 구상하여 관리자가 배송 준비를 효율적으로 관리하도록 하였다.

---
## **Contants**
<details>
<summary>로딩-랜딩 페이지</summary>
<div markdown="1">
안녕
</div>
</details>