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