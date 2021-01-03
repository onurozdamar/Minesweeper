import java.util.Collections;

class GameManager {

  int verticalCellNumber;
  int hortizonalCellNumber;

  int cellSize = 40;

  int bombCount = 9;

  Cell[][] cells;

  GameManager() {
    verticalCellNumber = (height + 1) / cellSize;
    hortizonalCellNumber = (width + 1) / cellSize;

    cells = new Cell[verticalCellNumber][hortizonalCellNumber];
  }

  void startGame() {
    ArrayList<Position> positions = new ArrayList();

    for (int i = 0; i < verticalCellNumber; i++) {
      for (int j = 0; j < hortizonalCellNumber; j++) {
        Position cellPos = new Position(i, j);
        cells[i][j] = new Cell(cellPos);
        positions.add(cellPos);
      }
    }

    Collections.shuffle(positions);

    for (int i = 0; i < bombCount; i++) {
      increaseNeighborBombCount(positions.get(i));
      getCell(positions.get(i)).makeBomb();
    }
  }

  void draw() {
    for (int i = 0; i < verticalCellNumber; i++) {
      for (int j = 0; j < hortizonalCellNumber; j++) {
        cells[i][j].draw();
      }
    }
  }

  void mousePressed() {
    Position selectedCellPosition = new Position(mouseY/cellSize, mouseX/cellSize);

    if (mouseButton == LEFT) {
      play(selectedCellPosition);
    } else if (mouseButton == RIGHT) {
      getCell(selectedCellPosition).setFlag();
    }
  }

  void keyPressed() {
    if (key == 'r') // reset game
      startGame();
    else if (key == 'q') // quit
      exit();
  }

  private void play(Position cellPos) {
    getCell(cellPos).open();

    if (getCell(cellPos).isBomb() || getClosedCellCount() == bombCount) {
      finishGame();
      return;
    }

    visitCell(cellPos);
  }

  private void visitCell(Position pos) {
    if (outOfBounds(pos))
      return;

    if (getCell(pos).isVisited() || getCell(pos).isBomb())
      return;

    getCell(pos).open();
    getCell(pos).visit();

    if (getCell(pos).getNeighborBombCount() == 0) {
      visitCell(new Position(pos.getI(), pos.getJ() + 1));
      visitCell(new Position(pos.getI(), pos.getJ() - 1));
      visitCell(new Position(pos.getI() + 1, pos.getJ()));
      visitCell(new Position(pos.getI() - 1, pos.getJ()));
    }
  }

  private Cell getCell(Position pos) {
    return cells[pos.getI()][pos.getJ()];
  }

  private int getClosedCellCount() {
    int closedCellCount = 0;

    for (int i = 0; i < verticalCellNumber; i++) {
      for (int j = 0; j < hortizonalCellNumber; j++) {
        if (!cells[i][j].isOpen()) {
          closedCellCount++;
        }
      }
    }

    return closedCellCount;
  }

  private boolean outOfBounds(Position pos) {
    return (pos.getJ() < 0 || pos.getJ() >= verticalCellNumber 
      || pos.getI() < 0 || pos.getI() >= hortizonalCellNumber);
  }

  private void finishGame() {
    for (int i = 0; i < verticalCellNumber; i++) {
      for (int j = 0; j < hortizonalCellNumber; j++) {
        cells[i][j].open();
      }
    }
  }

  private void increaseNeighborBombCount(Position pos) {
    for (int k = -1; k <= 1; k++) {
      for (int l = -1; l <= 1; l++) {
        Position newPos = new Position(pos.getI()+k, pos.getJ()+l);
        if (!outOfBounds(newPos)) {
          getCell(newPos).increaseNeighborBombCount();
        }
      }
    }
  }
}
