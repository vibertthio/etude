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

class Line {

  // A boundary is a simple rectangle with x,y,width,and height
  float x1;
  float y1;
  float x2;
  float y2;
  // But we also have to make a body for box2d to know about it
  Body b;
  float d;

  //color
  color boundColor = color (255, 255, 255);

  Line(float x1_,float y1_, float x2_, float y2_) {
    if (x1_ < x2_) {
      x1 = x1_;
      y1 = y1_;
      x2 = x2_;
      y2 = y2_;
    }
    else {
      x1 = x2_;
      y1 = y2_;
      x2 = x1_;
      y2 = y1_;
    }


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
    bd.angle = asin( -(y2 - y1) / d );
    bd.position.set(box2d.coordPixelsToWorld((x1 + x2)/2,(y1 + y2)/2));
    b = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    dotsLine(x1, y1, x2, y2, floor(d)/20);
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
