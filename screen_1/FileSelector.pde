class FileSelector {

  //constant
  int numberOfFileToDisplay = 5;
  int numberOfFiles;
  int textSizeLarge = 60;
  int textSizeSmall = 15;
  String fontType = "SansSerif";
  int timeConstant = 200;
  int widthOfArrows = 35;
  int correctionOfLarge = 8;
  int correctionOfSmall = 0;
  int numberOfData = 36;
  int arrowWeight = 4;


  //variable
  PGraphics canvas;
  PFont font;
  int lineCount = 0;
  int dataCount = 0;
  int fCount = 0;
  int id = -1;

  //int[][] dataStorage;


  //color
  color colorOfArrows = color (38, 166, 91);


  float w_rendor = 512;
  float h_rendor = 424;




  //new variable
  float gap = h_rendor / 8;
  float gap_2 = h_rendor / 6;
  int index = 2;

  //status variable
  boolean movingForward = false;
  boolean movingBackward = false;

  //String[] fileList;

  //TimeLine
  TimeLine timeLine;
  int shiftTime = 300;


  //constructor
  FileSelector(PGraphics _canvas, float w, float h, int _id) {
    canvas = _canvas;
    //fileList = _fileList;
    numberOfFiles = fileList.length;
    font = createFont (fontType, textSizeSmall, true);
    timeLine = new TimeLine (400);
    //dataStorage = new int[maxFrameNumber][numberOfData];
    id = _id;

    w_rendor = w;
    h_rendor = h;
  }



  void display() {
    canvas.background(localBackGroundColor);

    //arrows
    canvas.stroke(colorOfArrows, 255);
    canvas.strokeWeight(arrowWeight);
    canvas.line(w_rendor * 0.5, gap * 0.5 , (w_rendor - widthOfArrows) * 0.5, gap * 0.7 );
    canvas.line(w_rendor * 0.5, gap * 0.5, (w_rendor + widthOfArrows) * 0.5, gap * 0.7 );
    canvas.line(w_rendor * 0.5, h_rendor - gap * 0.5, (w_rendor - widthOfArrows) * 0.5, h_rendor - gap * 0.7 );
    canvas.line(w_rendor * 0.5, h_rendor - gap * 0.5, (w_rendor + widthOfArrows) * 0.5, h_rendor - gap * 0.7 );

    // for(int i = -5; i <= 5; i++) {
    //   canvas.line(0, h_rendor / 2 + i * gap , w_rendor, h_rendor / 2 + i * gap);
    // }

    //texts
    canvas.fill(255);
    canvas.textAlign(CENTER, CENTER);

    //static
    if ( !movingForward && !movingBackward ) {
      //index - 2
      int i = index - 2;
      if (i == -1) { i = numberOfFiles - 1; }
      else if ( i == -2) { i = numberOfFiles - 2; }
      canvas.textFont(font, textSizeSmall);
      canvas.text( fileList[i], w_rendor / 2,
                   h_rendor / 2 - gap - gap_2 - correctionOfSmall);
      //index - 1
      i = index - 1;
      if (i == -1) { i = numberOfFiles - 1; }
      canvas.textFont(font, textSizeSmall);
      canvas.text( fileList[i], w_rendor / 2,
                   h_rendor / 2 - gap_2 - correctionOfSmall);

      //index
      // i = index;
      // canvas.textFont(font, textSizeLarge);
      // canvas.text( fileList[i] + str(id), w_rendor / 2, h_rendor / 2 - correctionOfLarge);
      //index
      i = index;
      canvas.textFont(font, textSizeLarge);
      canvas.text( fileList[i], w_rendor / 2, h_rendor / 2 - correctionOfLarge);

      //index + 1
      i = index + 1;
      if (i == numberOfFiles) { i = 0; }
      canvas.textFont(font, textSizeSmall);
      canvas.text( fileList[i], w_rendor / 2,
                   h_rendor / 2 + gap_2 - correctionOfSmall);

      //index - 2
      i = index + 2;
      if (i == numberOfFiles) { i = 0; }
      else if ( i == numberOfFiles + 1 ) { i = 1; }
      canvas.textFont(font, textSizeSmall);
      canvas.text( fileList[i], w_rendor / 2,
                   h_rendor / 2 + gap + gap_2 - correctionOfSmall);


    }

    //moving forward
    else if ( movingForward ){
      if ( timeLine.state ) {
        float hei;
        float tranparency;
        int size;
        int i;

        //appearing index - 3
        i = index - 3;
        if (i == -1) { i = numberOfFiles - 1; }
        else if ( i == -2) { i = numberOfFiles - 2; }
        else if ( i == -3) { i = numberOfFiles - 3; }
        size = textSizeSmall;
        hei = ( h_rendor / 2 - 2 * gap - gap_2 - correctionOfSmall ) + gap * timeLine.liner();
        tranparency = 255 * timeLine.liner();
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);


        // index - 2
        i = index - 2;
        if (i == -1) { i = numberOfFiles - 1; }
        else if ( i == -2) { i = numberOfFiles - 2; }
        size = textSizeSmall;
        hei = ( h_rendor / 2 - gap - gap_2 - correctionOfSmall )
              + ( gap ) * timeLine.liner();
        tranparency = 255;
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);

        //index - 1
        i = index - 1;
        if (i == -1) { i = numberOfFiles - 1; }
        size = textSizeSmall + int( (textSizeLarge - textSizeSmall) * timeLine.liner() );
        hei = ( h_rendor / 2 - gap_2 - correctionOfSmall )
              + ( gap_2 - correctionOfLarge + correctionOfSmall ) * timeLine.liner();
        tranparency = 255;
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);

        //index
        i = index;
        size = textSizeLarge + int( (textSizeSmall - textSizeLarge) * timeLine.liner() );
        hei = ( h_rendor / 2 - correctionOfLarge )
              + ( gap_2 + correctionOfLarge - correctionOfSmall ) * timeLine.liner();
        tranparency = 255;
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);

        //index + 1
        i = index + 1;
        if (i == numberOfFiles) { i = 0; }
        size = textSizeSmall;
        hei = ( h_rendor / 2 + gap_2 - correctionOfSmall )
              + ( gap ) * timeLine.liner();
        tranparency = 255;
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);

        //index + 2
        i = index + 2;
        if (i == numberOfFiles) { i = 0; }
        else if ( i == numberOfFiles + 1 ) { i = 1; }
        size = textSizeSmall;
        hei = ( h_rendor / 2 + gap + gap_2 - correctionOfSmall )
              + ( gap ) * timeLine.liner();
        tranparency = 255 * ( 1-timeLine.liner() );
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);
      }

      else {
        movingForward = false;
        if (index > 0)
          index--;
        else
          index = numberOfFiles - 1;
        display();
      }
    }

    //moving backward
    else if ( movingBackward ) {
      if ( timeLine.state ) {
        float hei;
        float tranparency;
        int size;
        int i;

        //index - 2
        i = index - 2;
        if (i == -1) { i = numberOfFiles - 1; }
        else if ( i == -2) { i = numberOfFiles - 2; }
        size = textSizeSmall;
        hei = ( h_rendor / 2 - gap - gap_2 - correctionOfSmall ) - gap * timeLine.liner();
        tranparency = 255 * (1 - timeLine.liner());
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);


        // index - 1
        i = index - 1;
        if (i == -1) { i = numberOfFiles - 1; }
        size = textSizeSmall;
        hei = ( h_rendor / 2 - gap_2 - correctionOfSmall )
              - ( gap ) * timeLine.liner();
        tranparency = 255;
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);

        //index
        i = index;
        size = textSizeLarge + int( (textSizeSmall - textSizeLarge) * timeLine.liner() );
        hei = ( h_rendor / 2 - correctionOfLarge )
              - ( gap_2 - correctionOfLarge + correctionOfSmall ) * timeLine.liner();
        tranparency = 255;
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);

        //index + 1
        i = index + 1;
        if (i == numberOfFiles) { i = 0; }
        size = textSizeSmall + int( (textSizeLarge - textSizeSmall) * timeLine.liner() );
        hei = ( h_rendor / 2 + gap_2 - correctionOfSmall )
              - ( gap_2 + correctionOfLarge - correctionOfSmall ) * timeLine.liner();
        tranparency = 255;
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);

        //index + 2
        i = index + 2;
        if (i == numberOfFiles) { i = 0; }
        else if ( i == numberOfFiles + 1 ) { i = 1; }
        size = textSizeSmall;
        hei = ( h_rendor / 2 + gap + gap_2 - correctionOfSmall )
              - ( gap ) * timeLine.liner();
        tranparency = 255;
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);

        //appearing
        i = index + 3;
        if (i == numberOfFiles) { i = 0; }
        else if ( i == numberOfFiles + 1 ) { i = 1; }
        else if ( i == numberOfFiles + 2 ) { i = 2; }
        size = textSizeSmall;
        hei = ( h_rendor / 2 + 2 * gap + gap_2 - correctionOfSmall )
              - ( gap ) * timeLine.liner();
        tranparency = 255 * timeLine.liner();
        canvas.fill(255, tranparency);
        canvas.textFont(font, size);
        canvas.text( fileList[i], w_rendor / 2, hei);
      }

      else {
        movingBackward = false;
        if (index < numberOfFiles - 1)
          index++;
        else
          index = 0 ;
        display();
      }
    }
  }

  //void update() {}

  void nextFile() {
    if( !movingForward && !movingBackward) {
      movingForward = true;
      timeLine.startTimer();
    }
  }

  void previousFile() {
    if( !movingForward && !movingBackward) {
      movingBackward = true;
      timeLine.startTimer();
    }
  }

  void selectFile() {
    if (!movingForward && !movingBackward) {
      readFile();
    }
  }


  void readFile() {
    BufferedReader reader;
    String line;
    String fName = fileList[index] + ".txt";
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

    //update the global variables
    fcount[index] = fCount;
    loadedList[index] = true;
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
      dataStorage[index][fCount][dataCount] = data;
      dataCount++;

      if ( dataCount == numberOfData ) {
        dataCount = 0; //finish one set of data
        fCount++;
      }
    }
  }

}
