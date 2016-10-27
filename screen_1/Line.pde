class Line {

  // A boundary is a simple rectangle with x,y,width,and height
  float x1;
  float y1;
  float x2;
  float y2;
  // But we also have to make a body for box2d to know about it
  Body body;
  float d;
  int diameter = 10;

  //color
  color boundColor = color (255, 255, 255);

  //state
  boolean dragging1 = false;
  boolean dragging2 = false;

  TimeLine blink;
  color blinkColor = color(253, 57, 89);

  Line(float x1_,float y1_, float x2_, float y2_) {
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
    makeBody();
    blink = new TimeLine(500);
  }

  void makeBody() {
    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    d = dist(x1, y1, x2, y2);
    float box2dW = box2d.scalarPixelsToWorld(d/2);
    float box2dH = box2d.scalarPixelsToWorld(1);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = rotateAngle();//asin( -(y2 - y1) / d );
    bd.position.set(box2d.coordPixelsToWorld((x1 + x2)/2,(y1 + y2)/2));
    body = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    body.createFixture(sd,1);
    body.setUserData(this);

  }

  void killBody() {
    box2d.destroyBody(body);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(255, 150);
    noStroke();
    ellipse(x1, y1, diameter, diameter);
    ellipse(x2, y2, diameter, diameter);
    dotsDashLine(x1, y1, x2, y2, floor(d)/40);
    if (blink.state) {
      float t = 150 * (1 - blink.liner());
      fill(blinkColor, t);
      noStroke();
      ellipse(x1, y1, diameter, diameter);
      ellipse(x2, y2, diameter, diameter);
      dotsDashLine(x1, y1, x2, y2, floor(d)/40, blinkColor, t);
    }
  }

  float rotateAngle() {
    int k;
    if (x1 < x2) k = -1;
    else k = 1;
    return asin( (y2 - y1) * k / d );
  }

  int contains(float mX, float mY) {
    if ( dist(mX, mY, x1, y1) < 15 ) {
      return 1;
    }
    else if ( dist(mX, mY, x2, y2) < 15 ) {
      return 2;
    }
    return 0;
  }


  void detect(float mX, float mY) {
    int c = contains(mX, mY);
    switch(c) {
      case 1 :
        dragging1 = true;
        break;
      case 2 :
        dragging2 = true;
      default :
        break;
    }
  }

  void resetDragging() {
    dragging1 = false;
    dragging2 = false;
  }

  void update(float mX, float mY) {
    killBody();
    if (dragging1) {
      x1 = mX;
      y1 = mY;
    }
    else if (dragging2) {
      x2 = mX;
      y2 = mY;
    }
    makeBody();
  }
  void blink() {
    blink.startTimer();
  }

}
