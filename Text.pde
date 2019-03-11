
public class Text {
  String displayText;
  boolean updateText = false;
  int characterPos = 0;
  int xPos;
  int yPos;
  int scale;
  color textColor;
  PImage fontData;
  Screen screen;
  private boolean instant = false;

  public Text(int _x, int _y, color col, int _scale) {
    xPos = _x;
    yPos = _y;
    textColor = col;
    scale = _scale;
    this.fontData = GlobalSettings.getFontData();
    this.screen = GlobalSettings.getScreen();
  }
  
  public boolean isInstant() {
    return instant;
  }
  
  public void isInstant(boolean instant) {
    this.instant = instant;
  }

  public void render() {
    for (int i = 0; i < characterPos; i++) {
      drawIcon((i * 10 * scale) + xPos, yPos, 100, scale, (int) displayText.charAt(i));
    }
  }

  public void update() {
    if (characterPos < displayText.length()) {
      characterPos++;
    }
    if(instant) {
      characterPos = displayText.length();
    }
  }

  public void setText(String input) {
    displayText = input;
    characterPos = 0;
    updateText = true;
    update();
  }

  public void drawIcon(int xPos, int yPos, int shade, int scale, int icon) {
    int index = 0;
    for (int x = xPos; x < xPos + 10 * scale; x += scale) {
      for (int y = yPos; y < yPos + 10 * scale; y += scale) {
        if (tile(icon).get(index / 10, index % 10) == color(255,255,255)) {
          drawSquare(x, y, shade, scale);
        }
        index++;
      }
    }
  }

  public void drawSquare(int xPos, int yPos, int shade, int scale) {
    for (int y = yPos; y < yPos + scale; y++) {
      for (int x = xPos; x < xPos + scale; x++) {
        screen.setPixel((y * screen.getPixelWidth()) + x,shift(textColor, shade));
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
}