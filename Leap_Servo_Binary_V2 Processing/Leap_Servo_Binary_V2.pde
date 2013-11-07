import processing.serial.*;
import com.onformative.leap.LeapMotionP5;
import processing.serial.*;
Serial port = null;
import javax.swing.JOptionPane;
LeapMotionP5 leap;

String portname = null;
public static final char HEADER = 'H';
public static final char MOUSE_TAG = 'M';

int fingerX, fingerY, fingerZ;

void setup()
{
  size(512, 512);
  openSerialPort();
  selectSerialPort();
  leap = new LeapMotionP5(this);
}

void draw() {
  getFingers();
  sendMessage(MOUSE_TAG, fingerX, fingerY);
  delay(10);
}

/*void serialEvent(Serial p) {
 String inString = port.readStringUntil('\n');
 if (inString != null) {
 print (inString);
 }
 }*/

void sendMessage(char tag, int x, int y) {
  println(x);
  port.write(HEADER);
  port.write(tag);
  port.write((char)(x / 256));
  port.write(x & 0xff);
  port.write((char)(y/256));
  port.write(y & 0xff);
}

void getFingers() {
  PVector fingerPos = leap.getTip(leap.getFinger(0));
  fingerX = int(fingerPos.x);
  fingerY = int(fingerPos.y);
  fingerZ = int(fingerPos.z);
  background(0);
  ellipse(fingerX, fingerY, fingerZ, fingerZ);
}


void openSerialPort()
{
  if (portname == null) return;
  if (port != null) port.stop();
  port = new Serial(this, portname, 9600);
  port.bufferUntil('\n');
}

void selectSerialPort()
{
  String result = (String) JOptionPane.showInputDialog(this, 
  "Select the serial port that corresponds to your Arduino board.", 
  "Select serial port", 
  JOptionPane.PLAIN_MESSAGE, 
  null, 
  Serial.list(), 
  0);

  if (result != null) {
    portname = result;
    openSerialPort();
  }
}

