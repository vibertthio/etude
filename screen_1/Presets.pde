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
    list0 = new Preset[25];
    list1 = new Preset[3];
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
    list0[0] = (new Preset(files[33])).set(236, 162, 130, 0, 0);
    list0[1] = (new Preset(files[32])).set(453, 162, 130, 0, 2);
    list0[2] = (new Preset(files[32])).set(670, 162, 130, 0, 4);
    list0[3] = (new Preset(files[32])).set(887, 162, 130, 0, 6);
    list0[4] = (new Preset(files[34])).set(236, 352, 130, 1, 8);
    list0[5] = (new Preset(files[32])).set(453, 352, 130, 1, 10);
    list0[6] = (new Preset(files[32])).set(670, 352, 130, 1, 12);
    list0[7] = (new Preset(files[34])).set(887, 352, 130, 1, 14);
    list0[8] = (new Preset(files[32])).set(236, 542, 130, 2, 16);
    list0[9] = (new Preset(files[34])).set(453, 542, 130, 2, 18);
    list0[10] = (new Preset(files[33])).set(670, 542, 130, 2, 20);
    list0[11] = (new Preset(files[32])).set(887, 542, 130, 2, 22);
    list0[12] = (new Preset(files[34])).set(236, 732, 130, 3, 24);
    list0[13] = (new Preset(files[32])).set(453, 732, 130, 3, 26);
    list0[14] = (new Preset(files[32])).set(670, 732, 130, 3, 28);
    list0[15] = (new Preset(files[32])).set(887, 732, 130, 3, 30);
    list0[16] = (new Preset(files[32])).set(1104, 162, 130, 0, 3);
    list0[17] = (new Preset(files[32])).set(1104, 352, 130, 1, 15);
    list0[18] = (new Preset(files[32])).set(1104, 542, 130, 2, 27);
    list0[19] = (new Preset(files[33])).set(1104, 732, 130, 3, 23);
    list0[20] = (new Preset(files[32])).set(236, 922, 130, 0, 21);
    list0[21] = (new Preset(files[32])).set(453, 922, 130, 1, 25);
    list0[22] = (new Preset(files[32])).set(670, 922, 130, 2, 29);
    list0[23] = (new Preset(files[32])).set(887, 922, 130, 3, 31);
    list0[24] = (new Preset(files[33])).set(1104, 922, 130, 3, 6);


    list1[0] = (new Preset(files[32])).set(453, 162, 130, 0, 2);
    list1[1] = (new Preset(files[32])).set(670, 162, 130, 0, 4);
    list1[2] = (new Preset(files[32])).set(887, 162, 130, 0, 6);

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
  Preset set(float _x, float _y, int _h, int _c, int _t) {
    x = _x;
    y = _y;
    h = _h;
    triggerKey = _t;
    colorIndex = _c;
    return this;
  }
}



// class Presets {
//   //constant
//   Preset[] files;
//
//   // Preset f00 = new Preset(100, 100, 0, 200, 0, 50, 50, 100, 60, 0);
//   // Preset f01 = new Preset(100, 100, 0, 200, 1, 50, 50, 100, 60, 0);
//   // Preset f02 = new Preset(100, 100, 0, 200, 2, 50, 50, 100, 60, 0);
//   // Preset f03 = new Preset(100, 100, 0, 200, 3, 50, 50, 100, 60, 0);
//   // Preset f04 = new Preset(100, 100, 0, 200, 4, 50, 50, 100, 60, 0);
//   // Preset f05 = new Preset(100, 100, 0, 200, 5, 50, 50, 100, 60, 0);
//   // Preset f06 = new Preset(100, 100, 0, 200, 6, 50, 50, 100, 60, 0);
//   // Preset f07 = new Preset(100, 100, 0, 200, 7, 50, 50, 100, 60, 0);
//   // Preset f08 = new Preset(100, 100, 0, 200, 8, 50, 50, 100, 60, 0);
//   // Preset f09 = new Preset(100, 100, 0, 200, 9, 50, 50, 100, 60, 0);
//   // Preset f10 = new Preset(100, 100, 0, 200, 10, 50, 50, 100, 60, 0);
//   // Preset f11 = new Preset(100, 100, 0, 200, 11, 50, 50, 100, 60, 0);
//   // Preset f12 = new Preset(100, 100, 0, 200, 12, 50, 50, 100, 60, 0);
//   // Preset f13 = new Preset(100, 100, 0, 200, 13, 50, 50, 100, 60, 0);
//   // Preset f14 = new Preset(100, 100, 0, 200, 14, 50, 50, 100, 60, 0);
//   // Preset f15 = new Preset(100, 100, 0, 200, 15, 50, 50, 100, 60, 0);
//   // Preset f16 = new Preset(100, 100, 0, 200, 16, 50, 50, 100, 60, 0);
//   // Preset f17 = new Preset(100, 100, 0, 200, 17, 50, 50, 100, 60, 0);
//
//
//   ArrayList <Preset[]> lists;
//   Preset[] list0;
//   Preset[] list1;
//   Preset[] list2;
//   Preset[] list3;
//   Preset[] list4;
//   Preset[] list5;
//   Preset[] list6;
//   Preset[] list7;
//   Preset[] list8;
//   Preset[] list9;
//
//   Preset p0_0 = new Preset(100, 100, 0, 200, 0, 50, 50, 100, 60, 0);
//   Preset p0_1 = new Preset(500, 200, 0, 200, 1, 50, 50, 100, 60, 1);
//   Preset p0_2 = new Preset(100, 400, 0, 200, 2, 50, 50, 100, 60, 2);
//   Preset p0_3 = new Preset(500, 500, 0, 200, 3, 50, 50, 100, 60, 3);
//
//   Preset p1_0 = new Preset(100, 100, 0, 200, 6,  30, 100, 200, 110, 0);
//   Preset p1_1 = new Preset(600, 100, 0, 200, 10, 30, 70, 120, 60, 1);
//   Preset p1_2 = new Preset(100, 400, 0, 200, 11, 30, 20, 120, 60, 2);
//   Preset p1_3 = new Preset(600, 400, 0, 200, 14, 30, 30, 130, 60, 3);
//
//   Preset p2_0 = new Preset(100, 100, 0, 200, 4, 50, 50, 100, 60, 0);
//   Preset p2_1 = new Preset(600, 100, 0, 200, 8, 50, 50, 100, 60, 1);
//   Preset p2_2 = new Preset(100, 400, 0, 200, 12, 50, 50, 100, 60, 2);
//
//   Preset p3_0 = new Preset(800, 500, 0, 200, 9, 50, 50, 100, 60, 0);
//   Preset p3_1 = new Preset(1000, 800, 0, 200, 16, 25, 0, 100, 60, 1);
//   Preset p3_2 = new Preset(100, 100, 0, 200, 17, 25, 0, 100, 60, 1);
//
//   Preset p4_0 = new Preset(100, 100, 0, 200, 9, 50, 50, 100, 60, 0);
//   Preset p4_1 = new Preset(400, 100, 0, 200, 16, 25, 0, 100, 60, 1);
//   Preset p4_2 = new Preset(700, 100, 0, 200, 17, 25, 0, 100, 60, 1);
//   Preset p4_3 = new Preset(1000, 100, 0, 200, 9, 50, 50, 100, 60, 0);
//   Preset p4_4 = new Preset(1300, 100, 0, 200, 16, 25, 0, 100, 60, 1);
//   Preset p4_5 = new Preset(1600, 100, 0, 200, 17, 25, 0, 100, 60, 1);
//   Preset p4_6 = new Preset(100, 400, 0, 200, 9, 50, 50, 100, 60, 0);
//   Preset p4_7 = new Preset(400, 400, 0, 200, 16, 25, 0, 100, 60, 1);
//   Preset p4_8 = new Preset(700, 400, 0, 200, 17, 25, 0, 100, 60, 1);
//
//   Preset p5_0 = new Preset(100, 100, 0, 200, 18, 25, 440, 480, 440, 0);
//   Preset p5_1 = new Preset(400, 100, 0, 200, 18, 25, 440, 480, 445, 1);
//   Preset p5_2 = new Preset(700, 100, 0, 200, 18, 25, 440, 480, 450, 2);
//   Preset p5_3 = new Preset(1000, 100, 0, 200, 18, 25, 440, 480, 455, 3);
//   Preset p5_4 = new Preset(100, 400, 0, 200, 18, 25, 440, 480, 460, 1);
//   Preset p5_5 = new Preset(400, 400, 0, 200, 18, 25, 440, 480, 465, 1);
//   Preset p5_6 = new Preset(700, 400, 0, 200, 18, 25, 440, 480, 470, 1);
//   Preset p5_7 = new Preset(1000, 400, 0, 200, 18, 25, 440, 480, 475, 1);
//
//   Preset p6_0 = new Preset(100, 100, 0, 200, 6,  50, 110, 145, 110, 0);
//   Preset p6_1 = new Preset(600, 100, 0, 200, 9, 50, 42, 77, 42, 1);
//   Preset p6_2 = new Preset(100, 400, 0, 200, 11, 50, 102, 137, 102, 2);
//   Preset p6_3 = new Preset(600, 400, 0, 200, 18, 50, 63, 98, 63, 3);
//
//   // Preset p7_0 = new Preset(100, 80, 0, 300, 33, 50, 4, 23, 4, 0, 0);
//   // Preset p7_1 = new Preset(550, 80, 0, 200, 32, 50, 0, 19, 0, 1, 4);
//   // Preset p7_2 = new Preset(900, 80, 0, 200, 32, 50, 0, 19, 0, 1, 8);
//   // Preset p7_3 = new Preset(1000, 80, 0, 200, 32, 50, 0, 19, 0, 1, 12);
//   // Preset p7_4 = new Preset(1000, 350, 0, 200, 30, 50, 0, 19, 0, 2, 8);
//   // Preset p7_5 = new Preset(670, 350, 0, 75, 32, 50, 0, 19, 0, 1, 3);
//   // Preset p7_6 = new Preset(550, 350, 0, 75, 31, 50, 0, 19, 0, 2, 7);
//   // Preset p7_7 = new Preset(100, 570, 0, 200, 33, 50, 4, 23, 4, 0, 10);
//   // Preset p7_8 = new Preset(410, 570, 0, 200, 33, 50, 4, 23, 4, 0, 11);
//   // Preset p7_9 = new Preset(1000, 570, 0, 200, 30, 50, 0, 19, 0, 2, 13);
//
//   Preset p7_0 = new Preset(100, 80, 0, 300, 33, 50, 4, 23, 4, 0, 0);
//   Preset p7_1 = new Preset(550, 80, 0, 200, 32, 50, 0, 19, 0, 1, 8);
//   Preset p7_2 = new Preset(900, 80, 0, 200, 32, 50, 0, 19, 0, 1, 16);
//   Preset p7_3 = new Preset(1000, 80, 0, 200, 32, 50, 0, 19, 0, 1, 24);
//   Preset p7_4 = new Preset(1000, 350, 0, 200, 30, 50, 0, 19, 0, 2, 16);
//   Preset p7_5 = new Preset(670, 350, 0, 75, 32, 50, 0, 19, 0, 1, 6);
//   Preset p7_6 = new Preset(550, 350, 0, 75, 31, 50, 0, 19, 0, 2, 14);
//   Preset p7_7 = new Preset(100, 570, 0, 200, 33, 50, 4, 23, 4, 0, 20);
//   Preset p7_8 = new Preset(410, 570, 0, 200, 33, 50, 4, 23, 4, 0, 22);
//   Preset p7_9 = new Preset(1000, 570, 0, 200, 30, 50, 0, 19, 0, 2, 26);
//
//   Preset p8_0 = new Preset(200, 200, 0, 400, 0, 25, 0, 40, 0, 0);
//   Preset p8_1 = new Preset(300, 500, 0, 200, 2, 25, 40, 80, 40, 1);
//   Preset p8_2 = new Preset(700, 700, 0, 200, 4, 25, 40, 80, 40, 2);
//
//   Preset p9_0 = new Preset(100, 100, 0, 200, 33, 50, 4, 23, 4, 0, 0);
//   Preset p9_1 = new Preset(100, 400, 0, 200, 32, 50, 0, 20, 0, 1, 4);
//   Preset p9_2 = new Preset(400, 400, 0, 200, 32, 50, 0, 20, 0, 2, 8);
//   Preset p9_3 = new Preset(700, 400, 0, 200, 32, 50, 0, 20, 0, 3, 12);
//   Preset p9_4 = new Preset(700, 100, 0, 200, 31, 50, 0, 20, 0, 2, 16);
//   Preset p9_5 = new Preset(400, 700, 0, 200, 32, 50, 0, 20, 0, 1, 20);
//   Preset p9_6 = new Preset(1000, 700, 0, 200, 32, 50, 0, 20, 0, 3, 24);
//   Preset p9_7 = new Preset(400, 100, 0, 200, 32, 50, 0, 20, 0, 1, 28);
//
//   Presets() {
//     lists = new ArrayList <Preset[]> ();
//     list0 = new Preset[4];
//     list1 = new Preset[4];
//     list2 = new Preset[3];
//     list3 = new Preset[3];
//     list4 = new Preset[9];
//     list5 = new Preset[8];
//     list6 = new Preset[4];
//     list7 = new Preset[10];
//     list8 = new Preset[3];
//     list9 = new Preset[8];
//
//
//     list0[0] = p0_0;
//     list0[1] = p0_1;
//     list0[2] = p0_2;
//     list0[3] = p0_3;
//
//     list1[0] = p1_0;
//     list1[1] = p1_1;
//     list1[2] = p1_2;
//     list1[3] = p1_3;
//
//     list2[0] = (p2_0);
//     list2[1] = (p2_1);
//     list2[2] = (p2_2);
//
//     list3[0] = (p3_0);
//     list3[1] = (p3_1);
//     list3[2] = (p3_2);
//
//     list4[0] = (p4_0);
//     list4[1] = (p4_1);
//     list4[2] = (p4_2);
//     list4[3] = (p4_3);
//     list4[4] = (p4_4);
//     list4[5] = (p4_5);
//     list4[6] = (p4_6);
//     list4[7] = (p4_7);
//     list4[8] = (p4_8);
//
//     list5[0] = (p5_0);
//     list5[1] = (p5_1);
//     list5[2] = (p5_2);
//     list5[3] = (p5_3);
//     list5[4] = (p5_4);
//     list5[5] = (p5_5);
//     list5[6] = (p5_6);
//     list5[7] = (p5_7);
//
//     list6[0] = p6_0;
//     list6[1] = p6_1;
//     list6[2] = p6_2;
//     list6[3] = p6_3;
//
//     list7[0] = (p7_0);
//     list7[1] = (p7_1);
//     list7[2] = (p7_2);
//     list7[3] = (p7_3);
//     list7[4] = (p7_4);
//     list7[5] = (p7_5);
//     list7[6] = (p7_6);
//     list7[7] = (p7_7);
//     list7[8] = (p7_8);
//     list7[9] = (p7_9);
//
//     list8[0] = (p8_0);
//     list8[1] = (p8_1);
//     list8[2] = (p8_2);
//
//     list9[0] = p9_0;
//     list9[1] = p9_1;
//     list9[2] = p9_2;
//     list9[3] = p9_3;
//     list9[4] = p9_4;
//     list9[5] = p9_5;
//     list9[6] = p9_6;
//     list9[7] = p9_7;
//
//     lists.add(list0);
//     lists.add(list1);
//     lists.add(list2);
//     lists.add(list3);
//     lists.add(list4);
//     lists.add(list5);
//     lists.add(list6);
//     lists.add(list7);
//     lists.add(list8);
//     lists.add(list9);
//
//
//     int n = fileList.length;
//     files = new Preset[n];
//     for (int i = 0; i < n ; i++ ) {
//       files[i] = new Preset(100, 100, 0, 200, i, 50, 0, 100, 60, i%4);
//     }
//     files[0] = new Preset(100, 100, 0, 200, 0, 50, 0, 100, 60, 0);
//     files[1] = new Preset(100, 100, 0, 200, 1, 50, 0, 100, 60, 1);
//     files[2] = new Preset(100, 100, 0, 200, 2, 50, 0, 100, 60, 2);
//     files[3] = new Preset(100, 100, 0, 200, 3, 50, 0, 100, 60, 3);
//     files[4] = new Preset(100, 100, 0, 200, 4, 50, 0, 100, 60, 0);
//     files[5] = new Preset(100, 100, 0, 200, 5, 50, 200, 1000, 200, 1);
//     files[6] = new Preset(100, 100, 0, 200, 6, 25, 110, 150, 110, 2);
//     files[7] = new Preset(100, 100, 0, 200, 7, 25, 27, 67, 27, 3);
//     files[8] = new Preset(100, 100, 0, 200, 8, 50, 5, 45, 5, 0);
//     files[9] = new Preset(100, 100, 0, 200, 9, 50, 50, 90, 50, 1);
//     files[10] = new Preset(100, 100, 0, 200, 10, 50, 30, 70, 30, 2);
//     files[11] = new Preset(100, 100, 0, 200, 11, 50, 40, 80, 40, 3);
//
//     files[28] = new Preset(100, 100, 0, 200, 28, 50, 0, 19, 0, 0);
//     files[29] = new Preset(100, 100, 0, 200, 29, 50, 0, 19, 0, 1);
//     files[30] = new Preset(100, 100, 0, 200, 30, 50, 0, 19, 0, 2);
//     files[31] = new Preset(100, 100, 0, 200, 31, 50, 0, 19, 0, 2);
//     files[32] = new Preset(100, 100, 0, 200, 32, 50, 0, 19, 0, 3);
//     files[33] = new Preset(100, 100, 0, 200, 33, 50, 0, 19, 0, 3);
//     files[34] = new Preset(100, 100, 0, 200, 34, 50, 0, 19, 0, 0);
//
//     files[35] = new Preset(100, 100, 0, 200, 35, 50, 0, 200, 0, 3);
//
//   }
//
//   // Preset get(int i) {
//   //   return list.get(i);
//   // }
// }
//
// class Preset {
//   float x;
//   float y;
//   int w;
//   int h;
//   int fileIndex;
//   String fileName;
//   int limit;
//   int startFrameCount;
//   int endFrameCount;
//   int currentFrame;
//   int colorIndex;
//   int triggerKey = -1;
//
//   Preset(float _x, float _y, int _w, int _h,
//          int fi, int l, int s, int e, int c, int col) {
//     x = _x;
//     y = _y;
//     w = _w;
//     h = _h;
//     fileIndex = fi;
//     limit = l;
//     startFrameCount = s;
//     endFrameCount = e;
//     currentFrame = c;
//     colorIndex = col;
//   }
//   Preset(float _x, float _y, int _w, int _h,
//          int fi, int l, int s, int e, int c, int col, int _triggerKey) {
//     x = _x;
//     y = _y;
//     w = _w;
//     h = _h;
//     fileIndex = fi;
//     limit = l;
//     startFrameCount = s;
//     endFrameCount = e;
//     currentFrame = c;
//     colorIndex = col;
//     triggerKey = _triggerKey;
//   }
//   Preset(float _x, float _y, int _w, int _h,
//          String fn, int l, int s, int e, int c, int col) {
//     x = _x;
//     y = _y;
//     w = _w;
//     h = _h;
//     fileName = fn;
//     limit = l;
//     startFrameCount = s;
//     endFrameCount = e;
//     currentFrame = c;
//     colorIndex = col;
//   }
//   Preset(float _x, float _y, int _w, int _h,
//          String fn, int l, int s, int e, int c, int col, int _triggerKey) {
//     x = _x;
//     y = _y;
//     w = _w;
//     h = _h;
//     fileName = fn;
//     limit = l;
//     startFrameCount = s;
//     endFrameCount = e;
//     currentFrame = c;
//     colorIndex = col;
//     triggerKey = _triggerKey;
//   }
//   //copy
//   Preset (Preset p) {
//     this(p.x, p.y, p.w, p.h, p.fileIndex,
//          p.limit, p.startFrameCount,
//          p.endFrameCount, p.currentFrame,
//          p.colorIndex);
//   }
// }
