class Vpresets {
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
