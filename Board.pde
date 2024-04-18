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
  
  int getBoxSize() {
    return boxSize;
  }
  
  float getXPos(){
    return xPos;
  }
  
  float getYPos(){
    return yPos;
  }
  
  float getTopBound(){
    return yPos;
  }
  
  float getBottomBound(){
    return yPos + size;
  }
  
  float getLeftBound(){
    return xPos;
  }
  
  float getRightBound(){
    return xPos + size;
  }
}
