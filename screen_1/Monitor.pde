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
  int w_drag, h_drag;
  float xpos = 0, ypos = 0;

  //variable
  int id = -1;
  int index = -1;
  //int lineCount = 0;
  int dataCount = 0;
  int fCount = 0;
  int currentFrame = 0;
  int loopStartFrame, loopEndFrame;
  //int[][] dataStorage;

  boolean changingRatio;
  boolean waitingForFileSelector;
  boolean selectingFile;
  boolean fileSelectorFadeOut;
  boolean skeletonFadeIn;
  boolean startPlayingAndAdjusting;
  boolean fadeOut;
  boolean dissappear;


  //skeleton variable
  Skeleton skeleton;

  //color
  //color backGroundColor = color (34, 49, 63);
  int colorIndex = 1;
  color backGroundColor = localBackGroundColor;
  color closeMonitorSignColor = color (242, 38, 19);


  //Metro & TimeLine & Time constant
  Metro metro;
  TimeLine changeRatioTimer;
  TimeLine dissolveTimer;
  TimeLine transientTimer;
  TimeLine fadeOutTimer;
  TimeLine soundReactionTimer; // sound reaction

  int changeRatioTime = 400;
  float changeRatioTimeRate = 6;
  int dissolveTime = 400;
  float dissolveTimeRate = 0.7;
  int waitingForFileSelectorTime = 500;
  int waitingForFileSelectorStartTime;
  int transientTime = 200;
  float transientTimerRate = 0.7;

  int soundReactionTime = 800;
  float soundReactionTimerRate = 0.5;

  //sound reaction
  color soundReactionColor = color (247, 202, 24);
  int soundReactionIndex = 0;

  color soundReactionTextColor = color (249, 105, 14); //orange
  int soundReactionTextSize = 60;
  int soundReactionX = 150;
  int soundReactionY = 200;

  //Box2D
  Box box;
  Spring spring;


  //constructor
  Monitor(float _xpos, float _ypos, int _w_drag, int _h_drag, int _id) {
    canvas = createGraphics(w_rendor, h_rendor);
    xpos = _xpos;
    ypos = _ypos;
    h_drag = _h_drag;
    w_drag = _w_drag;
    h_display = _h_drag;
    w_display = int(_h_drag * (float(w_rendor) / float(h_rendor)));
    id = _id;

    fileSelector = new FileSelector(canvas, w_rendor, h_rendor, id); //fileList is global
    skeleton = new Skeleton(canvas, id);
    metro = new Metro(false ,timeSlot);

    //status variable
    changingRatio = true;
    selectingFile = false;
    waitingForFileSelector = false;  //use dissolveTimer
    fileSelectorFadeOut = false;     //use dissolveTimer
    skeletonFadeIn = false;          //use dissolveTimer
    startPlayingAndAdjusting = false;
    fadeOut = false;
    dissappear = false;

    //TimeLine
    changeRatioTimer = new TimeLine(changeRatioTime);
    changeRatioTimer.setLinerRate(changeRatioTimeRate);
    dissolveTimer = new TimeLine(dissolveTime);
    dissolveTimer.setLinerRate(dissolveTimeRate);
    transientTimer = new TimeLine(transientTime);
    transientTimer.setLinerRate(transientTimerRate);
    fadeOutTimer = new TimeLine(dissolveTime);
    fadeOutTimer.setLinerRate(dissolveTimeRate);
    soundReactionTimer = new TimeLine(soundReactionTime);
    soundReactionTimer.setLinerRate(soundReactionTimerRate);
    soundReactionTimer.turnOffTimer();

    changeRatioTimer.startTimer();


    //box = new Box(width/2,height/2, 100, 100);
  }

  void selectFile() {
    if( selectingFile ) {
      index = fileSelector.index;
      if (!loadedList[index]) {
        fileSelector.selectFile();
        fCount = fileSelector.fCount;
        //dataStorage = fileSelector.dataStorage;
      }
      else {
        fCount = fcount[index];
      }

      selectingFile = false;   //starttimer to make the animation
      fileSelectorFadeOut = true;
      dissolveTimer.startTimer();

      loopStartFrame = 0;
      loopEndFrame = fCount;
    }
  }
  void boxUpdate(float _mX, float _mY) {
    if (startPlayingAndAdjusting) {
      if(id%3!=2)
        box2d.step();
      Vec2 pos = box2d.getBodyPixelCoord(box.body);
      // Get its angle of rotation
      xpos = pos.x - w_display/2;
      ypos = pos.y - h_display/2;
      spring.update(_mX,_mY);
    }
  }

  void rendor() {
    //println("Frame Count : " + currentFrame);
    //println("Local Time Count : " + float(currentFrame) * 0.05 );
    if ( !changingRatio ) {
      canvas.beginDraw();
      if ( waitingForFileSelector) {
        displayChangingRatio();
        if ((millis() - waitingForFileSelectorStartTime > waitingForFileSelectorTime)) {
          waitingForFileSelector = false;
          selectingFile = true;
          dissolveTimer.startTimer();
        }
      }
      else {
        if (selectingFile) {
          fileSelector.display();
        }
        else if (fileSelectorFadeOut) {
          if (dissolveTimer.liner() >= 1) {
            fileSelectorFadeOut = false;
            skeletonFadeIn = true;
            dissolveTimer.startTimer();
            playing = true;
            metro.startPlaying();
            skeleton.set(dataStorage[index][currentFrame]);
          }
        }
        else {
          //unecessary
          if (dissolveTimer.liner() >= 1 && !startPlayingAndAdjusting) {
            skeletonFadeIn = false;
            startPlayingAndAdjusting = true;


            box = new Box(xpos + w_display / 2 , ypos + h_display / 2 ,
                            w_display + radiusOfShiftingDot * 2,
                            h_display + radiusOfShiftingDot * 2);
            boxCreated = true;
            spring = new Spring();
          }

          //start play
          canvas.background(mainBackgroundColor);
          canvas.fill(backGroundColor, 255);
          canvas.rectMode(CORNER);
          canvas.rect(1, 1, w_rendor, h_rendor);
          skeleton.display();
          barDisplay();
          if(metro.frameCount() > currentFrame) {
            skeleton.update(dataStorage[index][currentFrame]);
            int gap = metro.frameCount() - currentFrame;
            currentFrame++;
            while(gap > 3) {      //the fast rendor
              currentFrame++;
              gap--;
            }
            if(currentFrame >= loopEndFrame) {
              currentFrame = loopStartFrame;
              metro.startPlayingAt(loopStartFrame);
            }
          }
          soundReaction();
          speedReaction();
        }
      }
      canvas.endDraw();
    }



    if ( fadeOut ) {
      if ( fadeOutTimer.liner() >= 1) {
        fadeOut = false;
        dissappear = true;
      }
    }

    //check the pos
    checkOutOfScreen();

  }

  void display() {
    rectMode(CORNER);
    if ( changingRatio ) {
      displayChangingRatio();
      if(changeRatioTimer.liner() >= 1) {
        waitingForFileSelectorStartTime = millis();
        changingRatio = false;
        waitingForFileSelector = true;
      }
    }

    else if (!(fadeOut || dissappear)) {
      imageMode(CORNER);
      noTint();


      if( selectingFile || skeletonFadeIn ) {
        displayChangingRatio();
        tint(255,  255 * dissolveTimer.liner());
      }
      else if( fileSelectorFadeOut ) {
        displayChangingRatio();
        tint(255,  255 * (1-dissolveTimer.liner()));
      }

      image(canvas, xpos, ypos, w_display, h_display);
      if (!fadeOut) { noTint(); }

      stroke(lineColor);
      strokeWeight(lineWeight);
      noFill();
      rect(xpos - lineWeight/4, ypos - lineWeight/4, w_display, h_display);
      controlDotsDisplay();
    }

    if (fadeOut || dissappear) {
      imageMode(CORNER);
      tint(255,  255 * (1-fadeOutTimer.liner()));
      image(canvas, xpos, ypos, w_display, h_display);
      stroke(lineColor, 255 * (1-fadeOutTimer.liner()));
      strokeWeight(lineWeight/2);
      noFill();
      rect(xpos - lineWeight/2, ypos - lineWeight/2, w_display, h_display);
      fadeOutControlDotDisplay();
    }

    //box2D
    if ( dissappear && boxCreated ) {
      box.killBody();
      boxCreated = false;
    }
    else if ( boxCreated ){
      //box.display();
      spring.display();
    }

    if (scaling) {
      hwInfo(xpos, xpos + w_display, ypos, ypos + h_display);
    }


  }

  void sendSound() {
    if ( startPlayingAndAdjusting) {
      //pose1, pose2, pose3, pose4
      if ( skeleton.soundPose1() ) {
        soundReactionTimer.startTimer();
        soundReactionIndex = 1;
      }
      if ( skeleton.soundPose2() ) {
        soundReactionTimer.startTimer();
        soundReactionIndex = 2;
      }
      if ( skeleton.soundPose3_l() ) {
        soundReactionTimer.startTimer();
        soundReactionIndex = 3;
      }
      if ( skeleton.soundPose3_r() ) {
        soundReactionTimer.startTimer();
        soundReactionIndex = 3;
      }
      if ( skeleton.soundPose4() ) {
        soundReactionTimer.startTimer();
        soundReactionIndex = 4;
      }

      if (theremin) {
        skeleton.thereminSignal();
      }

      //soundReaction();
    }
  }

  void soundReaction() {
    if ( soundReactionTimer.liner() < 1
      && soundReactionTimer.state
      && startPlayingAndAdjusting ) {
      //println("REACTION!!!!");
      String react = "X";
      switch ( soundReactionIndex ) {
        case 1:
          react = "A";
          break;
        case 2:
          react = "B";
          break;
        case 3:
          react = "C";
          break;
        case 4:
          react = "D";
          break;
      }

      // println("DRAW!!!!");
      // println("soundReactionTimer.liner() = " + soundReactionTimer.liner());
      canvas.fill(soundReactionColor,
              255 * ( 1 - soundReactionTimer.liner() ));
      canvas.noStroke();
      canvas.rectMode(CORNER);
      canvas.rect(0, 0, w_rendor, h_rendor);

      canvas.textSize(soundReactionTextSize);
      canvas.fill(soundReactionTextColor,
              255 * ( 1 - soundReactionTimer.liner() ));
      canvas.text(react, soundReactionX, soundReactionY);
    }


  }

  void displayChangingRatio () {
    //println("displayChangingRatio");
    rectMode(CORNER);

    noStroke();
    fill(backGroundColor, 255);
    rect(xpos, ypos, w_drag + (w_display - w_drag) * changeRatioTimer.liner(), h_display);
    stroke(lineColor);
    strokeWeight(lineWeight);
    noFill();
    rect(xpos, ypos, w_drag + (w_display - w_drag)*changeRatioTimer.liner(), h_display);
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
  boolean checkOutOfScreen() {
    if ( xpos < - w_display || xpos > width || ypos > height || ypos < -h_display ) {
      dissappear = true;
      //box.killBody();
      return true;
    }
    else {
      return false;
    }
  }




  //UI interface of Monitor
  //status line
  float lengthOfBar = 400;
  float heightOfBar = 50;
  int numberOfDots = 40;
  int transparencyOfBar = 150;
  int transparencyOfDot = 255;
  int transparencyOfShiftingDot = 255;

  int radiusOfDots = 1;
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


  int lineWeight = 1;

  //color
  color barColor = color (210, 82, 127);
  color dotColor = color (249, 105, 14);
  //color lineColor = color (38, 166, 91);
  color lineColor = color (200, 200, 200);
  color shiftingDotColor = color (38, 166, 91);

  //variable
  boolean playing = true;
  boolean adjusting = false;
  boolean shifting = false;
  boolean scaling = false;
  boolean theremin = false;
  boolean springBind = false;
  boolean boxCreated = false;
  boolean mouseSense = false;

  float shiftOffsetX, shiftOffsetY;

  boolean loopStartAdjusting = false;
  boolean loopEndAdjusting = false;

  //loop sign
  color loopStartSignColor = color (34, 167, 240);
  color loopEndSignColor = color (242, 38, 19);
  float widthOfLoopSign = 5;
  float lengthOfLoopSign = 15;
  float radiusOfSensingOfLoopSign = 10;
  int  minLoopGap = 10; // it can be calculated into number of frame

  //text
  int textSize = 18;
  int textHeight = 17;


  //theremin
  int buttonRadius = 18;
  int buttonPosX = 50;
  int buttonPosY = 50;
  int innerButtonRadius = 10;
  color buttonColor =  lineColor;//color (38, 166, 91);



  void barDisplay() {
    //frame notation
    canvas.textAlign(RIGHT, CENTER);
    canvas.textSize(textSize);
    if ( loopStartAdjusting ) {
      canvas.fill(loopStartSignColor);
      canvas.text(str(loopStartFrame),w_rendor - heightOfBar * 2.2 ,//2.5
                                h_rendor - heightOfBar - textHeight);
      canvas.text("[            / " + str(fCount) + " ]",
                  w_rendor - heightOfBar * 1.0,
                  h_rendor - heightOfBar - textHeight );
    }
    else if ( loopEndAdjusting ) {
      canvas.fill(loopEndSignColor);
      canvas.text(str(loopEndFrame),w_rendor - heightOfBar * 2.2 , //2.5
                                h_rendor - heightOfBar - textHeight);
      canvas.text("[            / " + str(fCount) + " ]",
                  w_rendor - heightOfBar * 1.0,
                  h_rendor - heightOfBar - textHeight );
    }
    else {
      canvas.fill(lineColor);
      canvas.text(str(currentFrame),w_rendor - heightOfBar * 2.2 ,//2.5
                                h_rendor - heightOfBar - textHeight);
      canvas.text("[            / " + str(fCount) + " ]",
                  w_rendor - heightOfBar * 1.0,
                  h_rendor - heightOfBar - textHeight );
    }

    //old format
    // canvas.text(str(loopEndFrame) + " / " + str(fCount),
    //             w_rendor - heightOfBar * 1.2,
    //             h_rendor - heightOfBar - textHeight );

    canvas.noStroke();
    for(float i = 0; i < numberOfDots ; i++ ) {
      canvas.fill(barColor, transparencyOfBar);
      canvas.ellipse(  (w_rendor - lengthOfBar) / 2 + i * lengthOfBar / (numberOfDots - 1),
                        h_rendor - heightOfBar, radiusOfDots*3, radiusOfDots*3);
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
    // if(!playing) {
    //   int k = 100;
    //   canvas.fill(barColor, transparencyOfBar);
    //   canvas.triangle(w_rendor/2-k/3, h_rendor/2+k/3, w_rendor/2-k/3, h_rendor/2-k/3, w_rendor/2+k/3, h_rendor/2);
    // }

    //stop button
    // canvas.fill(barColor, transparencyOfBar);
    // canvas.ellipse(x_stop, y_stop, radiusOfStopButton, radiusOfStopButton);
    // canvas.fill(dotColor, transparencyOfDot);
    // canvas.rectMode(CENTER);
    // canvas.rect(x_stop, y_stop, radiusOfStopButton/3, radiusOfStopButton/3);

    //theremin button
    canvas.stroke(buttonColor);
    canvas.strokeWeight(lineWeight * 2);
    canvas.noFill();
    canvas.ellipse(buttonPosX, buttonPosY,
                    buttonRadius * 2, buttonRadius * 2);
    if ( theremin ) {
      canvas.fill(buttonColor);
      canvas.noStroke();
      canvas.ellipse(buttonPosX, buttonPosY,
                      innerButtonRadius * 2,
                      innerButtonRadius * 2);
    }
    canvas.noStroke();


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
    if(changingRatio) {
      ellipse(xpos + w_drag + (w_display - w_drag)*changeRatioTimer.liner()
              , ypos + h_display, radiusOfControlDot*2, radiusOfControlDot*2);
      stroke(closeMonitorSignColor, 255);
      ellipse(xpos + w_drag + (w_display - w_drag)*changeRatioTimer.liner()
              , ypos, radiusOfControlDot*2, radiusOfControlDot*2);
    }
    else {
      ellipse(xpos + w_display, ypos + h_display, radiusOfControlDot*2, radiusOfControlDot*2);
      stroke(closeMonitorSignColor, 255);
      ellipse(xpos + w_display, ypos, radiusOfControlDot*2, radiusOfControlDot*2);
    }
  }

  void fadeOutControlDotDisplay() {
    stroke(lineColor, 255 * (1-fadeOutTimer.liner()));
    strokeWeight(lineWeight);
    fill(backGroundColor, 255 * (1-fadeOutTimer.liner()));
    ellipse(xpos, ypos, radiusOfControlDot*2, radiusOfControlDot*2);
    ellipse(xpos + w_display, ypos + h_display, radiusOfControlDot*2, radiusOfControlDot*2);
    stroke(closeMonitorSignColor, 255 * (1-fadeOutTimer.liner()));
    ellipse(xpos + w_display, ypos, radiusOfControlDot*2, radiusOfControlDot*2);
  }

  void mousePressed(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
    // if ( !shifting ) {
    //   if ( dist(x, y, 0, 0) < radiusOfTheDot ) {
    //     shifting = true;
    //   }
    // }

    if ( !scaling ) {
      if ( dist(x, y, w_display, h_display) < radiusOfTheDot ) {
        scaling = true;
      }
    }

    if (startPlayingAndAdjusting) {
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

    if ( !scaling && !adjusting && !shifting &&
         !loopStartAdjusting && !loopEndAdjusting ) {
      if ( x > 0 && x < w_display &&
           y > 0 && y < h_display ) {
        if (startPlayingAndAdjusting && !springBind) {
          spring.bind(_mX,_mY,box);
          springBind = true;
        }
        else {
          shiftOffsetX = x;
          shiftOffsetY = y;
        }
        shifting = true;

      }
    }

  }

  void mouseDragged(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;
    if ( shifting ) {
      if (startPlayingAndAdjusting) {
        //spring.update(_mX, _mY);
      }
      else {
        xpos = xpos - accelOfShifting * ( xpos - ( _mX - shiftOffsetX ) ) ;
        ypos = ypos - accelOfShifting * ( ypos - ( _mY - shiftOffsetY ) ) ;
      }
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

      if (startPlayingAndAdjusting) {
        box.killBody();
        box = new Box(xpos + w_display / 2 , ypos + h_display / 2 ,
                        w_display + radiusOfShiftingDot * 2,
                        h_display + radiusOfShiftingDot * 2);
      }
    }

    if ( startPlayingAndAdjusting ) {
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
      if (springBind) {
        spring.destroy();
        springBind = false;
      }
      shifting = false;
    }
    if (scaling) {
      scaling = false;
    }
    if ( startPlayingAndAdjusting ){

      if (adjusting) {
        metro.startPlayingAt(currentFrame);
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
    if ( dist(x, y, w_display, 0) < radiusOfControlDot && !changingRatio && !fadeOut ) {
      fadeOut = true;
      fadeOutTimer.startTimer();
    }
    else if ( x > 0 && x < w_display && y > 0 && y < h_display) {

      //selectingFile
      if ( selectingFile ) {
        if ( !scaling && !shifting) {
        //   float _y = y * h_rendor / h_display;
        //   if (  _y < h_rendor / 3) {
        //     fileSelector.previousFile(); }
        //   else if ( _y < h_rendor * 2 / 3 ) {
        //     selectFile();
        //   }
        //   else if ( _y < h_rendor ) {
        //     fileSelector.nextFile(); }
          if ( y > h_display / 3 &&
               y < h_display * 2 / 3 ) {
            selectFile();
          }
        }
      }

      else {
        float _x = x * w_rendor / w_display;
        float _y = y * h_rendor / h_display;
        if ( dist ( _x, _y, buttonPosX, buttonPosY ) < buttonRadius ) {
          theremin = !theremin;
        }
        else if (mouseSense && adjustingSpeed) {
          if ( x < w_display/2 ) {
            metro.speedDown();
          }
          else {
            metro.speedUp();
          }
        }
        else if (mouseSense && changeColor) {
          changeColor();
        }
      }

      // playing/pause


      // else if (startPlayingAndAdjusting) {
      //   //stop
      //   float _x = x * w_rendor / w_display;
      //   float _y = y * h_rendor / h_display;
      //   // if ( dist( _x, _y, x_stop, y_stop) < radiusOfStopButton) {
      //   //   metro.stopAndReset();
      //   //   currentFrame = 0;
      //   //   playing = false;
      //   // }
      //
      //   //play and pause
      //   if (true) {
      //     if(playing) {
      //       metro.pause();
      //       playing = false;
      //     }
      //     else {
      //       playing = true;
      //       metro.startPlaying();
      //     }
      //   }
      // }
    }
  }

  void mouseSense(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;

    if (x > 0 && x < w_display
       && y > 0 && y < h_display ) {
      mouseSense = true;
      //selecting file
      if ( selectingFile ) {
        if ( !scaling && !shifting) {
          if (  y < h_display / 4   &&
                x > w_display / 4 &&
                x < w_display * 3 / 4 ) {
            if ( !fileSelector.movingForward &&
                 !fileSelector.movingBackward )
                 fileSelector.previousFile();
          }
          else if ( y > h_display * 3 / 4 &&
                    x > w_display / 4     &&
                    x < w_display * 3 / 4 ) {
            if ( !fileSelector.movingForward &&
                 !fileSelector.movingBackward )
                 fileSelector.nextFile();
          }
        }
      }
    }
    else {
      mouseSense = false;
    }

  }
  void speedReaction () {
    if (adjustingSpeed && mouseSense) {
      canvas.noStroke();
      canvas.rectMode(CORNER);
      canvas.fill(loopStartSignColor,80);
      canvas.rect(0, 0, w_rendor/2, h_rendor);
      canvas.fill(loopEndSignColor,80);
      canvas.rect(w_rendor/2, 0, w_rendor/2, h_rendor);
      speedInfo();
    }
  }
  void speedInfo() {
    textSize(20);
    fill(255);
    pushMatrix();
    translate( xpos + w_display / 2, ypos - 18);
    // String t = "[ speed : " + nfs(metro.framerate(), 3, 2) + "  f/sec ]";
    String t = "[ speed : " + nfs(metro.framerate(), 3, 2) + "  f/sec ] " + str(id);

    textAlign(CENTER, CENTER);
    //rotate(-PI/2);
    text(t, 0, 0);
    popMatrix();
  }
  void changeColor() {
    if (colorIndex == etudeCircle.length-1 ) {
      colorIndex = 0;
    }
    else {
      colorIndex++;
    }
    backGroundColor = etudeCircle[colorIndex];
  }
}
