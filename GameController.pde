class GameController {
  
  boolean gameActive;
  Integer win;
  
   GameController(){
     gameActive = true;
     win = null;
   }
   
   void startGame(){
     
   }
   
   void StartGame2P(){
     
   }
   
   void endGame(int win) { 
    gameActive = false;
    this.win = win;
    time.stopTime();
  }
  
  void display() {
    if (!gameActive) {  
      fill(255);
    rectMode(CENTER);
    rect(width/2, height/2, width/2, height/2);
    textAlign(CENTER);
    textSize(48); 
    fill(0);
    if (win == 0) {
      
      text("Game Over", width/2, height/2);
    } else if (win == 1) {
      text("Player 1 wins", width/2, height/2);
    } else if (win == 2) {
      text("Player 2 wins", width/2, height/2);
    } else {
      print("Problem");
    }
    fill(255);
    }
  }
}
