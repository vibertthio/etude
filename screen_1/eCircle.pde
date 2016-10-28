class eCircle {
  eCircle() {

  }

  void display() {

  }

  void update() {

  }

  void recept() {

  }

}

class eCircleClient {
  eCircleClient() {

  }

  boolean signalFilter() {
    return true;
  }

  void display() {

  }

  void messageEvent(OscMessage msg) {
    float x = msg.get(0).floatValue();
    float y = msg.get(1).floatValue();
    float sz = msg.get(2).floatValue();
    float alpha = msg.get(3).floatValue();
    int colId = msg.get(4).intValue();
    int trg = msg.get(5).intValue();

    println("x : " + str(x));
    println("y : " + str(y));
    println("sz : " + str(sz));
    println("alpha : " + str(alpha));
    println("colId : " + str(colId));
    println("trg : " + str(trg));
  }

}
