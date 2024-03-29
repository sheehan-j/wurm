class Score {
   private int score;
   PFont arial;
  
   Score() {
     score = 0;
     arial = loadFont("Arial-BoldMT-48.vlw");
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
   
   void display() {
     textFont(arial);
     textSize(48);
     textAlign(RIGHT, TOP);
     text(str(this.score), width-10, 15);
   }
}
