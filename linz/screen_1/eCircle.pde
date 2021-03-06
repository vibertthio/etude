class eCircle {
  int circleId = -1;
  float x = 0;
  float y = 0;
  float sz = 0;
  float alpha = 0;
  int colId = 1;
  int trg = 0;

  color[] colorOfCircles = {
    color(135, 135, 196),
    color(33, 175, 114),
    color(181, 48, 71),
    color(89, 119, 211),
    color(137, 81, 204),
  };

  eCircle(int _id) {
    circleId = _id;
  }

  void display() {
    if ( trg == 1 ) {
      if ( (x > (0 - sz)) &&
           (x < (width + sz)) ) {
        noStroke();
        fill(colorOfCircles[colId], alpha);
        ellipse(x, y, sz*2, sz*2);
      }
    }
  }

  void update(float _x, float _y, float _sz, float _alpha, int _colId, int _trg) {
    x = _x;
    y = _y;
    sz = _sz;
    alpha = _alpha;
    colId = _colId;
    trg = _trg;
  }
}

class eCircleClient {
  eCircle[] eCircles;
  int numberOfeCircles = 40;

  eCircleClient() {
    eCircles = new eCircle[numberOfeCircles];
    for(int i=0; i<numberOfeCircles; i++) {
      eCircles[i] = new eCircle(i);
    }
  }

  void display() {
    for(int i=0; i<numberOfeCircles; i++) {
      eCircles[i].display();
    }
  }

  void messageEvent(OscMessage msg) {
    int circleId = msg.get(0).intValue();
    // float x = msg.get(1).floatValue();
    float x;
    try {
      x = msg.get(1).floatValue();
    } catch(NumberFormatException e) {
      int x_buf = msg.get(1).intValue();
      x = float(x_buf);
    }
    float y = msg.get(2).floatValue();
    float sz = msg.get(3).floatValue();
    float alpha = msg.get(4).floatValue();
    int colId = msg.get(5).intValue();
    int trg = msg.get(6).intValue();

    // x = map(x, -21.24, 21.24, 0, 3 * width);

    x = map(x, -15, 15, 0, 3 * width);
    y = map(y, -4, 4, height, 0);
    sz = map(sz, 0, 4, 0, height/2);
    alpha = map(alpha, 0, 1, 127, 255);
    // print("id[" + circleId + "]  ");
    // print("x : " + str(x));
    // print(" y : " + str(y));
    // print(" sz : " + str(sz));
    // print(" alpha : " + str(alpha) + "\n");
    // print("col : " + str(colId));
    // print(" trg : " + str(trg));
    // print(" time: " + millis() + "\n");
    // println("------------------------");

    eCircles[circleId].update(x, y, sz, alpha, colId, trg);
  }

}
