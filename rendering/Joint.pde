class Joint {
  PGraphics canvas;

  int type;
  float xpos, ypos;

  Joint(int _type, float _xpos, float _ypos, PGraphics _canvas) {
    type = _type;
    xpos = _xpos;
    ypos = _ypos;
    canvas = _canvas;
  }

  float getX() { return xpos; }
  float getY() { return ypos; }
  int getType() { return type; }

  void display() {
    canvas.pushMatrix();
    canvas.translate(xpos, ypos);
    if(type == 0) {
      canvas.ellipse(0, 0, 60, 60); }
    else {
      canvas.ellipse(0, 0, 10, 10); }
    canvas.popMatrix();
  }
}

class JointHand extends Joint {
  int handState; //0~3
  JointHand(int _type, float _xpos, float _ypos, int _handState, PGraphics _canvas) {
    super(_type, _xpos, _ypos, _canvas);
    handState = _handState;
  }

  float getX() { return xpos; }
  float getY() { return ypos; }
  int getType() { return type; }
  int getState() { return handState; }

  void display() {
    canvas.pushMatrix();
    setHandColor();
    canvas.translate(xpos, ypos);
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
        canvas.fill(255, 255, 255, 125);
        break;
      }
  }
}