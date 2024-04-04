class Board {
   int[][] board;
   int numX;
   int numY;
   int size;
   int xPos;
   int yPos;
   
   Board( int xPos_, int yPos_, int size_,int numX_, int numY_) {
     board = new int[numX_][numY_];
     numX = numX_;
     numY = numY_;
     size = size_;
     xPos = xPos_;
     yPos = yPos_;
     
   }
   
   void display() {
    strokeWeight(1);
    
    for(int i = 0; i<= numX; i++){
      line(xPos + (i*(size/numY)), yPos, xPos + (i*(size/numY)), yPos + size);
    }
    
    for(int j = 0; j<= numY; j++){
       line(xPos, yPos + (j*(size/numY)), xPos + size, yPos + (j*(size/numY)));
    }
   }
}
