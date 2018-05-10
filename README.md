# 종합설계프로젝트2 [ITEC402]
**[Capstone Design 2] Team Capstone Design Project. (Prof. 고석주)**

### 프로젝트 사용할 오픈소스 기술 목록
- Firebase cloud Messageging :: IOS -> Swift | Android -> Java | WEB -> JavaScript
[FCM: 플랫폼을 가리지 않고 무료로 알림 전송](https://firebase.google.com/products/cloud-messaging/?hl=ko)

- Philips Hue :: IOS -> Swift | Android -> Java::
[Philips Hue API](https://www.developers.meethue.com/)

### 프로젝트 팀원 담당 기술 목록
- **경북대학교 IT대학 컴퓨터 학부 양창엽**  ::Mobile -> IOS | Network | Mobile UI/UX | HW::
yeop9657@naver.com (@ChangYeop-Yang)

- 경북대학교 IT대학 컴퓨터 학부 이재선  ::WEB -> Node.js | HW:: 
coldy24@gmail.com

- 경북대학교 IT대학 컴퓨터 학부 정의석  ::Mobile -> Android::
jesboom0635@naver.com

- 경북대학교 IT대학 컴퓨터 학부 허수호  ::WEB -> Node.js | HW::
conankids62@gmail.com

### 프로젝트 상세 내용

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

### 프로젝트 구현 목표
- [x] JavaScript Relational Database 기능 구현 (MySQL)
- [x] PHP Relational Database 기능 구현 (MySQL)
- [x] IOS Philips Hue 스마트 전구 연동 기능 구현
- [ ] Arduino WIFI Remote Control 기능 구현
- [ ] Arduino IR Remote Control 기능 구현 (TV, Air Condictioner, DVD player, Etc)
- [ ] Arduino <-> IOS & Android Real Processing 기능 구현 (Notification)
- [ ] BackUp Server <-> Main Server Database 자료 교환 기능 구현 (MySQL <-> SQLite3) 
