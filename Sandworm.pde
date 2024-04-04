class Sandworm {
  Board board;
  GameController gc;
  ArrayList<PVector> body; // Array of x,y vectors representing tiles of worm's body
  int size; // The number tiles in the worm's body
  int dx, dy; // Direction of movement
  int speedX = 20; // Constant movespeed (i.e. moves in 20px tiles)
  int speedY = 20;
  int dir = 0; // 0 up, 1 right, 2 down, 3 left
  PVector head;
  PVector tail;

  Sandworm(Board board_, GameController gc_) {
    body = new ArrayList<PVector>();
    board = board_;
    gc = gc_;
    head = new PVector(board.getXPos() - (board.getBoxSizeX()/2) + board.getBoxSizeX() * 5, board.getYPos() - (board.getBoxSizeY()/2) + board.getBoxSizeY() * 8);
    tail = new PVector(board.getXPos() - (board.getBoxSizeX()/2) + board.getBoxSizeX() * 4, board.getYPos() - (board.getBoxSizeY()/2) + board.getBoxSizeY() * 8);

    speedX = board.getBoxSizeX();
    speedY = board.getBoxSizeY();

    dx = 0;
    dy = -speedY;
  }

  void display() {
    fill(200, 0, 0);
    ellipse(head.x, head.y, 10, 10);
    for (int i = 0; i < body.size(); i++) {
      fill(255);
      ellipse(body.get(i).x, body.get(i).y, 10, 10);
    }
    fill(0, 200, 0);
    ellipse(tail.x, tail.y, 10, 10);
  }

  void move() {
    float prevX = head.x;
    float prevY = head.y;
    head.x += dx;
    head.y += dy;

    if (body.size() != 0) {
      float curX;
      float curY;
      for (int i = 0; i < body.size(); i++) {
        curX = body.get(i).x;
        curY = body.get(i).y;

        body.get(i).x = prevX;
        body.get(i).y = prevY;

        prevX = curX;
        prevY = curY;
      }
    }
    tail.x = prevX;
    tail.y = prevY;
  }

  void add() {
    PVector v;
    if (body.size() == 0)
      v  = new PVector(head.x - dx, head.y - dy);
    else
      v = new PVector(body.get(body.size()-1).x - dx, body.get(body.size()-1).y - dy);

    body.add(v);
  }

  void changeDirUp() {
    if (dir != 2) {
      dir = 0;
      dx = 0;
      dy = -speedY;
    }
  }

  void changeDirLeft() {
    if (dir != 1) {
      dir = 3;
      dx = -speedX;
      dy = 0;
    }
  }

  void changeDirRight() {
    if (dir != 3) {
      dir = 1;
      dx = speedX;
      dy = 0;
    }
  }

  void changeDirDown() {
    if (dir != 2) {
      dir = 2;
      dx = 0;
      dy = speedY;
    }
  }


  void checkCollision() {
     if(head.x < board.getLeftBound() || head.x > board.getRightBound() || head.y > board.getTop() || head.y < board.getBottom()){
       gc.endGame(0);
     }
  }
}
