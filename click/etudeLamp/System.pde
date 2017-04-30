class System {
  Light[] lights;
  int nOfLights = 6;

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

    // turnEachOn
    if (turnEachOnActivate) {
      turnEachOn();
    }

    // turnSequence
    if (turnSequenceActivate) {
      turnSequence();
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

  boolean turnEachOnActivate = false;
  int turnEachOnTime = 0;
  int turnEachOnIndex = 0;
  int turnEachOnCount = 0;
  int turnEachOnCountLimit = 5;

  void triggerTurnEachOn(int time) {
    turnEachOnActivate = !turnEachOnActivate;
    turnEachOnTime = time;
  }

  void turnEachOn() {
    turnEachOnCount++;
    if (turnEachOnCount > turnEachOnCountLimit) {
      int prev = (turnEachOnIndex > 0)? (turnEachOnIndex - 1) : (nOfLights - 1);
      turnOneOn(turnEachOnIndex, turnEachOnTime);
      turnOneOff(prev, turnEachOnTime);
      turnEachOnIndex = (turnEachOnIndex + 1) % nOfLights;
      turnEachOnCount = 0;
    }
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

  boolean turnSequenceActivate = false;
  int turnSequenceTime = 0;
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

  void triggerSequence(int index, int time) {
    turnOff();
    turnSequenceActivate = !turnSequenceActivate;
    turnSequenceTime = time;
    sequence = sequenceSet[index%sequenceSet.length];
    turnSequenceIndex = 0;
    turnSequenceCount = 0;
  }

  void turnSequence() {
    turnSequenceCount++;
    if (turnSequenceCount > turnSequenceCountLimit) {
      int prev = (turnSequenceIndex > 0)? (turnSequenceIndex - 1) : (sequence.length - 1);
      turnOneOn(sequence[turnSequenceIndex], turnSequenceTime);
      turnOneOff(sequence[prev], turnSequenceTime);
      turnSequenceIndex = (turnSequenceIndex + 1) % sequence.length;
      turnSequenceCount = 0;
    }
  }


}
