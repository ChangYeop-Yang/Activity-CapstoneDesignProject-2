#include <MsTimer2.h>
#include <math.h>
#include <SoftwareSerial.h>

// MARK: - Define
#define GAS_LIMIT 1000
#define SOUND_LIMIT_NIGHT 10
#define SOUND_LIMIT_MORNING 43
#define CHECK_GAS_M(X) X >= GAS_LIMIT ? true : false

// MARK: - Digital Pin
enum DigitalPin {
  FLARE_DPIN = 7,
  BYZZER_DPIN = 8,
  LED_RED_DPIN = 13,
  LED_GREEN_DPIN = 12,
  LED_BLUE_DPIN = 11,
  BLUETOOTH_RX_DPIN = 2,
  BLUETOOTH_TX_DPIN = 3
};

// MARK: - Analog Pin
enum AnalogPin {
  TEMPERATURE_APIN = 5,
  GAS_APIN = 4,
  SOUND_APIN = 2
};

typedef struct flag {
  bool flare_Flag = false;
  bool byzzer_Flag = false;
  bool hotTemp_Flag = false;
  bool gas_Flag = false;
} CFlag;

// MARK: - Global Variable
CFlag currentState;
SoftwareSerial bluetoothSerial(BLUETOOTH_TX_DPIN, BLUETOOTH_RX_DPIN);
 
void setup ()
{ 
  Serial.begin(9600);

  /* setting bluetooth module */
  bluetoothSerial.begin(9600);
  bluetoothSerial.write("AT+NAMEArduino-Kitchen");
  bluetoothSerial.write("AT+PIN9311");
  
  /* setting controls the digital IO foot buzzer */
  pinMode (BYZZER_DPIN, OUTPUT);

  /* setting controls the digital IO flare */
  pinMode(FLARE_DPIN, INPUT);

  /* setting controls the digital IO LED */
  pinMode(LED_RED_DPIN, OUTPUT);
  pinMode(LED_GREEN_DPIN, OUTPUT);
  pinMode(LED_BLUE_DPIN, OUTPUT);

  /* setting Analog Temperature Timmer */
  MsTimer2::set(60000, readingTemperatuer);
  MsTimer2::start();

  /* setting Analog Sound Timmer */
  MsTimer2::set(60000, senseAreaSound);
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