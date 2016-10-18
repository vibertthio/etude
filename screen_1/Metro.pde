class Metro {
  boolean state;
  int elapsedTime;
  int localtime;
  int limit;
  int timeInterval;

  Metro(boolean ss, int ll) {
    state = ss;
    limit=ll;
    timeInterval=0;
    if(state) {
      localtime = currentTime();
    }
  }

  int frameCount() {
    if(state) {
      return (millis() - localtime)/limit;
    }
    else {
      return timeInterval/limit;
    }
  }

  void setTime (int fCount) { //input is the frame count
    timeInterval = fCount * limit;
  }

  int currentTime() {
    return millis();
  }

  void startPlaying() { // or resume from pause
    if(!state) {
      state = true;
      localtime = currentTime() - timeInterval;
    }
  }

  void startPlayingAt( int fc) {
    if(state)
      stopAndReset();
    state = true;
    localtime = currentTime() - fc * limit;
  }

  void stopAndReset() {
    state = false;
    timeInterval = 0;
  }

  void pause() {
    if(state) {
      state = false;
      timeInterval = millis() - localtime;
    }
  }

  boolean bang() {
    if (state == true) {
      elapsedTime = (millis() - localtime)%limit;
      if (elapsedTime<=5) {
        return true;
      }
    }
    return false;
  }

  void doubleSpeed() {
    pause();
    int fc = frameCount();
    limit /= 2;
    localtime = currentTime() - fc * limit;
    startPlayingAt(fc);
  }

}
