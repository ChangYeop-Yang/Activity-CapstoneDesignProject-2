# 종합설계프로젝트2 [ITEC402]
**[Capstone Design 2] Team Capstone Design Project. (Prof. 고석주)**

### ⌘ 프로젝트 사용할 오픈소스 기술 목록

- Philips Hue ::IOS -> Swift | Android -> Java::
[Philips Hue API](https://www.developers.meethue.com/)

### ⌘ 프로젝트 팀원 담당 기술 목록

- **경북대학교 IT대학 컴퓨터 학부 양창엽**  ::Mobile -> IOS | Network | Mobile UI/UX | HW::
yeop9657@naver.com (@ChangYeop-Yang)

- 경북대학교 IT대학 컴퓨터 학부 이재선  ::WEB -> Node.js | HW:: 
coldy24@gmail.com

- 경북대학교 IT대학 컴퓨터 학부 정의석  ::Mobile -> Android::
jesboom0635@naver.com

- 경북대학교 IT대학 컴퓨터 학부 허수호  ::WEB -> Node.js | HW::
conankids62@gmail.com

### ⌘ 프로젝트 상세 내용

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

### ⌘ 프로젝트 화면 구성도
|Page 001|Page 002|
|:----:|:----:|
|![001](https://user-images.githubusercontent.com/20036523/40636376-388887cc-62ee-11e8-9b98-c2f57e8bd988.png)|![002](https://user-images.githubusercontent.com/20036523/40636378-38e1ce40-62ee-11e8-807f-c799f485ae45.png)|

|Page 003|Page 004|
|:----:|:----:|
|![003](https://user-images.githubusercontent.com/20036523/40636379-3911d1da-62ee-11e8-9a5a-220463b7db8c.png)|![004](https://user-images.githubusercontent.com/20036523/40636380-393af16e-62ee-11e8-858e-85f87faa32b6.png)|

### ⌘ 프로젝트 구동 사진
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

### ⌘ 프로젝트 구현 목표
- [x] JavaScript Relational Database 기능 구현 (MySQL)
- [x] PHP Relational Database 기능 구현 (MySQL)
- [x] IOS Philips Hue 스마트 전구 연동 기능 구현
- [X] Arduino WIFI Remote Control 기능 구현
- [X] Arduino IR Remote Control 기능 구현 (TV, Air Condictioner, DVD player, Etc)
- [X] Arduino <-> IOS & Android Real Processing 기능 구현 (Notification)
- [X] BackUp Server <-> Main Server Database 자료 교환 기능 구현 (MySQL <-> SQLite3)

### ⌘ Project Links
[Google Drive - Project Resource](https://drive.google.com/open?id=1B94huR0b4-fvKvtiAtKstcIHRmp9_om-)
[Project Meeting Minutes](https://github.com/ChangYeop-Yang/CPL-20181-Team2/issues/7)
