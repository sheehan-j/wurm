import processing.sound.*;

Score score;
Timer time;
Board board;
Sandworm wurm;
GameController gc;
Harvester harvester;

PImage background, image1P, image2P, titleText;
PFont arial;
Button button1P, button2P;
SoundFile bkg_music;

void setup() {
  size(850, 600);
  
  score = new Score();
  time = new Timer(2, 0);
  time.startTime();
  gc = new GameController();
  board = new Board(width/2, height/2, 15);
  wurm = new Sandworm();
  harvester = new Harvester();
  
  background = loadImage("background.png");
  image1P = loadImage("1pbutton.png");
  image2P = loadImage("2pbutton.png");
  titleText = loadImage("titletext.png");
  
  button1P = new Button(image1P, 150, 150, width-320, 40);
  button2P = new Button(image2P, 150, 150, width-170, 40);
  
  arial = loadFont("Arial-BoldMT-48.vlw");
  
  bkg_music = new SoundFile(this, "desert_background_music.mp3");
  bkg_music.loop();
}

void draw() {
  gc.display();
}

void mouseClicked() {
  if (gc.gameState == GameState.START_MENU) {
    if (button1P.checkPressed()) {
      gc.startGame();
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
