class Presets {
  //constant
  Preset[] files;

  // Preset f00 = new Preset(100, 100, 0, 200, 0, 50, 50, 100, 60, 0);
  // Preset f01 = new Preset(100, 100, 0, 200, 1, 50, 50, 100, 60, 0);
  // Preset f02 = new Preset(100, 100, 0, 200, 2, 50, 50, 100, 60, 0);
  // Preset f03 = new Preset(100, 100, 0, 200, 3, 50, 50, 100, 60, 0);
  // Preset f04 = new Preset(100, 100, 0, 200, 4, 50, 50, 100, 60, 0);
  // Preset f05 = new Preset(100, 100, 0, 200, 5, 50, 50, 100, 60, 0);
  // Preset f06 = new Preset(100, 100, 0, 200, 6, 50, 50, 100, 60, 0);
  // Preset f07 = new Preset(100, 100, 0, 200, 7, 50, 50, 100, 60, 0);
  // Preset f08 = new Preset(100, 100, 0, 200, 8, 50, 50, 100, 60, 0);
  // Preset f09 = new Preset(100, 100, 0, 200, 9, 50, 50, 100, 60, 0);
  // Preset f10 = new Preset(100, 100, 0, 200, 10, 50, 50, 100, 60, 0);
  // Preset f11 = new Preset(100, 100, 0, 200, 11, 50, 50, 100, 60, 0);
  // Preset f12 = new Preset(100, 100, 0, 200, 12, 50, 50, 100, 60, 0);
  // Preset f13 = new Preset(100, 100, 0, 200, 13, 50, 50, 100, 60, 0);
  // Preset f14 = new Preset(100, 100, 0, 200, 14, 50, 50, 100, 60, 0);
  // Preset f15 = new Preset(100, 100, 0, 200, 15, 50, 50, 100, 60, 0);
  // Preset f16 = new Preset(100, 100, 0, 200, 16, 50, 50, 100, 60, 0);
  // Preset f17 = new Preset(100, 100, 0, 200, 17, 50, 50, 100, 60, 0);
  //

  ArrayList <Preset[]> lists;
  Preset[] list0;
  Preset[] list1;
  Preset[] list2;
  Preset[] list3;
  Preset[] list4;
  Preset[] list5;

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

  Preset p5_0 = new Preset(100, 100, 0, 200, 18, 50, 440, 480, 440, 0);
  Preset p5_1 = new Preset(400, 100, 0, 200, 18, 50, 440, 480, 445, 1);
  Preset p5_2 = new Preset(700, 100, 0, 200, 18, 50, 440, 480, 450, 2);
  Preset p5_3 = new Preset(1000, 100, 0, 200, 18, 50, 440, 480, 455, 3);
  Preset p5_4 = new Preset(100, 400, 0, 200, 18, 50, 440, 480, 460, 1);
  Preset p5_5 = new Preset(400, 400, 0, 200, 18, 50, 440, 480, 465, 1);
  Preset p5_6 = new Preset(700, 400, 0, 200, 18, 50, 440, 480, 470, 1);
  Preset p5_7 = new Preset(1000, 400, 0, 200, 18, 50, 440, 480, 475, 1);


  Presets() {
    lists = new ArrayList <Preset[]> ();
    list0 = new Preset[4];
    list1 = new Preset[4];
    list2 = new Preset[3];
    list3 = new Preset[3];
    list4 = new Preset[9];
    list5 = new Preset[8];

    list0[0] = p0_0;
    list0[1] = p0_1;
    list0[2] = p0_2;
    list0[3] = p0_3;

    list1[0] = p1_0;
    list1[1] = p1_1;
    list1[2] = p1_2;
    list1[3] = p1_3;

    list2[0] = (p2_0);
    list2[1] = (p2_1);
    list2[2] = (p2_2);

    list3[0] = (p3_0);
    list3[1] = (p3_1);
    list3[2] = (p3_2);

    list4[0] = (p4_0);
    list4[1] = (p4_1);
    list4[2] = (p4_2);
    list4[3] = (p4_3);
    list4[4] = (p4_4);
    list4[5] = (p4_5);
    list4[6] = (p4_6);
    list4[7] = (p4_7);
    list4[8] = (p4_8);

    list5[0] = (p5_0);
    list5[1] = (p5_1);
    list5[2] = (p5_2);
    list5[3] = (p5_3);
    list5[4] = (p5_4);
    list5[5] = (p5_5);
    list5[6] = (p5_6);
    list5[7] = (p5_7);


    lists.add(list0);
    lists.add(list1);
    lists.add(list2);
    lists.add(list3);
    lists.add(list4);
    lists.add(list5);

    int n = fileList.length;
    files = new Preset[n];
    for (int i = 0; i < n ; i++ ) {
      files[i] = new Preset(100, 100, 0, 200, i, 50, 50, 100, 60, i%4);
    }


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
