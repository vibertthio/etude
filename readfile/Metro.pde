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

  boolean bang() {
    if (state == true) {
      elapsedTime = (millis() - localtime)%limit;
      if (elapsedTime<=5) {
        return true;
      }
    }
    return false;
  }

  int currentTime() {
    return millis();
  }

  void start() {
    state = true;
    localtime = currentTime() - timeInterval;
  }
  
  void stop() {
    state = false;
    timeInterval = 0;
  }
  
  void pause() {
    state = false;
    timeInterval = millis() - localtime;
  }
}