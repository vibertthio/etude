class Presets {
  //constant
  // int
  ArrayList<Preset> list0;
  ArrayList<Preset> list1;
  ArrayList<Preset> list2;
  ArrayList<Preset> list3;
  ArrayList<Preset> list4;

  Preset p0_0 = new Preset(100, 100, 0, 200, 0, 50, 50, 100, 60, 0);
  Preset p0_1 = new Preset(500, 200, 0, 200, 1, 50, 50, 100, 60, 1);
  Preset p0_2 = new Preset(100, 400, 0, 200, 2, 50, 50, 100, 60, 2);
  Preset p0_3 = new Preset(500, 500, 0, 200, 3, 50, 50, 100, 60, 3);

  Preset p1_0 = new Preset(100, 100, 0, 200, 6,  30, 100, 200, 110, 0);
  Preset p1_1 = new Preset(600, 100, 0, 200, 10, 30, 70, 120, 60, 1);
  Preset p1_2 = new Preset(100, 400, 0, 200, 11, 30, 20, 120, 60, 2);
  Preset p1_3 = new Preset(600, 400, 0, 200, 14, 30, 30, 130, 60, 3);

  Preset p2_0 = new Preset(100, 100, 0, 200, 4, 50, 50, 100, 60, 0);
  Preset p2_1 = new Preset(600, 100, 0, 200, 8, 50, 50, 100, 60, 1);
  Preset p2_2 = new Preset(100, 400, 0, 200, 12, 50, 50, 100, 60, 2);

  Preset p3_0 = new Preset(800, 500, 0, 200, 9, 50, 50, 100, 60, 0);
  Preset p3_1 = new Preset(1000, 800, 0, 200, 16, 25, 0, 100, 60, 1);
  Preset p3_2 = new Preset(100, 100, 0, 200, 17, 25, 0, 100, 60, 1);

  Preset p4_0 = new Preset(100, 100, 0, 200, 9, 50, 50, 100, 60, 0);
  Preset p4_1 = new Preset(400, 100, 0, 200, 16, 25, 0, 100, 60, 1);
  Preset p4_2 = new Preset(700, 100, 0, 200, 17, 25, 0, 100, 60, 1);
  Preset p4_3 = new Preset(1000, 100, 0, 200, 9, 50, 50, 100, 60, 0);
  Preset p4_4 = new Preset(1300, 100, 0, 200, 16, 25, 0, 100, 60, 1);
  Preset p4_5 = new Preset(1600, 100, 0, 200, 17, 25, 0, 100, 60, 1);
  Preset p4_6 = new Preset(100, 400, 0, 200, 9, 50, 50, 100, 60, 0);
  Preset p4_7 = new Preset(400, 400, 0, 200, 16, 25, 0, 100, 60, 1);
  Preset p4_8 = new Preset(700, 400, 0, 200, 17, 25, 0, 100, 60, 1);


  Presets() {
    list0 = new ArrayList<Preset>();
    list1 = new ArrayList<Preset>();
    list2 = new ArrayList<Preset>();
    list3 = new ArrayList<Preset>();
    list4 = new ArrayList<Preset>();

    list0.add(p0_0);
    list0.add(p0_1);
    list0.add(p0_2);
    list0.add(p0_3);

    list1.add(p1_0);
    list1.add(p1_1);
    list1.add(p1_2);
    list1.add(p1_3);

    list2.add(p2_0);
    list2.add(p2_1);
    list2.add(p2_2);

    list3.add(p3_0);
    list3.add(p3_1);
    list3.add(p3_2);

    list4.add(p4_0);
    list4.add(p4_1);
    list4.add(p4_2);
    list4.add(p4_3);
    list4.add(p4_4);
    list4.add(p4_5);
    list4.add(p4_6);
    list4.add(p4_7);
    list4.add(p4_8);
  }

  // Preset get(int i) {
  //   return list.get(i);
  // }
}

class Preset {
  float x;
  float y;
  int w;
  int h;
  int fileIndex;
  String fileName;
  int colorIndex;
  int limit;
  int startFrameCount;
  int endFrameCount;
  int currentFrame;

  Preset(float _x, float _y, int _w, int _h,
         int fi, int l, int s, int e, int c, int col) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    fileIndex = fi;
    limit = l;
    startFrameCount = s;
    endFrameCount = e;
    currentFrame = c;
    colorIndex = col;
  }
  Preset(float _x, float _y, int _w, int _h,
         String fn, int l, int s, int e, int c, int col) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    fileName = fn;
    limit = l;
    startFrameCount = s;
    endFrameCount = e;
    currentFrame = c;
    colorIndex = col;
  }
}
