class GameController {
  
  GameState gameState;
  
   GameController(){
     gameState = GameState.START_MENU;
   }
   
   void startGame(){
     
   }
   
   void StartGame2P(){
     
   }
   
   void endGame(GameState gameState) { // Either WIN, LOSS, P1_WIN, P2_WIN 
    this.gameState = gameState;
    time.stopTime();
  }
  
  void display() {
    // Display based on game state
    if (gameState == GameState.START_MENU) {
      displayStartMenu();
    } else if (gameState == GameState.PLAYING) {
      displayGame();
    } else if (gameState == GameState.WIN ||
      gameState == GameState.LOSS ||
      gameState == GameState.P1_WIN ||
      gameState == GameState.P2_WIN) {
      displayGame();
      displayGameEnd();
    }
    
    // Update the worm and check for collisions if the game is being played
    if (gameState == GameState.PLAYING) {
      wurm.update();
      wurm.checkCollision(); 
    }
  }
  
  void displayStartMenu() {
    image(background, 0, 0);
  }
  
  void displayGame() {
    background(200);
    score.display();
    time.display(width/2, 50);
    board.display();
    wurm.display();
    harvester.display();
  }
  
  void displayGameEnd() {
    fill(255);
    rectMode(CENTER);
    rect(width/2, height/2, width/2, height/2);
    textAlign(CENTER);
    textSize(48); 
    fill(0);
    
    if (gameState == GameState.LOSS) {
      text("Game Over", width/2, height/2);
    } else if (gameState == GameState.WIN) {
      text("You Win!", width/2, height/2);
    } else if (gameState == GameState.P1_WIN) {
      text("Player 1 wins", width/2, height/2);
    } else if (gameState == GameState.P2_WIN) {
      text("Player 2 wins", width/2, height/2);
    } else {
      print("Problem");
    }
    fill(255);
  }
}

enum GameState {
  START_MENU, PLAYING, WIN, LOSS, P1_WIN, P2_WIN;
}
