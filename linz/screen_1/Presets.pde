class Presets {
  //constant
  Preset[] files;

  ArrayList <Preset[]> lists;
  Preset[] list0;
  Preset[] list1;
  Preset[] list2;
  Preset[] list3;
  Preset[] list4;
  Preset[] list5;
  Preset[] list6;
  Preset[] list7;
  Preset[] list8;
  Preset[] list9;
  Preset[] list10;

  Presets() {
    //basic files
    int n = fileList.length;
    files = new Preset[n];
    for (int i = 0; i < n ; i++ ) {
      files[i] = new Preset(100, 100, 0, 200, i, 50, 0, 100, 60, i%4);
    }

    files[0] = new Preset(100, 100, 0, 200, 0, 50, 0, 100, 60, 0);
    files[1] = new Preset(100, 100, 0, 200, 1, 50, 0, 100, 60, 1);
    files[2] = new Preset(100, 100, 0, 200, 2, 50, 0, 100, 60, 2);
    files[3] = new Preset(100, 100, 0, 200, 3, 50, 0, 100, 60, 3);
    files[4] = new Preset(100, 100, 0, 200, 4, 50, 0, 100, 60, 0);
    files[5] = new Preset(100, 100, 0, 200, 5, 50, 200, 1000, 200, 1);
    files[6] = new Preset(100, 100, 0, 200, 6, 25, 110, 150, 110, 2);
    files[7] = new Preset(100, 100, 0, 200, 7, 25, 27, 67, 27, 3);
    files[8] = new Preset(100, 100, 0, 200, 8, 50, 5, 45, 5, 0);
    files[9] = new Preset(100, 100, 0, 200, 9, 50, 50, 90, 50, 1);
    files[10] = new Preset(100, 100, 0, 200, 10, 50, 30, 70, 30, 2);
    files[11] = new Preset(100, 100, 0, 200, 11, 50, 40, 80, 40, 3);

    files[28] = new Preset(100, 100, 0, 200, 28, 50, 0, 19, 0, 0);
    files[29] = new Preset(100, 100, 0, 200, 29, 50, 2, 17, 0, 1);
    files[30] = new Preset(100, 100, 0, 200, 30, 50, 0, 19, 0, 2);
    files[31] = new Preset(100, 100, 0, 200, 31, 50, 0, 19, 0, 2);
    files[32] = new Preset(100, 100, 0, 200, 32, 50, 0, 19, 0, 1);
    files[33] = new Preset(100, 100, 0, 200, 33, 50, 9, 22, 0, 2);
    files[34] = new Preset(100, 100, 0, 200, 34, 50, 9, 37, 0, 0);
    files[35] = new Preset(100, 100, 0, 200, 35, 50, 0, 200, 0, 3);

    //presets
    lists = new ArrayList <Preset[]> ();
    list0 = new Preset[4];
    list1 = new Preset[5];
    list2 = new Preset[3];
    list3 = new Preset[9];
    list4 = new Preset[3];
    list5 = new Preset[9];
    list6 = new Preset[4];
    list7 = new Preset[4];
    list8 = new Preset[5];
    list9 = new Preset[8];
    list10 = new Preset[32];

    //set 1
    //
    // (19)  (236, 162) (453) (670) (887)
    //       (352)
    //       (542)
    //       (732)
    //       (922)
    list0[0] = (new Preset(files[33])).set(100, 120, 320, 0, 0, false);
    list0[1] = (new Preset(files[32])).set(560, 360, 100, 3, 1, false);
    list0[2] = (new Preset(files[34])).set(560, 120, 200, 1, 2, false);
    list0[3] = (new Preset(files[32])).set(720, 360, 100, 1, 3, false);


    list1[0] = (new Preset(files[33])).set(100, 120, 200, 1, 4, false);
    list1[1] = (new Preset(files[34])).set(420, 70, 200, 0, 5, false);
    list1[2] = (new Preset(files[32])).set(200, 380, 170, 3, 6, false);
    list1[3] = (new Preset(files[30])).set(470, 350, 180, 1, 7, false);
    list1[4] = (new Preset(files[31])).set(730, 180, 160, 2, 8, false);

    list2[0] = (new Preset(files[34])).set(236, 352, 130, 1, 8);
    list2[1] = (new Preset(files[32])).set(236, 542, 130, 2, 16);
    list2[2] = (new Preset(files[34])).set(236, 732, 130, 3, 24);

    list3[0] = (new Preset(files[32])).set(453, 352, 130, 1, 10);
    list3[1] = (new Preset(files[32])).set(670, 352, 130, 1, 12);
    list3[2] = (new Preset(files[34])).set(887, 352, 130, 1, 14);
    list3[3] = (new Preset(files[34])).set(453, 542, 130, 2, 18);
    list3[4] = (new Preset(files[33])).set(670, 542, 130, 2, 20);
    list3[5] = (new Preset(files[32])).set(887, 542, 130, 2, 22);
    list3[6] = (new Preset(files[32])).set(453, 732, 130, 3, 26);
    list3[7] = (new Preset(files[32])).set(670, 732, 130, 3, 28);
    list3[8] = (new Preset(files[32])).set(887, 732, 130, 3, 30);

    list4[0] = (new Preset(files[33])).set(236, 352, 130, 0, 8);
    list4[1] = (new Preset(files[33])).set(236, 542, 130, 0, 16);
    list4[2] = (new Preset(files[33])).set(236, 732, 130, 0, 24);


    list5[0] = (new Preset(files[32])).set(453, 352, 130, 0, 10);
    list5[1] = (new Preset(files[32])).set(670, 352, 130, 1, 12);
    list5[2] = (new Preset(files[32])).set(887, 352, 130, 2, 14);
    list5[3] = (new Preset(files[32])).set(453, 542, 130, 0, 18);
    list5[4] = (new Preset(files[32])).set(670, 542, 130, 1, 20);
    list5[5] = (new Preset(files[32])).set(887, 542, 130, 2, 22);
    list5[6] = (new Preset(files[32])).set(453, 732, 130, 0, 26);
    list5[7] = (new Preset(files[32])).set(670, 732, 130, 1, 28);
    list5[8] = (new Preset(files[32])).set(887, 732, 130, 2, 30);

    list6[0] = (new Preset(files[32])).set(1104, 162, 130, 0, 3);
    list6[1] = (new Preset(files[32])).set(1104, 352, 130, 1, 15);
    list6[2] = (new Preset(files[32])).set(1104, 542, 130, 2, 27);
    list6[3] = (new Preset(files[33])).set(1104, 732, 130, 3, 23);

    list7[0] = (new Preset(files[32])).set(236, 922, 130, 0, 21);
    list7[1] = (new Preset(files[32])).set(453, 922, 130, 1, 25);
    list7[2] = (new Preset(files[32])).set(670, 922, 130, 2, 29);
    list7[3] = (new Preset(files[32])).set(887, 922, 130, 3, 31);

    list8[0] = (new Preset(files[34])).set(19, 162, 130, 0, 16);
    list8[1] = (new Preset(files[34])).set(19, 352, 130, 1, 20);
    list8[2] = (new Preset(files[34])).set(19, 542, 130, 2, 26);
    list8[3] = (new Preset(files[34])).set(19, 732, 130, 3, 28);
    list8[4] = (new Preset(files[34])).set(19, 922, 130, 3, 28);


    // list7[0] = new Preset(100, 80, 0, 300, 33, 50, 4, 23, 4, 0, 0);
    // list7[1] = new Preset(550, 80, 0, 200, 32, 50, 0, 19, 0, 1, 8);
    // list7[2] = new Preset(900, 80, 0, 200, 32, 50, 0, 19, 0, 1, 16);
    // list7[3] = new Preset(1000, 80, 0, 200, 32, 50, 0, 19, 0, 1, 24);
    // list7[4] = new Preset(1000, 350, 0, 200, 30, 50, 0, 19, 0, 2, 16);
    // list7[5] = new Preset(670, 350, 0, 75, 32, 50, 0, 19, 0, 1, 6);
    // list7[6] = new Preset(550, 350, 0, 75, 31, 50, 0, 19, 0, 2, 14);
    // list7[7] = new Preset(100, 570, 0, 200, 33, 50, 4, 23, 4, 0, 20);
    // list7[8] = new Preset(410, 570, 0, 200, 33, 50, 4, 23, 4, 0, 22);
    // list7[9] = new Preset(1000, 570, 0, 200, 30, 50, 0, 19, 0, 2, 26);


    list9[0] = new Preset(100, 100, 0, 200, 33, 50, 4, 23, 4, 0, 0);
    list9[1] = new Preset(100, 400, 0, 200, 32, 50, 0, 20, 0, 1, 4);
    list9[2] = new Preset(400, 400, 0, 200, 32, 50, 0, 20, 0, 2, 8);
    list9[3] = new Preset(700, 400, 0, 200, 32, 50, 0, 20, 0, 3, 12);
    list9[4] = new Preset(700, 100, 0, 200, 31, 50, 0, 20, 0, 2, 16);
    list9[5] = new Preset(400, 700, 0, 200, 32, 50, 0, 20, 0, 1, 20);
    list9[6] = new Preset(1000, 700, 0, 200, 32, 50, 0, 20, 0, 3, 24);
    list9[7] = new Preset(400, 100, 0, 200, 32, 50, 0, 20, 0, 1, 28);

    //
    // (19)  (236, 162) (453) (670) (887)
    //       (352)
    //       (542)
    //       (732)
    //       (922)
    list10[0] = (new Preset(files[33])).set(236, 162, 130, 0, 0);
    list10[1] = (new Preset(files[32])).set(453, 162, 130, 1, 2);
    list10[2] = (new Preset(files[32])).set(670, 162, 130, 2, 4);
    list10[3] = (new Preset(files[32])).set(887, 162, 130, 3, 6);
    list10[4] = (new Preset(files[34])).set(236, 352, 130, 0, 8);
    list10[5] = (new Preset(files[32])).set(453, 352, 130, 1, 10);
    list10[6] = (new Preset(files[32])).set(670, 352, 130, 2, 12);
    list10[7] = (new Preset(files[34])).set(887, 352, 130, 3, 14);
    list10[8] = (new Preset(files[32])).set(236, 542, 130, 0, 16);
    list10[9] = (new Preset(files[34])).set(453, 542, 130, 1, 18);
    list10[10] = (new Preset(files[33])).set(670, 542, 130, 2, 20);
    list10[11] = (new Preset(files[32])).set(887, 542, 130, 3, 22);
    list10[12] = (new Preset(files[34])).set(236, 732, 130, 0, 24);
    list10[13] = (new Preset(files[32])).set(453, 732, 130, 1, 26);
    list10[14] = (new Preset(files[32])).set(670, 732, 130, 2, 28);
    list10[15] = (new Preset(files[32])).set(887, 732, 130, 3, 30);
    list10[16] = (new Preset(files[32])).set(19, 162, 130, 1, 1);
    list10[17] = (new Preset(files[32])).set(19, 352, 130, 1, 3);
    list10[18] = (new Preset(files[32])).set(19, 542, 130, 1, 5);
    list10[19] = (new Preset(files[32])).set(19, 732, 130, 1, 7);
    list10[20] = (new Preset(files[32])).set(19, 922, 130, 1, 9);
    list10[21] = (new Preset(files[32])).set(236, 922, 130, 1, 11);
    list10[22] = (new Preset(files[32])).set(453, 922, 130, 1, 13);
    list10[23] = (new Preset(files[32])).set(670, 922, 130, 1, 15);
    list10[24] = (new Preset(files[32])).set(887, 922, 130, 1, 17);


    lists.add(list0);
    lists.add(list1);
    lists.add(list2);
    lists.add(list3);
    lists.add(list4);
    lists.add(list5);
    lists.add(list6);
    lists.add(list7);
    lists.add(list8);
    lists.add(list9);
    lists.add(list10);


    // list16[0] = new Preset(100, 100, 0, 200, 0, 50, 50, 100, 60, 0);
    // list16[1] = new Preset(500, 200, 0, 200, 1, 50, 50, 100, 60, 1);
    // list16[2] = new Preset(100, 400, 0, 200, 2, 50, 50, 100, 60, 2);
    // list16[3] = new Preset(500, 500, 0, 200, 3, 50, 50, 100, 60, 3);

    // list17[0] = new Preset(100, 100, 0, 200, 6,  50, 110, 145, 110, 0);
    // list17[1] = new Preset(600, 100, 0, 200, 9, 50, 42, 77, 42, 1);
    // list17[2] = new Preset(100, 400, 0, 200, 11, 50, 102, 137, 102, 2);
    // list17[3] = new Preset(600, 400, 0, 200, 18, 50, 63, 98, 63, 3);


    // list18[0] = new Preset(200, 200, 0, 400, 0, 25, 0, 40, 0, 0);
    // list18[1] = new Preset(300, 500, 0, 200, 2, 25, 40, 80, 40, 1);
    // list18[2] = new Preset(700, 700, 0, 200, 4, 25, 40, 80, 40, 2);
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
  int limit;
  int startFrameCount;
  int endFrameCount;
  int currentFrame;
  int colorIndex;
  int triggerKey = -1;
  boolean sync = true;

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
         int fi, int l, int s, int e, int c, int col, int _triggerKey) {
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
    triggerKey = _triggerKey;
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
  Preset(float _x, float _y, int _w, int _h,
         String fn, int l, int s, int e, int c, int col, int _triggerKey) {
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
    triggerKey = _triggerKey;
  }
  //copy
  Preset (Preset p) {
    this(p.x, p.y, p.w, p.h, p.fileIndex,
         p.limit, p.startFrameCount,
         p.endFrameCount, p.currentFrame,
         p.colorIndex);
  }

  Preset set(float _x, float _y, int _h, int _t) {
    x = _x;
    y = _y;
    h = _h;
    triggerKey = _t;
    return this;
  }
  Preset set(float _x, float _y, int _h, int _t, boolean _s) {
    x = _x;
    y = _y;
    h = _h;
    triggerKey = _t;
    sync = _s;
    return this;
  }
  Preset set(float _x, float _y, int _h, int _c, int _t) {
    x = _x;
    y = _y;
    h = _h;
    triggerKey = _t;
    colorIndex = _c;
    return this;
  }
  Preset set(float _x, float _y, int _h, int _c, int _t, boolean _s) {
    x = _x;
    y = _y;
    h = _h;
    triggerKey = _t;
    colorIndex = _c;
    sync = _s;
    return this;
  }
}
