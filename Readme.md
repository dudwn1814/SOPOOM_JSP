# **Sopoom: 쇼핑몰 사이트 제작 프로젝트**

<center> <img src = "Readme_img/1.png" width="800"> </center>
<br>

## 🗓**Period**
> 2022/08/09 - 2022/08/30
<br>

## ℹ️**Info.**
- 5인 팀 프로젝트
- 회원가입, 장바구니, 찜하기, 탈퇴하기, 관리자 페이지 등의 기능이 있는 쇼핑몰 제작.
<br>

## ✏️**Summury**

### **1. 개발 환경**
<center> <img src = "Readme_img/4.png" width="800"> </center>

    - 개발 언어: Java 11<br>
    - 동적 웹 구현: JSP (JavaServer Pages)<br>
    - DB: MariaDB, Mybatis<br>
    - Web Server: Apache tomcat 9<br>
    - IDA : Eclips<br>
    - 협업 / 디자인 툴 : Figma


### **2. Header** : User Role 에 따른 접근 페이지 변화
<center> <img src = "Readme_img/5.png" width="800"> </center>

    - Role 에 상관 없는 접근 페이지 : 랜딩, 로그인, 상품 정보 페이지
    - 관리자 기능: 상품 등록, 재고관리, 회원관리, 배송관리
    - 회원 기능: 상품 주문, 쇼핑카트, 결제, 마이페이지 주문정보 확인
    - 비회원 기능: 회원가입

### **3. Database Schema**: Table 설명
<center> <img src = "Readme_img/6.png" width="800"> </center>

#### **1. User**
> PK) userid
기본적인 유저 정보/주소 정보 저장 테이블


#### **2. Product**
> PK) p_id(제품id)
>
제품 정보와 관련된 img file의 경로를 저장하는 테이블


#### **3. Cart**
> FK) user table - userID, cart table - p_ID
>
유저가 카트에 담은 물건 정보를 저장하는 테이블

#### **4. Order**
> PK) orderID
>
주문한 유저 아이디와 총 주문 가격, 주문 날짜가 저장되는 테이블


#### **5. Ordereditem**
>FK) order table - orderID, product table - p_id

유저가 주문한 제품내역이 저장되는 테이블


#### **6. Shipping**
> PK) shipID FK)order table- orderID
>
주문한 유저의 기본적인 정보와 결제 완료 내역이 저장되는 테이블

## **Contants**

### **공통 기능**

<details>
<summary style="Font-Weight:800">로딩-랜딩 페이지</summary>
<div markdown="1">
<center> <img src = "Readme_img/7.png" width="800"> </center>
<center> <img src = "Readme_img/8.png" width="800"> </center>
</div>
</details>
<details>
<summary style="Font-Weight:800">카테고리 드롭다운 메뉴</summary>
<div markdown="1">
<center> <img src = "Readme_img/9.png" width="800"> </center>
</div>
</details>
<details>
<summary style="Font-Weight:800">제품 상세 페이지</summary>
<div markdown="1">
<center> <img src = "Readme_img/10.png" width="800"> </center>
</div>
</details>
<details>
<summary style="Font-Weight:800">로그인 / 회원가입</summary>
<div markdown="1">
<center> <img src = "Readme_img/11.png" width="800"> </center>
<center> <img src = "Readme_img/12.png" width="800"> </center>
<center> <img src = "Readme_img/13.png" width="800"> </center>
<center> <img src = "Readme_img/14.png" width="800"> </center>
<center> <img src = "Readme_img/15.png" width="800"> </center>
<center> <img src = "Readme_img/16.png" width="800"> </center>

</div>
</details>

---

### **회원 기능**
<details>
<summary style="Font-Weight:800">장바구니</summary>
<div markdown="1">

<center> <img src = "Readme_img/17.png" width="800"> </center>
<center> <img src = "Readme_img/18.png" width="800"> </center>
<center> <img src = "Readme_img/19.png" width="800"> </center>
<center> <img src = "Readme_img/20.png" width="800"> </center>
<center> <img src = "Readme_img/21.png" width="800"> </center>
<center> <img src = "Readme_img/22.png" width="800"> </center>
</div>
</details>

<details>
<summary style="Font-Weight:800">주문/결제</summary>
<div markdown="1">
<center> <img src = "Readme_img/23.png" width="800"> </center>
<center> <img src = "Readme_img/24.png" width="800"> </center>
</div>
</details>

<details>
<summary style="Font-Weight:800">마이페이지</summary>
<div markdown="1">
<center> <img src = "Readme_img/25.png" width="800"> </center>
<center> <img src = "Readme_img/26.png" width="800"> </center>
<center> <img src = "Readme_img/27.png" width="800"> </center>
</div>
</details>

<details>
<summary style="Font-Weight:800">배송 정보</summary>
<div markdown="1">
<center> <img src = "Readme_img/28.png" width="800"> </center>
<center> <img src = "Readme_img/29.png" width="800"> </center>
</div>
</details>

---

### **관리자 기능**
<details>
<summary style="Font-Weight:800">상품 등록</summary>
<div markdown="1">
<center> <img src = "Readme_img/30.png" width="800"> </center>
<center> <img src = "Readme_img/31.png" width="800"> </center>
</div>
</details>

<details>
<summary style="Font-Weight:800">재고 관리</summary>
<div markdown="1">
<center> <img src = "Readme_img/32.png" width="800"> </center>
<center> <img src = "Readme_img/33.png" width="800"> </center>

</div>
</details>

<details>
<summary style="Font-Weight:800">회원 관리</summary>
<div markdown="1">
<center> <img src = "Readme_img/34.png" width="800"> </center>
<center> <img src = "Readme_img/35.png" width="800"> </center>

</div>
</details>

<details>
<summary style="Font-Weight:800">배송 관리</summary>
<div markdown="1">
<center> <img src = "Readme_img/36.png" width="800"> </center>
</div>
</details>

---

### **이후 발전 방향**
1. 상세페이지 아래에 상품 리뷰란 추가
2. 카트에 담은 이후 취소하면 찜하기 항목에 추가 유도
3. 매출 분석 기능 추가

---

### 💻 **개발자**
**안영주**
<a href="https://github.com/dudwn1814" >
<img src="https://img.shields.io/badge/github-dudwn1814-lightgrey?style=for-the-badge&logo=Github&logoColor=white"  height="20"/></a>
> 전체적인 관리자 기능, 배송 정보, 찜하기, 렌딩 페이지
<br>

**한예규**
<a href="https://github.com/yegyu-han" >
<img src="https://img.shields.io/badge/github-yegyu_han-lightgrey?style=for-the-badge&logo=Github&logoColor=white"  height="20"/></a>
> 주문/결제, 로그인-로그아웃, 비밀번호 찾기, 헤더-풋터
<br>

**황서영**
<a href="https://github.com/Seo0H" >
<img src="https://img.shields.io/badge/github-Seo-lightgrey?style=for-the-badge&logo=Github&logoColor=white"  height="20"/></a>
> 장바구니, 마이페이지, 카테고리, 드롭다운 메뉴
<br>


**이하영**
<a href="https://github.com/glorialeezero" >
<img src="https://img.shields.io/badge/github-glorialeezero-lightgrey?style=for-the-badge&logo=Github&logoColor=white"  height="20"/></a>
> 전체적인 관리자 기능
<br>

**진민서**
<a href="https://github.com/jin0719" >
<img src="https://img.shields.io/badge/github-jin0719-lightgrey?style=for-the-badge&logo=Github&logoColor=white"  height="20"/></a>
> 렌딩 페이지, 제품 상세 페이지
<br>
