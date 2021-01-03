class Position {

  private float x, y; // coordinate
  private int i, j;  // indexes

  Position(int i, int j) {
    this.i = i;
    this.j = j;
  }

  void calculateX(float cellSize) {
    this.x = j * cellSize;
  }

  void calculateY(float cellSize) {
    this.y = i * cellSize;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  void setI(int i) {
    this.i = i;
  }

  void setJ(int j) {
    this.j = j;
  }

  int getI() {
    return i;
  }

  int getJ() {
    return j;
  }

  String toString() {
    return "x: " + x + " y " + y;
  }
}
