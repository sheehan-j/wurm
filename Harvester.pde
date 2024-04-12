class Harvester {
  float x, y; // Position on screen
  int speed = 5; // Speed that the harvester will move if the gamemode is appropriate
  
  Harvester() {
    this.generate();
  }
  
  void generate() {
    
    int rand = int(random(board.numOfBoxes)) + 1;
    x = board.getXPos() - (board.getBoxSize()/2) + board.getBoxSize() * rand;
    rand = int(random(board.numOfBoxes)) + 1;
    y = board.getYPos() - (board.getBoxSize()/2) + board.getBoxSize() * rand;
  }
  
  void display() {
    fill(255, 234, 0);
    ellipse(x, y, 10, 10);
    imageMode(CENTER);
    image(harvesterImage, x, y, board.getBoxSize()-4, board.getBoxSize()-4);
  }
  
  // Check for the sandworm's vicinity and move accordingly
  void move() {
    
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
