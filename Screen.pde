
public class Screen {
  // --screenSettings--
  public static final int WIDTH = 260;
  public static final int HEIGHT = WIDTH / 12 * 9;
  public static final int SCALE = 3;
  public static final String NAME = "Jumpy Shoot Boy";

  private PImage image = createImage(WIDTH, HEIGHT,RGB);

  // --mouse data--
  private boolean mouseDown = false;

  // --Keyboard data--
  private boolean up;
  private boolean down;
  private boolean left;
  private boolean right;
  private boolean jump;
  private boolean fire;
  private boolean escape;

  // camera data
  private double cameraX = 0;
  private double cameraY = 0;
  private double cameraOffsetX = 0;
  private double cameraOffsetY = 0;
  int shakeTimer = 0;
  int shakeAmount;

  // timing
  public double deltaTime;
  public long lastTime;
  public long time;
  private int frameCount;

  public Screen() {
    time = System.nanoTime();
    lastTime = time;
  }

  public void init() {
    //size(WIDTH * SCALE, HEIGHT * SCALE);
    image.loadPixels();
  }

  public void render() {
    checkMousePress();
    checkKeyboardInput();
    if (shakeTimer > 0) {
      setCameraOffset(random(-shakeAmount, shakeAmount),
          random(-shakeAmount, shakeAmount));
      shakeTimer--;
    } else {
      setCameraOffset(0, 0);
    }
    image.updatePixels();
    image(image, 0, 0, width, height);
    
    time = System.nanoTime();
    deltaTime = time - lastTime;
    lastTime = time;
    frameCount++;
  }

  public int getPixel(int index) {
    return image.pixels[index];
  }

  public void setPixel(int index, int val) {
    if (index < image.pixels.length && index >= 0) {
      image.pixels[index] = val;
    }
  }

  public int getPixelWidth() {
    return WIDTH;
  }

  public int getPixelHeight() {
    return HEIGHT;
  }

  public int getPixelScale() {
    return SCALE;
  }
  
  public void background(color col) {
    for (int i = 0; i < image.pixels.length; i++) {
      image.pixels[i] = lerpColor(color(image.pixels[i]), col, (int)alpha(col));
    }
  }

  public color lerpColor(color col1, color col2, int alpha) {
    return color((int) lerp(red(col1), red(col2), alpha / 255.0),
        (int) lerp(green(col1), green(col2), alpha / 255.0),
        (int) lerp(blue(col1), blue(col2), alpha / 255.0));
  }

  // --mouse related info!!!!!!--
  
  void checkMousePress(){
    mouseDown = mousePressed;
  }
  
  void checkKeyboardInput(){
    
  }

  public int getMouseX() {
    return (int)(mouseX / ((float)width/WIDTH));
  }

  public int getMouseY() {
    return (int)(mouseY / ((float)height/HEIGHT));
  }

  public boolean mouseDown() {
    return mouseDown;
  }

  public boolean upPressed() {
    return up;
  }

  public boolean downPressed() {
    return down;
  }

  public boolean leftPressed() {
    return left;
  }

  public boolean rightPressed() {
    return right;
  }

  public boolean jumpPressed() {
    return jump;
  }

  public boolean firePressed() {
    return fire;
  }

  public boolean escapePressed() {
    return escape;
  }

  public void checkKeyPress() {
    if (key == 'w')
      up = true;
    if (key == 's')
      down = true;
    if (key == 'a')
      left = true;
    if (key == 'd')
      right = true;
    if (key == ' ')
      jump = true;
    if (keyCode == ENTER)
      fire = true;
    if (keyCode == ESC)
      escape = true;
      key = 0;
  }

  public void checkKeyRelease() {
    if (key == 'w')
      up = false;
    if (key == 's')
      down = false;
    if (key == 'a')
      left = false;
    if (key == 'd')
      right = false;
    if (key == ' ')
      jump = false;
    if (keyCode == ENTER)
      fire = false;
    if (keyCode == ESC)
      escape = false;
  }

  public void keyTyped(KeyEvent e) {
    // TODO Auto-generated method stub

  }

  public double getCamX() {
    return cameraX + cameraOffsetX;
  }

  public double getCamY() {
    return cameraY + cameraOffsetY;
  }

  public void setCameraPos(double x, double y) {
    if (GlobalSettings.getGame() != null) {
      this.cameraX = constrain((float)x, 0.0, (float)GlobalSettings.getGame().getCurrentWorld().getWidth()-getPixelWidth());
      this.cameraY = constrain((float)y, 0.0, (float)GlobalSettings.getGame().getCurrentWorld().getHeight()-getPixelHeight());
    }else {
      this.cameraX = x;
      this.cameraY = y;
    }
  }

  public void setCameraOffset(double x, double y) {
    this.cameraOffsetX = x;
    this.cameraOffsetY = y;
  }

  public void shake(int length, int amount) {
    this.shakeTimer = length;
    this.shakeAmount = amount;
  }

  public int getFrameCount() {
    return frameCount;
  }
}
