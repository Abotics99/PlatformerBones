
public class Sprite {
  PImage[][] sprite;
  int[][] tiles;
  PImage fontData;
  Screen screen;
  color col;
  int scale;
  boolean hidden = false;
  int xPos = 0;
  int yPos = 0;
  boolean flipped = false;
  boolean flashing = false;
  boolean visible = true;
  int flashSpeed = 3;
  long frameCount = 0;

  public Sprite(int[][] tiles, color col, int scale) {
    this.fontData = GlobalSettings.getFontData();
    setSpriteTiles(tiles);
    this.screen = GlobalSettings.getScreen();
    this.col = col;
    this.scale = scale;
  }

  public void draw(int x, int y) {
    setPos(x, y);
    render();
  }

  public void setPos(int x, int y) {
    xPos = x;
    yPos = y;
  }

  public int getTile(int x, int y) {
    int temp1 = (y - yPos) / (10 * scale);
    int temp2 = (x - xPos) / (10 * scale);
    if (temp1 >= 0 && temp2 >= 0 && temp1 < tiles.length && temp2 < tiles[0].length) {
      return tiles[temp1][temp2];
    }
    return -1;
  }

  public void setSpriteTiles(int[][] tiles) {
    this.tiles = tiles;
    sprite = new PImage[tiles.length][tiles[0].length];
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[i].length; j++) {
        sprite[i][j] = tile(tiles[i][j]);
      }
    }
  }

  public void render() {
    if (!hidden) {
      if (frameCount % flashSpeed == 0 && flashing)
        visible = !visible;
      if (visible || !flashing) {
        for (int i = 0; i < sprite.length; i++) {
          for (int j = 0; j < sprite[i].length; j++) {
            if (sprite[i][j] != null) {
              if (this.col != 0) {
                drawIcon(xPos + (j * 10 * scale) - (int) screen.getCamX(),
                    yPos + (i * 10 * scale) - (int) screen.getCamY(), sprite[i][j], 100, scale,
                    false);
              } else {
                drawTile(xPos + (j * 10 * scale) - (int) screen.getCamX(),
                    yPos + (i * 10 * scale) - (int) screen.getCamY(), sprite[i][j], 100, scale,
                    false);
              }
            }
          }
        }
      }
      frameCount++;
    }
  }

  private void drawIcon(int xPos, int yPos, PImage tile, int shade, int scale, boolean inverted) {
    int index = 0;
    if (xPos >= -10 * scale && yPos >= -10 * scale && xPos < screen.getPixelWidth()
        && yPos < screen.getPixelHeight()) {
      if (flipped) {
        for (int x = xPos + 10 * scale - 1; x >= xPos; x -= scale) {
          for (int y = yPos; y < yPos + 10 * scale; y += scale) {
            if (inverted) {
              if (tile.get(index / 10, index % 10) == color(0,0,0)) {
                drawSquare(x, y, shade, this.col, scale);
              }
            } else {
              if (tile.get(index / 10, index % 10) == color(255,255,255)) {
                drawSquare(x, y, shade, this.col, scale);
              }
            }
            index++;
          }
        }
      } else {
        for (int x = xPos; x < xPos + 10 * scale; x += scale) {
          for (int y = yPos; y < yPos + 10 * scale; y += scale) {
            if (inverted) {
              if (tile.get(index / 10, index % 10) == color(0,0,0)) {
                drawSquare(x, y, shade, this.col, scale);
              }
            } else {
              if (tile.get(index / 10, index % 10) == color(255,255,255)) {
                drawSquare(x, y, shade, this.col, scale);
              }
            }
            index++;
          }
        }
      }
    }
  }

  private void drawTile(int xPos, int yPos, PImage tile, int shade, int scale, boolean inverted) {
    int index = 0;
    if (xPos >= -10 * scale && yPos >= -10 * scale && xPos < screen.getPixelWidth()
        && yPos < screen.getPixelHeight()) {
      if (flipped) {
        for (int x = xPos + 10 * scale - 1; x >= xPos; x -= scale) {
          for (int y = yPos; y < yPos + 10 * scale; y += scale) {
            drawSquare(x, y, shade, color(tile.get(index / 10, index % 10)), scale);
            index++;
          }
        }
      } else {
        for (int x = xPos; x < xPos + 10 * scale; x += scale) {
          for (int y = yPos; y < yPos + 10 * scale; y += scale) {
            drawSquare(x, y, shade, color(tile.get(index / 10, index % 10)), scale);
            index++;
          }
        }
      }
    }
  }

  private void drawSquare(int xPos, int yPos, int shade, color col, int scale) {
    for (int y = yPos; y < yPos + scale; y++) {
      for (int x = xPos; x < xPos + scale; x++) {
        if (x >= 0 && x < screen.getPixelWidth()) {
          screen.setPixel((y * screen.getPixelWidth()) + x, shift(col, shade));
        }
      }
    }
  }

  private PImage tile(int index) {
    if (index == -1) {
      return null;
    }
    return (fontData.get((index * 10) % fontData.width, ((index * 10) / fontData.width) * 10, 10, 10));
  }

  public color shift(color col, int percent) {
    return (color(max(0, min(255, (int) (red(col) * (percent / 100.0)))),
        max(0, min(255, (int) (green(col) * (percent / 100.0)))),
        max(0, min(255, (int) (blue(col) * (percent / 100.0))))));
  }

  public void isHidden(boolean hidden) {
    this.hidden = hidden;
  }

  public boolean isHidden() {
    return hidden;
  }

  public void setFlipped(boolean flipped) {
    this.flipped = flipped;
  }

  public boolean isFlipped() {
    return flipped;
  }

  public double getPosX() {
    return xPos;
  }

  public double getPosY() {
    return yPos;
  }

  public double getWidth() {
    return sprite[0].length * 10;
  }

  public double getHeight() {
    return sprite.length * 10;
  }

  public void setFlashSpeed(int flashSpeed) {
    this.flashSpeed = flashSpeed;
  }

  public void setFlashing(boolean flashing) {
    this.flashing = flashing;
  }

  public boolean isFlashing() {
    return flashing;
  }
}