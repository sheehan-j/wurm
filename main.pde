Score score;
Timer time;
Board board;
Sandworm wurm;
GameController gc;
Harvester harvester;

PImage background, buttonP1, buttonP2, titleText;

void setup() {
  size(850, 600);
  score = new Score();
  time = new Timer(2, 0);
  time.startTime();
  gc = new GameController();
  board = new Board(75, 100, 15);
  wurm = new Sandworm();
  harvester = new Harvester();
  
  background = loadImage("background.png");
}

void draw() {
  gc.display();
}

void keyPressed() {
  if (key == ' ') {
    wurm.queueAdd();
  }
  
  if (gc.gameState == GameState.PLAYING && key == CODED) {
    if (keyCode == UP) {
      //wurm.changeDirUp();
      wurm.queueDir(0);
    }
    else if (keyCode == DOWN) {
      //wurm.changeDirDown();
      wurm.queueDir(2);
    } else if (keyCode == LEFT) {
      //wurm.changeDirLeft();
      wurm.queueDir(3);
    }
    else if (keyCode == RIGHT) {
      //wurm.changeDirRight();
      wurm.queueDir(1);
    }
  }
}
