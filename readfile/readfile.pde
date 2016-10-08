//constant
int numberOfData = 36;
int fRate = 20;
int timeSlot = 1000/fRate;

//variable
int lineCount = 0;
int dataCount = 0;
int fCount = 0;
int currentFrame = 0;
boolean finishReading;
int[][] dataStorage;

//skeleton variable
Skeleton skeleton;

//Metro
Metro metro;

BufferedReader reader;
String line;

void setup() {
  frameRate(200);
  size(512, 424);
  background(0);

  /*********READ LINE***********/
  finishReading = false;
  String fileName = "U8221233.txt"; 
  reader = createReader(fileName);
           //createReader("U826190.txt");
           //createReader("U8221233.txt");
           //createReader("U825159.txt");
           //createReader("test.txt");

  dataStorage = new int[10000][numberOfData];
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
      //println("-------" + lineCount +"-------");
      String[] pieces = split(line, ' ');
      for( int i=0, n=pieces.length; i<n; i++) {
        string2Buffer(pieces[i]); }
    }
  }

  skeleton = new Skeleton();
  metro = new Metro(true ,timeSlot);
}

void draw() {
  background(0);
  skeleton.display();
  println("Frame Count : " + currentFrame);
  //print("check");

  if(metro.frameCount() > currentFrame) {
    skeleton.set(dataStorage[currentFrame]);
    currentFrame++;
    if(currentFrame >= fCount) {
      currentFrame = 0;
      metro.stop();
      metro.start();
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


void keyPressed() {
  if(key == 'p') {
    metro.start();
  }
  if(key == 'o') {
    metro.pause();
  }
  if(key == 's') {
    metro.stop();
    currentFrame = 0;
  }
}