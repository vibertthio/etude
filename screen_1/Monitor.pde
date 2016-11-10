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
  int triggerKey = -1;
  //int[][] dataStorage;

  boolean loadPreset;
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
  int colorIndex = 0;
  color backGroundColor = etudeCircle[colorIndex];
  color closeMonitorSignColor = color (242, 38, 19);


  //Metro & TimeLine & Time constant
  Metro metro;
  TimeLine changeRatioTimer;
  TimeLine dissolveTimer;
  TimeLine transientTimer;
  TimeLine fadeOutTimer;
  TimeLine soundReactionTimer; // sound reaction
  TimeLine soundTextReactionTimer;

  int changeRatioTime = 400;
  float changeRatioTimeRate = 6;
  int dissolveTime = 400;
  float dissolveTimeRate = 0.7;
  int waitingForFileSelectorTime = 500;
  int waitingForFileSelectorStartTime;
  int transientTime = 200;
  float transientTimerRate = 0.7;

  int soundReactionTime = 250;
  float soundReactionTimerRate = 0.5;
  int soundTextReactionTime = 600;
  float soundTextReactionTimerRate = 0.5;

  //sound reaction
  color soundReactionColor = color (247, 202, 24);
  int soundReactionIndex = 0;

  // color soundReactionTextColor = color (249, 105, 14); //orange
  color soundReactionTextColor = color (255, 255, 255);
  int soundReactionTextSize = 30;
  int soundReactionX = 80;
  int soundReactionY = 50;

  //Box2D
  Box box;
  Spring spring;


  //constructor ( regular and preset )
  Monitor(float _xpos, float _ypos, int _w_drag, int _h_drag, int _id) {
    canvas = createGraphics(w_rendor, h_rendor);
    xpos = _xpos;
    ypos = _ypos;
    h_drag = _h_drag;
    w_drag = _w_drag;
    h_display = _h_drag;
    w_display = int(_h_drag * (float(w_rendor) / float(h_rendor)));
    id = _id;
    initBackGroundColor();

    fileSelector = new FileSelector(canvas, w_rendor, h_rendor, id, colorIndex); //fileList is global
    skeleton = new Skeleton(canvas, id);
    metro = new Metro(false ,timeSlot);

    // canvas.textFont(fileSelector.font, textSize);

    //status variable
    loadPreset = false;
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
    soundTextReactionTimer = new TimeLine(soundTextReactionTime);
    soundTextReactionTimer.setLinerRate(soundTextReactionTimerRate);
    soundTextReactionTimer.turnOffTimer();
    changeRatioTimer.startTimer();

  }
  Monitor(Preset pre, int _id) {
    canvas = createGraphics(w_rendor, h_rendor);
    xpos = pre.x;
    ypos = pre.y;
    h_drag = pre.h;
    w_drag = pre.w;
    h_display = pre.h;
    w_display = int(h_drag * (float(w_rendor) / float(h_rendor)));
    id = _id;

    changeColor(pre.colorIndex);
    fileSelector = new FileSelector(canvas, w_rendor, h_rendor, id, colorIndex); //fileList is global
    skeleton = new Skeleton(canvas, id);
    metro = new Metro(false ,pre.limit);

    // textFont(fileSelector.font, textSize);

    //status variable
    loadPreset = true;
    changingRatio = true;
    selectingFile = false;
    waitingForFileSelector = false;  //use dissolveTimer
    fileSelectorFadeOut = false;     //use dissolveTimer
    skeletonFadeIn = false;          //use dissolveTimer
    startPlayingAndAdjusting = false;
    fadeOut = false;
    dissappear = false;

    if (pre.triggerKey != -1) {
      triggerByKey = true;
      triggerKey = pre.triggerKey;
    }

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
    soundTextReactionTimer = new TimeLine(soundTextReactionTime);
    soundTextReactionTimer.setLinerRate(soundTextReactionTimerRate);
    soundTextReactionTimer.turnOffTimer();
    changeRatioTimer.startTimer();

    //setting for preset
    index = pre.fileIndex;
    fileSelector.index = pre.fileIndex;
    // selectFile();
    loopStartFrame = pre.startFrameCount;
    loopEndFrame = pre.endFrameCount;
    currentFrame = pre.currentFrame;
  }

  void selectFile() {
    if (!loadPreset)
      index = fileSelector.index;
    if (!loadedList[index]) {
      fileSelector.selectFile();
      fCount = fileSelector.fCount;
    }
    else {
      fCount = fcount[index];
    }

    selectingFile = false;   //starttimer to make the animation
    if (!loadPreset) {
      fileSelectorFadeOut = true;
      loopStartFrame = 0;
      loopEndFrame = fCount;
      dissolveTimer.startTimer();
    }
    else {
      startPlaySkeleton();
    }

  }
  void boxUpdate(float _mX, float _mY) {
    if (startPlayingAndAdjusting) {
      // if( id%3 != 2 && id < 8 && physicsWork )
      //   box2d.step();
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
            // if ( !loadPreset )
            startPlaySkeleton();
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
          canvas.rect(0, 0, w_rendor, h_rendor);
          if (selected) {
            selectedDisplay();
          }
          skeleton.display();
          if(theremin) { skeleton.thereminDisplay(); }
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
              if (triggerByKey) {
                metro.pause();
              }
              else {
                //regular loop
                currentFrame = loopStartFrame;
                metro.startPlayingAt(loopStartFrame);
              }
            }
          }
          soundReaction();
          speedReaction();
          dateInfo();
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

        // regulat
        if ( !loadPreset ) {
          waitingForFileSelector = true;
        }
        // preset
        else {
          selectFile();
        }
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
      if ( !selected ) { strokeWeight(lineWeight); }
      else { strokeWeight(lineWeight * 4); }

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

    //OTHER DISPLAY FUNCTION
    //box2D
    if ( dissappear && boxCreated ) {
      box.killBody();
      boxCreated = false;
    }
    else if ( boxCreated ){
      //box.display();
      spring.display();
    }

    //scaling info
    if (scaling) {
      hwInfo(xpos, xpos + w_display, ypos, ypos + h_display);
    }


  }

  void sendSound() {
    if ( startPlayingAndAdjusting) {
      //pose1, pose2, pose3, pose4
      if ( skeleton.soundPose1() ) {
        soundReactionTimer.startTimer();
        soundTextReactionTimer.startTimer();
        soundReactionIndex = 1;
      }
      if ( skeleton.soundPose2() ) {
        soundReactionTimer.startTimer();
        soundTextReactionTimer.startTimer();
        soundReactionIndex = 2;
      }
      if ( skeleton.soundPose3_l() ) {
        soundReactionTimer.startTimer();
        soundTextReactionTimer.startTimer();
        soundReactionIndex = 3;
      }
      if ( skeleton.soundPose3_r() ) {
        soundReactionTimer.startTimer();
        soundTextReactionTimer.startTimer();
        soundReactionIndex = 3;
      }
      if ( skeleton.soundPose4() ) {
        soundReactionTimer.startTimer();
        soundTextReactionTimer.startTimer();
        soundReactionIndex = 4;
      }

      if (theremin) {
        skeleton.thereminSignal();
      }

      //soundReaction();
    }
  }

  void soundReaction() {
    if ( soundTextReactionTimer.liner() < 1
      && soundTextReactionTimer.state
      && startPlayingAndAdjusting ) {
      //println("REACTION!!!!");
      String react = "X";
      switch ( soundReactionIndex ) {
        case 1:
          react = "Up";
          break;
        case 2:
          react = "Bend";
          break;
        case 3:
          react = "Grab";
          break;
        case 4:
          react = "Lift";
          break;
      }

      // println("DRAW!!!!");
      // println("soundReactionTimer.liner() = " + soundReactionTimer.liner());
      canvas.fill(soundReactionColor,
              255 * ( 1 - soundReactionTimer.liner() ));
      canvas.noStroke();
      canvas.rectMode(CORNER);
      canvas.rect(0, 0, w_rendor, h_rendor);
      canvas.textAlign(LEFT, CENTER);
      canvas.textSize(soundReactionTextSize);
      canvas.fill(soundReactionTextColor,
              255 * ( 1 - soundTextReactionTimer.liner() ));
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
  void startPlaySkeleton() {
    skeletonFadeIn = true;
    dissolveTimer.startTimer();
    if ( !loadPreset ) {
      playing = true;
      metro.startPlayingAt(currentFrame);
    }
    skeleton.set(dataStorage[index][currentFrame]);
  }



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
  boolean selected = false;
  boolean triggerByKey = false;


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
    canvas.textFont(fileSelector.font, textSize);
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
                        h_rendor - heightOfBar, radiusOfDots, radiusOfDots);
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
    //layer
    pushMatrix();
    translate(0, 0, 1);

    stroke(lineColor, 255);
    if (!selected) { strokeWeight(lineWeight); }
    else { strokeWeight(lineWeight * 4); }
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

    popMatrix();
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
      if ( h_new > 20 && w_new > 20) {
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
        else if (selectingMonitor) {
          selected = !selected;
        }
        else if (selectingTriggerMonitor) {
          switchTriggerKey();
        }
        else if (mouseSense && adjustingSpeed) {
          if ( x < w_display / 5 ) {
            metro.adjustSpeed(0.5);
          }
          else if ( x < w_display * 2 / 5){
            metro.speedDown();
          }
          else if ( x < w_display * 3 / 5){
            metro.setLimit(timeSlot);
          }
          else if ( x < w_display * 4 / 5){
            metro.speedUp();
          }
          else {
            metro.adjustSpeed(2);
          }
        }
        else if (mouseSense && changeColor) {
          changeColor();
        }
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
    int n = 5;
    if (adjustingSpeed && mouseSense) {
      canvas.noStroke();
      canvas.rectMode(CORNER);
      for (int i = 0; i < n; i++) {
        color c = (loopStartSignColor * i / n) + (loopEndSignColor * (n-i) / n);
        canvas.fill(c,80);
        canvas.rect(w_rendor * i / n, 0, w_rendor/n, h_rendor);
      }
      speedInfo();
    }
  }
  void speedInfo() {
    textSize(20);
    fill(255);
    pushMatrix();
    translate( xpos + w_display / 2, ypos - 18);
    // String t = "[ speed : " + nfs(metro.framerate(), 3, 2) + "  f/sec ]";
    String t = "[ speed : " + nfs(metro.framerate(), 3, 2)
             + "  f/sec ] "
             + " id : " + str(id)
             + " key : " + str(triggerKey);

    textAlign(CENTER, CENTER);
    //rotate(-PI/2);
    text(t, 0, 0);
    popMatrix();
  }
  void dateInfo() {
    textSize(20);
    fill(255);
    pushMatrix();
    translate( xpos , ypos + h_display + 18);
    String t = "  [ " + fileList[index] +  " ]    date : " + dateList[index];
    textAlign(LEFT, CENTER);
    text(t, 0, 0);
    popMatrix();
  }
  void initBackGroundColor() {
    int i = 3;
    if (firstColor) { i = 0; }
    else if (secondColor) { i = 1; }
    else if (thirdColor) { i = 2; }
    changeColor(i);
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
  void changeColor (int i) {
    colorIndex = i;
    backGroundColor = etudeCircle[colorIndex];
  }
  void triggerPlay() {
    currentFrame = loopStartFrame;
    metro.startPlayingAt(loopStartFrame);
  }
  void pause() {
    metro.pause();
  }
  void selectedDisplay() {
    // canvas.fill(255,255,255, 150 * cursorTimer.liner());
    // canvas.rectMode(CORNER);
    // canvas.rect(0, 0, w_rendor, h_rendor);
  }
  boolean contain(float _mX, float _mY) {
    float x = _mX - xpos;
    float y = _mY - ypos;

    if (x > 0 && x < w_display
       && y > 0 && y < h_display ) { return true; }
    else { return false; }
  }
  void switchTriggerKey() {
    if (!triggerByKey) {
      triggerByKey = true;
      triggerKey = 0;
    }
    else {
      if (triggerKey == triggerGroupNumber) {
        triggerByKey = false;
        triggerKey = -1;
      }
      else {
        triggerKey++;
      }
    }
  }
  void switchTriggerKey(int b) {
    if ( b >= 0 && b <= triggerGroupNumber) {
      triggerByKey = true;
      triggerKey = b;
    }
  }
  void switchOffTriggerKey() {
    triggerByKey = false;
    triggerKey = -1;
  }
}
