Score score;
Timer time;
Board board;

void setup() {
  size(600, 600);
  score = new Score();
  time = new Timer(2,0);
  time.startTime();
  board = new Board(75,100,450,15,15);
}

void draw() {
  background(200);
  score.display();
  time.display(width/2,50);
  board.display();
}
