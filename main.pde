import processing.sound.*;

Score score;
Timer time;
Board board;
Sandworm wurm, wurm2;
GameController gc;
Harvester harvester;

PImage background, image1P, image1PSelected, image2P, image2PSelected, titleText, sand;
PImage easy, hard, easySelected, hardSelected;
PImage start, exit, restart;
PImage gamebackground;
PImage headLeft, headRight, headUp, headDown;
PImage bodyLeft, bodyRight, bodyUp, bodyDown;
PImage tailLeft, tailRight, tailUp, tailDown;
PImage headLeft2, headRight2, headUp2, headDown2;
PImage bodyLeft2, bodyRight2, bodyUp2, bodyDown2;
PImage tailLeft2, tailRight2, tailUp2, tailDown2;
PImage harvesterImage;
PFont arial, duneFont, arialSmall;
Button button1P, button2P, buttonStart, buttonQuit, buttonEasy, buttonHard, buttonRestart, buttonMainMenu;
SoundFile bkgMusic;
SoundFile wormEat;

void setup() {
  size(850, 600);
  surface.setTitle("Wurm");
  
  gc = new GameController();
  
  background = loadImage("background.png");
  image1P = loadImage("1pbutton.png");
  image1PSelected = loadImage("1pbuttonoutlined.png");
  image2P = loadImage("2pbutton.png");
  image2PSelected = loadImage("2pbuttonoutlined.png");
  titleText = loadImage("titletext.png");
  sand = loadImage("sand.png");
  
  easy = loadImage("difficulty1.png");
  hard = loadImage("difficulty2.png");
  easySelected = loadImage("difficulty1outlined.png");
  hardSelected = loadImage("difficulty2outlined.png");
  
  start = loadImage("start.png");
  exit = loadImage("quit.png");
  restart = loadImage("restart.png");
  
  gamebackground = loadImage("gamebackground.png");
  
  headUp = loadImage("wormheadup.png");
  headLeft = loadImage("wormheadleft.png");
  headDown = loadImage("wormheaddown.png");
  headRight = loadImage("wormheadright.png");

  bodyUp = loadImage("wormbodyup.png");
  bodyLeft = loadImage("wormbodyleft.png");
  bodyDown = loadImage("wormbodydown.png");
  bodyRight = loadImage("wormbodyright.png");
  
  tailUp = loadImage("wormtailup.png");
  tailLeft = loadImage("wormtailleft.png");
  tailDown = loadImage("wormtaildown.png");
  tailRight = loadImage("wormtailright.png");
  
  headUp2 = loadImage("wormhead2up.png");
  headLeft2 = loadImage("wormhead2left.png");
  headDown2 = loadImage("wormhead2down.png");
  headRight2 = loadImage("wormhead2right.png");
  
  bodyUp2 = loadImage("wormbody2up.png");
  bodyLeft2 = loadImage("wormbody2left.png");
  bodyDown2 = loadImage("wormbody2down.png");
  bodyRight2 = loadImage("wormbody2right.png");
    
  tailUp2 = loadImage("wormtail2up.png");
  tailLeft2 = loadImage("wormtail2left.png");
  tailDown2 = loadImage("wormtail2down.png");
  tailRight2 = loadImage("wormtail2right.png");

  harvesterImage = loadImage("harvester.png");
  
  button1P = new Button(image1P, image1PSelected, false, 110, 100, width-280, 75);
  button2P = new Button(image2P, image2PSelected, false, 110, 110, width-140, 70);
  buttonEasy = new Button(easy, easySelected, true, 110, 110, width-280, 200);
  buttonHard = new Button(hard, hardSelected, false, 110, 110, width-140, 200);
  buttonStart = new Button(start, null, false, 190, 110, width-245, 330);
  buttonQuit = new Button(exit, null, false, 190, 110, width-245, 450);
  buttonRestart = new Button(restart, null, false, 180, 100, width/2-180-10, height/2-10);
  buttonMainMenu = new Button(exit, null, false, 180, 100, width/2+10, height/2-10);
  
  arial = loadFont("Arial-BoldMT-48.vlw");
  duneFont = loadFont("Dune_Rise-48.vlw");
  arialSmall = loadFont("ArialMT-16.vlw");
  
  wormEat = new SoundFile(this, "wormeat.mp3");
  bkgMusic = new SoundFile(this, "desert_background_music.mp3");
  bkgMusic.loop();
}

void draw() {
  gc.display();
}

// Check for whether various buttons are displayed based on gamestate
void mousePressed() {
  if (gc.gameState == GameState.START_MENU || gc.gameState == GameState.START_MENU_2) {
    if (button1P.checkPressed()) {
      gc.gameState = GameState.START_MENU_2;
      button1P.setSelected(true);
      button2P.setSelected(false);
    } else if (button2P.checkPressed()) {
      gc.gameState = GameState.START_MENU_2;
      button1P.setSelected(false);
      button2P.setSelected(true);
    } else if (buttonEasy.checkPressed()) {
      buttonEasy.setSelected(true);
      buttonHard.setSelected(false);
    } else if (buttonHard.checkPressed()) {
      buttonEasy.setSelected(false);
      buttonHard.setSelected(true);
    } else if (buttonStart.checkPressed()){
      if (button1P.selected) gc.startGame(buttonEasy.selected ? true : false);
      else gc.startGame2P(buttonEasy.selected ? true : false);
    } else if (buttonQuit.checkPressed()) {
      exit();
    } else if (mouseX > width-125 && mouseX < width-10 && mouseY > 5 && mouseY < 36) {
      gc.gameState = GameState.MAN1;
    }
  } else if (gc.gameState == GameState.WIN ||
    gc.gameState == GameState.LOSS ||
    gc.gameState == GameState.P1_WIN ||
    gc.gameState == GameState.P2_WIN ||
    gc.gameState == GameState.DRAW) {
     if (buttonRestart.checkPressed()) {
       if (gc.is2P) gc.startGame2P(buttonEasy.selected ? true : false);
       else gc.startGame(buttonEasy.selected ? true : false);
     } else if (buttonMainMenu.checkPressed()) {
       gc.gameState = GameState.START_MENU; 
       button1P.setSelected(false);
       button2P.setSelected(false);
       buttonEasy.setSelected(true);
       buttonHard.setSelected(false);
     }
  } else if (gc.gameState == GameState.MAN1 || gc.gameState == GameState.MAN2 || gc.gameState == GameState.MAN3 || gc.gameState == GameState.MAN4 || gc.gameState == GameState.MAN5) {
    gc.checkManualControlPressed();
  }
}

// Check for WASD or arrow keys input based on gamestate/1-player v. 2-player
void keyPressed() {  
  if (gc.gameState == GameState.PLAYING) {
    if (key == CODED) {
      if (keyCode == UP) wurm.queueDir(0);
      else if (keyCode == DOWN) wurm.queueDir(2);
      else if (keyCode == LEFT) wurm.queueDir(3);
      else if (keyCode == RIGHT) wurm.queueDir(1);
    }
    
    if (wurm2 != null) {
      if (key == 'w' || key == 'W') wurm2.queueDir(0);
      else if (key == 'a' || key == 'A') wurm2.queueDir(3);
      else if (key == 's' || key == 'S') wurm2.queueDir(2);
      else if (key == 'd' || key == 'D') wurm2.queueDir(1);
    }
  }
}
