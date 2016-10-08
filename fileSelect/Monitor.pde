class Monitor {
  PGraphics canvas;
  FileSelector fileSelector;

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
  int loopStartFrame, loopEndFrame;
  int[][] dataStorage;
  boolean selectingFile = true;


  //skeleton variable
  Skeleton skeleton;

  //color
  color backGroundColor = color (34, 49, 63);

  //Metro
  Metro metro;

  //constructor
  Monitor(float x, float y) {
    canvas = createGraphics(w_rendor, h_rendor);
    xpos = x;
    ypos = y;
    fileSelector = new FileSelector(canvas, fileList, w_rendor, h_rendor); //fileList is global
    skeleton = new Skeleton(canvas);
    metro = new Metro(false ,timeSlot);
    //println(fCount);
  }

  void selectFile() {
    if( selectingFile ) {
      fileSelector.selectFile();
      fCount = fileSelector.fCount;
      lineCount = fileSelector.lineCount;
      dataStorage = fileSelector.dataStorage;
      selectingFile = false;   //starttimer to make the animation

      loopStartFrame = 0;
      loopEndFrame = fCount;
      playing = true;
      metro.startPlaying();
    }
  }

  void rendor() {
    //println("Frame Count : " + currentFrame);
    println("Local Time Count : " + float(currentFrame) * 0.05 );
    canvas.beginDraw();

    if (selectingFile) {
      fileSelector.display();
    }
    else {
      //start play
      canvas.background(mainBackgroundColor);
      canvas.fill(backGroundColor, 255);

      canvas.rectMode(CORNER);
      canvas.rect(1, 1, w_rendor, h_rendor);
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
        // if(currentFrame >= fCount) {
        //   currentFrame = 0;
        //   metro.stopAndReset();
        //   metro.startPlaying();
        // }
        if(currentFrame >= loopEndFrame) {
          currentFrame = loopStartFrame;
          //metro.setTime(loopStartFrame);
          //metro.stopAndReset();
          metro.startPlayingAt(loopStartFrame);
        }
      }
    }

    canvas.endDraw();
  }

  void display() {
    imageMode(CORNER);
    image(canvas, xpos, ypos, w_display, h_display);
    stroke(lineColor);
    strokeWeight(lineWeight);
    noFill();
    rect(xpos - lineWeight/4, ypos - lineWeight/4, w_display, h_display);
    controlDotsDisplay();
  }

  // void readFile() {
  //   BufferedReader reader;
  //   String line;
  //   reader = createReader(fName);
  //   while( true ) {
  //     try {
  //       line = reader.readLine();
  //       lineCount++;
  //     } catch (IOException e) {
  //       e.printStackTrace();
  //       line = null;
  //     }
  //
  //     if (line == null) {
  //       break;
  //     } else {
  //       String[] pieces = split(line, ' ');
  //       for( int i=0, n=pieces.length; i<n; i++) {
  //         string2Buffer(pieces[i]); }
  //     }
  //   }
  // }
  //
  // void string2Buffer (String piece) {
  //   int pos = piece.indexOf(';');
  //   if ( pos != 0) { //if the line don't start with ';'
  //     if ( pos > 0 ) {
  //       piece = piece.substring(0, pos);
  //     }
  //
  //     int data = int(piece);
  //     //println("piece:" + piece);
  //     //println("data:" + data);
  //     dataStorage[fCount][dataCount] = data;
  //     dataCount++;
  //
  //     if ( dataCount == numberOfData ) {
  //       dataCount = 0; //finish one set of data
  //       fCount++;
  //     }
  //   }
  // }

  //setting functions
  int getWidthOfMonitor() { return w_display; }
  int getHeightOfMonitor() { return h_display; }

  void setXorigin(float x) { xpos = x; }
  void setYorigin(float y) { ypos = y; }





  //UI interface of Monitor
  //status line
  float lengthOfBar = 400;
  float heightOfBar = 50;
  int numberOfDots = 40;
  int transparencyOfBar = 150;
  int transparencyOfDot = 255;
  int transparencyOfShiftingDot = 255;

  int radiusOfDots = 2;
  int radiusOfTheDot = 10;
  int radiusOfShiftingDot = 10;
  int radiusOfControlDot = 7;

  float radiusOfStopButton = 30;
  float x_dot = ( w_rendor - lengthOfBar ) / 2, y_dot = h_rendor - heightOfBar;
  float x_stop = w_rendor/2, y_stop = h_rendor - heightOfBar/2;
  float d = 1 / float(numberOfDots);
  float accelOfShifting = 0.7;
  float dotPositionCorrection = 10;
  float widthOfPositionSign = 18;
  float heightOfPositionSign = 10;


  int lineWeight = 2;

  //color
  color barColor = color (210, 82, 127);
  color dotColor = color (249, 105, 14);
  color lineColor = color (38, 166, 91);
  color shiftingDotColor = color (38, 166, 91);

  //variable
  boolean playing = false;
  boolean adjusting = false;
  boolean shifting = false;
  boolean scaling = false;

  boolean loopStartAdjusting = false;
  boolean loopEndAdjusting = false;

  //loop sign
  color loopStartSignColor = color (34, 167, 240);
  color loopEndSignColor = color (242, 38, 19);
  float widthOfLoopSign = 5;
  float lengthOfLoopSign = 15;
  float radiusOfSensingOfLoopSign = 10;
  int  minLoopGap = 10; // it can be calculated into number of frame



  void barDisplay() {
    canvas.noStroke();
    for(float i = 0; i < numberOfDots ; i++ ) {
      canvas.fill(barColor, transparencyOfBar);
      canvas.ellipse(  (w_rendor - lengthOfBar) / 2 + i * lengthOfBar / (numberOfDots - 1),
                        h_rendor - heightOfBar, radiusOfDots*2, radiusOfDots*2);
    }

    //head, tail sign
    canvas.stroke(lineColor);
    canvas.strokeWeight(lineWeight*2);
    canvas.line( (w_rendor - lengthOfBar) / 2 - dotPositionCorrection , y_dot,
                 (w_rendor - lengthOfBar) / 2 - dotPositionCorrection - heightOfPositionSign,
                 y_dot - widthOfPositionSign/2);
    canvas.line( (w_rendor - lengthOfBar) / 2 - dotPositionCorrection , y_dot,
                 (w_rendor - lengthOfBar) / 2 - dotPositionCorrection - heightOfPositionSign,
                 y_dot + widthOfPositionSign/2);
    canvas.line( (w_rendor + lengthOfBar) / 2 + dotPositionCorrection , y_dot,
                 (w_rendor + lengthOfBar) / 2 + dotPositionCorrection + heightOfPositionSign,
                 y_dot - widthOfPositionSign/2);
    canvas.line( (w_rendor + lengthOfBar) / 2 + dotPositionCorrection , y_dot,
                 (w_rendor + lengthOfBar) / 2 + dotPositionCorrection + heightOfPositionSign,
                 y_dot + widthOfPositionSign/2);
    //the playing region
    canvas.line( barPosition (loopStartFrame), y_dot, barPosition (loopEndFrame), y_dot);



    //current sign
    x_dot = barPosition( currentFrame );
    canvas.line( x_dot , y_dot + dotPositionCorrection,
                 x_dot - widthOfPositionSign/2, y_dot + dotPositionCorrection + heightOfPositionSign);
    canvas.line( x_dot , y_dot + dotPositionCorrection,
                 x_dot + widthOfPositionSign/2, y_dot + dotPositionCorrection + heightOfPositionSign);

    //loop sign
    canvas.noStroke();
    canvas.rectMode(CENTER);
    //start
    canvas.fill(loopStartSignColor);
    canvas.rect( barPosition (loopStartFrame)
                , h_rendor - heightOfBar, widthOfLoopSign, lengthOfLoopSign);
    //stop
    canvas.fill(loopEndSignColor);
    canvas.rect( barPosition (loopEndFrame)
                , h_rendor - heightOfBar, widthOfLoopSign, lengthOfLoopSign);


    //play sign
    if(!playing) {
      int k = 100;
      canvas.fill(barColor, transparencyOfBar);
      canvas.triangle(w_rendor/2-k/3, h_rendor/2+k/3, w_rendor/2-k/3, h_rendor/2-k/3, w_rendor/2+k/3, h_rendor/2);
    }

    //stop button
    // canvas.fill(barColor, transparencyOfBar);
    // canvas.ellipse(x_stop, y_stop, radiusOfStopButton, radiusOfStopButton);
    // canvas.fill(dotColor, transparencyOfDot);
    // canvas.rectMode(CENTER);
    // canvas.rect(x_stop, y_stop, radiusOfStopButton/3, radiusOfStopButton/3);

  }

  float barPosition ( int frameNumber ) {
    float ret = ( w_rendor - lengthOfBar ) / 2 + lengthOfBar * frameNumber / fCount;
    return ret;
  }
  int barPosition2Frame ( float pos) {
    int ret = int ( fCount * ( (pos - ( w_rendor - lengthOfBar ) / 2) / lengthOfBar ) );
    return ret;
  }

  void controlDotsDisplay() {
    stroke(lineColor, 255);
    strokeWeight(lineWeight);
    fill(backGroundColor);
    ellipse(xpos, ypos, radiusOfControlDot*2, radiusOfControlDot*2);
    ellipse(xpos + w_display, ypos + h_display, radiusOfControlDot*2, radiusOfControlDot*2);
  }

  void mousePressed(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
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

    if ( selectingFile ) { }
    else {
      if ( !adjusting ) {
        //adjust the ratio
        float _x = x * w_rendor / w_display;
        float _y = y * h_rendor / h_display;
        if ( dist(_x, _y, x_dot, y_dot + dotPositionCorrection*1.5 ) < radiusOfTheDot) {
          adjusting = true;
          metro.pause();
        }
      }

      if ( !loopStartAdjusting) {
        float _x = x * w_rendor / w_display;
        float _y = y * h_rendor / h_display;
        if ( dist(_x, _y, barPosition(loopStartFrame), y_dot) < radiusOfSensingOfLoopSign) {
          loopStartAdjusting = true;
        }
      }

      if ( !loopEndAdjusting) {
        float _x = x * w_rendor / w_display;
        float _y = y * h_rendor / h_display;
        if ( dist(_x, _y, barPosition(loopEndFrame), y_dot) < radiusOfSensingOfLoopSign) {
          loopEndAdjusting = true;
        }
      }

    }
  }

  void mouseDragged(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
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

    if ( selectingFile) { }
    else {
      if ( adjusting ) {
        //adjust the ratio
        float _x = x * w_rendor / w_display;
        x_dot = min(max(_x, ( w_rendor - lengthOfBar ) / 2), ( w_rendor +lengthOfBar ) / 2);
        int fc = int ( fCount * ( (x_dot - ( w_rendor - lengthOfBar ) / 2) / lengthOfBar ) );
        metro.setTime(fc);
        currentFrame = fc;
      }

      if ( loopStartAdjusting ) {
        //adjust the ratio
        float _x = x * w_rendor / w_display;
        x_dot = min(max(_x, ( w_rendor - lengthOfBar ) / 2),
                    barPosition(loopEndFrame) - minLoopGap );
        //int fc = int ( fCount * ( (x_dot - ( w_rendor - lengthOfBar ) / 2) / lengthOfBar ) );
        loopStartFrame = barPosition2Frame(x_dot);


      }

      if ( loopEndAdjusting ) {
        //adjust the ratio
        float _x = x * w_rendor / w_display;
        x_dot = min(max(_x, barPosition(loopStartFrame) + minLoopGap),
                    ( w_rendor +lengthOfBar ) / 2);
        //int fc = int ( fCount * ( (x_dot - ( w_rendor - lengthOfBar ) / 2) / lengthOfBar ) );
        loopEndFrame = barPosition2Frame(x_dot);
      }


    }
  }

  void mouseReleased(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
    if (shifting) {
      shifting = false;
    }
    if (scaling) {
      scaling = false;
    }
    if ( selectingFile ) {}
    else {

      if (adjusting) {
        metro.startPlaying();
        playing = true;
        adjusting = false;
      }

      if (loopStartAdjusting) {
        if (loopStartFrame > currentFrame ) {
          currentFrame = loopStartFrame;
          metro.startPlayingAt(loopStartFrame);
        }
        loopStartAdjusting = false;
      }

      if (loopEndAdjusting) {
        loopEndAdjusting = false;
      }

    }

  }

  void mouseClicked(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
    if ( x > 0 && x < w_display && y > 0 && y < h_display) {
      if ( selectingFile ) {
        if ( !scaling && !shifting) {
          float _y = y * h_rendor / h_display;
          if (  _y < h_rendor / 3) {
            fileSelector.previousFile(); }
          else if ( _y < h_rendor * 2 / 3 ) {
            selectFile();
          }
          else if ( _y < h_rendor ) {
            fileSelector.nextFile(); }
        }
      }
      else {
        //stop
        float _x = x * w_rendor / w_display;
        float _y = y * h_rendor / h_display;
        // if ( dist( _x, _y, x_stop, y_stop) < radiusOfStopButton) {
        //   metro.stopAndReset();
        //   currentFrame = 0;
        //   playing = false;
        // }

        //play and pause
        if (true) {
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


}