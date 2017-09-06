import dmxP512.*;
import processing.serial.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

DmxP512 dmxOutput;
int universeSize=128;

boolean LANBOX=false;
String LANBOX_IP="192.168.1.77";

boolean DMXPRO=true;
String DMXPRO_PORT="/dev/cu.usbserial-ENXKFAGI";//case matters ! on windows port must be upper cased.
int DMXPRO_BAUDRATE=115200;


void setup() {
  
  size(245, 245, JAVA2D);  
  
  dmxOutput=new DmxP512(this,universeSize,false);
  
  if(LANBOX){
    dmxOutput.setupLanbox(LANBOX_IP);
  }
  
  if(DMXPRO){
    dmxOutput.setupDmxPro(DMXPRO_PORT,115200);
  }
  
  oscP5 = new OscP5(this,12001);
    myRemoteLocation = new NetAddress("127.0.0.1",12001);
   
}

void draw() {    
  int nbChannel=6;  
  background(0);
  for(int i=0;i<nbChannel;i++){
    int value=(int)random(10)+((i%2==0)?mouseX:mouseY);
    //dmxOutput.set(5,Lvalue);
    fill(value);
    rect(0,i*height/10,width,(i+10)*height/10);    
  }
}
  void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/lnum/lVal")) {
    if(theOscMessage.checkTypetag("i")) {
      int lVal = theOscMessage.get(1).intValue();
      int lNum = theOscMessage.get(0).intValue();
      dmxOutput.set(lNum,lVal);
      //value = floor(map(value, 0, 255, 0, 250));
      //port.write(value);
    }
  }
  
}