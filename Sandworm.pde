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
    imageMode(CENTER);

    int imageSize = board.getBoxSize();

    // Draw head
    fill(200, 0, 0);
    image(getWormImage("head", body.get(0).dx, body.get(0).dy), body.get(0).x, body.get(0).y, imageSize, imageSize);
    resetMatrix();
    

    // Draw body
    for (int i = 1; i < body.size()-1; i++) {
      fill(255);
      image(getWormImage("body", body.get(i).dx, body.get(i).dy), body.get(i).x, body.get(i).y, imageSize, imageSize);
    }

    // Draw tail
    fill(0, 200, 0);
    image(getWormImage("tail", body.get(body.size()-1).dx, body.get(body.size()-1).dy), body.get(body.size()-1).x, body.get(body.size()-1).y, imageSize, imageSize);
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
    if ((frameCount - gc.startFrame) % (board.getBoxSize()/speed) == 0) {
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
    if (head.getLeftBound() < board.getLeftBound() || 
      head.getRightBound() > board.getRightBound() || 
      head.getTopBound() < board.getTopBound() || 
      head.getBottomBound() > board.getBottomBound()) {
      gc.endGame(GameState.LOSS);
    }
    //check body
    for (int i = 1; i < body.size(); i++) {
      if (head.x < body.get(i).getRightBound() && 
        head.x > body.get(i).getLeftBound() && 
        head.y < body.get(i).getBottomBound() && 
        head.y > body.get(i).getTopBound()) {
        gc.endGame(GameState.LOSS);
      }
    }

    //check "food"
    if (head.x > harvester.getBound("left") && head.x < harvester.getBound("right") && head.y < harvester.getBound("bottom") && head.y > harvester.getBound("top")) {
      this.add();
      score.increase();
      wormEat.play();
      harvester.generate();
    }
  }
  
  PImage getWormImage(String bodyPart, float dx, float dy) {
     if (dx < 0) {
       if (bodyPart == "head") return headLeft;
       else if (bodyPart == "body") return bodyLeft;
       else if (bodyPart == "tail") return tailLeft;
     } else if (dx > 0) {
       if (bodyPart == "head") return headRight;
       else if (bodyPart == "body") return bodyRight;
       else if (bodyPart == "tail") return tailRight;
     } else if (dy > 0) {
       if (bodyPart == "head") return headDown;
       else if (bodyPart == "body") return bodyDown;
       else if (bodyPart == "tail") return tailDown;
     } else {
       if (bodyPart == "head") return headUp;
       else if (bodyPart == "body") return bodyUp;
       else if (bodyPart == "tail") return tailUp;
     }
     
     return null;
  }
}

class DirChange {
  int index;
  float dx, dy;
  
  DirChange(int index, float dx, float dy) {
    this.index = index;
    this.dx = dx;
    this.dy = dy;
  }
}

class Body {
  float x, y, dx, dy;
  
  Body(float x, float y, float dx, float dy) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
  }
  
  float getTopBound() {
     return y - (board.getBoxSize()/2 - 5); 
  }
  
  float getBottomBound() {
     return y + (board.getBoxSize()/2 - 5); 
  }
  
  float getLeftBound() {
    return x - (board.getBoxSize()/2 - 5); 
  }
  
  float getRightBound() {
    return x + (board.getBoxSize()/2 - 5);
  }
}
