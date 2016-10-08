//constant
int numberOfData = 36;
int fRate = 20;
int timeSlot = 1000/fRate;
int numberOfMonitors = 4;
color mainBackgroundColor = color(102, 51, 153);

Metro metro;
Monitor[] monitors;

void setup() {
  frameRate(200);
  size(1920, 1080);
  background(mainBackgroundColor);
  monitors = new Monitor[numberOfMonitors];

  monitors[0] = new Monitor("U8221233.txt", 0, 0);
  monitors[0].setXorigin( (width - monitors[0].getWidthOfMonitor() * 2) / 4 );
  monitors[0].setYorigin( (height - monitors[0].getHeightOfMonitor() * 2) / 4 );

  monitors[1] = new Monitor("U8221233.txt", 0 ,0);
  monitors[1].setXorigin( (width * 3 - monitors[1].getWidthOfMonitor() * 2) / 4 );
  monitors[1].setYorigin( (height - monitors[1].getHeightOfMonitor() * 2) / 4 );
  
  monitors[2] = new Monitor("U8221233.txt", 0, 0);
  monitors[2].setXorigin( (width - monitors[0].getWidthOfMonitor() * 2) / 4 );
  monitors[2].setYorigin( (height * 3 - monitors[0].getHeightOfMonitor() * 2) / 4 );
  
  monitors[3] = new Monitor("U8221233.txt", 0, 0);
  monitors[3].setXorigin( (width * 3 - monitors[1].getWidthOfMonitor() * 2) / 4 );
  monitors[3].setYorigin( (height * 3 - monitors[0].getHeightOfMonitor() * 2) / 4 );
}



void draw() {
  background(mainBackgroundColor);
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