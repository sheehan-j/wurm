class Score {
   private int score;
   private int score2;
  
   Score() {
     score = 0;
     score2 = 0;
   }
   
   int getScore() {
     return score;
   }
   
   void increase() {
     score += 1;
   }
   
   void increaseScore2() {
     score2 += 1;
   }
   
   void reset() {
     score = 0;
     score2 = 0;
   }
   
   void display(float x, float y) {
     if (gc.is2P) {
       fill(100);
       rectMode(CENTER);
       rect(x, y-18, 136, 100);
       
       fill(255);
       textFont(arial);
       textAlign(CENTER, CENTER);
       textSize(18);
       text("Score", x, y-50);
       
       textSize(32);
       text("P1: " + str(this.score), x, y-25);
       
       text("P2: " + str(this.score2), x, y + 8);
     } else {
       fill(100);
       rectMode(CENTER);
       rect(x, y-11, 136, 80);
       
       fill(255);
       textFont(arial);
       textAlign(CENTER, CENTER);
       textSize(18);
       text("Score", x, y-30);
       
       textSize(48);
       text(str(this.score), x,y);
     }
   }
}
