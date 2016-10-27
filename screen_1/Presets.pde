class Presets {
  //constant
  ArrayList<Vpreset> preList;
  //-----------------------x----y----w----h-fi---l---s---e----c
  Vpreset p0 = new Vpreset(100, 100, 100, 200, 0, 50, 50, 100, 60);
  Vpreset p1 = new Vpreset(300, 100, 100, 200, 1, 50, 50, 100, 60);
  Vpreset p2 = new Vpreset(100, 300, 100, 200, 2, 50, 50, 100, 60);
  Vpreset p3 = new Vpreset(300, 300, 100, 200, 4, 50, 50, 100, 60);

  Presets() {
    preList = new ArrayList<Vpreset>();
    preList.add(p0);
    preList.add(p1);
    preList.add(p2);
    preList.add(p3);
  }

  Vpreset get(int i) {
    return preList[i];
  }
}
