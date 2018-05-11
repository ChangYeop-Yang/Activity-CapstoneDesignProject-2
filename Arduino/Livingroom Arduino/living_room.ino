
#include <ESP8266Client.h>
#include <Timer.h>
#include <SoftwareSerial.h>
#include <math.h>
#include<DHT.h>
#include <IRremote.h>     
DHT dht(5, DHT11);

// MARK: - Define
#define GAS_LIMIT 500
#define SOUND_LIMIT_NIGHT 10
#define SOUND_LIMIT_MORNING 43
#define CHECK_GAS_M(X) X >= GAS_LIMIT ? true : false
#define DEBUG true
#define CDS_LIMIT_LIGHT 450

// MARK: - Digital Pin
enum DigitalPin {
  
 
  BYZZER_DPIN = 7,
  Button_DPIN = 8,
  Gradient_DPIN = 4,
  LED_RED_DPIN = 13,
  LED_GREEN_DPIN = 12,
  LED_BLUE_DPIN = 11,
  IR_DPIN = 6
 };

// MARK: - Analog Pin
enum AnalogPin {
  
  GAS_APIN = 3,
  SOUND_APIN = 4,
  CDS_APIN = 2
};


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
Timer sensorTimer;

// MARK: - ESP8266 Variable
SoftwareSerial esp8266_Serial = SoftwareSerial(2, 3);

//IR_raw
unsigned int power[] = {4550,4400,600,1650,550,1650,600,1650,
550,550,600,500,600,550,550,550,600,500,600,1650,600,1600,600,
1650,550,550,600,500,600,550,600,500,600,500,650,450,650,1600,
600,500,650,450,650,500,600,500,600,500,600,550,600,1600,600,
500,650,1600,650,1550,650,1600,650,1550,650,1600,650,1600,600};

unsigned int S_mute[68]={4650,4350,650,1550,650,1550,700,1550,700,400,700,400,
700,400,700,450,650,450,650,1550,700,1500,700,1550,700,400,700,450,650,400,700,
450,700,400,700,1500,700,1550,650,1550,700,1500,700,450,700,400,700,400,700,400,
700,400,700,450,650,450,700,400,700,1500,700,1550,650,1550,700,1500,700};

unsigned int S_vup[68]={4600,4350,650,1550,700,1500,700,1550,700,400,700,
400,700,450,650,450,700,400,700,1500,700,1550,650,1550,700,400,700,400,700,
450,650,450,700,400,700,1500,700,1550,650,1550,700,400,700,450,700,400,700,
400,700,400,700,450,650,450,650,450,650,1550,700,1500,700,1550,700,1500,700,
1550,650};

unsigned int S_vdown[68]={4600,4350,700,1550,650,1550,700,1500,700,450,650,
450,700,400,700,400,700,400,700,1550,700,1500,700,1550,700,400,700,400,700,
400,700,450,650,450,650,1550,700,1500,700,450,650,1550,700,400,700,400,700,
450,700,400,700,400,700,400,700,1550,700,400,700,1500,700,1500,700,1550,700,
1500,700};
 // canais
 // channel up
 unsigned int S_cup[68]={4600,4350,700,1500,700,1500,700,1550,700,450,650,
 400,700,450,650,450,700,400,700,1500,700,1550,650,1550,700,450,650,450,700,
 400,700,400,700,400,700,400,700,1550,700,400,700,400,700,1550,650,450,700,
 400,700,400,700,1550,650,450,650,1600,650,1550,650,450,700,1500,700,1500,
 700,1550,650};
// channel down
 unsigned int S_cdown[68]={4650,4300,700,1550,700,1500,700,1550,700,400,700,
 400,700,400,700,450,650,450,650,1550,700,1500,700,1550,700,400,700,400,700,
 400,700,450,700,400,700,400,700,400,700,450,650,450,650,1550,700,400,700,
 450,650,400,700,1550,700,1500,700,1550,700,1500,700,400,700,1550,650,1550,
 700,1500,700};
 int pp = 1; //ir order
 
IRsend irsend;
 
void setup ()
{ 
  Serial.begin(9600);
  
  /* setting Esp8266 WIFI Serial Module */
  esp8266_Serial.begin(9600);
  settingESP8266(true);
    
  /* setting controls the digital IO foot buzzer */
  pinMode (BYZZER_DPIN, OUTPUT);
  pinMode (Button_DPIN, INPUT); 
  /* setting controls the digital IO flare */
  
  /* setting controls the digital IO LED */
  pinMode(LED_RED_DPIN, OUTPUT);
  pinMode(LED_GREEN_DPIN, OUTPUT);
  pinMode(LED_BLUE_DPIN, OUTPUT);

   pinMode(Gradient_DPIN,INPUT);
   pinMode (IR_DPIN , OUTPUT); 
  /* setting Collect Sensor Date Timmer */
  sensorTimer.every(60000, collectSensorDate);
}

void loop ()
{
 
  // MARK: - Sensing gas Method
  senseGas();
  
  senseGra();

  tvIR(pp);  
  
  sensorTimer.update();
}

void tvIR(int c){
  if(c==1){
    irsend.sendRaw(power,68,38);
  }
  else if(c==2){
    irsend.sendRaw(S_cup,68,38);
  }
  else if(c==3){
    irsend.sendRaw(S_cdown,68,38);
  }
  else if(c==4){
    irsend.sendRaw(S_vup,68,38);
  }else if(c==5){
    irsend.sendRaw(S_vup,68,38);
  }else if(c==6){
    irsend.sendRaw(S_vdown,68,38);
  }else if(c==7){
    irsend.sendRaw(S_vdown,68,38);
  }
}

// MARK: - Function
void collectSensorDate() {
  
  /* setting Analog Sound Timmer */
  int noise = senseAreaSound();

  /* setting Analog Temperature Timmer */
  int temputure = readingTemperatuer();
  
  /* setting Humidity Timmer */
  //int humidity = readingHumidity(); 

  int brightness = collectCDS();
  
 /* Sending Data to Server Timmer */
  sendSensorData(temputure,brightness,noise);
  
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
void senseGra(){
      int sensorstate = digitalRead(Gradient_DPIN);
           if(sensorstate){
                while (sensorstate) {
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
      //Serial.println("warnning warnnig!!");
      sensorstate = digitalRead(Gradient_DPIN);
    }
 }
 else{
    //Serial.println("current : 0"); 
    }
}

void senseGas() {

  int rawADC = analogRead(GAS_APIN);
     //Serial.println(rawADC);
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

   int celsius = dht.readTemperature();
  if (celsius >= 40) {
      digitalWrite(LED_RED_DPIN, HIGH);
      digitalWrite(LED_BLUE_DPIN, HIGH);
      Serial.println("The temperature of the room is too hot now.");
  }
  
  Serial.print("- Current Tempuerature = "); Serial.print(celsius); Serial.println("℃");
  return celsius;
}

//
//int readingHumidity() {
//  
//       int hum = dht.readHumidity();
//       Serial.print("- Current humidity = "); Serial.print(hum); Serial.println("%");
//       return hum;
//}

const String setESP8266(String command, const int timeout, boolean debug) {
  
    String response = "";
    esp8266_Serial.print(command); // send the read character to the esp8266
    
    long int time = millis();
    while( (time+timeout) > millis()) {
      while(esp8266_Serial.available()) {
        // The esp has data so display its output to the serial window 
        char c = esp8266_Serial.read(); // read the next character.
        response+=c;
      }
    }
    
    if(debug) {
      Serial.print(response);
    }
    
    return response;
}

void settingESP8266(bool state) {
if (state) {
     Serial.println("The ESP8266 is operating success.");
    
      // Setting ESP8266 Configuration
     setESP8266("AT+RST\r\n",2000,DEBUG); // reset module
     setESP8266("AT+CIOBAUD?\r\n",2000,DEBUG); // check baudrate (redundant)
     setESP8266("AT+CWMODE=3\r\n",1000,DEBUG); // configure as access point (working mode: AP+STA)
     //setESP8266("AT+CWLAP\r\n",3000,DEBUG); // list available access points
     esp8266_Serial.println("AT+CWJAP=\"YCY-Android-Note7\",\"1q2w3e4r!\"\r\n");
     //setESP8266("AT+CWJAP=\"AndroidHotspot0635\",\"05060506\"\r\n",5000,DEBUG); // join the access point
     setESP8266("AT+CIPMUX=1\r\n",1000,DEBUG); // configure for multiple connections
     setESP8266("AT+CIPSERVER=1,80\r\n",1000,DEBUG); // turn on server on port 80
     setESP8266("AT+CIFSR\r\n",1000,DEBUG); // get ip address
     setESP8266("AT+CIFSR\r\n",1000,DEBUG); // get ip address
     setESP8266("AT+CIFSR\r\n",1000,DEBUG); // get ip address
     
   }

}

bool sendSensorData(int temp, int hum, int noise) {
  Serial.println("send secction in");
  const String backup_ServerURL = "yeop9657.duckdns.org";
  delay(5000);
  
  esp8266_Serial.println("AT+CIPSTART=\"TCP\",\"" + backup_ServerURL + "\",80\r\n");
  if ( esp8266_Serial.find("OK") ) {
    Serial.println("- HTTP TCP Connection Ready.");

    String query;
    query.concat("GET /livingInsert.php?&TEMP=");  query.concat(temp);
    query.concat("&HUM=");                  query.concat(hum);  
    query.concat("&NOISE=");                query.concat(noise);
    query.concat("&GAS=");                  query.concat(analogRead(GAS_APIN));      query.concat("\r\n");
    
    
    delay(5000);
    const String sendCommand = "AT+CIPSEND=";
    esp8266_Serial.print(sendCommand);
   
    esp8266_Serial.println(query.length());
    
    if ( esp8266_Serial.find(">") ) {
      delay(500);
      Serial.println("- Please, Input GET Request Query.");
      esp8266_Serial.println(query);
      Serial.println(query);

      if ( esp8266_Serial.find("SEND OK") ) {
        Serial.println("- Success send server packet.");
      }
    }
  }
  
  
  esp8266_Serial.println("AT+CIPCLOSE\r");
}
