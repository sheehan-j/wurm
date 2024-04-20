class Score {
   private int score;
   private int score2;
  
  // Initializes scores to 0
   Score() {
     score = 0;
     score2 = 0;
   }
   
   // Returns the score
   int getScore() {
     return score;
   }
   
   // Increments player 1's score
   void increase() {
     score += 1;
   }
   
   // Increments player 2's score
   void increaseScore2() {
     score2 += 1;
   }
   
   // Resets both scores to 0
   void reset() {
     score = 0;
     score2 = 0;
   }
   
   // Displays the score(s) based on whether the mode is 1P/2P
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
