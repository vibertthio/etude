import processing.serial.*;
import processing.opengl.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Serial port;                         // The serial port
char[] teapotPacket = new char[14];  // InvenSense Teapot packet
int serialCount = 0;                 // current packet byte position
int synced = 0;
int interval = 0;

float[] accel = new float[6];
float[] temp = new float[6];
float[] motion = new float[3];
float threshold = 1000;
int time = 0;
int count = 0;
int limit = 2;
int bang = 0;
int sendAccelCount = 0;

float bk = 0;

String[] ports = {
  "/dev/cu.VT-HC-05-SPPDev",
  "/dev/tty.VT-HC-05-SPPDev",
  "/dev/cu.VT-HC-05-2-DevB",
  "/dev/tty.VT-HC-05-2-DevB",
  "na",
  "na",
};

void init() {
  motion[0] = 0;
  motion[1] = 0;
  motion[2] = 0;
}

void setup() {
    // 300px square viewport using OpenGL rendering
    size(300, 300);
    println(Serial.list());
    // Serial.list();
    // String portName = Serial.list()[3];
    // println(portName);
    try {
      port = new Serial(this, ports[2], 115200);
    } catch(Exception e) {
      println("catch:");
      e.printStackTrace();
      port = new Serial(this, ports[3], 115200);
    }
    port.write('r');

    // oscP5
    oscP5 = new OscP5(this,12000);
    myRemoteLocation = new NetAddress("169.254.114.53",3002);
    // myRemoteLocation = new NetAddress("127.0.0.1",3002);
}

void draw() {
  if (millis() - interval > 1000) {
    // resend single character to trigger DMP init/start
    // in case the MPU is halted/reset while applet is running
    port.write('r');
    interval = millis();
  }

  // black background
  bk -= bk * 0.1;
  background(bk);
  derivative();
  if (sendAccelCount++ > 1) {
    sendAccelOsc();
    sendAccelCount = 0;
  }
}

void trigger() {
  bk = 255;
}

void trigger(float value) {
  float v = map(value, 2000, 10000, 0, 255);
  bk = v;
  sendOsc("/strike", v);
}

int syncButton = 0;
int buttonId = 0;

void buttonEvent(int ch) {
  if (syncButton == 0 && ch == '*') {
    syncButton = 1;
  } else if (syncButton == 1 && ch == '#') {
    syncButton = 2;
  } else if (syncButton == 2 && (
    (ch > 47 && ch < 51)
  )) {
    buttonId = (ch - 48);
    syncButton = 3;
  } else if (syncButton == 3 && (ch == 'a' || ch == 'b')) {
    if (ch == 'a') {
      println("button #" + buttonId + ": on");
      syncButton = 0;
      sendOsc("/btn", buttonId, 1);
    }
    if (ch == 'b') {
      println("button #" + buttonId + ": off");
      syncButton = 0;
      sendOsc("/btn", buttonId, 0);
    }
    syncButton = 0;
  } else {
    syncButton = 0;
  }
}

void serialEvent(Serial port) {
    // println("-------------");
    interval = millis();
    while (port.available() > 0) {
        int ch = port.read();
        buttonEvent(ch);

        if (synced == 0 && ch != '$') return;   // initial synchronization - also used to resync/realign if needed
        synced = 1;
        //print ((char)ch);

        if ((serialCount == 1 && ch != 2)
            || (serialCount == 16 && ch != '\r')
            || (serialCount == 17 && ch != '\n'))  {
            serialCount = 0;
            synced = 0;
            return;
        }

        if (serialCount > 0 || ch == '$') {
            teapotPacket[serialCount++] = (char)ch;
            if (serialCount == 14) {
                serialCount = 0; // restart packet byte position

                // get quaternion from data packet
                accel[0] = ((teapotPacket[2] << 8) | teapotPacket[3]) / 16384.0f;
                accel[1] = ((teapotPacket[4] << 8) | teapotPacket[5]) / 16384.0f;
                accel[2] = ((teapotPacket[6] << 8) | teapotPacket[7]) / 16384.0f;
                accel[3] = ((teapotPacket[8] << 8) | teapotPacket[9]) / 16384.0f;
                accel[4] = ((teapotPacket[10] << 8) | teapotPacket[11]) / 16384.0f;
                accel[5] = ((teapotPacket[12] << 8) | teapotPacket[13]) / 16384.0f;
                for (int i = 0; i < 6; i++) {
                  if (accel[i] >= 2) accel[i] = -4 + accel[i];
                }
                // debug();
            }
        }
    }
}

void derivative() {
  motion[0] = motion[1];
  motion[1] = motion[2];

  float value = 0;
  int timeInterval = millis() - time;
  time = millis();
  for (int i = 0; i < 3; i++) {
    value += sq((accel[i] - temp[i]) * 1000 / float(timeInterval));
  }
  motion[2] = value;
  if (showValue) {
    println("value:" + value);
  }

  if ((motion[1] > motion[0]) &&
      (motion[1] > motion[2]) &&
      (motion[1] > threshold)
  ) {
    println("strike : " + motion[1]);
    trigger(motion[1]);
  }

  arrayCopy(accel, temp);

}

void debug() {
  // if (accel[0] > 0.2
  //  || accel[0] < -0.2
  //  || accel[1] > 0.2
  //  || accel[1] < -0.2
  //  || accel[2] > 0.2
  //  || accel[2] < -0.2
  // ) {
  //   print("x:\t" + accel[0] * 100 + "\t");
  //   print("y:\t" + accel[1] * 100 + "\t");
  //   println("z:\t" + accel[2] * 100);
  // }
  // println("accel:");
  // print("x:\t" + accel[0] * 100 + "\t");
  // print("y:\t" + accel[1] * 100 + "\t");
  // println("z:\t" + accel[2] * 100);
  // println("gyro:");
  // print("x:\t" + accel[3] * 10000 + "\t");
  // print("y:\t" + accel[4] * 10000 + "\t");
  // println("z:\t" + accel[5] * 10000);
}

boolean showValue = false;
void keyPressed() {
  if (key == ' ') {
    showValue = true;
  }
}

void keyReleased() {
  if (key == ' ') {
    showValue = false;
  }
}

void sendOsc(String h, float v) {
  // OscMessage osc = new OscMessage(h);
  // osc.add(v);
  // oscP5.send(osc, myRemoteLocation);
}
void sendOsc(String h, int i_1, int i_2) {
  // OscMessage osc = new OscMessage(h);
  // osc.add(i_1);
  // osc.add(i_2);
  // oscP5.send(osc, myRemoteLocation);
}
void sendAccelOsc() {
  // String head = "/accel";
  // OscMessage osc = new OscMessage(head);
  // osc.add(accel[0]);
  // osc.add(accel[1]);
  // osc.add(accel[2]);
  // osc.add(motion[1]);
  // osc.add(accel[3] * 10000);
  // osc.add(accel[4] * 10000);
  // osc.add(accel[5] * 10000);
  // oscP5.send(osc, myRemoteLocation);
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/hdl")) {
    if(theOscMessage.checkTypetag("i")) {
      int value = theOscMessage.get(0).intValue();
      value = floor(map(value, 0, 255, 0, 250));
      port.write(value);
    }
  }
}
