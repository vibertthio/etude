color lightColor = color (239, 72, 54);

class Light {
  int id;
  float angle;
  float xpos;
  float ypos;
  float length = 300;
  float sz;

  TimeLine dimTimer;

  // state
  boolean repeatBreathing = false;

  // temperary
  boolean dimming = false;
  float alpha = 255;
  float targetAlpha;
  float initialAlpha;

  // blink function
  boolean blink = false;
  TimeLine turnOnTimer;
  int blinkLimit = 20;

  Light(int _id, float _a, float _x, float _y, float _sz) {
    id = _id;
    angle = _a;
    xpos = _x;
    ypos = _y;
    sz = _sz;

    // Timers
    dimTimer = new TimeLine(300);
    turnOnTimer = new TimeLine(50);
  }

  void update() {
    if (dimming) {
      float ratio = 0;
      if (repeatBreathing) {
        ratio = dimTimer.repeatBreathMovement();
      } else {
        ratio = dimTimer.liner();
      }

      alpha = initialAlpha +
      (targetAlpha - initialAlpha) * ratio;

      if (!dimTimer.state) {
        // alpha = targetAlpha;
        dimming = false;
        repeatBreathing = false;
      }
    } else if (blink) {
      if (turnOnTimer.liner() == 1) {
        turnOff(blinkLimit);
        blink = false;
      }
    }
  }

  void render() {
    if (controlling) {
      sendOSC();
    }
    canvas.pushMatrix();
    canvas.translate(xpos, ypos);

    canvas.noStroke();
    canvas.fill(lightColor, alpha);
    canvas.ellipse(0, 0, sz, sz);

    canvas.popMatrix();
  }

  void turnOn() {
    repeatBreathing = false;
    dimming = false;
    alpha = 255;
    initialAlpha = 255;
    targetAlpha = 255;
  }

  void turnOn(int time) {
    repeatBreathing = false;
    dimming = true;
    dimTimer.limit = time;
    dimTimer.startTimer();
    initialAlpha = alpha;
    targetAlpha = 255;
  }

  void turnOff() {
    repeatBreathing = false;
    dimming = false;
    alpha = 0;
    initialAlpha = 0;
    targetAlpha = 0;
  }

  void turnOff(int time) {
    repeatBreathing = false;
    dimming = true;
    dimTimer.limit = time;
    dimTimer.startTimer();
    initialAlpha = alpha;
    targetAlpha = 0;
  }

  void turnOnFor(int dur) {
    turnOnFor(dur, 20);
  }

  void turnOnFor(int dur, int time) {
    repeatBreathing = false;
    blink = true;
    blinkLimit = time;
    turnOnTimer.limit = dur;
    turnOnTimer.startTimer();
    turnOn(blinkLimit);
  }

  void blink() {
    turnOnFor(20);
  }

  void setLimit(int ll) {
    dimTimer.limit = ll;
  }

  // dim 3 times
  void dimRepeat(int time, int ll) {
    alpha = 0;
    repeatBreathing = true;
    dimming = true;
    initialAlpha = 0;
    targetAlpha = 255;
    dimTimer.limit = ll;
    dimTimer.repeatTime = time;
    dimTimer.breathState = false;
    dimTimer.startTimer();
  }
  void dimRepeatInverse(int time, int ll) {
    alpha = 255;
    repeatBreathing = true;
    dimming = true;
    initialAlpha = 255;
    targetAlpha = 0;
    dimTimer.limit = ll;
    dimTimer.repeatTime = time;
    dimTimer.breathState = false;
    dimTimer.startTimer();
  }

  // oscP5
  void sendOSC() {
    String head = "/l" + str(id);
    OscMessage osc = new OscMessage(head);
    osc.add(alpha);
    oscP5.send(osc,  myRemoteLocation);
  }
}