import oscP5.*;
import netP5.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


//oscP5
OscP5 oscP5;
NetAddress myRemoteLocation;

//file list
String[] fileList = { "U826190",
                      "U8301523",
                      "U8221233",
                      "U8301524",
                      "U8301538",
                      "U8301559"
                    };
//background
PImage backImg;


//constant
int numberOfData = 36;
int fRate = 20;
int timeSlot = 1000/fRate;
int numberOfMonitors = 0;
int maxNumberOfMonitors = 12;

int maxFrameNumber = 20000;

color etude1 = color(82, 74, 90);
color etude2 = color(82, 227, 90);
color etude3 = color(235, 74, 90);
color etude4 = color(82, 74, 243);

color mainBackgroundColor = color(102, 51, 153);
color localBackGroundColor = color (34, 49, 63);
color cursorColor = color (242, 38, 19);
color textColor = color (247, 202, 24);



//UI design
float xmouse, ymouse;
boolean newMonitor = true;

Metro metro;
Monitor[] monitors;
Monitor mChannel;

boolean dragging = false;

//text
String fontType = "SansSerif";
int textSize = 20;

/**********box2D***********/
// A reference to our box2d world
Box2DProcessing box2d;
ArrayList boundaries;




void setup() {
  frameRate(100);
  size(1920, 1080);
  //size(1500, 900);

  //color Adjusting
  mainBackgroundColor = etude1;


  /**********box2D***********/
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Add a bunch of fixed boundaries
  boundaries = new ArrayList();
  boundaries.add(new Boundary(width/2,height-5,width,10,0));
  boundaries.add(new Boundary(width/2,5,width,10,0));
  boundaries.add(new Boundary(width-5,height/2,10,height,0));
  boundaries.add(new Boundary(5,height/2,10,height,0));
  //boundaries.add(new BoundaryCircle(width/2, height/2, 20));

  //test
  //box = new Box(width/2,height/2);

  background(mainBackgroundColor);
  backgroundDots();
  monitors = new Monitor[maxNumberOfMonitors];
  mChannel = new Monitor(0, 0, 2, 2, -1);
  mChannel.changingRatio = false;

  //text
  PFont font = createFont (fontType, textSize, true);
  textFont(font, textSize);

  //oscP5
  oscP5 = new OscP5(this,9020);
  myRemoteLocation = new NetAddress("127.0.0.1",9020);

  //back image
  backImg = loadImage("layout_2.png");

}


void draw() {
  background(mainBackgroundColor);
  backgroundDots();
  noTint();
  // if(newMonitor)
  //   image(backImg, 5, 5, width, height);
  drawInfo();

  //println("Global Time Count : " + float(millis())/1000 );
  for(int i=0; i<numberOfMonitors; i++) {

    if ( monitors[i].dissappear ) {
      for (int j=i; j<numberOfMonitors - 1; j++) {
        monitors[j] = monitors[j+1];
      }
      numberOfMonitors--;
    }

    monitors[i].mouseSense(mouseX, mouseY);
    monitors[i].sendSound();
    monitors[i].rendor();
    monitors[i].display();
    monitors[i].boxUpdate(mouseX, mouseY);
  }


  if (newMonitor) {
    if (dragging) {
      draggingDraw();
    }
    drawCursorForNewMonitor();
  }



  /**********box2D***********/
  // box2d.step();

  // for (int i = 0; i < boundaries.size(); i++) {
  //   Boundary wall = (Boundary) boundaries.get(i);
  //   wall.display();
  // }


}


void keyPressed() {
  if( key == 'n') {
    newMonitor = ! newMonitor;
  }

  if (key == 't') {
    print("check");
    OscMessage osc = new OscMessage("/test");
    oscP5.send(osc, myRemoteLocation);
  }
}

void mousePressed() {
  //monitor
  if(!newMonitor) {
    for(int i=0; i<numberOfMonitors; i++) {
      monitors[i].mousePressed(mouseX, mouseY);
    }
  }
  //new monitor
  else {
    if (numberOfMonitors < maxNumberOfMonitors) {
      dragging = true;
      xmouse = mouseX;
      ymouse = mouseY;
    }
  }
}

void mouseReleased() {
  if(!newMonitor) {
    for(int i=0; i<numberOfMonitors; i++) {
      monitors[i].mouseReleased(mouseX, mouseY);
    }
  }
  else {
    if (numberOfMonitors < maxNumberOfMonitors) {
      float x_max = max(xmouse, mouseX);
      float x_min = min(xmouse, mouseX);
      float y_max = max(ymouse, mouseY);
      float y_min = min(ymouse, mouseY);

      if ( y_max - y_min > 20) {
        monitors[numberOfMonitors] =
          new Monitor(x_min, y_min,
                      int(x_max - x_min),
                      int(y_max - y_min),
                      numberOfMonitors);
        numberOfMonitors++;
        newMonitor = false;
      }
    }
    dragging = false;
  }
}

void mouseClicked() {
  if(!newMonitor) {
    for(int i=0; i<numberOfMonitors; i++) {
      monitors[i].mouseClicked(mouseX, mouseY);
    }
  }
  else { }
}

void mouseDragged() {
  if(!newMonitor) {
    for(int i=0; i<numberOfMonitors; i++) {
      monitors[i].mouseDragged(mouseX, mouseY);
    }
  }
  else { }
}

void draggingDraw() {
  rectMode(CORNER);
  float x_max = max(xmouse, mouseX);
  float x_min = min(xmouse, mouseX);
  float y_max = max(ymouse, mouseY);
  float y_min = min(ymouse, mouseY);

  mChannel.xpos = x_min;
  mChannel.ypos = y_min;
  noStroke();
  fill(localBackGroundColor, 255);
  rect(x_min, y_min, x_max - x_min, y_max - y_min);
  stroke(mChannel.lineColor);
  strokeWeight(mChannel.lineWeight/2);
  noFill();
  rect(x_min, y_min,  x_max - x_min, y_max - y_min);
  mChannel.w_display = int(x_max - x_min);
  mChannel.h_display = int(y_max - y_min);
  mChannel.controlDotsDisplay();
}

void drawCursorForNewMonitor() {
  stroke(cursorColor, 255);
  strokeWeight(mChannel.lineWeight);
  noFill();
  ellipse(mouseX, mouseY, mChannel.radiusOfControlDot*2, mChannel.radiusOfControlDot*2);
  noStroke();
}

void drawInfo() {
  fill(textColor);
  textSize(textSize);
  text( "Press 'n' to switch mode", 30, 40);
  text( "(New Monitor) & (Adjusting Monitor)", 30, 70);
  String fr = "frameRate : " + str(frameRate);
  text(fr, 30, 100);


  textSize(3*textSize);
  String msg;
  if ( newMonitor ) {
    msg = "Create";
  }
  else {
    msg = "Edit";
  }

  text( msg, 30, height - 40);
}

void backgroundDots() {
  int sz = 6;
  int x_offset = 5;
  int y_offset = 5;
  int distance = 42;
  int x_n = 47;
  int y_n = 28;
  int trans = 50;
  color dotsCol = color(255, 255, 255);
  stroke(dotsCol, trans);
  strokeWeight(sz);
  for(int i=0; i<x_n; i++) {
    for(int j=0; j<y_n; j++) {
      point(x_offset + i * distance, y_offset + j * distance);
    }
  }
}
