import codeanticode.syphon.*;
import controlP5.*;

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
  Group g1 = cp5.addGroup("myGroup1")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(200)
                ;

  cp5.addBang("dim on")
     .setPosition(10,20)
     .setSize(30,30)
     .moveTo(g1)
     .setId(0)
     ;
  cp5.addBang("bang_1")
     .setPosition(10,70)
     .setSize(30,30)
     .moveTo(g1)
     .setId(1)
     ;
  cp5.addBang("bang_2")
     .setPosition(10,120)
     .setSize(30,30)
     .moveTo(g1)
     .setId(2)
     ;
  cp5.addBang("bang_3")
     .setPosition(50,20)
     .setSize(30,30)
     .moveTo(g1)
     .setId(3)
     ;
  cp5.addBang("bang_4")
     .setPosition(50,70)
     .setSize(30,30)
     .moveTo(g1)
     .setId(4)
     ;
  cp5.addBang("bang_5")
     .setPosition(50,120)
     .setSize(30,30)
     .moveTo(g1)
     .setId(5)
     ;
  cp5.addBang("bang_6")
     .setPosition(90,20)
     .setSize(30,30)
     .moveTo(g1)
     .setId(6)
     ;
  cp5.addBang("bang_7")
     .setPosition(90,70)
     .setSize(30,30)
     .moveTo(g1)
     .setId(7)
     ;
  cp5.addBang("bang_8")
     .setPosition(90,120)
     .setSize(30,30)
     .moveTo(g1)
     .setId(8)
     ;

  // group number 2, contains a radiobutton
  Group g2 = cp5.addGroup("myGroup2")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;

  cp5.addRadioButton("radio")
     .setPosition(10,20)
     .setItemWidth(20)
     .setItemHeight(20)
     .addItem("dim in", 0)
     .addItem("dim out", 1)
     .addItem("dim 1 repeat", 2)
     .addItem("dim 3 repeat", 3)
     .addItem("flowing", 4)
     .setColorLabel(color(255))
     .activate(2)
     .moveTo(g2)
     ;

  // group number 3, contains a bang and a slider
  Group g3 = cp5.addGroup("myGroup3")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;

  cp5.addBang("shuffle")
     .setPosition(10,20)
     .setSize(40,50)
     .moveTo(g3)
     ;

  cp5.addSlider("hello")
     .setPosition(60,20)
     .setSize(100,20)
     .setRange(100,500)
     .setValue(100)
     .moveTo(g3)
     ;

  cp5.addSlider("world")
     .setPosition(60,50)
     .setSize(100,20)
     .setRange(100,500)
     .setValue(200)
     .moveTo(g3)
     ;

  // create a new accordion
  // add g1, g2, and g3 to the accordion.
  accordion = cp5.addAccordion("acc")
                 .setPosition(40,40)
                 .setWidth(200)
                 .addItem(g1)
                 .addItem(g2)
                 .addItem(g3)
                 ;

  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.open(0,1,2);}}, 'o');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.close(0,1,2);}}, 'c');
  //  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setWidth(300);}}, '1');
  //  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setPosition(0,0);accordion.setItemHeight(190);}}, '2');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setCollapseMode(ControlP5.ALL);}}, '3');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setCollapseMode(ControlP5.SINGLE);}}, '4');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {cp5.remove("myGroup1");}}, '0');

  accordion.open(0);

  // use Accordion.MULTI to allow multiple group
  // to be open at a time.
  accordion.setCollapseMode(Accordion.MULTI);

  // when in SINGLE mode, only 1 accordion
  // group can be open at a time.
  // accordion.setCollapseMode(Accordion.SINGLE);
}

public void controlEvent(ControlEvent theEvent) {
  // println(
  // "## controlEvent / id:"+theEvent.controller().getId()+
  //   " / name:"+theEvent.controller().getName()+
  //   " / value:"+theEvent.controller().getValue()
  //   );
  switch(theEvent.controller().getId()) {
    case(0):
      system.turnOn(300);
      break;
    case(1):
      system.turnOff(300);
      break;
    case(2):
      system.dimRepeat(3, 500);
      break;
    case(3):
      system.blink();
      break;
    case(4):
      system.triggerRandomMode();
      break;
    case(5):
      system.triggerSequenceMode(0, 200);
      break;
    case(6):
      system.triggerSequenceMode(1, 200);
      break;
    case(7):
      system.triggerSequenceMode(2, 200);
      break;
    case(8):
      system.triggerSequenceMode(3, 200);
      break;
  }
}
