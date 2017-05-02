import codeanticode.syphon.*;
import controlP5.*;
import oscP5.*;
import netP5.*;

//oscP5
OscP5 oscP5;
NetAddress myRemoteLocation;

// controlP5
ControlP5 cp5;
Accordion accordion;

PGraphics canvas;

System system;

color c = color(0, 160, 100);

void settings() {
  size(1400, 800, P3D);
  PJOGL.profile=1;
}

void setup() {
  background(20);
  canvas = createGraphics(800, 800, P3D);
  system = new System();

  // oscP5
  oscP5 = new OscP5(this,3000);
  myRemoteLocation = new NetAddress("169.254.42.145", 7300);

  gui();
}

void draw() {
  background(0);
  system.render();
}

void keyPressed() {
  if (int(key) >= 49 && int(key) <= 54) {
    system.pianoTrigger(int(key) - 49, 300);
  }
  if (key == '7') {
    system.blink();
  }
  if (key == '8') {
    println("press");
  }
}

void mousePressed() {

}


void gui() {

  cp5 = new ControlP5(this);

  // group number 1, contains 2 bangs
  Group g1 = cp5.addGroup("dim/blink")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(200)
  ;

  int[][] pos = {
    {10, 20},
    {30, 20},
  };
  cp5.addBang("dim on")
    .setPosition(10,20)
    .setSize(20,20)
    .moveTo(g1)
    .setId(0)
  ;
  cp5.addBang("dim off")
    .setPosition(10,70)
    .setSize(20,20)
    .moveTo(g1)
    .setId(1)
  ;
  cp5.addBang("bang_2")
    .setPosition(10,120)
    .setSize(20,20)
    .moveTo(g1)
    .setId(2)
  ;
  cp5.addBang("bang_3")
    .setPosition(50,20)
    .setSize(20,20)
    .moveTo(g1)
    .setId(3)
  ;
  cp5.addBang("bang_4")
    .setPosition(50,70)
    .setSize(20,20)
    .moveTo(g1)
    .setId(4)
  ;
  cp5.addBang("bang_5")
    .setPosition(50,120)
    .setSize(20,20)
    .moveTo(g1)
    .setId(5)
  ;
  cp5.addBang("bang_6")
    .setPosition(90,20)
    .setSize(20,20)
    .moveTo(g1)
    .setId(6)
  ;
  cp5.addBang("bang_7")
    .setPosition(90,70)
    .setSize(20,20)
    .moveTo(g1)
    .setId(7)
  ;
  cp5.addBang("bang_8")
    .setPosition(90,120)
    .setSize(20,20)
    .moveTo(g1)
    .setId(8)
  ;

  // group number 2
  Group g2 = cp5.addGroup("modes")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150)
  ;


  cp5.addToggle("m1")
    .setPosition(10,20)
    .setSize(20,20)
    .moveTo(g2)
  ;
  cp5.addToggle("m2")
    .setPosition(35,20)
    .setSize(20,20)
    .moveTo(g2)
  ;
  cp5.addToggle("m3")
    .setPosition(60,20)
    .setSize(20,20)
    .moveTo(g2)
  ;

  // create a new accordion
  // add g1, g2, and g3 to the accordion.
  accordion = cp5.addAccordion("acc")
              .setPosition(40,40)
              .setWidth(200)
              .addItem(g1)
              .addItem(g2)
  ;

  accordion.open(0, 1);

  // use Accordion.MULTI to allow multiple group
  // to be open at a time.
  accordion.setCollapseMode(Accordion.MULTI);

  // when in SINGLE mode, only 1 accordion
  // group can be open at a time.
  // accordion.setCollapseMode(Accordion.SINGLE);
}

public void controlEvent(ControlEvent theEvent) {
  if (theEvent.isController()) {
    println(
      "## controlEvent / id:"+theEvent.controller().getId()+
      " / name:"+theEvent.controller().getName()+
      " / value:"+theEvent.controller().getValue()
    );
    switch(theEvent.controller().getId()) {
      case (0):
        system.turnOn(300);
        break;
      case (1):
        system.turnOff(300);
        break;
      case (2):
        system.dimRepeat(3, 500);
        break;
      case (3):
        system.triggerBlinkMode();
        break;
      case (4):
        system.triggerRandomMode();
        break;
      case (5):
        system.triggerSequenceMode(0, 200);
        break;
      case (6):
        system.triggerSequenceMode(1, 200);
        break;
      case (7):
        system.triggerSequenceMode(2, 200);
        break;
      case (8):
        system.triggerComplexSequenceMode(1);
        break;
    }
  }
}
