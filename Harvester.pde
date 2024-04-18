class Harvester {
  float x, y, speed;
  boolean hasMoved = false;
  boolean moving = false;
  int movingSteps = 0;
  int dx = 0;
  int dy = 0;
  
  Harvester() {
    this.generate(wurm);
    speed = board.getBoxSize() / 7;
  }
  
  void generate(Sandworm wurm) {
    boolean inWurm = false;
    boolean first = true;
    while(true) {
      int rand = int(random(board.numOfBoxes-3)) + 2;
      x = board.getXPos() - (board.getBoxSize()/2) + board.getBoxSize() * rand;
      if (first) x = wurm.body.get(1).x;
      rand = int(random(board.numOfBoxes-3)) + 2;
      y = board.getYPos() - (board.getBoxSize()/2) + board.getBoxSize() * rand;
      if (first) y = wurm.body.get(1).y;
      first = false;
      
      for (int i = 0; i < wurm.body.size(); i++) {
        Body curr = wurm.body.get(i);
        if (curr.x > this.getBound("left") && curr.x < this.getBound("right") && curr.y < this.getBound("bottom") && curr.y > this.getBound("top")) {
          inWurm = true;
        }
        if (inWurm) break;
      }
      
      if (!inWurm && wurm2 != null) {
        for (int i = 0; i < wurm2.body.size(); i++) {
          Body curr = wurm2.body.get(i);
          if (curr.x > this.getBound("left") && curr.x < this.getBound("right") && curr.y < this.getBound("bottom") && curr.y > this.getBound("top")) {
          inWurm = true;
        }
        if (inWurm) break;
        }
      }
      
      // If the harvester was generated inside the wurm, reset inWurm and retry
      if (inWurm) {
         inWurm = false;
         continue;
      }
      
      hasMoved = false;
      break;
    }
  }
  
  void display() {
    if (!gc.isEasy) move();
    
    fill(255, 234, 0);
    ellipse(x, y, 10, 10);
    imageMode(CENTER);
    image(harvesterImage, x, y, board.getBoxSize()-4, board.getBoxSize()-4);
  }
  
  // Check for the sandworm's vicinity and move accordingly
  void move() {
    Sandworm wurmToCheck = wurm;
    int checks = 1;
    if (wurm2 != null) checks++;
    
    for (int i=0; i < checks; i++) {
      if (i == 1) wurmToCheck = wurm2;
      if (!hasMoved) {
        float radius = board.getBoxSize() * 3;
        Body head = wurmToCheck.body.get(0);
        if (head.x > x-radius && head.x < x+radius && head.y > y-radius && head.y < y+radius) {
          moving = true;
          hasMoved = true;
          
          int rand = int(random(0, 4));
          if (rand == 0) { //<>//
            dx = -1;
            dy = 0;
          } else if (rand == 1) {
            dx = 1;
            dy = 0;
          } else if (rand == 2) {
            dx = 0;
            dy = -1;
          } else {
            dx = 0;
            dy = 1;
          }
          
          // Temporarily change harvester position and check if it will move into the wurm
          // If it will, just abort the move
          x += (dx * board.getBoxSize());
          y += (dy * board.getBoxSize());
          for (int j=0; j<wurmToCheck.body.size(); j++) {
            Body curr = wurmToCheck.body.get(j);
            if (curr.x > getBound("left") && curr.x < getBound("right") && curr.y > getBound("top") && curr.y < getBound("bottom")) {
              moving = false;
            }
          }
          x -= (dx * board.getBoxSize());
          y -= (dy * board.getBoxSize());
        }
      }
      
      if (moving) {
        x += (dx * speed);
        y += (dy * speed);
        
        movingSteps++;
        
        if (movingSteps >= 8) {
           movingSteps = 0;
           moving = false;
        }
      }
    }
  }
  
  float getBound(String side) {
    if (side == "left") {
      return this.x - (board.boxSize/2);
    } else if (side == "right") {
      return this.x + (board.boxSize/2);
    } else if (side == "top") {
      return this.y - (board.boxSize/2);
    } else if (side == "bottom") {
      return this.y + (board.boxSize/2);
    }
    
    return -1.0;
  }
}
