class GameController {
  
  GameState gameState;
  int startFrame;
  float gameDifficulty;
  boolean is2P;
  boolean isEasy;
  
   GameController(){
     gameState = GameState.START_MENU;
   }
   
   // Initialize the game for 1-player mode, either easy or hard mode
   void startGame(boolean isEasy){
     time = new Timer();
     time.startTime();
     this.isEasy = isEasy;
     gameDifficulty = isEasy ? 6 : 7.5;
     score = new Score();
     board = new Board(-1, -1, 15);
     wurm = new Sandworm(false);
     wurm2 = null;
     harvester = new Harvester();
     this.gameState = GameState.PLAYING;
     is2P = false;
     startFrame = frameCount;
   }
   
   // Initialize the game for 2-player mode, either easy or hard mode
   void startGame2P(boolean isEasy){
     time = new Timer();
     time.startTime();
     this.isEasy = isEasy;
     gameDifficulty = isEasy ? 6 : 7.5;
     score = new Score();
     board = new Board(-1, -1, 15);
     wurm = new Sandworm(false);
     wurm2 = new Sandworm(true);
     harvester = new Harvester();
     this.gameState = GameState.PLAYING;
     is2P = true;
     startFrame = frameCount;
   }
   
   // Stops the game and changes to the provided state
   void endGame(GameState gameState) { // Either WIN, LOSS, P1_WIN, P2_WIN, DRAW
    this.gameState = gameState;
    time.stopTime();
  }
  
  // Main display method, displays all menus/the game based on game state
  // Also updates the wurms and checks for collisions
  void display() {
    // Display based on game state
    if (gameState == GameState.START_MENU || gameState == GameState.START_MENU_2) {
      displayStartMenu();
    } else if (gameState == GameState.PLAYING) {
      displayGame();
    } else if (gameState == GameState.WIN ||
      gameState == GameState.LOSS ||
      gameState == GameState.P1_WIN ||
      gameState == GameState.P2_WIN ||
      gameState == GameState.DRAW) {
      displayGame();
      displayGameEnd();
    }
    
    // Update the worm and check for collisions if the game is being played
    if (gameState == GameState.PLAYING) {
      wurm.update();
      wurm.checkCollision(); 
    }
    
    // Recheck for gamestate bc it could be updated by the wurm check collision
    if (wurm2 != null && gameState == GameState.PLAYING) {
      wurm2.update();
      wurm2.checkCollision();
    }
  }
  
  // Displays all relevant visuals for the start menu
  void displayStartMenu() {
    image(background, 0, 0);
    image(titleText, 20, height-180);
    button1P.display();
    button2P.display();
    buttonQuit.display();
    if(gameState == GameState.START_MENU_2) {
      buttonStart.display();
      buttonEasy.display();
      buttonHard.display();
    }
      
  }
  
  // Displays all elements of the game when it is being played
  void displayGame() {
    imageMode(CENTER);
    image(gamebackground,width/2, height/2, width, height);
    score.display(width-75, height/2);
    time.display(75, height/2);
    board.display();
    wurm.display();
    harvester.display();
    
    if (wurm2 != null) wurm2.display();
  }
  
  // Displays all relevant visuals for the game over menu
  void displayGameEnd() {
    fill(209,145,6);
    rectMode(CENTER);
    stroke(92,64,3);
    strokeWeight(3);
    rect(width/2, height/2, 450, 250);
    textAlign(CENTER);
    textSize(42);
    textFont(duneFont);
    fill(0);
    
    //image(gobackground,width/2, height/2, 700, 400);
    buttonRestart.display();
    buttonMainMenu.display();
    
    if (gameState == GameState.LOSS) {
      text("Game Over", width/2, height/2-40);
    } else if (gameState == GameState.WIN) {
      text("You Win!", width/2, height/2-40);
    } else if (gameState == GameState.P1_WIN) {
      text("P1 Wins!", width/2, height/2-40);
    } else if (gameState == GameState.P2_WIN) {
      text("P2 Wins!", width/2, height/2-40);
    } else if (gameState == GameState.DRAW) {
      text("Draw!", width/2, height/2-40);
    } else {
      print("Problem");
    }
    fill(255);
  }
}

// All possible game states
enum GameState {
  START_MENU, START_MENU_2, PLAYING, WIN, LOSS, P1_WIN, P2_WIN, DRAW;
}

// Class to represent all buttons in the UI
class Button {
  int buttonWidth, buttonHeight, x, y;
  PImage buttonImage, selectedButtonImage;
  boolean selected;
   
   // Initializes all relevant button data
   Button(PImage buttonImage, PImage selectedButtonImage, boolean selected, int buttonWidth, int buttonHeight, int x, int y) {
     this.buttonImage = buttonImage;
     this.selectedButtonImage = selectedButtonImage;
     this.selected = selected;
     this.buttonWidth = buttonWidth;
     this.buttonHeight = buttonHeight;
     this.x = x;
     this.y = y;
   }
   
   // Sets the selected state of the button
   void setSelected(boolean isSelected) {
      selected = isSelected;
   }
   
   // Displays all visuals for the button
   void display() {
     imageMode(CORNER);
     if (selected) image(selectedButtonImage, x, y, buttonWidth, buttonHeight);
     else image(buttonImage, x, y, buttonWidth, buttonHeight);
   }
   
   // Checks whether the mouse's current position is within the bounds of the button
   boolean checkPressed() {
      return mouseX > x && mouseX < x+buttonWidth && mouseY > y && mouseY < y + buttonHeight; 
   }
}
