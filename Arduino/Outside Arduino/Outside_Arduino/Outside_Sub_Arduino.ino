#include <L298N.h>

const int testButton = 8;
const int yellowLED = 13;

L298N myMotor(5, 6, 7);

void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600);

  pinMode(testButton, INPUT);
  pinMode(yellowLED, OUTPUT);

  myMotor.setSpeed(255);
}

void loop() {
  // put your main code here, to run repeatedly:

  if (digitalRead(testButton) == HIGH) {
    digitalWrite(yellowLED, HIGH); delay(500); digitalWrite(yellowLED, LOW);

    myMotor.forward();
    delay(3000);
    myMotor.stop();
  } 
}
