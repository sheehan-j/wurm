class Timer {
  private int time; //(in seconds)
  private int start;
  private int lastStop;
  private boolean running = false;
  PFont arial;

  Timer() {
    time = 120;
    arial = loadFont("Arial-BoldMT-48.vlw");
  }
  
  Timer(int time_) {
    time = time_;
    arial = loadFont("Arial-BoldMT-48.vlw");
  }
  
  Timer(int minutes, int seconds) {
    time = (minutes *60) + seconds;
    arial = loadFont("Arial-BoldMT-48.vlw");
  }

  int getTime() {
    return time;
  }

  void startTime()
  {
    running = true;
    start = millis();
  }

  void stopTime()
  {
    running = false;
    lastStop = millis();
  }

  int getElapsedTime() {
    int elapsed;
    if (running) {
      elapsed = (millis() - start);
    } else {
      elapsed = (lastStop - start);
    }
    return elapsed;
  }

  int getSecond() {
    return (time - (getElapsedTime() / 1000)) % 60;
  }
  int getMinute() {
    return (time - (getElapsedTime() / 1000)) / 60;
  }
  void display(float x, float y)
  {
     textFont(arial);
     textSize(48);
     textAlign(CENTER);
     String sec = getSecond() < 10 ? '0' + str(getSecond()) : str(getSecond());
     text(str(getMinute()) + ":" +sec, x, y);
  }
}
