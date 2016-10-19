// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A fixed boundary class (now incorporates angle)

class Boundary {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;
  // But we also have to make a body for box2d to know about it
  Body b;

  //color
  color boundColor = color (247, 202, 24);

 Boundary(float x_,float y_, float w_, float h_, float a) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = a;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(boundColor);
    noStroke();
    rectMode(CENTER);

    float a = b.getAngle();

    pushMatrix();
    translate(x,y);
    rotate(-a);
    rect(0,0,w,h);
    popMatrix();
  }

}

class BoundaryCircle extends Boundary {

  float r;
  BoundaryCircle ( float x_,float y_, float r_ ) {
    super(0, 0, 0, 0, 0);
    x = x_ ;
    y = y_ ;
    r = r_ ;

    // Define the polygon

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    b.createFixture(cs,1);
  }

  void display() {
    fill(boundColor);
    noStroke();

    pushMatrix();
    translate(x,y);
    ellipse(0,0,2 * r,2 * r);
    popMatrix();
  }

}

class Line {

  // A boundary is a simple rectangle with x,y,width,and height
  float x1;
  float y1;
  float x2;
  float y2;
  // But we also have to make a body for box2d to know about it
  Body b;
  float d;
  int diameter = 20;

  //color
  color boundColor = color (255, 255, 255);

  //state
  boolean dragging1 = false;
  boolean dragging2 = false;

  Line(float x1_,float y1_, float x2_, float y2_) {
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
    makeBody();
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
    b = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

  void killBody() {
    box2d.destroyBody(b);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(255, 150);
    noStroke();
    ellipse(x1, y1, diameter, diameter);
    ellipse(x2, y2, diameter, diameter);
    dotsDashLine(x1, y1, x2, y2, floor(d)/40);
  }

  float rotateAngle() {
    int k;
    if (x1 < x2) k = -1;
    else k = 1;
    return asin( (y2 - y1) * k / d );
  }

  int contains(float mX, float mY) {
    if ( dist(mX, mY, x1, y1) < diameter / 2 ) {
      return 1;
    }
    else if ( dist(mX, mY, x2, y2) < diameter / 2 ) {
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


}
