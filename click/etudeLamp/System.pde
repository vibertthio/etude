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
    false, // complex pattern mode
  };

  System() {
    lights = new Light[nOfLights];
    int middle = 400;
    int[] gap = {60, 200, 350};
    lights[0] = new Light(0, 0, middle - gap[2], 350, 90);
    lights[1] = new Light(1, 0, middle - gap[1], 320, 80);
    lights[2] = new Light(2, 0, middle - gap[0], 300, 70);
    lights[3] = new Light(3, 0, middle + gap[0], 300, 70);
    lights[4] = new Light(4, 0, middle + gap[1], 320, 80);
    lights[5] = new Light(5, 0, middle + gap[2], 350, 90);

  }

  void render() {
    canvas.beginDraw();
    canvas.background(0);

    // modes
    if (modes[0]) { // sequence
      sequenceMode();
    }
    if (modes[1]) { // blink
      blinkMode();
    }
    if (modes[2]) {
      randomMode();
    }
    if (modes[3]) {
      complexSequenceMode();
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

  int sequenceTime = 100;
  int sequenceDur = 50;
  int sequenceIndex = 0;
  int sequenceCount = 0;
  int sequenceCountLimit = 5;
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
    sequenceTime = time;
    sequence = sequenceSet[index%sequenceSet.length];
    sequenceIndex = 0;
    sequenceCount = 0;
  }
  void sequenceMode() {
    sequenceCount++;
    if (sequenceCount > sequenceCountLimit) {
      turnOneOnFor(sequence[sequenceIndex], sequenceDur, sequenceTime);
      sequenceIndex = (sequenceIndex + 1) % sequence.length;
      sequenceCount = 0;
    }
  }

  int blinkCount = 0;
  int blinkCountLimit = 5;
  void triggerBlinkMode() {
    modes[1] = !modes[1];
  }
  void blinkMode() {
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
  void randomMode() {
    randomCount++;
    if (randomCount > randomCountLimit) {
      randomIndex = floor(random(nOfLights));
      turnOneOnFor(randomIndex, randomDuration, randomTime);
      randomCount = 0;
    }
  }

  int complexSequenceTime = 300;
  int complexSequenceDur = 100;
  int complexSequenceIndex = 0;
  int complexSequenceCount = 0;
  int complexSequenceCountLimit = 20;
  int[][][] complexSequenceSet = {
    {
      {0, 5},
      {1, 4},
      {2, 3},
    },
    {
      {2, 3},
      {1, 4},
      {0, 5},
    },
  };
  int[][] complexSequence;
  void triggerComplexSequenceMode(int index) {
    modes[3] = !modes[3];
    complexSequence = complexSequenceSet[index%complexSequenceSet.length];
    complexSequenceIndex = 0;
    complexSequenceCount = 0;
  }
  void complexSequenceMode() {
    complexSequenceCount++;
    if (complexSequenceCount > complexSequenceCountLimit) {
      for (int i = 0, n = complexSequence[complexSequenceIndex].length; i < n; i++) {
        turnOneOnFor(complexSequence[complexSequenceIndex][i], complexSequenceDur, complexSequenceTime);
      }
      complexSequenceIndex = (complexSequenceIndex + 1) % complexSequence.length;
      complexSequenceCount = 0;
    }
  }
}
