
//file list
String[] fileList = { "U826190",
                      "U8221233",
                      "U8301523",
                      "U8301524",
                      "U8301538",
                      "U8301559"
                    };


//constant
int numberOfData = 36;
int fRate = 20;
int timeSlot = 1000/fRate;
int numberOfMonitors = 4;
int maxFrameNumber = 20000;
color mainBackgroundColor = color(102, 51, 153);
color localBackGroundColor = color (34, 49, 63);



Metro metro;
Monitor[] monitors;

//test for FileSelector
// PGraphics test;
// FileSelector fs;

void setup() {
  frameRate(200);
  size(1920, 1080);
  background(mainBackgroundColor);
  monitors = new Monitor[numberOfMonitors];

  monitors[0] = new Monitor(0, 0);
  monitors[0].setXorigin( (width - monitors[0].getWidthOfMonitor() * 2) / 4 );
  monitors[0].setYorigin( (height - monitors[0].getHeightOfMonitor() * 2) / 4 );

  monitors[1] = new Monitor(0 ,0);
  monitors[1].setXorigin( (width * 3 - monitors[1].getWidthOfMonitor() * 2) / 4 );
  monitors[1].setYorigin( (height - monitors[1].getHeightOfMonitor() * 2) / 4 );

  monitors[2] = new Monitor(0, 0);
  monitors[2].setXorigin( (width - monitors[0].getWidthOfMonitor() * 2) / 4 );
  monitors[2].setYorigin( (height * 3 - monitors[0].getHeightOfMonitor() * 2) / 4 );

  monitors[3] = new Monitor(0, 0);
  monitors[3].setXorigin( (width * 3 - monitors[1].getWidthOfMonitor() * 2) / 4 );
  monitors[3].setYorigin( (height * 3 - monitors[0].getHeightOfMonitor() * 2) / 4 );


  //test for FileSelector
  // test = createGraphics(512, 424);
  // fs = new FileSelector(test, fileList, 512, 424);
}


//test for FileSelector
void keyPressed() {
  if( key == 'u') {
    monitors[0].fileSelector.nextFile();
  }
  if( key == 'd') {
    monitors[0].fileSelector.previousFile();
  }
  if( key == 'l') {
    monitors[0].selectFile();
  }
}

void draw() {
  background(mainBackgroundColor);
  println("Global Time Count : " + float(millis())/1000 );
  for(int i=0; i<numberOfMonitors; i++) {
    monitors[i].display();
    monitors[i].rendor();
  }

}

void mousePressed() {
  for(int i=0; i<numberOfMonitors; i++) {
    monitors[i].mousePressed(mouseX, mouseY);
  }
}

void mouseReleased() {
  for(int i=0; i<numberOfMonitors; i++) {
    monitors[i].mouseReleased(mouseX, mouseY);
  }
}

void mouseClicked() {
  for(int i=0; i<numberOfMonitors; i++) {
    monitors[i].mouseClicked(mouseX, mouseY);
  }
}

void mouseDragged() {
  for(int i=0; i<numberOfMonitors; i++) {
    monitors[i].mouseDragged(mouseX, mouseY);
  }
}
