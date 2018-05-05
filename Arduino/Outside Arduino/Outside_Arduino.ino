#include <MFRC522.h>
#include <SoftwareSerial.h>
#include <SPI.h>

// MARK: - Digital Pin
enum DigitalPin {
  SS_DPIN = 10,
  RST_DPIN = 9,
  IR_DPIN = 8,
  LED_RED_DPIN = 13,
  LED_GREEN_DPIN = 12,
  LED_BLUE_DPIN = 11,
};

// MARK: - ESP8266 Variable
SoftwareSerial esp8266_Serial = SoftwareSerial(2, 3);

// MARK: - RFID Variable
MFRC522 mfrc522(SS_DPIN, RST_DPIN);   // Create MFRC522 instance.

void setup() {
   Serial.begin(9600);
  
  /* setting Esp8266 WIFI Serial Module */
  esp8266_Serial.begin(9600);
  settingESP8266(true);

  /* setting RFID Module */
  SPI.begin();
  mfrc522.PCD_Init();

  /* setting Degital Pin Mode */
  pinMode(IR_DPIN, INPUT);

  pinMode(1, OUTPUT);
  pinMode(0, OUTPUT);
}

void loop() {

  // RFID MFRC522 Method
  checkTagRFID();

  delay(500);
  digitalWrite(1, HIGH);
  delay(500);
  digitalWrite(0, LOW);

  delay(500);
  digitalWrite(0, LOW);
  delay(500);
  digitalWrite(1, HIGH);
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
     content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
     content.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  
  content.toUpperCase();
  if (findContains(content, "64 9C 46 EC")) {
    Serial.println("- Tagging RFID marster key.");
    Serial.print("- RFID UID TAG: ");  Serial.println(content);
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
      
      esp8266_Serial.println("AT+CIOBAUD?\r\n");
      esp8266_Serial.println("AT+CWMODE=3\r\n");
      esp8266_Serial.println("AT+CWJAP=\"YCY-Android-Note7\",\"1q2w3e4r!\"\r\n");
      esp8266_Serial.println("AT+CIPMUX=0\r\n");
      esp8266_Serial.println("AT+CIPSERVER=1,80\r\n");
    }
}

// Send ESP8266 Method
bool sendSensorData(int temp, int cmd, int noise) {

  const String backup_ServerURL = "yeop9657.duckdns.org";
  delay(5000);
  
  esp8266_Serial.println("AT+CIPSTART=\"TCP\",\"" + backup_ServerURL + "\",80\r");
  if ( esp8266_Serial.find("OK") ) {
    Serial.println("- HTTP TCP Connection Ready.");

    String query;
//    query.concat("GET /insert.php?TEMP=");  query.concat(temp);
//    query.concat("&CMD=");                  query.concat(cmd);  
//    query.concat("&NOISE=");                query.concat(noise);
//    query.concat("&FLARE=");                query.concat(currentState.flare_Flag);
//    query.concat("&GAS=");                  query.concat(analogRead(GAS_APIN));      query.concat("\r\n");

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
  esp8266_Serial.println("AT+CIPCLOSE\r");
}
