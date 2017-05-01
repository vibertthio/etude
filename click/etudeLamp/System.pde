/**
 * System
 * TODO
 * . blinking mode (in a period of time or blink specific time)
 * . pattern trigger
 * . piano mode (always enable)
 * . random mode
 * . multiple pattern
 *
 * ControlP5 panel
 * . first panel should be the mode radio
 * . there should be bang panel below radio
 */
class System {
  Light[] lights;
  int nOfLights = 6;

  // Modes
  boolean[] modes = {
    false, // sequence mode
    false, // blink mode
    false, // random mode
  };

  System() {
    lights = new Light[nOfLights];
    int middle = 400;
    int[] gap = {60, 200, 350};
    lights[0] = new Light(0, 0, middle - gap[2], 350, 90);
    lights[1] = new Light(0, 0, middle - gap[1], 320, 80);
    lights[2] = new Light(0, 0, middle - gap[0], 300, 70);
    lights[3] = new Light(0, 0, middle + gap[0], 300, 70);
    lights[4] = new Light(0, 0, middle + gap[1], 320, 80);
    lights[5] = new Light(0, 0, middle + gap[2], 350, 90);

  }

  void render() {
    canvas.beginDraw();
    canvas.background(0);

    // modes
    if (modes[0]) { // sequence
      turnSequence();
    }
    if (modes[1]) { // blink
      blinkAll();
    }
    if (modes[2]) {
      randomSequence();
    }

    for (int i = 0; i < nOfLights; i++) {
      lights[i].update();
      lights[i].render();
    }

    image(canvas, 400, 0);
    canvas.endDraw();
  }

  void turnOn() {
    for (int i = 0; i < nOfLights; i++) {
      lights[i].turnOn();
    }
  }

  void turnOn(int time) {
    for (int i = 0; i < nOfLights; i++) {
      lights[i].turnOn(time);
    }
  }

  void turnOneOn(int id) {
    lights[id].turnOn();
  }

  void turnOneOn(int id, int time) {
    lights[id].turnOn(time);
  }

  void turnOneOnFor(int id, int time, int dur) {
    lights[id].turnOnFor(time, dur);
  }

  void turnOff() {
    for (int i = 0; i < nOfLights; i++) {
      lights[i].turnOff();
    }
  }

  void turnOff(int time) {
    for (int i = 0; i < nOfLights; i++) {
      lights[i].turnOff(time);
    }
  }

  void turnOneOff(int id) {
    lights[id].turnOff();
  }

  void turnOneOff(int id, int time) {
    lights[id].turnOff(time);
  }

  void dimRepeat(int time, int ll) {
    for (int i = 0; i < nOfLights; i++) {
      lights[i].dimRepeat(time, ll);
    }
  }

  void blink() {
    for (int i = 0; i < nOfLights; i++) {
      lights[i].blink();
    }
  }

  void blink(int id) {
    lights[id].blink();
  }


  /**
   * Performance
   */
  void pianoTrigger(int id, int release) {
    turnOneOn(id);
    turnOneOff(id, release);
  }

  int turnSequenceTime = 100;
  int turnSequenceDur = 50;
  int turnSequenceIndex = 0;
  int turnSequenceCount = 0;
  int turnSequenceCountLimit = 5;
  int[][] sequenceSet = {
    { 0, 1, 2, 3, 4, 5 },
    { 2, 3, 1, 4, 0, 5 },
    { 5, 4, 3, 2, 1, 0 },
    { 0, 1, 0, 1, 5, 4, 5, 4, 3, 2, 3, 2 },
  };
  int[] sequence;
  void triggerSequenceMode(int index, int time) {
    turnOff();
    modes[0] = !modes[0];
    turnSequenceTime = time;
    sequence = sequenceSet[index%sequenceSet.length];
    turnSequenceIndex = 0;
    turnSequenceCount = 0;
  }
  void turnSequence() {
    turnSequenceCount++;
    if (turnSequenceCount > turnSequenceCountLimit) {
      turnOneOnFor(sequence[turnSequenceIndex], turnSequenceDur, turnSequenceTime);
      turnSequenceIndex = (turnSequenceIndex + 1) % sequence.length;
      turnSequenceCount = 0;
    }
  }

  int blinkCount = 0;
  int blinkCountLimit = 5;
  void triggerBlinkMode() {
    modes[1] = !modes[1];
  }
  void blinkAll() {
    blinkCount++;
    if (blinkCount > blinkCountLimit) {
      blink();
      blinkCount = 0;
    }
  }

  int randomCount = 0;
  int randomCountLimit = 5;
  int randomIndex = 0;
  int randomTime = 200;
  int randomDuration = 50;
  void triggerRandomMode() {
    modes[2] = !modes[2];
  }
  void randomSequence() {
    randomCount++;
    if (randomCount > randomCountLimit) {
      randomIndex = floor(random(nOfLights));
      turnOneOnFor(randomIndex, randomDuration, randomTime);
      randomCount = 0;
    }
  }
}
