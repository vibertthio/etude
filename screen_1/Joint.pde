class Joint {
  PGraphics canvas;

  PVector pos;
  int type;
  int handState = 0; //0~3
  //float xpos, ypos;

  Joint(int _type, float _xpos, float _ypos, PGraphics _canvas) {
    type = _type;
    // xpos = _xpos;
    // ypos = _ypos;
    canvas = _canvas;
    pos = new PVector (_xpos, _ypos);
  }
  Joint(int _type, float _xpos, float _ypos, PGraphics _canvas, int _handState) {
    type = _type;
    // xpos = _xpos;
    // ypos = _ypos;
    canvas = _canvas;
    pos = new PVector (_xpos, _ypos);
    handState = _handState;
  }

  float getX() { return pos.x; }
  float getY() { return pos.y; }
  int getType() { return type; }

  // void update(float x, float y) {
  //   pos.set(x, y);
  // }
  void update(int x, int y) {
    pos.set(x, y);
  }

  void display() {
    canvas.pushMatrix();
    canvas.translate(pos.x, pos.y);
    if(type == 0) {
      canvas.ellipse(0, 0, 60, 60); } //head
    else {
      canvas.ellipse(0, 0, 10, 10); }
    canvas.popMatrix();
  }
}

class JointHand extends Joint {
  // int handState; //0~3
  JointHand(int _type, float _xpos, float _ypos, int _handState, PGraphics _canvas) {
    super(_type, _xpos, _ypos, _canvas, _handState);
  }

  float getX() { return pos.x; }
  float getY() { return pos.y; }
  int getType() { return type; }
  int getState() { return handState; }

  // void update(float x, float y, int _handState) {
  //   super.update(x, y);
  //   handState = _handState;
  // }
  void update(int x, int y) {
    super.update(x, y);
  }
  void display() {
    canvas.pushMatrix();
    setHandColor();
    canvas.translate(pos.x, pos.y);
    canvas.stroke(255,255,255);
    canvas.strokeWeight(3);
    canvas.ellipse(0, 0, 35, 35);
    canvas.noStroke();
    canvas.popMatrix();
  }

  void setHandColor() {
      switch(handState) {
      case 0:
        canvas.fill(0, 255, 0, 125);
        break;
      case 1:
        canvas.fill(255, 0, 0, 125);
        break;
      case 2:
        canvas.fill(255, 255, 0, 125);
        break;
      case 3:
        canvas.fill(255, 255, 255, 125);
        break;
      case 4:
        canvas.fill(0, 255, 255, 125);
        break;
      }
  }
}
