class Cell {

  private Position position;
  private int cellSize = 40;

  private boolean open = false;
  private boolean bomb = false;

  private boolean visited = false;

  private int neighborBombCount = 0;

  private boolean drawFlag = false;

  Cell(Position position) {
    this.position = position;
    position.calculateX(cellSize);
    position.calculateY(cellSize);
  }

  void draw() {
    drawRect();
    if (open) {
      if (bomb) {
        drawEllipse();
      } else {
        writeBombCount();
      }
    } else {
      if (drawFlag) {
        drawFlag();
      }
    }
  }

  private void drawRect() {
    fill(getRectcolor());
    stroke(0);
    rect(position.getX() - 1, position.getY() - 1, cellSize, cellSize);
  }

  private void drawEllipse() {
    fill(#5F5F5F);
    ellipse(position.getX()+cellSize/2, position.getY()+cellSize/2, cellSize/2, cellSize/2);
  }

  private void drawFlag() {
    stroke(255, 0, 0);
    line(position.getX() + cellSize/2 + 3, position.getY() + cellSize/2, 
      position.getX() + cellSize/2 - 3, position.getY() + cellSize/2);
    line(position.getX() + cellSize/2, position.getY() + cellSize/2 + 3, 
      position.getX() + cellSize/2, position.getY() + cellSize/2 - 3);
  }

  private void writeBombCount() {
    fill(0);
    textAlign(CENTER);
    textSize(15);
    if (neighborBombCount != 0)
      text(neighborBombCount + "", position.getX() + cellSize/2, position.getY() + cellSize/2 + 3);
  }

  void open() {
    open = true;
  }

  void makeBomb() {
    bomb = true;
  }

  void increaseNeighborBombCount() {
    neighborBombCount++;
  }

  void visit() {
    visited = true;
  }

  void setFlag() {
    drawFlag = !drawFlag;
  }

  int getNeighborBombCount() {
    return neighborBombCount;
  }

  boolean isOpen() {
    return open;
  }

  boolean isBomb() {
    return bomb;
  }

  boolean isVisited() {
    return visited;
  }

  private color getRectcolor() {
    return open ? #A7A1A1 : #5F5F5F;
  }
}
