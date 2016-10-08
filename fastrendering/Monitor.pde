class Monitor {
  PGraphics canvas;

  //constant
  int numberOfData = 36;
  int fRate = 20;
  int timeSlot = 1000/fRate;
  String fName;
  int w_rendor = 512, h_rendor = 424;
  float screenRatio = float(w_rendor)/float(h_rendor);
  int w_display = w_rendor, h_display = h_rendor;
  float xpos = 0, ypos = 0;

  //variable
  int lineCount = 0;
  int dataCount = 0;
  int fCount = 0;
  int currentFrame = 0;
  int[][] dataStorage;


  //skeleton variable
  Skeleton skeleton;

  //color
  color backGroundColor = color (34, 49, 63);

  //Metro
  Metro metro;

  //constructor
  Monitor(String fileName, float x, float y) {

    canvas = createGraphics(w_rendor, h_rendor);
    xpos = x;
    ypos = y;
    fName = fileName;
    dataStorage = new int[15000][numberOfData];
    readFile();

    skeleton = new Skeleton(canvas);
    metro = new Metro(true ,timeSlot);
    println(fCount);
  }

  void rendor() {
    //println("Frame Count : " + currentFrame);
    println("Local Time Count : " + float(currentFrame) * 0.05 );
    canvas.beginDraw();
    canvas.background(mainBackgroundColor);
    canvas.fill(backGroundColor, 200);
    canvas.rectMode(CORNER);
    canvas.rect(0, 0, w_rendor, h_rendor);
    skeleton.display();
    barDisplay();
    if(metro.frameCount() > currentFrame) {
      skeleton.set(dataStorage[currentFrame]);
      int gap = metro.frameCount() - currentFrame;
      currentFrame++;
      while(gap > 3) {
        currentFrame++;
        gap--;
      }
      //if end, replay
      if(currentFrame >= fCount) {
        currentFrame = 0;
        metro.stopAndReset();
        metro.startPlaying();
      }
    }
    canvas.endDraw();
  }

  void display() {
    imageMode(CORNER);
    image(canvas, xpos, ypos, w_display, h_display);
  }

  void readFile() {
    BufferedReader reader;
    String line;
    reader = createReader(fName);
    while( true ) {
      try {
        line = reader.readLine();
        lineCount++;
      } catch (IOException e) {
        e.printStackTrace();
        line = null;
      }

      if (line == null) {
        break;
      } else {
        String[] pieces = split(line, ' ');
        for( int i=0, n=pieces.length; i<n; i++) {
          string2Buffer(pieces[i]); }
      }
    }
  }

  void string2Buffer (String piece) {
    int pos = piece.indexOf(';');
    if ( pos != 0) { //if the line don't start with ';'
      if ( pos > 0 ) {
        piece = piece.substring(0, pos);
      }

      int data = int(piece);
      //println("piece:" + piece);
      //println("data:" + data);
      dataStorage[fCount][dataCount] = data;
      dataCount++;

      if ( dataCount == numberOfData ) {
        dataCount = 0; //finish one set of data
        fCount++;
      }
    }
  }

  //setting functions
  int getWidthOfMonitor() { return w_display; }
  int getHeightOfMonitor() { return h_display; }

  void setXorigin(float x) { xpos = x; }
  void setYorigin(float y) { ypos = y; }





  //UI interface of Monitor
  //status line
  float lengthOfBar = 400;
  float heightOfBar = 100;
  int numberOfDots = 40;
  int transparencyOfBar = 150;
  int transparencyOfDot = 255;
  int transparencyOfShiftingDot = 255;

  int radiusOfDots = 2;
  int radiusOfTheDot = 10;
  int radiusOfShiftingDot = 10;

  float radiusOfStopButton = 30;
  float x_dot = ( w_rendor - lengthOfBar ) / 2, y_dot = h_rendor - heightOfBar;
  float x_stop = w_rendor/2, y_stop = h_rendor - heightOfBar/2;
  float d = 1 / float(numberOfDots);
  float accelOfShifting = 0.7;

  //color
  color barColor = color (210, 82, 127);
  color dotColor = color (249, 105, 14);
  color shiftingDotColor = color (38, 166, 91);

  //variable
  boolean playing = true;
  boolean adjusting = false;
  boolean shifting = false;
  boolean scaling = false;


  void barDisplay() {
    for(float i = -0.5; i <= 0.5 ; i += d) {
      canvas.fill(barColor, transparencyOfBar);
      canvas.ellipse(  w_rendor / 2 + i * lengthOfBar, h_rendor - heightOfBar, radiusOfDots*2, radiusOfDots*2);
    }
    x_dot = ( w_rendor - lengthOfBar ) / 2 + lengthOfBar * currentFrame / fCount;
    canvas.fill(dotColor, transparencyOfDot);
    canvas.ellipse( x_dot, y_dot, radiusOfTheDot*2, radiusOfTheDot*2);

    //play sign
    if(!playing) {
      int k = 100;
      canvas.fill(barColor, transparencyOfBar);
      canvas.triangle(w_rendor/2-k/3, h_rendor/2+k/3, w_rendor/2-k/3, h_rendor/2-k/3, w_rendor/2+k/3, h_rendor/2);
    }

    //stop button
    canvas.fill(barColor, transparencyOfBar);
    canvas.ellipse(x_stop, y_stop, radiusOfStopButton, radiusOfStopButton);
    canvas.fill(dotColor, transparencyOfDot);
    canvas.rectMode(CENTER);
    canvas.rect(x_stop, y_stop, radiusOfStopButton/3, radiusOfStopButton/3);

    noStroke();
    fill(shiftingDotColor, transparencyOfShiftingDot);
    ellipse(xpos, ypos, radiusOfShiftingDot*2, radiusOfShiftingDot*2);
    ellipse(xpos + w_display, ypos + h_display, radiusOfShiftingDot*2, radiusOfShiftingDot*2);
  }

  void mousePressed(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
    if ( !adjusting ) {
      //adjust the ratio
      float _x = x * w_rendor / w_display;
      float _y = y * h_rendor / h_display;
      if ( dist(_x, _y, x_dot, y_dot) < radiusOfTheDot) {
        adjusting = true;
        metro.pause();
      }
    }

    if ( !shifting ) {
      if ( dist(x, y, 0, 0) < radiusOfTheDot ) {
        shifting = true;
      }
    }

    if ( !scaling ) {
      if ( dist(x, y, w_display, h_display) < radiusOfTheDot ) {
        scaling = true;
        println("check");
      }
    }
  }

  void mouseDragged(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
    if ( adjusting ) {
      //adjust the ratio
      float _x = x * w_rendor / w_display;
      x_dot = min(max(_x, ( w_rendor - lengthOfBar ) / 2), ( w_rendor +lengthOfBar ) / 2);
      int fc = int ( fCount * ( (x_dot - ( w_rendor - lengthOfBar ) / 2) / lengthOfBar ) );
      metro.setTime(fc);
      currentFrame = fc;
    }

    if ( shifting ) {
      xpos = xpos - accelOfShifting * ( xpos - _mX ) ;
      ypos = ypos - accelOfShifting * ( ypos - _mY ) ;
    }

    if ( scaling ) {
      float h_new = y;
      float w_new = h_new * screenRatio;
      if ( w_new < x ) {
        w_new = x;
        h_new = w_new / screenRatio;
      }
      w_display = int(w_new);
      h_display = int(h_new);
    }
  }

  void mouseReleased(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
    if (adjusting) {
      metro.startPlaying();
      playing = true;
      adjusting = false;
    }
    if (shifting) {
      shifting = false;
    }
    if (scaling) {
      scaling = false;
    }

  }

  void mouseClicked(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
    if ( x > 0 && x < w_display && y > 0 && y < h_display) {

      //stop
      float _x = x * w_rendor / w_display;
      float _y = y * h_rendor / h_display;
      if ( dist( _x, _y, x_stop, y_stop) < radiusOfStopButton) {
        metro.stopAndReset();
        currentFrame = 0;
        playing = false;
      }

      //play and pause
      else {
        if(playing) {
          metro.pause();
          playing = false;
        }
        else {
          playing = true;
          metro.startPlaying();
        }
      }
    }
  }


}