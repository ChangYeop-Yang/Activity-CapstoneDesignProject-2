#include <MFRC522.h>
#include <SoftwareSerial.h>
#include <SPI.h>
#include <Servo.h>

// MARK: - Digital Pin
enum DigitalPin {
  SS_DPIN = 10,
  RST_DPIN = 9,
  MOTER_DPIN = 8,
  BUTTON_DPIN = 4,
  LED_RED_DPIN = 6,
  LED_GREEN_DPIN = 5,
  LED_BLUE_DPIN = 7,
  S_DPIN = A5
};

// MARK: - Analog Pin
enum AnalogPin {
  VIBRATE_APIN = A0,
  BUZZER_APIN = A1
};

// MARK: - Button Variable
bool isBackUpState = false;

// MARK: - ESP8266 Variable
SoftwareSerial esp8266_Serial = SoftwareSerial(2, 3);

// MARK: - Servo Moter
Servo lockMoter;

// MARK: - RFID Variable
MFRC522 mfrc522(SS_DPIN, RST_DPIN);   // Create MFRC522 instance.

void setup() {
   Serial.begin(9600);
  
  /* setting ESP8266 WIFI Serial Module */
  esp8266_Serial.begin(9600);
  settingESP8266(true);

  /* setting RFID Module */
  SPI.begin();
  mfrc522.PCD_Init();

  /* setting Moter Mode */
  lockMoter.attach(MOTER_DPIN);
  
  /* setting Button Pin Mode */
  pinMode(BUTTON_DPIN, INPUT);

  /* setting Moter Pin Mode */
  pinMode(MOTER_DPIN, OUTPUT);

  /* setting Vibrate Pin Mode */
  pinMode(VIBRATE_APIN, INPUT);
  
  /* setting LED Module Degital Pin Mode */
  pinMode(LED_RED_DPIN,   OUTPUT);
  pinMode(LED_GREEN_DPIN, OUTPUT);
  pinMode(LED_BLUE_DPIN,  OUTPUT);
}

void loop() {

  // RFID MFRC522 Method
  checkTagRFID();

  // Check Push BackUP Button
  if (digitalRead(BUTTON_DPIN) == HIGH) {
    isBackUpState = true;
    Serial.println("- Enable send to back-up server.");
    controlLED(LED_GREEN_DPIN);
    tone(BUZZER_APIN, 3729, 1000);
  }

  // Check shock Detected
  if (HIGH == digitalRead(VIBRATE_APIN)) {
    tone(BUZZER_APIN, 6000, 2000);
    controlLED(LED_RED_DPIN);
    Serial.println("The Arduino shock detected.");
  }

  // Read data from client.
  if(esp8266_Serial.available()) {
     controlLED(LED_BLUE_DPIN);
     if (esp8266_Serial.find("+IPD")) {
        delay(1000);
        Serial.println(esp8266_Serial.read());
     }
  }
}

// MARK: - Operate Sub Motor Method
void operateMotor(bool degree) {
  if (degree) {
    for (int pos = 0; pos <= 180; pos += 10) {
      lockMoter.write(pos);
    }
  } else {
    for (int pos = 180; pos >= 0; pos -= 10) {
      lockMoter.write(pos);
    }
  }
}

// MARK: - Control LED Module Method
void controlLED(int color) {

  switch (color) {
    case LED_RED_DPIN: { 
      digitalWrite(LED_RED_DPIN, HIGH);
      delay(500);
      digitalWrite(LED_RED_DPIN, LOW);
      break; 
    }
    case LED_GREEN_DPIN: {
      digitalWrite(LED_GREEN_DPIN, HIGH);
      delay(500);
      digitalWrite(LED_GREEN_DPIN, LOW);
      break; 
    }
    case LED_BLUE_DPIN: { 
      digitalWrite(LED_BLUE_DPIN, HIGH);
      delay(500);
      digitalWrite(LED_BLUE_DPIN, LOW);
      break; 
    }
  }
}

// MARK: - RFID MFRC522 Method
void checkTagRFID() {

  // Check Look for new cards and Select one of the cards
  if ( !mfrc522.PICC_IsNewCardPresent() || !mfrc522.PICC_ReadCardSerial() ) {
    return;
  }
  
  String content= "";
  byte letter;
  for (byte i = 0; i < mfrc522.uid.size; i++) 
  {
     content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? "0" : " "));
     content.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  
  content.toUpperCase();
  if (findContains(content, "64 9C 46 EC")) {
    Serial.println("- Tagging RFID marster key.");
    Serial.print("- RFID UID TAG: ");  Serial.println(content);

    // Send to Back-up Server.
    if (isBackUpState) {
      delay(5000);
      sendSensorData("MarsterKey-64:9C:46:EC"); 
    }
  }
}

// Find String Method
bool findContains(String s, String search) {
    int max = s.length() - search.length();

    for (int i = 0; i <= max; i++) {
        if (s.substring(i) == search) return true; // or i
    }

    return false; //or -1
} 

// Setting ESP8266 Method
void settingESP8266(bool state) {

    // Setting ESP8266 Configuration
    esp8266_Serial.println("AT+RST\r");
    if ( esp8266_Serial.find("OK") ) {
      Serial.println("- ESP8266 module is operating success.");

      esp8266_Serial.println("AT+RST\r\n");
      esp8266_Serial.println("AT+CIOBAUD?\r\n");
      esp8266_Serial.println("AT+CWMODE=3\r\n");
      esp8266_Serial.println("AT+CWJAP=\"YCY-Android-Note7\",\"1q2w3e4r!\"\r\n");
      esp8266_Serial.println("AT+CIPMUX=1\r\n");
      esp8266_Serial.println("AT+CIPSERVER=1,80\r\n");
    }
}

// Send ESP8266 Method
bool sendSensorData(String rfidID) {

  const String backup_ServerURL = "yeop9657.duckdns.org";
  delay(5000);
  
  esp8266_Serial.println("AT+CIPSTART=\"TCP\",\"" + backup_ServerURL + "\",80\r");
  if ( esp8266_Serial.find("OK") ) {
    Serial.println("- HTTP TCP Connection Ready.");

    String query;
    query.concat("GET /outsideInsert.php?RFID=");  query.concat(rfidID);  query.concat("\r\n");

    delay(5000);
    const String sendCommand = "AT+CIPSEND=";
    esp8266_Serial.print(sendCommand);
    esp8266_Serial.println(query.length());

    if ( esp8266_Serial.find(">") ) {

      delay(500);
      Serial.println("- Please, Input GET Request Query.");
      esp8266_Serial.println(query);

      if ( esp8266_Serial.find("SEND OK") ) {
        Serial.println("- Success send server packet.");
      }
    }
  }
  esp8266_Serial.println("AT+CIPCLOSE\r\n");
}
