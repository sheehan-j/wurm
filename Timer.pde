class Timer {
  private int time; //(in seconds)
  private int start;
  private int lastStop;
  private boolean running = false;
  private boolean countUp;

  // Initilizes the timer to 0 and to count up
  Timer() {
    time = 0;
    countUp = true;
  }

  // Initializes the time at a specific time
  Timer(int time_) {
    time = time_;
    countUp = false;
  }

  // Initializes the time at a specific time in mins/secs
  Timer(int minutes, int seconds) {
    time = (minutes *60) + seconds;
    countUp = false;
  }

  // Returns the time
  int getTime() {
    return time;
  }

  // Starts the timer
  void startTime()
  {
    running = true;
    start = millis();
  }

  // Stops the timer
  void stopTime()
  {
    running = false;
    lastStop = millis();
  }

  // Computes the difference between the start time and the most recent stop to return elapsed time
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

  // Returns the elapsed second on the timer
  int getSecond() {
    if (countUp)
      return (time + (getElapsedTime() / 1000)) % 60;
    else
      return (time - (getElapsedTime() / 1000)) % 60;
  }

  // Returns the elapsed minute on the timer
  int getMinute() {
    if (countUp)
      return (time + (getElapsedTime() / 1000)) / 60;
    else
      return (time - (getElapsedTime() / 1000)) / 60;
  }

  // Displays the timer
  void display(float x, float y)
  {
    fill(100);
    rectMode(CENTER);
    rect(x, y-11, 136, 80);
    
    fill(255);
    textFont(arial);
    textAlign(CENTER, CENTER);
    textSize(18);
    text("Time Elapsed", x, y-30);
    
    textSize(42);
    String sec = getSecond() < 10 ? '0' + str(getSecond()) : str(getSecond());
    text(str(getMinute()) + ":" +sec, x, y);
  }
}
