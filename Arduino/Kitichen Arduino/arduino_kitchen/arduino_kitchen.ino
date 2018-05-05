#include <ESP8266Client.h>
#include <Timer.h>
#include <SoftwareSerial.h>
#include <math.h>

// MARK: - Define
#define GAS_LIMIT 1000
#define SOUND_LIMIT_NIGHT 10
#define SOUND_LIMIT_MORNING 43
#define CDS_LIMIT_LIGHT 450
#define CHECK_GAS_M(X) X >= GAS_LIMIT ? true : false

// MARK: - Digital Pin
enum DigitalPin {
  FLARE_DPIN = 6,
  BYZZER_DPIN = 8,
  BUTTON_DPIN = 7,
  LED_RED_DPIN = 13,
  LED_GREEN_DPIN = 12,
  LED_BLUE_DPIN = 11,
};

// MARK: - Analog Pin
enum AnalogPin {
  TEMPERATURE_APIN = 5,
  GAS_APIN = 4,
  SOUND_APIN = 3,
  CDS_APIN = 2,
};

// MARK: - Standard Lux Value
enum StandardCDS {
  BAD_ROOM_CDS = 15,
  KITCHEN_CDS = 150,
  LIVING_ROOM_CDS = 60
};

typedef struct flag {
  bool flare_Flag = false;
  bool byzzer_Flag = false;
  bool hotTemp_Flag = false;
  bool gas_Flag = false;
  bool backup_Flag = false;
} CFlag;

// MARK: - Global Variable
CFlag currentState;
Timer sensorTimer;

// MARK: - ESP8266 Variable
SoftwareSerial esp8266_Serial = SoftwareSerial(2, 3);
 
void setup ()
{ 
  Serial.begin(9600);
  
  /* setting Esp8266 WIFI Serial Module */
  esp8266_Serial.begin(9600);
  settingESP8266(true);
    
  /* setting controls the digital IO foot buzzer */
  pinMode (BYZZER_DPIN, OUTPUT);

  /* setting controls the digital IO flare */
  pinMode(FLARE_DPIN, INPUT);

  /* setting controls the digital IO LED */
  pinMode(LED_RED_DPIN, OUTPUT);
  pinMode(LED_GREEN_DPIN, OUTPUT);
  pinMode(LED_BLUE_DPIN, OUTPUT);

  /* setting read the digital button */
  pinMode(BUTTON_DPIN, INPUT);

  /* setting Collect Sensor Date Timmer */
  sensorTimer.every(60000, collectSensorDate);
}

void loop ()
{
  // MARK: - Sensing fire flare Mehod
  senseFlare();

  // MARK: - Sensing gas Method
  senseGas();

  // MARK: - Read Backup Button
  if (digitalRead(BUTTON_DPIN) == LOW) {
    currentState.backup_Flag = true;
    Serial.println("- Enable send to back-up server.");
  }

  // MARK: - Update Sensor Timer.
  sensorTimer.update();
}

// MARK: - Function
void collectSensorDate() {
  
  /* setting Analog Sound Timmer */
  int noise = senseAreaSound();

  /* setting Analog Temperature Timmer */
  int temputure = readingTemperatuer();

  /* setting Analog CDS Timmer */
  int brightness = collectCDS();

  /* Sending Data to Server Timmer */
  if (currentState.backup_Flag) {
    sendSensorData(temputure, brightness, noise); 
  }
}

void senseFlare() {

  // MARK: Sensing Fire
  currentState.flare_Flag = digitalRead(FLARE_DPIN);

  if (currentState.flare_Flag) {
    Serial.println("Sensing Dangerous Fire Flare...");

    while ( (currentState.flare_Flag = digitalRead(FLARE_DPIN)) ) {
      // Speak Byzzer
      for (int i = 0; i < 80; i++) {
        digitalWrite (BYZZER_DPIN, HIGH); delay (1);  // Delay 1ms
        digitalWrite (BYZZER_DPIN, LOW);  delay (1);  // Delay 1ms
        digitalWrite (LED_RED_DPIN, HIGH); delay (1); // Delay 1ms
      }
      for (int i = 0; i < 100; i++) {
        digitalWrite (BYZZER_DPIN, HIGH); delay (2) ;// Delay 2ms
        digitalWrite (BYZZER_DPIN, LOW);  delay (2) ;// Delay 2ms
        digitalWrite (LED_RED_DPIN, LOW); delay (2); // Delay 2ms
      } 
    } 
  }
}

int senseAreaSound() {

  int rawValue = analogRead(SOUND_APIN);
  int db = (rawValue + 83.2073) / 11.003;

  if (db < SOUND_LIMIT_MORNING && db > SOUND_LIMIT_NIGHT) {
    digitalWrite (LED_RED_DPIN, HIGH);  digitalWrite (LED_GREEN_DPIN, HIGH); delay(2);
    digitalWrite (LED_RED_DPIN, LOW);   digitalWrite (LED_GREEN_DPIN, LOW);
    Serial.println("[Night] Current room dB vary high!!!");
  } else if (db > SOUND_LIMIT_MORNING) {
    digitalWrite (LED_BLUE_DPIN, HIGH);  digitalWrite (LED_GREEN_DPIN, HIGH); delay(2);
    digitalWrite (LED_BLUE_DPIN, LOW);   digitalWrite (LED_GREEN_DPIN, LOW);
    Serial.println("[Mornig] Current room dB vary high!!!");
  }

  Serial.print("Current dB Value: "); Serial.println(db);

  return db;
}

void senseGas() {

  int rawADC = analogRead(GAS_APIN);
    
    if (CHECK_GAS_M(rawADC)) {
        
      currentState.gas_Flag = true;
      while (currentState.gas_Flag) {
        
        if (CHECK_GAS_M(rawADC) == false) {
          currentState.gas_Flag = false;
        }
        
        for (int i = 0; i < 80; i++) {
          digitalWrite (BYZZER_DPIN, HIGH); delay (2);  // Delay 1ms
          digitalWrite (BYZZER_DPIN, LOW);  delay (1);  // Delay 1ms
          digitalWrite (LED_RED_DPIN, HIGH); delay (1); // Delay 1ms
        }
        for (int i = 0; i < 100; i++) {
          digitalWrite (BYZZER_DPIN, HIGH); delay (1); // Delay 2ms
          digitalWrite (BYZZER_DPIN, LOW);  delay (2); // Delay 2ms
          digitalWrite (LED_RED_DPIN, LOW); delay (2); // Delay 2ms
        }
        
         Serial.println("Current Danger GAS PPM!!!");
         Serial.print( analogRead(GAS_APIN) ); Serial.println("PPM");
      }
    } 

    currentState.gas_Flag = false;
    return analogRead(GAS_APIN);
}

int readingTemperatuer() {

  int rawADC = analogRead(TEMPERATURE_APIN);
  
  double Temp;
  Temp = log(10000.0*((1024.0/rawADC-1))); 
  Temp = 1 / (0.001129148 + (0.000234125 + (0.0000000876741 * Temp * Temp ))* Temp );
  Temp = Temp - 273.15;            // Convert Kelvin to Celcius
  //Temp = (Temp * 9.0)/ 5.0 + 32.0; // Celsius to Fahrenheit - comment out this line if you need Celsius

  int celsius = (Temp-32) / 1.8;
  if (celsius >= 40) {
      digitalWrite(LED_RED_DPIN, HIGH);
      digitalWrite(LED_BLUE_DPIN, HIGH);
      Serial.println("The temperature of the room is too hot now.");
  }
  
  Serial.print("- Current Tempuerature = "); Serial.print(celsius); Serial.println("℃");
  return celsius;
}

int collectCDS() {

  int cdsValue = analogRead(CDS_APIN);
  Serial.print("- Current CDS: "); Serial.print(cdsValue); Serial.println("[Lx]");

  if (cdsValue >= CDS_LIMIT_LIGHT) {
    Serial.println("The room is current brightness very dark. (TURN OFF)");
    return cdsValue;
  }

  if (BAD_ROOM_CDS >= cdsValue) {
    Serial.println("The bad room is current good brightness.");
  } else if (LIVING_ROOM_CDS >= cdsValue) {
    Serial.println("The living room is current good brightness.");
  } else if (KITCHEN_CDS >= cdsValue) {
    Serial.println("The kitchen is current good brightness.");
  }

  return cdsValue;
}

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

bool sendSensorData(int temp, int cmd, int noise) {

  const String backup_ServerURL = "yeop9657.duckdns.org";
  delay(5000);
  
  esp8266_Serial.println("AT+CIPSTART=\"TCP\",\"" + backup_ServerURL + "\",80\r");
  if ( esp8266_Serial.find("OK") ) {
    Serial.println("- HTTP TCP Connection Ready.");

    String query;
    query.concat("GET /insert.php?TEMP=");  query.concat(temp);
    query.concat("&CMD=");                  query.concat(cmd);  
    query.concat("&NOISE=");                query.concat(noise);
    query.concat("&FLARE=");                query.concat(currentState.flare_Flag);
    query.concat("&GAS=");                  query.concat(analogRead(GAS_APIN));      query.concat("\r\n");

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
