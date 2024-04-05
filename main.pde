Score score;
Timer time;
Board board;
Sandworm wurm;
GameController gc;
Harvester harvester;

void setup() {
  size(600, 600);
  score = new Score();
  time = new Timer(2, 0);
  time.startTime();
  gc = new GameController();
  board = new Board(75, 100, 15);
  wurm = new Sandworm();
  harvester = new Harvester();
}

void draw() {
  background(200);
  score.display();
  time.display(width/2, 50);
  board.display();
  wurm.display();
  harvester.display();
  
  if (gc.gameActive) {
    wurm.update();
    wurm.checkCollision();
  }
  
  gc.display();
}

void checkGame(){
  
}

void keyPressed() {
  if (key == ' ') {
    wurm.queueAdd();
  }
  if (key == CODED) {
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
