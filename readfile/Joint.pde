class Joint {

  int type;
  float xpos, ypos;

  Joint(int _type, float _xpos, float _ypos) {
    type = _type;
    xpos = _xpos;
    ypos = _ypos;
  }

  float getX() { return xpos; }
  float getY() { return ypos; }
  int getType() { return type; }

  void display() {
    pushMatrix();
    translate(xpos, ypos);
    if(type == 0) {
      ellipse(0, 0, 60, 60); }
    else {
      ellipse(0, 0, 10, 10); }
    popMatrix();
  }
}

class JointHand extends Joint {
  int handState; //0~3
  JointHand(int _type, float _xpos, float _ypos, int _handState) {
    super(_type, _xpos, _ypos);
    handState = _handState;
  }

  float getX() { return xpos; }
  float getY() { return ypos; }
  int getType() { return type; }
  int getState() { return handState; }

  void display() {
    pushMatrix();
    setHandColor();
    translate(xpos, ypos);
    stroke(255,255,255);
    strokeWeight(3);
    ellipse(0, 0, 35, 35);
    noStroke();
    popMatrix();
  }

  void setHandColor() {
      switch(handState) {
      case 0:
        fill(0, 255, 0, 125);
      case 1:
        fill(255, 0, 0, 125);
        break;
      case 2:
        fill(255, 255, 0, 125);
        break;
      case 3:
        fill(255, 255, 255, 125);
        break;
      case 4:
        fill(255, 255, 255, 125);
        break;
      }
  }
}
