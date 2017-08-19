import processing.serial.*;
import processing.opengl.*;

Serial port;                         // The serial port
char[] teapotPacket = new char[14];  // InvenSense Teapot packet
int serialCount = 0;                 // current packet byte position
int synced = 0;
int interval = 0;

float[] accel = new float[6];
float[] temp = new float[6];
float[] motion = new float[3];
float threshold = 2000;
int time = 0;
int count = 0;
int limit = 2;
int bang = 0;

float bk = 0;

void init() {
  motion[0] = 0;
  motion[1] = 0;
  motion[2] = 0;
}

void setup() {
    // 300px square viewport using OpenGL rendering
    size(300, 300);
    println(Serial.list());

    // get the first available port (use EITHER this OR the specific port code below)
    String portName = Serial.list()[3];
    port = new Serial(this, portName, 115200);
    port.write('r');
}

void draw() {
  if (millis() - interval > 1000) {
    // resend single character to trigger DMP init/start
    // in case the MPU is halted/reset while applet is running
    port.write('r');
    interval = millis();
  }

  // black background
  bk -= bk * 0.2;
  background(bk);
  derivative();

}

void trigger() {
  bk = 255;
  println(bang++);
}

void serialEvent(Serial port) {
    interval = millis();
    while (port.available() > 0) {
        int ch = port.read();

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
                // derivative();
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
    trigger();
  }

  arrayCopy(accel, temp);

}

void debug() {
  if (accel[0] > 0.2
   || accel[0] < -0.2
   || accel[1] > 0.2
   || accel[1] < -0.2
   || accel[2] > 0.2
   || accel[2] < -0.2
  ) {
    print("x:\t" + accel[0] * 100 + "\t");
    print("y:\t" + accel[1] * 100 + "\t");
    println("z:\t" + accel[2] * 100);
  }
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
