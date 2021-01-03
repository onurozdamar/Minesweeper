
GameManager gameManager;

void setup() {
  size(399, 399);

  gameManager = new GameManager();

  gameManager.startGame();
}

void draw() {
  gameManager.draw();
}

void mousePressed() {
  gameManager.mousePressed();
}

void keyPressed() {
  gameManager.keyPressed();
}
