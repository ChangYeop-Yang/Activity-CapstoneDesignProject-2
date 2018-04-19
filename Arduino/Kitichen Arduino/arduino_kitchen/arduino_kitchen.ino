#include <ESP8266.h>
#include <ESP8266Client.h>
#include <SoftwareSerial.h>
#include <MsTimer2.h>
#include <math.h>

// MARK: - Define
#define GAS_LIMIT 1000
#define SOUND_LIMIT_NIGHT 10
#define SOUND_LIMIT_MORNING 43
#define CDS_LIMIT_LIGHT 450
#define CHECK_GAS_M(X) X >= GAS_LIMIT ? true : false

// MARK: - Digital Pin
enum DigitalPin {
  FLARE_DPIN = 7,
  BYZZER_DPIN = 8,
  LED_RED_DPIN = 13,
  LED_GREEN_DPIN = 12,
  LED_BLUE_DPIN = 11,
};

// MARK: - Analog Pin
enum AnalogPin {
  TEMPERATURE_APIN = 5,
  GAS_APIN = 4,
  SOUND_APIN = 3,
  CDS_APIN = 2
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
} CFlag;

// MARK: - Global Variable
CFlag currentState;
SoftwareSerial esp8266_Serial = SoftwareSerial(4, 3);
ESP8266 wifi_Esp8266 = ESP8266(esp8266_Serial);
 
void setup ()
{ 
  Serial.begin(9600);

  /* setting Esp8266 WIFI Serial Module */
  esp8266_Serial.begin(9600);
  wifi_Esp8266.begin();
  wifi_Esp8266.setTimeout(1000);
  connectWIFI(wifi_Esp8266.test());
  
  /* setting controls the digital IO foot buzzer */
  pinMode (BYZZER_DPIN, OUTPUT);

  /* setting controls the digital IO flare */
  pinMode(FLARE_DPIN, INPUT);

  /* setting controls the digital IO LED */
  pinMode(LED_RED_DPIN, OUTPUT);
  pinMode(LED_GREEN_DPIN, OUTPUT);
  pinMode(LED_BLUE_DPIN, OUTPUT);

  /* setting Collect Sensor Date Timmer */
  MsTimer2::set(60000, collectSensorDate);
  MsTimer2::start();
}

void loop ()
{
  // MARK: - Sensing fire flare Mehod
  senseFlare();

  // MARK: - Sensing gas Method
  senseGas();
}

// MARK: - Function
void collectSensorDate() {
  
  /* setting Analog Sound Timmer */
  senseAreaSound();

  /* setting Analog Temperature Timmer */
  readingTemperatuer();

  /* setting Analog CDS Timmer */
  collectCDS();
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

void senseAreaSound() {

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
}

void readingTemperatuer() {

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
}

void collectCDS() {

  int cdsValue = analogRead(CDS_APIN);
  Serial.print("- Current CDS: "); Serial.print(cdsValue); Serial.println("[Lx]");

  if (cdsValue >= CDS_LIMIT_LIGHT) {
    Serial.println("The room is current brightness very dark. (TURN OFF)");
    return;
  }

  if (BAD_ROOM_CDS >= cdsValue) {
    Serial.println("The bad room is current good brightness.");
  } else if (LIVING_ROOM_CDS >= cdsValue) {
    Serial.println("The living room is current good brightness.");
  } else if (KITCHEN_CDS >= cdsValue) {
    Serial.println("The kitchen is current good brightness.");
  }
}

void connectWIFI(bool state) {

  if (state) {
    Serial.println("The successfully is operating WIFI(ESP8266) Module.");
    digitalWrite(LED_GREEN_DPIN, HIGH); delay(2000); digitalWrite (LED_GREEN_DPIN, LOW);
  }
}

