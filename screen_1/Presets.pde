class Presets {
  //constant
  ArrayList<Preset> list;
  //-----------------------x----y----w----h-fi---l---s---e----c
  Preset p0 = new Preset(100, 100, 100, 200, 0, 50, 50, 100, 60);
  Preset p1 = new Preset(300, 100, 100, 200, 1, 50, 50, 100, 60);
  Preset p2 = new Preset(100, 300, 100, 200, 2, 50, 50, 100, 60);
  Preset p3 = new Preset(300, 300, 100, 200, 4, 50, 50, 100, 60);

  Presets() {
    list = new ArrayList<Preset>();
    list.add(p0);
    list.add(p1);
    list.add(p2);
    list.add(p3);
  }

  Preset get(int i) {
    return list[i];
  }
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

  Preset(float _x, float _y, int _w, int _h,
         int fi, int l, int s, int e, int c) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    fileIndex = fi;
    limit = l;
    startFrameCount = s;
    endFrameCount = e;
    currentFrame = c;
  }
  Preset(float _x, float _y, int _w, int _h,
         String fn, int l, int s, int e, int c) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    fileName = fn;
    limit = l;
    startFrameCount = s;
    endFrameCount = e;
    currentFrame = c;
  }
}
