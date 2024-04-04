Score score;
Timer time;
Board board;
Sandworm wurm;
GameController gc;

void setup() {
  size(600, 600);
  score = new Score();
  time = new Timer(2, 0);
  time.startTime();
  gc = new GameController();
  board = new Board(75, 100, 450, 15, 15);
  wurm = new Sandworm(board, gc);
  frameRate(5);
}

void draw() {
  background(200);
  score.display();
  time.display(width/2, 50);
  board.display();
  wurm.display();
  wurm.move();
}

void checkGame(){
  
}

void keyPressed() {
  if (key == ' ') {
    wurm.add();
  }
  if (key == CODED) {
    if (keyCode == UP) {
      wurm.changeDirUp();
    } else if (keyCode == DOWN) {
      wurm.changeDirDown();
    } else if (keyCode == LEFT) {
      wurm.changeDirLeft();
    } else if (keyCode == RIGHT) {
      wurm.changeDirRight();
    }
  }
}
