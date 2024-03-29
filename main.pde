Score score;

void setup() {
  size(600, 600);
  score = new Score();
}

void draw() {
  background(200);
  score.display();
}
