class Midi {
  MidiBus myBus; // The MidiBus

  Midi() {
    myBus = new MidiBus(this, 0, -1);
  }
  void nOn(int channel, int pitch, int velocity) {
    // Receive a noteOn
    println();
    println("Note On:");
    println("--------");
    println("Channel:"+channel);
    println("Pitch:"+pitch);
    println("Velocity:"+velocity);
    // if ( channe;)
  }
  void noteOff(int channel, int pitch, int velocity) {
    // Receive a noteOff
    println();
    println("Note Off:");
    println("--------");
    println("Channel:"+channel);
    println("Pitch:"+pitch);
    println("Velocity:"+velocity);
  }
  void controllerChange(int channel, int number, int value) {
    // Receive a controllerChange
    println();
    println("Controller Change:");
    println("--------");
    println("Channel:"+channel);
    println("Number:"+number);
    println("Value:"+value);
  }

}
