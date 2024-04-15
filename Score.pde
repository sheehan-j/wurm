class Score {
   private int score;
  
   Score() {
     score = 0;
   }
   
   int getScore() {
     return score;
   }
   
   void increase() {
     score += 1;
   }
   
   void reset() {
     score = 0;
   }
   
   void display(float x, float y) {
     fill(255);
     textFont(arial);
     textSize(48);
     textAlign(RIGHT, TOP);
     text(str(this.score), x,y);
   }
}
