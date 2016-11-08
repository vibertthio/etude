#include "FastLED.h"
#define NUM_LEDS 192
#define DATA_PIN_1 5
#define DATA_PIN_2 6

const byte dim_curve[] = {
  0,   1,   1,   2,   2,   2,   2,   2,   2,   3,   3,   3,   3,   3,   3,   3,
  3,   3,   3,   3,   3,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4,
  4,   4,   4,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   6,   6,   6,
  6,   6,   6,   6,   6,   7,   7,   7,   7,   7,   7,   7,   8,   8,   8,   8,
  8,   8,   9,   9,   9,   9,   9,   9,   10,  10,  10,  10,  10,  11,  11,  11,
  11,  11,  12,  12,  12,  12,  12,  13,  13,  13,  13,  14,  14,  14,  14,  15,
  15,  15,  16,  16,  16,  16,  17,  17,  17,  18,  18,  18,  19,  19,  19,  20,
  20,  20,  21,  21,  22,  22,  22,  23,  23,  24,  24,  25,  25,  25,  26,  26,
  27,  27,  28,  28,  29,  29,  30,  30,  31,  32,  32,  33,  33,  34,  35,  35,
  36,  36,  37,  38,  38,  39,  40,  40,  41,  42,  43,  43,  44,  45,  46,  47,
  48,  48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,
  63,  64,  65,  66,  68,  69,  70,  71,  73,  74,  75,  76,  78,  79,  81,  82,
  83,  85,  86,  88,  90,  91,  93,  94,  96,  98,  99,  101, 103, 105, 107, 109,
  110, 112, 114, 116, 118, 121, 123, 125, 127, 129, 132, 134, 136, 139, 141, 144,
  146, 149, 151, 154, 157, 159, 162, 165, 168, 171, 174, 177, 180, 183, 186, 190,
  193, 196, 200, 203, 207, 211, 214, 218, 222, 226, 230, 234, 238, 242, 248, 255,
};

CRGB leds[1][NUM_LEDS];
int values[1][NUM_LEDS * 3];
int pd[5] = {7, 25, 25, 1, 2} ;
//int pd[5] = {20, 35, 30, 180, 2} ;
//int pd[5] = {18, 85, 20, 130, 2} ;
//訊號1.選擇圖案
//訊號2.控制訊號
//訊號3.亮度
//訊號4.特定
//訊號5.兩軌同步

float pd_temp[5]  ;

int t1 = 0;
float t2 = 0;
int t3 = 0;

int rgb_colors[3];
float pos[NUM_LEDS];


void setup() {
  FastLED.addLeds<WS2811, DATA_PIN_1, RGB>(leds[0], NUM_LEDS);
  FastLED.addLeds<WS2811, DATA_PIN_2, RGB>(leds[0], NUM_LEDS);
  Serial.begin(9600);
}

void loop() {
  int now = 0;
  while (Serial.available()) {
    int in = Serial.read();
    pd_temp[now] = in;

    if (now >= 4) {
      now = 0;
      for (int i = 0; i < 5; i++) {
        pd[i] = int(pd_temp[i]);
      }
    } else {
      now++;
    }
  }//讀取serial 訊號

  if (pd[0] == 1) {//black-------------------------------------------------

    for (int k = 0; k < 1; k++) {
      if (pd[1] == 1) {
        for (int i = 0; i < NUM_LEDS; i++) {
          values[k][i * 3] = pd[2];
          values[k][i * 3 + 1] = pd[2];
          values[k][i * 3 + 2] = pd[2];
        }
      } else {
        for (int i = 0; i < NUM_LEDS; i++) {
          values[k][i * 3] = 0;
          values[k][i * 3 + 1] = 0;
          values[k][i * 3 + 2] = 0;
        }
      }
    }

  } else if (pd[0] == 2) {//run-----------------------------------------
    float xx = cos((float(pd[1]) / float(255))  * 2 * 3.1415926);
    float yy = sin((float(pd[1]) / float(255))  * 2 * 3.1415926);
    float pospos = atan2(yy, xx);


    for (int i = 0; i < NUM_LEDS; i++) {
      float x = cos((float(i) / float(NUM_LEDS)) * 2 * 3.1415926);
      float y = sin((float(i) / float(NUM_LEDS)) * 2 * 3.1415926);
      float pos = atan2(y, x);
      float gray = (pos - pospos) * 180 / 3.1415926;
      if (gray < 0) {
        gray = 360 + gray;
      }

      if (gray < float(pd[3])) {
        gray = 1 - pow(abs((gray / float(pd[3])) - 0.5) * 2, 0.5);
      } else {
        gray = 0;
      }
      for (int k = 0; k < 1; k++) {
        if (k == 0) {
          values[k][i * 3]     =  int(float(pd[2]) * gray);
          values[k][i * 3 + 1] =  int(float(pd[2]) * gray);
          values[k][i * 3 + 2] =  int(float(pd[2]) * gray);
        } else {
          values[k][(NUM_LEDS - i) * 3]     =  int(float(pd[2]) * gray);
          values[k][(NUM_LEDS - i) * 3 + 1] =  int(float(pd[2]) * gray);
          values[k][(NUM_LEDS - i) * 3 + 2] =  int(float(pd[2]) * gray);
        }
      }
    }
  } else if (pd[0] == 3) {//purecolor-------------------------------------------------
    getRGB(pd[1], 255, pd[2], rgb_colors);

    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        values[k][i * 3]     =  rgb_colors[1];
        values[k][i * 3 + 1] =  rgb_colors[0];
        values[k][i * 3 + 2] =  rgb_colors[2];
      }
    }

  } else if (pd[0] == 4) {//只有一顆-------------------------------------------------
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        if (i == pd[1]) {
          values[k][i * 3]     =  pd[2];
          values[k][i * 3 + 1] =  pd[2];
          values[k][i * 3 + 2] =  pd[2];
        } else {
          values[k][i * 3]     =  0;
          values[k][i * 3 + 1] =  0;
          values[k][i * 3 + 2] =  0;
        }
      }
    }

  } else if (pd[0] == 5) {//白色音量-------------------------------------------------

    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        pos[i] = random(-10, 20);
        if (pd[1] > i) {
          values[k][i * 3]     = pd[2] + int(pos[i]);
          values[k][i * 3 + 1] = pd[2] + int(pos[i]);
          values[k][i * 3 + 2] = pd[2] + int(pos[i]);
        } else {
          values[k][i * 3]     = 0;
          values[k][i * 3 + 1] = 0;
          values[k][i * 3 + 2] = 0;
        }
      }
    }

  } else if (pd[0] == 6) {//彩色音量-------------------------------------------------
    t2 = sin(float(pd[1]) / NUM_LEDS - 1) * 43758.5453;
    if (t2 < 0) {
      t2 = t2 * -1;
    }
    t1 = int(t2) % 358;
    if (t1 < 0) {
      t1 = t1 * -1;
    }

    for (int k = 0; k < 1; k++) {
      getRGB( t1, 255, pd[2], rgb_colors);
      for (int k = 0; k < 1; k++) {
      }
      for (int i = 0; i < NUM_LEDS; i++) {
        if (pd[1] > i) {
          values[k][i * 3]     = rgb_colors[1];
          values[k][i * 3 + 1] = rgb_colors[0];
          values[k][i * 3 + 2] = rgb_colors[2];
        } else {
          values[k][i * 3]     = 0;
          values[k][i * 3 + 1] = 0;
          values[k][i * 3 + 2] = 0;
        }
      }
    }

  } else if (pd[0] == 7) {//star-------------------------------------------------

    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        int temp;
        pos[i] = random (0, pd[2]);
        temp = random(1, 30);
        if (temp > pd[1]) {
          values[k][i * 3]     = int(pos[i]);
          values[k][i * 3 + 1] = int(pos[i]);
          values[k][i * 3 + 2] = int(pos[i]);
        } else {
          values[k][i * 3]     = 0;
          values[k][i * 3 + 1] = 0;
          values[k][i * 3 + 2] = 0 ;
        }
      }
    }

  } else if (pd[0] == 8) {//zebra-------------------------------------------------
    t1 = (t1 + 1) % NUM_LEDS;
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        t3 = (i + t1) % pd[1];
        if (t3 > pd[3]) {
          values[k][i * 3]     = pd[2];
          values[k][i * 3 + 1] = pd[2];
          values[k][i * 3 + 2] = pd[2] ;
        } else {
          values[k][i * 3]     = int(float(pd[2]) * 0.2);
          values[k][i * 3 + 1] = int(float(pd[2]) * 0.2);
          values[k][i * 3 + 2] = int(float(pd[2]) * 0.2);
        }
      }
    }

  } else if (pd[0] == 9) {//RedGreen_center-------------------------------------------------
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        pos[i] = random(-5, 20);
        if (pd[1] > i) {
          values[k][i * 3]     = 0;
          values[k][i * 3 + 1] = pd[2] + int(pos[i]);//紅
          values[k][i * 3 + 2] = 0;
        } else if (pd[1] < i) {
          values[k][i * 3]     = int(float(pd[2]) * 0.5);
          values[k][i * 3 + 1] = int(float(pd[2]) * 0.1);
          values[k][i * 3 + 2] = pd[2] + int(pos[i]);//藍
        } else if (pd[1] == i) {
          values[k][i * 3]     = pd[2] ;
          values[k][i * 3 + 1] = pd[2] ;
          values[k][i * 3 + 2] = pd[2] ;
        }
      }
    }

  } else if (pd[0] == 10) {//ghost-------------------------------------------------
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        t1 = i - pd[1];
        if (t1 < 0) {
          t1 *= -1;
        }
        if (t1 > 20) {
          t1 = 20;
        }
        pos[i] = pow((20 - float(t1)) / 20, 3) * pd[2];

        if (t1 < 20) {
          values[k][i * 3]     = int(pos[i]);
          values[k][i * 3 + 1] = int(pos[i]);
          values[k][i * 3 + 2] = int(pos[i]);
        } else {
          values[k][i * 3]     = 0;
          values[k][i * 3 + 1] = 0;
          values[k][i * 3 + 2] = 0;
        }
      }
    }

  } else if (pd[0] == 11) {//blue+white-------------------------------------------------
    for (int k = 0; k < 1; k++) {
      t1 = (t1 + 1) % NUM_LEDS;
      for (int i = 0; i < NUM_LEDS; i++) {
        pos[i] = random(0, 5);
        t3 = (i + t1) % pd[1];
        if (t3 == 0) {
          values[k][i * 3]     =  int(float(pd[2]) * 1.5);
          values[k][i * 3 + 1] =  int(float(pd[2]) * 1.5);
          values[k][i * 3 + 2] =  int(float(pd[2]) * 1.5);
        } else {
          values[k][i * 3]     = int(float(pd[2]) * 0.3) + int(pos[i]);
          values[k][i * 3 + 1] = int(float(pd[2]) * 0.08) + int(pos[i]);
          values[k][i * 3 + 2] = int(float(pd[2]) * 0.7) + int(pos[i]);
        }
      }
    }
  } else if (pd[0] == 12) {// 彩虹 Rainbow-------------------------------------------------
    t1 = (t1 + pd[3]) % 255;
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        t2 = i / float(NUM_LEDS) * 255;
        t3 = ((int(t2) + t1) * pd[1]) % 255;
        getRGB(t3, 255, pd[2], rgb_colors);
        values[k][i * 3]     = rgb_colors[1];
        values[k][i * 3 + 1] = rgb_colors[0];
        values[k][i * 3 + 2] = rgb_colors[2];
      }
    }
  } else if (pd[0] == 13) {//ToCenter-------------------------------------------------
    t1 = (t1 + 1) % (NUM_LEDS / 2);
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        t3 = i - (NUM_LEDS / 2);
        if (t3 < 0) {
          t3 *= -1;
        }//distaance

        if (t3 - t1 <= pd[1] - 1 && t3 - t1 >= (-1 * (pd[1] - 1))) {
          values[k][i * 3]     = pd[2];
          values[k][i * 3 + 1] = pd[2];
          values[k][i * 3 + 2] = pd[2];
        } else {
          values[k][i * 3]     = 0;
          values[k][i * 3 + 1] = 0;
          values[k][i * 3 + 2] = 0;
        }
      }
    }

  } else if (pd[0] == 14) {//ToCenter_Invert-------------------------------------------------
    t1 = (t1 + 1) % (NUM_LEDS / 2);
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        t3 = i - (NUM_LEDS / 2);
        if (t3 < 0) {
          t3 *= -1;
        }//distaance

        if (t3 - t1 <= pd[1] - 1 && t3 - t1 >= (-1 * (pd[1] - 1))) {
          values[k][i * 3]     = 0;
          values[k][i * 3 + 1] = 0;
          values[k][i * 3 + 2] = 0;
        } else {
          values[k][i * 3]     = pd[2];
          values[k][i * 3 + 1] = pd[2];
          values[k][i * 3 + 2] = pd[2];
        }
      }
    }
  } else if (pd[0] == 15) {//red+blue_Gradient

    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        //t2 = pow((float((i) % (pd[1])) / float(pd[1])),2.0);
        t2 = (float((i) % (pd[1])) / float(pd[1]));
        between(t2, pd[2], rgb_colors);
        pos[i] = random(0, 20);
        if (t2 < 0.9 && t2 > 0.1) {
          values[k][i * 3]     = rgb_colors[1] + int(pos[i]);
          values[k][i * 3 + 1] = rgb_colors[0] + int(pos[i]);
          values[k][i * 3 + 2] = rgb_colors[2] + int(pos[i]);
        } else {
          values[k][i * 3]     = 0;
          values[k][i * 3 + 1] = 0;
          values[k][i * 3 + 2] = 0;
        }
      }
    }

  } else if (pd[0] == 16) {//blue+white-------------------------------------------------
    int tempseed;
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        pos[i] = random(0, 5);
        if (int(pos[i]) == 0) {
          tempseed = 1;
        } else if (int(pos[i]) == 1) {
          tempseed = int(float(pd[2]) * 1.5);
        } else if (int(pos[i]) == 2) {
          tempseed = int(float(pd[2]) * 1);
        } else if (int(pos[i]) == 3) {
          tempseed = 1;
        } else if (int(pos[i]) == 4) {
          tempseed = int(float(pd[2]) * 2);
        }

        if (i > pd[1] - 14 && i < pd[1] + 14) {
          values[k][i * 3]     =  tempseed;
          values[k][i * 3 + 1] =  tempseed;
          values[k][i * 3 + 2] =  tempseed;
        } else {
          values[k][i * 3]     =  0;
          values[k][i * 3 + 1] =  0;
          values[k][i * 3 + 2] =  0;
        }
      }
    }
  } else if (pd[0] == 17) {// 舉手
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        if (i > 0 && i < 96) {
          if (pd[1] > i) {
            values[k][i * 3]     = pd[2];
            values[k][i * 3 + 1] = pd[2];
            values[k][i * 3 + 2] = pd[2];

          } else if (pd[1] == i) {
            values[k][i * 3]     = 40;
            values[k][i * 3 + 1] = 60;
            values[k][i * 3 + 2] = 10;

          } else {
            values[k][i * 3]     = 3;
            values[k][i * 3 + 1] = 5;
            values[k][i * 3 + 2] = 1;
          }

        } else if (i >= 96 ) {
          if (pd[3] < i) {
            values[k][i * 3]     = pd[2];
            values[k][i * 3 + 1] = pd[2];
            values[k][i * 3 + 2] = pd[2];

          } else if (pd[3] == i) {
            values[k][i * 3]     = 40;
            values[k][i * 3 + 1] = 60;
            values[k][i * 3 + 2] = 10;

          } else {
            values[k][i * 3]     = 3;
            values[k][i * 3 + 1] = 5;
            values[k][i * 3 + 2] = 1;
          }
        }
      }
    }
  }// 舉手end
  else if (pd[0] == 18) {//摸頭
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        if (i > 0 && i < 48) {
          values[k][i * 3]     = 1;
          values[k][i * 3 + 1] = 1;
          values[k][i * 3 + 2] = 4;

        } else if (i >= 48 && i < 96) {
          if (pd[1] > i) {
            values[k][i * 3]     = pd[2];
            values[k][i * 3 + 1]     = pd[2];
            values[k][i * 3 + 2]     = pd[2];
          } else if (pd[1] == i) {
            values[k][i * 3]     = 0;
            values[k][i * 3 + 1]     = 60;
            values[k][i * 3 + 2]     = 0;
          } else {
            values[k][i * 3]     = 1;
            values[k][i * 3 + 1] = 1;
            values[k][i * 3 + 2] = 4;
          }

        } else if (i >= 96 && i < 144) {
          if (pd[3] < i) {
            values[k][i * 3]     = pd[2];
            values[k][i * 3 + 1]     = pd[2];
            values[k][i * 3 + 2]     = pd[2];
          } else if (pd[3] == i) {
            values[k][i * 3]     = 0;
            values[k][i * 3 + 1]     = 60;
            values[k][i * 3 + 2]     = 0;
          } else {
            values[k][i * 3]     = 1;
            values[k][i * 3 + 1] = 1;
            values[k][i * 3 + 2] = 4;
          }
        } else if (i >= 144) {
          values[k][i * 3]     = 1;
          values[k][i * 3 + 1] = 1;
          values[k][i * 3 + 2] = 4;
        }
      }
    }
  } //摸頭end
  else if (pd[0] == 19) {//握拳
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        if (i > 0 && i < 96) {
          values[k][i * 3]     = 1;
          values[k][i * 3 + 1] = pd[2];
          values[k][i * 3 + 2] = 1;
        } else if (i >= 96 ) {
          values[k][i * 3]     = 1;
          values[k][i * 3 + 1] = pd[3];
          values[k][i * 3 + 2] = 5;
        }
      }
    }
  }//握拳end
  else if (pd[0] == 20) {//抬腳
    for (int k = 0; k < 1; k++) {
      for (int i = 0; i < NUM_LEDS; i++) {
        if (i > 0 && i < 48) {
          if (pd[1] > i) {
            values[k][i * 3]     = pd[2];
            values[k][i * 3 + 1]     = pd[2];
            values[k][i * 3 + 2]     = pd[2];
          } else if (pd[1] == i) {
            values[k][i * 3]     = 0;
            values[k][i * 3 + 1] = 00;
            values[k][i * 3 + 2] = 60;
          } else {
            values[k][i * 3]     = 4;
            values[k][i * 3 + 1] = 1;
            values[k][i * 3 + 2] = 4;
          }

        } else if (i > 48 && i < 96) {
          values[k][i * 3]     = 4;
          values[k][i * 3 + 1] = 1;
          values[k][i * 3 + 2] = 4;

        } else if (i >= 96 && i < 144) {
          values[k][i * 3]     = 4;
          values[k][i * 3 + 1] = 1;
          values[k][i * 3 + 2] = 4;
        } else if (i > 144) {
          if (pd[3] < i) {
            values[k][i * 3]     = pd[2];
            values[k][i * 3 + 1] = pd[2];
            values[k][i * 3 + 2] = pd[2];
          } else if (pd[3] == i) {
            values[k][i * 3]     = 0;
            values[k][i * 3 + 1] = 0;
            values[k][i * 3 + 2] = 60;
          } else {
            values[k][i * 3]     = 4;
            values[k][i * 3 + 1] = 1;
            values[k][i * 3 + 2] = 4;
          }
        } else if (i == 48 || i == 144) {
          values[k][i * 3]     = 0;
          values[k][i * 3 + 1] = 00;
          values[k][i * 3 + 2] = 80;
        }
      }
    }
  }//抬腳 end

  for (int i = 0; i < NUM_LEDS; i++) {
    for (int k = 0; k < 1; k++) {
      leds[k][i] = CRGB(values[k][i * 3] , values[k][i * 3 + 1] , values[k][i * 3 + 2] );
    }
  }
  FastLED.show();
  delay(60);
}//loop_end---------------------------------------------------------------------------------------------------------



void between(float val, int bright, int colors[3]) {
  colors[0] = int(bright * (1.0 - val));
  colors[1] = int(0);
  colors[2] = int(bright * val * 1.5);
}



void getRGB(int hue, int sat, int val, int colors[3]) {
  val = dim_curve[val];
  sat = 255 - dim_curve[255 - sat];

  int r;
  int g;
  int b;
  int base;

  if (sat == 0) { // Acromatic color (gray). Hue doesn't mind.
    colors[0] = val;
    colors[1] = val;
    colors[2] = val;
  } else  {

    base = ((255 - sat) * val) >> 8;

    switch (hue / 60) {
      case 0:
        r = val;
        g = (((val - base) * hue) / 60) + base;
        b = base;
        break;

      case 1:
        r = (((val - base) * (60 - (hue % 60))) / 60) + base;
        g = val;
        b = base;
        break;

      case 2:
        r = base;
        g = val;
        b = (((val - base) * (hue % 60)) / 60) + base;
        break;

      case 3:
        r = base;
        g = (((val - base) * (60 - (hue % 60))) / 60) + base;
        b = val;
        break;

      case 4:
        r = (((val - base) * (hue % 60)) / 60) + base;
        g = base;
        b = val;
        break;

      case 5:
        r = val;
        g = base;
        b = (((val - base) * (60 - (hue % 60))) / 60) + base;
        break;
    }

    colors[0] = r;
    colors[1] = g;
    colors[2] = b;
  }
}
