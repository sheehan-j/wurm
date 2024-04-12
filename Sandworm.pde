class Sandworm {
  Sandworm sandworm;
  ArrayList<Body> body;
  float speed;
  int dir = 1; // represents the most recent dir change (0 up, 1 right, 2 down, 3 left)

  int add = 0; // "Queue" of body objects to be added
  ArrayList<DirChange> dirQueue; // Queue for direction changes
  
  int gameDifficulty = 6;

  Sandworm() {
    body = new ArrayList<Body>();
    dirQueue = new ArrayList<DirChange>();

    // Set the speed so that the snake travels one box every frameRate/3 frames
    speed = board.getBoxSize() / (frameRate/gameDifficulty);

    body.add(
      new Body(
      board.getXPos() - (board.getBoxSize()/2) + board.getBoxSize() * 2,
      board.getYPos() - (board.getBoxSize()/2) + board.getBoxSize() * 8,
      speed,
      0
      )
      );
    body.add(
      new Body(
      board.getXPos() - (board.getBoxSize()/2) + board.getBoxSize() * 1,
      board.getYPos() - (board.getBoxSize()/2) + board.getBoxSize() * 8,
      speed,
      0
      )
      );
  }

  void display() {
    // Stroke settings
    strokeWeight(1);
    stroke(0);

    // Draw head
    fill(200, 0, 0);
    ellipse(body.get(0).x, body.get(0).y, 10, 10);

    // Draw body
    for (int i = 1; i < body.size()-1; i++) {
      fill(255);
      ellipse(body.get(i).x, body.get(i).y, 10, 10);
    }

    // Draw tail
    fill(0, 200, 0);
    ellipse(body.get(body.size()-1).x, body.get(body.size()-1).y, 10, 10);
  }

  void update() {
    // Increment the position of all body parts
    for (int i = 0; i < body.size(); i++) {
      Body curr = body.get(i);
      curr.x += curr.dx;
      curr.y += curr.dy;
    }

    // Check if the box square size divided by speed divides into the frameCount
    // If so, the snake is aligned with the center of a box
    if (frameCount % (board.getBoxSize()/speed) == 0) {
      int recentIndex = -1;
      for (int i = 0; i < dirQueue.size(); i++) {
        DirChange currDir = dirQueue.get(i);
        if (currDir.index != recentIndex) {
          Body currBody = body.get(currDir.index);
          currBody.dx = currDir.dx;
          currBody.dy = currDir.dy;

          recentIndex = currDir.index;
          currDir.index += 1;
        }
      }

      for (int i = 0; i < dirQueue.size(); i++) {
        if (dirQueue.get(i).index == body.size()) {
          dirQueue.remove(i);
          i--;
        }
      }

      // Add a body piece if necessary
      if (add > 0) {
        this.add();
        add -= 1;
      }
    }
  }

  void queueAdd() {
    add += 1;
  }

  void add() {
    Body last = body.get(body.size()-1);

    Body newBody;
    newBody = new Body(
      last.x + ((board.getBoxSize()/speed) * last.dx * -1),
      last.y + ((board.getBoxSize()/speed) * last.dy * -1),
      last.dx,
      last.dy
      );

    body.add(newBody);
  }

  void queueDir(int newDir) {
    boolean invalidDirChange = (newDir == 0 && (dir == 0 || dir == 2));
    invalidDirChange = invalidDirChange || (newDir == 2 && (dir == 0 || dir == 2));
    invalidDirChange = invalidDirChange || (newDir == 1 && (dir == 1 || dir == 3));
    invalidDirChange = invalidDirChange || (newDir == 3 && (dir == 1 || dir == 3));

    if (invalidDirChange) return;

    dir = newDir;
    float newDx, newDy;

    if (dir == 0) { // Up
      newDx = 0;
      newDy = -speed;
    } else if (dir == 1) { // Left
      newDx = speed;
      newDy = 0;
    } else if (dir == 2) { // Down
      newDx = 0;
      newDy = speed;
    } else { // Right
      newDx = -speed;
      newDy = 0;
    }

    dirQueue.add(new DirChange(0, newDx, newDy));
  }

  void checkCollision() {
    Body head = body.get(0);

    //check edges
    if (head.x < board.getLeftBound() || head.x > board.getRightBound() || head.y < board.getTopBound() || head.y > board.getBottomBound()) {
      gc.endGame(GameState.LOSS);
    }
    //check body
    for (int i = 1; i < body.size()-1; i++) {
      if (head.x == body.get(i).x && head.y == body.get(i).y) {
        gc.endGame(GameState.LOSS);
      }
    }

    //check "food"
    if (head.x > harvester.getBound("left") && head.x < harvester.getBound("right") && head.y < harvester.getBound("bottom") && head.y > harvester.getBound("top")) {
      this.add();
      score.increase();
      harvester.generate();
    }
  }
}
