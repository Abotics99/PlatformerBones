/*
 * NOTE: keep ENTIRE bounds of button inside the screen!! Will cause exception
 * otherwise!! NOTENOTE:The icon is expected to have been made on an 8x8 grid of
 * 1s and 0s no spacing.
 */
public class Button {
  int xPos;
  int yPos;
  int buttonWidth;
  int buttonHeight;
  color buttonColor;
  PImage icon;
  boolean hidden = false;
  Screen screen;
  PImage fontData;

  public Button(int _xPos, int _yPos, int _width, int _height, color col, int _icon) {
    xPos = _xPos;
    yPos = _yPos;
    buttonWidth = _width;
    buttonHeight = _height;
    buttonColor = col;
    this.screen = GlobalSettings.getScreen();
    this.fontData = GlobalSettings.getFontData();
    icon = tile(_icon);
  }

  public void hide() {
    hidden = true;
  }

  public void show() {
    hidden = false;
  }

  public void render() {
    if (!hidden) {
      int iconScale = 3;
      if (isPressed()) {
        drawRect(xPos, yPos + 2, buttonWidth, buttonHeight - 2, 110);
        drawIcon(((2 * xPos + buttonWidth) / 2) - (5 * iconScale),
            ((2 * yPos + buttonHeight) / 2) - (5 * iconScale) + 1, 90, iconScale, false);
        drawIcon(((2 * xPos + buttonWidth) / 2) - (5 * iconScale),
            ((2 * yPos + buttonHeight) / 2) - (5 * iconScale) + 2, 100, iconScale, false);
      } else {
        drawRect(xPos, yPos, buttonWidth, buttonHeight, 80);
        drawRect(xPos, yPos, buttonWidth, buttonHeight - 2, 100);
        drawIcon(((2 * xPos + buttonWidth) / 2) - (5 * iconScale),
            ((2 * yPos + buttonHeight) / 2) - (5 * iconScale) - 1, 80, iconScale, false);
        drawIcon(((2 * xPos + buttonWidth) / 2) - (5 * iconScale),
            ((2 * yPos + buttonHeight) / 2) - (5 * iconScale), 90, iconScale, false);
      }
    }
  }

  public void drawRect(int xPos, int yPos, int width, int height, int shade) {
    for (int x = xPos; x < xPos + width; x++) {
      for (int y = yPos; y < yPos + height; y++) {
        if (!(x == xPos && y == yPos) && !(x == xPos && y == yPos + height - 1)
            && !(x == xPos + width - 1 && y == yPos)
            && !(x == xPos + width - 1 && y == yPos + height - 1)) {
          screen.setPixel((y * screen.getPixelWidth()) + x, shift(buttonColor, shade));
        }
      }
    }
  }

  private void drawIcon(int xPos, int yPos, int shade, int scale, boolean inverted) {
    int index = 0;
    for (int x = xPos; x < xPos + 10 * scale; x += scale) {
      for (int y = yPos; y < yPos + 10 * scale; y += scale) {
        if (inverted) {
          if (icon.get(index / 10, index % 10) == color(0,0,0)) {
            drawSquare(x, y, shade, scale);
          }
        } else {
          if (icon.get(index / 10, index % 10) == color(255,255,255)) {
            drawSquare(x, y, shade, scale);
          }
        }
        index++;
      }
    }
  }

  public void drawSquare(int xPos, int yPos, int shade, int scale) {
    for (int y = yPos; y < yPos + scale; y++) {
      for (int x = xPos; x < xPos + scale; x++) {
        screen.setPixel((y * screen.getPixelWidth()) + x, shift(buttonColor, shade));
      }
    }
  }

  private PImage tile(int index) {
    if (index == -1) {
      return null;
    }
    return (fontData.get((index * 10) % fontData.width, ((index * 10) / fontData.width) * 10, 10, 10));
  }

  public boolean isPressed() {
    return (screen.mouseDown() && (screen.getMouseX() > xPos
        && screen.getMouseX() < xPos + buttonWidth
        && screen.getMouseY() > yPos
        && screen.getMouseY() < yPos + buttonHeight) && !hidden);
  }

  public color shift(color col, int percent) {
    return (color(max(0, min(255, (int) (red(col) * (percent / 100.0)))),
        max(0, min(255, (int) (green(col) * (percent / 100.0)))),
        max(0, min(255, (int) (blue(col) * (percent / 100.0))))));
  }
}