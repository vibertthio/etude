class Presets {
  //constant
  ArrayList<Preset> list;
  Preset p0 = new Preset(100, 100, 0, 200, 0, 50, 50, 100, 60, 0);
  Preset p1 = new Preset(600, 100, 0, 200, 1, 50, 50, 100, 60, 1);
  Preset p2 = new Preset(100, 400, 0, 200, 2, 50, 50, 100, 60, 2);
  Preset p3 = new Preset(600, 400, 0, 200, 4, 50, 50, 100, 60, 3);

  Presets() {
    list = new ArrayList<Preset>();
    list.add(p0);
    list.add(p1);
    list.add(p2);
    list.add(p3);
  }

  Preset get(int i) {
    return list.get(i);
  }
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
