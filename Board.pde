class Board {
  int size, numOfBoxes;
  float xPos, yPos;
  private int boxSize = 36;

  Board(int xPos, int yPos, int numOfBoxes) {
    this.numOfBoxes = numOfBoxes;
    size = boxSize * numOfBoxes;
    
    if (xPos == -1) {
       this.xPos = width/2 - size/2;
       this.yPos = height/2 - size/2;
    } else {
      this.xPos = xPos;
      this.yPos = yPos;
    }
  }

  // Draw tiles of sand for each box on the board 
  void display() {
    fill(255, 0, 0);
    strokeWeight(1);
    imageMode(CORNER);
    for (int i = 0; i < numOfBoxes; i++) {
      for (int j = 0; j < numOfBoxes; j++) {
        image(sand, xPos + (j*boxSize), yPos+(i*boxSize), boxSize, boxSize);
      }
    }
  }
  
  // Returns the size of each tile on the board
  int getBoxSize() {
    return boxSize;
  }
  
  // Return x-coord of the board (left side)
  float getXPos(){
    return xPos;
  }
  
  // Return y-coord of the board (top side)
  float getYPos(){
    return yPos;
  }
  
  // Return top bound, same as y-coord
  float getTopBound(){
    return yPos;
  }
  
  // Return bottom bound of the board (y-coord + size of the entire board)
  float getBottomBound(){
    return yPos + size;
  }
  
  // Return left bound, same as x-coord
  float getLeftBound(){
    return xPos;
  }
  
  // Return right bound of the board (x-coord + size of entire board)
  float getRightBound(){
    return xPos + size;
  }
}
