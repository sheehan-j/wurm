class Timer {
  private int time; //(in seconds)
  private int start;
  private int lastStop;
  private boolean running = false;
  private boolean countUp;

  Timer() {
    time = 0;
    countUp = true;
  }

  Timer(int time_) {
    time = time_;
    countUp = false;
  }

  Timer(int minutes, int seconds) {
    time = (minutes *60) + seconds;
    countUp = false;
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

    if (countUp) {
      if (running) {
        elapsed = (millis() - start);
      } else {
        elapsed = (lastStop - start);
      }
    } else {
      if (running) {
        elapsed = (millis() - start);
      } else {
        elapsed = (lastStop - start);
      }
    }


    return elapsed;
  }

  int getSecond() {
    if (countUp)
      return (time + (getElapsedTime() / 1000)) % 60;
    else
      return (time - (getElapsedTime() / 1000)) % 60;
  }

  int getMinute() {
    if (countUp)
      return (time + (getElapsedTime() / 1000)) / 60;
    else
      return (time - (getElapsedTime() / 1000)) / 60;
  }

  void display(float x, float y)
  {
    fill(255);
    textFont(arial);
    textSize(48);
    textAlign(CENTER);
    String sec = getSecond() < 10 ? '0' + str(getSecond()) : str(getSecond());
    text(str(getMinute()) + ":" +sec, x, y);
  }
}
