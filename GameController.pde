class GameController {

  GameState gameState;
  int startFrame;
  float gameDifficulty;
  boolean is2P;
  boolean isEasy;

  GameController() {
    gameState = GameState.START_MENU;
  }

  // Initialize the game for 1-player mode, either easy or hard mode
  void startGame(boolean isEasy) {
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
  void startGame2P(boolean isEasy) {
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
    } else if (gc.gameState == GameState.MAN1 || gc.gameState == GameState.MAN2 || gc.gameState == GameState.MAN3) {
      displayManual();
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
    
    rectMode(CORNERS);
    stroke(0);
    strokeWeight(1);
    fill(145, 101, 4);
    rect(width-125, 5, width-10, 36);
    textFont(duneFont);
    textSize(16);
    fill(0);
    textAlign(RIGHT, TOP);
    text("MANUAL", width-15, 15);
    
    if (gameState == GameState.START_MENU_2) {
      buttonStart.display();
      buttonEasy.display();
      buttonHard.display();
    }
  }

  // Displays all elements of the game when it is being played
  void displayGame() {
    imageMode(CENTER);
    image(gamebackground, width/2, height/2, width, height);
    score.display(width-75, height/2);
    time.display(75, height/2);
    board.display();
    wurm.display();
    harvester.display();

    if (wurm2 != null) wurm2.display();
  }

  // Displays all relevant visuals for the game over menu
  void displayGameEnd() {
    //fill(209, 145, 6);
    fill(200);
    rectMode(CENTER);
    stroke(92, 64, 3);
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

  void displayManual() {
    image(background, 0, 0);
    fill(235, 215, 170);
    rectMode(CENTER);
    stroke(0);
    strokeWeight(1);
    rect(width/2, height/2, 810, 560);
    
    String title = "";
    String body = "";

    if (gameState == GameState.MAN1) {
      title = "CONTROLS";
      body = "Once the game starts, the sandworm will immediately start moving. You cannot control the sandworm’s movement speed, but you can control its movement direction with the following controls:\n\n";
      body += "PLAYER 1\n";
      body += "Press the up arrow key to turn the sandworm up.\n";
      body += "Press the left arrow key to turn the sandworm left.\n";
      body += "Press the down arrow key to turn the sandworm down.\n";
      body += "Press the right arrow key to turn the sandworm right.\n\n";
      
      body += "PLAYER 2\n";
      body += "Press the W to turn the sandworm up.\n";
      body += "Press the A key to turn the sandworm left.\n";
      body += "Press the S key to turn the sandworm down.\n";
      body += "Press the D key to turn the sandworm right.\n\n";
      
      body += "NOTE: The sandworm can only move in 90 degree turns. It cannot perform a full 180 degree in place. For instance, if the sandworm is moving to the left and you’d like it to face to the right, you must first turn the sandworm upward or downward and then to the right.";
    } else if (gameState == GameState.MAN2) {
      title = "GOALS";
      
      body = "In controlling the sandworm, you have three goals:\n\n";
      body += "Avoid the sandworm’s head making contact with the four borders of the playable area (designated by a sand-like surface). This will result in the game ending. In the hard mode, the wurm moves slightly faster, making this more difficult.\n\n";
      body += "Avoid the sandworm’s head making contact with any parts of the body that trail behind it. This will result in the game ending. As the sandworm grows longer, this will become more difficult.\n\n";
      body += "'Eat' the harvesters that randomly spawn in the playable area. This can be accomplished by directing the sandworm’s head to make contact with the harvester. When this happens, the score will increment by one, the sandworm’s length will increment by one, and the harvester will disappear and a new one will be randomly generated. In hard mode, the harvesters will attempt to avoid the wurms, adding another layer of difficulty to the game.\n\n";
      
      body += "TWO PLAYER MODE:\n\n";
      body += "There is an added goal of avoiding making contact with the other wurm’s body. This will result in you losing the game. Likewise, your goal is to position your wurm in such a way that the other player’s wurm will make contact with your wurm’s body.\n\n";
    } else if (gameState == GameState.MAN3) {
      title = "HOW TO WIN";
      
      body = "The object of the game is to eat harvesters to achieve the highest score possible before the sandworm’s head makes contact with the wall or with its own body, which will end the game and reset the score.\n\n";
      body += "The ultimate goal of the game is to eat so many harvesters such that the sandworm’s body occupies every tile of playable area on the board. This would prevent any further harvesters from being generated and would result in a win for the player. However, this is an extremely difficult task.\n\n";
      
      body += "TWO PLAYER MODE:\n\n";
      
      body += "In two-player mode, winning is much easier. If the other player’s wurm makes contact with your wurm’s body or with the bounds of the board, you will win the game. Eating harvesters to increase the length of your wurm will make it easier to force the other player to make contact with your wurm.\n\n";
      body += "A head-on collision between the wurms will result in a draw.";
    }

    rectMode(CORNER);
    textFont(duneFont);
    textSize(36);
    textAlign(CENTER, CENTER);
    fill(0);
    text(title, width/2, 55);
    
    textFont(arialSmall);
    textAlign(LEFT, TOP);
    textSize(16);
    textLeading(20);
    text(body, 40, 90, width-80, height-180);
    
    fill(255);
    rectMode(CENTER);
    rect(85, height-50, 100, 30);
    if (gameState == GameState.MAN1 || gameState == GameState.MAN2) { 
      rect(width-85, height-50, 100, 30);
    }
    
    fill(0);
    textAlign(CENTER, CENTER);
    text("BACK", 85, height-50);
    if (gameState == GameState.MAN1 || gameState == GameState.MAN2) { 
      text("NEXT", width-85, height-50);
    }
  }
  
  void checkManualControlPressed() {
    if (mouseX > 85-50 && mouseX < 85+50 && mouseY > height-50-15 && mouseY < height-50+15) {
      if (gameState == GameState.MAN3) gameState = GameState.MAN2;
      else if (gameState == GameState.MAN2) gameState = GameState.MAN1;
      else if (gameState == GameState.MAN1) {
        gameState = GameState.START_MENU;
        button1P.setSelected(false);
        button2P.setSelected(false);
        buttonEasy.setSelected(true);
        buttonHard.setSelected(false);
      }
    } else if (mouseX > width-85-50 && mouseX < width-85+50 && mouseY > height-50-15 && mouseY < height-50+15) {
      if (gameState == GameState.MAN1) gameState = GameState.MAN2;
      else if (gameState == GameState.MAN2) gameState = GameState.MAN3; 
    }
  }
}

// All possible game states
enum GameState {
  START_MENU, START_MENU_2, PLAYING, WIN, LOSS, P1_WIN, P2_WIN, DRAW, MAN1, MAN2, MAN3;
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
  
