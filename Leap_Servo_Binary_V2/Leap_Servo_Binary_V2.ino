
#include <Servo.h> 

Servo myServoPan, myServoTilt;

const char HEADER = 'H';
const char MOUSE_TAG = 'M';
const int TOTAL_BYTES = 6;
const int moveMax = 12;
const int moveMin = 0;

int x,y, xAngle, yAngle, xAngleOld, yAngleOld;

void setup(){
  Serial.begin(9600);
  myServoPan.attach(10);
  myServoTilt.attach(9);
}

void loop(){
  if(Serial.available() >= TOTAL_BYTES){
    if(Serial.read() == HEADER){
      char tag = Serial.read();
      if(tag == MOUSE_TAG){
        x = Serial.read()*256;
        x = x+Serial.read();
        y = Serial.read()*256;
        y = y+Serial.read();
        xAngle = servoValue(x);
        yAngle = servoValue(y);
        moveServos();
        //printValues();
      }
      else{
        Serial.print("got message with unknown tag");
        Serial.write(tag);
      }
    }
  }
}

int servoValue (int reading){
  int readingEnd;
  if (reading >= 500){
    readingEnd = 170;
  }
  else if (reading <=100){
    readingEnd = 10;
  }
  else if (reading>100 && reading <500){
    readingEnd = map(reading, 100, 500, 10, 170);
  }
  return readingEnd;
}

void printValues(){
  Serial.print("Received msg, x = ");
  Serial.print(xAngle);
  Serial.print(", y = ");
  Serial.println(yAngle);
}

void moveServos(){
  if(abs(xAngleOld-xAngle) < moveMax && abs(xAngleOld-xAngle) > moveMin){
    myServoPan.write(xAngle);
  }
  if(abs(yAngleOld-yAngle) < moveMax && abs(yAngleOld-yAngle) > moveMin){
    myServoTilt.write(yAngle);
  }
  xAngleOld = xAngle;
  yAngleOld = yAngle;
}


