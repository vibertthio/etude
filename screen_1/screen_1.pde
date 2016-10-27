import oscP5.*;
import netP5.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


//oscP5
OscP5 oscP5;
NetAddress myRemoteLocation;



//background
PImage backImg;
PImage cursor;

//constant
int numberOfData = 36;
int fRate = 20;
int timeSlot = 1000/fRate;
int numberOfMonitors = 0;
int maxNumberOfMonitors = 12;
int maxFrameNumber = 20000;
IntList idList;

//file list
String[] fileList = { "std_UpHand1",
                      "std_UpHand2",
                      "std_sideHands",
                      "std_grab",
                      "std_LiftLeg",
                      "U8221233"
                    };
String[] dateList = { "2016.1.23",
                      "2015.12.20",
                      "2015.2.5",
                      "2016.3.1",
                      "2016.5.10",
                      "2016.7.23"
                    };
boolean[] loadedList;

int[][][] dataStorage;
int[] fcount;

color etudeBack = color(32, 32, 32);
color[] etudeCircle = { color(163, 64, 82),  //red
                        //color(53, 163, 116),
                        color(1, 152, 117),  //green(adj)
                        color(83, 103, 157), //blue
                        color(34, 49, 63),
                      };
color[] etudeLine = { color(217, 156, 69),
                      color(32, 189, 256),
                      color(108, 65, 156),
                      color(255, 255, 255),
                    };
int backGroundColorIndex = 3;
int backGroundAlpha = 100;

color mainBackgroundColor = color(102, 51, 153);
color localBackGroundColor = color (34, 49, 63);
color cursorColor = color (242, 38, 19);
color textColor = color (247, 202, 24);



//UI design
Presets presets;
float xmouse, ymouse;
Metro metro;
Monitor[] monitors;
Monitor mChannel;


//state info
boolean newMonitor = true;
boolean dragging = false;
boolean drawLine = false;
boolean removeLine = false;
boolean adjustingSpeed = false;
boolean changeColor = false;
boolean selectingMonitor = false;
boolean firstColor = false;
boolean secondColor = false;
boolean thirdColor = false;
boolean physicsWork = true;


//text
//String fontType = "SansSerif";
String fontType = "ACaslonPro-BoldItalic";
int textSize = 20;
String msg;


//box2D
// A reference to our box2d world
Box2DProcessing box2d;
ArrayList lines;

//timer
TimeLine cursorTimer;
TimeLine textTimer;

//basics
void setup() {
  // String[] fontList = PFont.list();
  // println(fontList);

  frameRate(100);
  size(1920, 1080);
  // size(1080, 720);
  noCursor();

  //color Adjusting
  mainBackgroundColor = etudeBack;
  dataStorage = new int[fileList.length][maxFrameNumber][numberOfData];
  fcount = new int[fileList.length];
  loadedList = new boolean[fileList.length];
  for (boolean l : loadedList) {
    l = false;
  }

  presets = new Presets();

  /**********box2D***********/
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();

  // Add a bunch of fixed lines
  lines = new ArrayList();
  idList = new IntList();

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
  textTimer = new TimeLine(800);

  //oscP5
  oscP5 = new OscP5(this,9020);
  myRemoteLocation = new NetAddress("127.0.0.1",9020);

  //back image
  backImg = loadImage("layout_2.png");
  cursor = loadImage("paint.png");
  setupCursor();


}

void draw() {
  background(mainBackgroundColor);
  backgroundDots();
  noTint();

  //println("Global Time Count : " + float(millis())/1000 );
  //monitors
  for(int i=0; i<numberOfMonitors; i++) {

    if ( monitors[i].dissappear ) {
      idList.append(monitors[i].id);
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

  //drag draw control
  if (drawLine) {
    if (dragging) {
      dotsDashLine(xmouse, ymouse,
                   mouseX, mouseY,
                  floor(dist(xmouse, ymouse,
                             mouseX, mouseY))/40);
    }
  }
  else if (newMonitor) {
    if (dragging) {
      draggingDraw();
    }
  }

  //lines display
  for (int i = 0; i < lines.size(); i++) {
    Line line = (Line) lines.get(i);
    line.display();
  }

  //other information
  cursorRects();
  drawInfo();

}



//key and mouse events
void keyPressed() {
  boolean bang = false;

  if ( key == 'n') {
    newMonitor = ! newMonitor;
    bang = true;
  }
  if ( key == 't') {
    print("check");
    OscMessage osc = new OscMessage("/test");
    oscP5.send(osc, myRemoteLocation);
  }
  if ( key == 'z') {
    drawLine = true;
    bang = true;
  }
  if ( key == 'r') {
    removeLine = true;
    bang = true;
  }
  if ( key == 's') {
    adjustingSpeed = true;
    bang = true;
  }
  if ( key == 'c') {
    changeColor = true;
    bang = true;
  }
  if ( key == ' ') {
    if (removeLine) {
      clearLines();
    }
  }
  if ( key == 'm') {
    selectingMonitor = true;
    bang = true;
  }
  if ( key == 'p') {
    msg = "Trigger";
    triggerMonitors();
  }
  if ( key == 'l') {
    loadPreset();
  }
  if ( key == 'q') {
    firstColor = true;
    backGroundColorIndex = 0;
    localBackGroundColor = etudeCircle[0];
  }
  if ( key == 'w') {
    secondColor = true;
    backGroundColorIndex = 1;
    localBackGroundColor = etudeCircle[1];
  }
  if ( key == 'e') {
    thirdColor = true;
    backGroundColorIndex = 2;
    localBackGroundColor = etudeCircle[2];
  }
  if ( key == 'b') {
    physicsWork = !physicsWork;
  }
  if (bang)
    textTimer.startTimer();
}

void keyReleased() {
  if ( key == 'z') {
    drawLine = false;
    dragging = false;
  }
  if ( key == 'r') {
    removeLine = false;
  }
  if ( key == 's') {
    adjustingSpeed = false;
  }
  if ( key == 'c') {
    changeColor = false;
  }
  if ( key == 'm') {
    selectingMonitor = false;
  }
  if ( key == 'q') {
    firstColor = false;
    backGroundColorIndex = 3;
    localBackGroundColor = color (34, 49, 63);
  }
  if ( key == 'w') {
    secondColor = false;
    backGroundColorIndex = 3;
    localBackGroundColor = color (34, 49, 63);
  }
  if ( key == 'e') {
    thirdColor = false;
    backGroundColorIndex = 3;
    localBackGroundColor = color (34, 49, 63);
  }


  textTimer.turnOffTimer();
}

void mousePressed() {
  if(drawLine) {
    //
    dragging = true;
    xmouse = mouseX;
    ymouse = mouseY;
  }

  else {

    //monitor
    if(!newMonitor) {
      for(int i=0; i<numberOfMonitors; i++) {
        monitors[i].mousePressed(mouseX, mouseY);
      }
      for(int i =0, n=lines.size(); i<n; i++) {
        Line line = (Line) lines.get(i);
        line.detect(mouseX, mouseY);
      }
    }
    //new monitor
    else {
      mChannel.changeColor(backGroundColorIndex);
      if (numberOfMonitors < maxNumberOfMonitors) {
        dragging = true;
        xmouse = mouseX;
        ymouse = mouseY;
      }
    }

  }

}

void mouseReleased() {
  if(drawLine) {
    //
    lines.add(new Line(xmouse,ymouse,mouseX,mouseY));
    dragging = false;
  }
  else if(!newMonitor) {
    for(int i=0; i<numberOfMonitors; i++) {
      monitors[i].mouseReleased(mouseX, mouseY);
    }
    for(int i =0, n=lines.size(); i<n; i++) {
      Line line = (Line) lines.get(i);
      line.resetDragging();
    }
  }
  else {
    if (numberOfMonitors < maxNumberOfMonitors) {
      float x_max = max(xmouse, mouseX);
      float x_min = min(xmouse, mouseX);
      float y_max = max(ymouse, mouseY);
      float y_min = min(ymouse, mouseY);

      if ( y_max - y_min > 30) {
        int id;
        if (idList.size() != 0) {
          id = idList.get(0);
          idList.remove(0);
        }
        else {
          id = numberOfMonitors;
        }
        monitors[numberOfMonitors] =
          new Monitor(x_min, y_min,
                      int(x_max - x_min),
                      int(y_max - y_min),
                      id);
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
    if (removeLine) {
      for(int i =0, n=lines.size(); i<n; i++) {
        Line line = (Line) lines.get(i);
        if ( line.contains(mouseX, mouseY) != 0 ) {
          line.killBody();
          lines.remove(i);
          break;
        }
      }
    }
  }
}

void mouseDragged() {
  if (drawLine) {
    //
  }
  else if(!newMonitor) {
    for(int i=0; i<numberOfMonitors; i++) {
      monitors[i].mouseDragged(mouseX, mouseY);
    }
    for(int i =0, n=lines.size(); i<n; i++) {
      Line line = (Line) lines.get(i);
      line.update(mouseX, mouseY);
    }
  }
}

//box collision
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  int id1 = bodyForWhichMonitor(b1);
  int id2 = bodyForWhichMonitor(b2);

  println("o1 monitor id  : " + id1);
  println("o2 monitor id  : " + id2);

  String m;
  if ( id1 != -1 ) {
    m = "/p" + str(id1);
    if (id2 != -1 ) {
      m += "/frame";
    }
    else {
      m += "/edge";
      Line l = (Line) b2.getUserData();
      l.blink();
    }
  }
  else {
    m = "/p" + str(id2) + "/edge";
    Line l = (Line) b1.getUserData();
    l.blink();
  }

  OscMessage osc = new OscMessage(m);
  osc.add(1);
  oscP5.send(osc, myRemoteLocation);

}

//other functions
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
  strokeWeight(mChannel.lineWeight);
  noFill();
  rect(x_min, y_min,  x_max - x_min, y_max - y_min);
  mChannel.w_display = int(x_max - x_min);
  mChannel.h_display = int(y_max - y_min);
  mChannel.controlDotsDisplay();
  hwInfo(x_min, x_max, y_min, y_max);

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
  textAlign(CORNER, BOTTOM);
  textSize(textSize);
  String fr = "frameRate : " + str(frameRate);
  text(fr, 30, 40);
  if (textTimer.state) {
    //textSize(textSize);
    fill(textColor, 255 * (1 - textTimer.liner()));
    textAlign(CENTER, CENTER);
    // textAlign(LEFT, BOTTOM);

    // text( "Press 'n' to switch mode", 30, 40);
    // text( "(New Monitor) & (Adjusting Monitor)", 30, 70);
    // String fr = "frameRate : " + str(frameRate);
    // text(fr, 30, 100);

    textSize(6*textSize);
    if ( newMonitor ) {
      msg = "Create";
    }
    else if (drawLine) {
      msg = "Draw Line";
    }
    else if (removeLine) {
      msg = "Remove Line";
    }
    else if (adjustingSpeed) {
      msg = "Adjust Speed";
    }
    else if (changeColor) {
      msg = "Change Color";
    }
    else if (selectingMonitor) {
      msg = "Select Monitor";
    }
    else {
      if (msg != "Trigger")
        msg = "Edit";
    }

    // text( msg, 30, height - 40);
    text( msg, width/2, height/2);
  }
}
void backgroundDots() {
  int sz = 2;
  int x_offset = 5;
  int y_offset = 5;
  int distance = 42;
  int x_n = 47;
  int y_n = 28;
  int trans = 200;
  color dotsCol = color(255, 255, 255);
  stroke(dotsCol, trans);
  strokeWeight(sz);
  for(int i=0; i<x_n; i++) {
    for(int j=0; j<y_n; j++) {
      point(x_offset + i * distance, y_offset + j * distance);
    }
  }
}
void dotsLine(boolean horizon, float start, float end, float shift) {
  int sz = 1;
  int numberOfDots = 10;
  noStroke();
  fill(255);
  for(int i=1; i<numberOfDots; i++) {
    if(horizon) {
      ellipse( start + (end - start) * i / numberOfDots, shift, sz * 2, sz * 2);
    }
    else {
      ellipse(shift, start + (end - start) * i / numberOfDots, sz * 2, sz * 2);
    }
  }
}
void dotsLine(float x1, float y1, float x2, float y2) {
  int sz = 2;
  int numberOfDots = 10;
  noStroke();
  fill(255);
  for(int i=0; i<=numberOfDots; i++) {
    ellipse( x1 + ( x2 - x1 ) * i /numberOfDots,
             y1 + ( y2 - y1 ) * i /numberOfDots, sz * 2, sz * 2);
  }
}
void dotsLine(float x1, float y1, float x2, float y2, int n) {
  //dist / 20 would be a good choice
  int sz = 2;
  int numberOfDots = n;
  noStroke();
  fill(255);
  for(int i=0; i<=numberOfDots; i++) {
    ellipse( x1 + ( x2 - x1 ) * i /numberOfDots,
             y1 + ( y2 - y1 ) * i /numberOfDots, sz * 2, sz * 2);
  }
}
void dotsDashLine(float x1, float y1, float x2, float y2, int n) {
  int sz = 2;
  fill(255);
  for(float i=0; i<=n; i++) {
    noStroke();
    ellipse( x1 + ( x2 - x1 ) * i /n,
             y1 + ( y2 - y1 ) * i /n, sz * 2, sz * 2);
    stroke(255);
    strokeWeight(1);
    if(i<n){
      line(x1 + ( x2 - x1 ) * (i+0.25) /n,
           y1 + ( y2 - y1 ) * (i+0.25) /n,
           x1 + ( x2 - x1 ) * (i+0.75) /n,
           y1 + ( y2 - y1 ) * (i+0.75) /n);
    }
  }
}
void dotsDashLine(float x1, float y1, float x2, float y2, int n, color col, float transparency) {
  int sz = 2;
  fill(col, transparency);
  for(float i=0; i<=n; i++) {
    noStroke();
    ellipse( x1 + ( x2 - x1 ) * i /n,
             y1 + ( y2 - y1 ) * i /n, sz * 2, sz * 2);
    stroke(col, transparency);
    strokeWeight(1);
    if(i<n){
      line(x1 + ( x2 - x1 ) * (i+0.25) /n,
           y1 + ( y2 - y1 ) * (i+0.25) /n,
           x1 + ( x2 - x1 ) * (i+0.75) /n,
           y1 + ( y2 - y1 ) * (i+0.75) /n);
    }
  }
}
void hwInfo(float x_min, float x_max, float y_min, float y_max) {
  dotsLine(true, x_min, x_max, y_max + 30);
  dotsLine(false, y_min, y_max, x_min - 30);
  stroke(255);
  strokeWeight(1);
  line(x_min - 30, y_min, x_min - 15, y_min);
  line(x_min - 30, y_max, x_min - 15, y_max);
  line(x_min, y_max + 30, x_min, y_max + 15);
  line(x_max, y_max + 30, x_max, y_max + 15);
  textSize(20);
  fill(255);
  pushMatrix();
  translate(x_min - 18, (y_min + y_max) / 2);
  String t = "[ height : " + str(y_max - y_min) + " ]";
  textAlign(CENTER, CENTER);
  rotate(-PI/2);
  text(t, 0, 0);
  popMatrix();
}

void setupCursor() {
  cursorTimer = new TimeLine(300);
  cursorTimer.setLinerRate(1);
  cursorTimer.setLoop();
  cursorTimer.startTimer();
}
void cursorRects() {
  color cursorCol = color (254, 240, 53);
  rectMode(CENTER);
  imageMode(CENTER);
  image(cursor, mouseX, mouseY);
  float d = 16 + 8 * cursorTimer.liner();
  int l = 6;
  int w = 3;
  fill(cursorCol);
  noStroke();
  rect(mouseX, mouseY + d, w, l);
  rect(mouseX, mouseY - d, w, l);
  rect(mouseX + d, mouseY, l, w);
  rect(mouseX - d, mouseY, l, w);
}
void clearLines() {
  for(int i =0, n=lines.size(); i<n; i++) {
    Line line = (Line) lines.get(i);
    line.killBody();
  }
  lines.clear();
}
void triggerMonitors() {
  for (int i=0; i<numberOfMonitors; i++) {
    if (monitors[i].selected) {
      monitors[i].triggerPlay();
    }
  }
}
int bodyForWhichMonitor( Body body ) {
  Vec2 pos = box2d.getBodyPixelCoord(body);
  for (int i=0; i<numberOfMonitors; i++) {
    if (monitors[i].contain(pos.x, pos.y)) {
      return (monitors[i].id);
    }
  }
  return -1;
}

//Preset
int getId() {
  int id;
  if (idList.size() != 0) {
    id = idList.get(0);
    idList.remove(0);
  }
  else {
    id = numberOfMonitors;
  }
  return id;
}

void loadPreset() {
  for( int i = 0, n = presets.list.size(); i < n; i++) {
    if (numberOfMonitors < maxNumberOfMonitors) {
      int id = getId();
      monitors[numberOfMonitors] =
        new Monitor( presets.get(i), id);
      numberOfMonitors++;
    }
  }
}
