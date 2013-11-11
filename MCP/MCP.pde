import processing.serial.*;

Pressure pressure;
Serial myPort;
int pose = 2;
void setup() { 
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  pressure = new Pressure(myPort);
}

void draw() {
//  checkUI();
pressure.doeverything(pose);
//  LEDFB();
//  AudioFB();
//  UIFB();
}


