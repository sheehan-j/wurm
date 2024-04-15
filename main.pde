import processing.sound.*;

Score score;
Timer time;
Board board;
Sandworm wurm;
GameController gc;
Harvester harvester;

PImage background, image1P, image2P, titleText, sand;
PImage headLeft, headRight, headUp, headDown;
PImage bodyLeft, bodyRight, bodyUp, bodyDown;
PImage tailLeft, tailRight, tailUp, tailDown;
PImage harvesterImage;
PFont arial;
Button button1P, button2P, buttonStart, buttonDif1, buttonDif2, buttonDif3, buttonRestart, buttonMainMenu;
SoundFile bkgMusic;
SoundFile wormEat;

void setup() {
  size(850, 600);
  
  score = new Score();
  time = new Timer();
  gc = new GameController();
  
  background = loadImage("background.png");
  image1P = loadImage("1pbutton.png");
  image2P = loadImage("2pbutton.png");
  titleText = loadImage("titletext.png");
  sand = loadImage("sand.png");
  
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
  
  harvesterImage = loadImage("harvester.png");
  
  button1P = new Button(image1P, 110, 100, width-300, 40);
  button2P = new Button(image2P, 110, 110, width-150, 40);
  buttonDif1= new Button(image2P, 110, 110, width-340, 160);
  buttonDif2 = new Button(image2P, 110, 110, width-230, 160);
  buttonDif3 = new Button(image2P, 110, 110, width-120, 160);
  buttonStart = new Button(image2P, 110, 110, width-225, 300);
  buttonRestart = new Button(image2P, 110, 110, width/2-110-10, height/2-20);
  buttonMainMenu = new Button(image2P, 110, 110, width/2+10, height/2-20);
  
  arial = loadFont("Arial-BoldMT-48.vlw");
  
  wormEat = new SoundFile(this, "wormeat.mp3");
  bkgMusic = new SoundFile(this, "desert_background_music.mp3");
  bkgMusic.loop();
}

void draw() {
  gc.display();
}

void mousePressed() {
  if (gc.gameState == GameState.START_MENU || gc.gameState == GameState.START_MENU_2) {
    if (button1P.checkPressed() || button2P.checkPressed()) {
      gc.gameState = GameState.START_MENU_2;
    }
    if(buttonStart.checkPressed()){
      gc.startGame();
    }
  } else if (gc.gameState == GameState.WIN ||
    gc.gameState == GameState.LOSS ||
    gc.gameState == GameState.P1_WIN ||
    gc.gameState == GameState.P2_WIN) {
     if (buttonRestart.checkPressed()) {
       gc.startGame();
     } else if (buttonMainMenu.checkPressed()) {
       gc.gameState = GameState.START_MENU; 
     }
  }
}

void keyPressed() {
  if (key == ' ') {
    wurm.queueAdd();
  }
  
  if (gc.gameState == GameState.PLAYING && key == CODED) {
    if (keyCode == UP) {
      //wurm.changeDirUp();
      wurm.queueDir(0);
    }
    else if (keyCode == DOWN) {
      //wurm.changeDirDown();
      wurm.queueDir(2);
    } else if (keyCode == LEFT) {
      //wurm.changeDirLeft();
      wurm.queueDir(3);
    }
    else if (keyCode == RIGHT) {
      //wurm.changeDirRight();
      wurm.queueDir(1);
    }
  }
}
