# ■ 종합설계프로젝트2 [ITEC402] - SAIOT
**[Capstone Design 2] Team Capstone Design Project. (Prof. 고석주)**

## ⌘ 프로젝트 추진 배경

- 정부-기업 주도의 4차산업혁명이 진행중인 상황에서 수많은 IoT제품 및 서비스가 
   개발되는 상황

- 상용화된 수많은 IoT제품들은 대부분 높은 가격, 표준 확립 없이 전용HW사용으로 인한 
   확장성 제한, 총괄적인 서비스 제공 부분에서 미흡

- IoT기술발전 및 신제품 개발은 빠르게 증가하나, 실 가정에서 사용률은 시장성장률보다 
   저조

## ⌘ 프로젝트 목표 및 내용

#### - 휴대폰 앱을 통하여 가정환경을 실시간으로 확인 가능한 시스템 구축
  -  3대의 아두이노 및 센서를 활용한 가정환경 실시간 측정
  -  아두이노서 측정된 정보를 Wifi로 라즈베리파이 웹서버로 전송
  -  휴대폰App에서 가정환경 확인을 위한 라즈베리파이 Web서버 접속, 정보전달
  -  가정환경에 특별한 일 발생시 휴대폰에 팝업 알람 기능 제공

 #### - 다양하고 통합적인 시스템 제공
  -  사용유저의 다양한 Mobile 사용환경을 고려해 Android, IOS Application 동시제공
  -  소리알람, 적외선리모콘, 무인택배함, 화재알람, 집안 출입정보, 집안 조명환경 등
     다양한 서비스 제공

 #### - 상용품을 활용한 확장성 및 저비용 환경 구축
  - 아두이노, 라즈베리 파이등, 기존의 상용품을 활용을 통한 저비용 시스템 구성
  - 상용품 활용을 통해 IoT서비스가 기본적으로 제공되지 않는 기존 건축물 등에 쉬운 적용 가능 
  - 상용품의 해당 표준규격을 사용하므로 표준화 달성 및 시스템 확장성 용이 
  
## ⌘ 프로젝트 사용할 오픈소스 기술 목록

|Open Source Name|Language|Model|URL|
|----------------|--------|-----|---|
|Philips HUE|Swift, Java|iOS, Android|[Philips Hue API URL](https://www.developers.meethue.com/)|
|Apple Core ML|Swift|iOS|[Apple Core ML URL](https://developer.apple.com/documentation/coreml)|

## ⌘ 프로젝트 팀원 및 담당 기술 목록

|School Name|Name|Responsibility|E-Mail|
|:----------:|:----:|:--------------:|:------:|
|OO 대학교 IT대학 컴퓨터학부|**양창엽**|Mobile - iOS, Server - PHP, Mobile - UI/UX, HW - Arduino|yeop9657@naver.com|
|OO 대학교 IT대학 컴퓨터학부|이 OO|WEB - Node.js, HW - Arduino|coldy24@gmail.com|
|OO 대학교 IT대학 컴퓨터학부|정 OO|Mobile - Android|jesboom0635@naver.com|
|OO 대학교 IT대학 컴퓨터학부|허 OO|HW - Arduino|conankids62@gmail.com|

## ⌘ 프로젝트 상세 내용

**1. Arduino Living**

Num|Module Name|Module Comment
---|-----------|--------------
001|IR 송신 센서|지정 된 채널의 IR을 송신하는 센서
002|대형 사운드 감지 센서|주변의 소리를 측정하는 센서
003|아날로그 온도 센서|주변의 온도를 측정하는 센서
004|부저 센서|소리를 발생시키는 센서
005|IR 수신 센서|주변의 기기로 부터 IR 채널을 입력받는 센서
006|가스 센서|일산화탄소 및 LPG가스의 농도를 측정하는 센서
007|Serial WIFI 모듈|Serial을 통하여 WIFI 통신을 지원하는 모듈
008|CDS 센서|주변의 조도를 측정하는 센서

* * *

**2. Arduino Kitchen**

Num|Module Name|Module Comment
---|-----------|--------------
001|불꽃 감지 센서|불꽃 및 스파크를 감지하는 센서
002|소형 사운드 감지 센서|주변의 소리를 측정하는 센서
003|아날로그 온도 센서|주변의 온도를 측정하는 센서
004|부저 센서|소리를 발생시키는 센서
005|3색 LED 센서|3색 LED를 발광하는 센서
006|가스 센서|일산화탄소 및 LPG가스의 농도를 측정하는 센서
007|Serial WIFI 모듈|Serial을 통하여 WIFI 통신을 지원하는 모듈
008|CDS 센서|주변의 조도를 측정하는 센서

* * *

**3. Arduino Outside**

Num|Module Name|Module Comment
---|-----------|--------------
001|모터 모듈|전력을 통하여 회전하는 모듈
002|Serial WIFI 모듈|Serial을 통하여 WIFI 통신을 지원하는 모듈
003|3색 LED 센서|3색 LED를 발광하는 센서
004|부저 센서|소리를 발생시키는 센서
005|충격 센서|충격을 감지하는 센서
006|카메라 모듈|주변을 촬영하는 모듈

## ⌘ 프로젝트 화면 구성도
|Page 001|Page 002|
|:----:|:----:|
|![001](https://user-images.githubusercontent.com/20036523/40636376-388887cc-62ee-11e8-9b98-c2f57e8bd988.png)|![002](https://user-images.githubusercontent.com/20036523/40636378-38e1ce40-62ee-11e8-807f-c799f485ae45.png)|

|Page 003|Page 004|
|:----:|:----:|
|![003](https://user-images.githubusercontent.com/20036523/40636379-3911d1da-62ee-11e8-9a5a-220463b7db8c.png)|![004](https://user-images.githubusercontent.com/20036523/40636380-393af16e-62ee-11e8-858e-85f87faa32b6.png)|

## ⌘ 프로젝트 구동 사진
|Photo 001|Photo 002|
|:------:|:------:|
|![PHILIPS HUE 1](https://user-images.githubusercontent.com/20036523/40636363-369ebd50-62ee-11e8-98bf-fa52d8b8d7ec.gif)|![PHILIPS HUE 2](https://user-images.githubusercontent.com/20036523/40636365-36cb6bb6-62ee-11e8-853b-2d554bf8b1c7.gif)|

|Photo 003|Photo 004|
|:-------:|:-------:|
|![CORE ML 1](https://user-images.githubusercontent.com/20036523/40636366-36f3a37e-62ee-11e8-80ba-248dd4f5ac18.gif)|![CORE ML 2](https://user-images.githubusercontent.com/20036523/40636367-371a6040-62ee-11e8-96e2-09c78aa7860c.gif)|

|Photo 005|Photo 006|
|:-------:|:-------:|
|![LOCK](https://user-images.githubusercontent.com/20036523/40636368-373fe3ec-62ee-11e8-831f-a077ca2c981b.gif)|![UNLOCK](https://user-images.githubusercontent.com/20036523/40636369-376e62f8-62ee-11e8-9030-c261c9cb3e85.gif)|

|Page 007|Page 008|
|:------:|:------:|
|![SENSOR](https://user-images.githubusercontent.com/20036523/40636371-37be88aa-62ee-11e8-847a-eddd54000faf.gif)|![CAMERA](https://user-images.githubusercontent.com/20036523/40636372-37e51880-62ee-11e8-899c-01b419ce1e9e.gif)|

## ⌘ 프로젝트 구현 목표
- [x] JavaScript Relational Database 기능 구현 (MySQL)
- [x] PHP Relational Database 기능 구현 (MySQL)
- [x] IOS Philips Hue 스마트 전구 연동 기능 구현
- [X] Arduino WIFI Remote Control 기능 구현
- [X] Arduino IR Remote Control 기능 구현 (TV, Air Condictioner, DVD player, Etc)
- [X] Arduino <-> IOS & Android Real Processing 기능 구현 (Notification)
- [X] BackUp Server <-> Main Server Database 자료 교환 기능 구현 (MySQL <-> SQLite3)

### ⌘ Project Links
- [Google Drive - Project Resource](https://drive.google.com/open?id=1B94huR0b4-fvKvtiAtKstcIHRmp9_om-)
- [Project Meeting Minutes](https://github.com/ChangYeop-Yang/CPL-20181-Team2/issues/7)
- [Naver Blog - Project Introduction](http://yeop9657.blog.me/221289605478)

## ★ Developer Information

|:rocket: Github QR Code|:pencil: Naver-Blog QR Code|:eyeglasses: Linked-In QR Code|
|:---------------------:|:-------------------------:|:----------------------------:|
|![](https://user-images.githubusercontent.com/20036523/50044128-60406880-00c2-11e9-8d57-ea1cb8e6b2a7.jpg)|![](https://user-images.githubusercontent.com/20036523/50044131-60d8ff00-00c2-11e9-818c-cf5ad97dc76e.jpg)|![](https://user-images.githubusercontent.com/20036523/50044130-60d8ff00-00c2-11e9-991a-107bffa2bf57.jpg)|
