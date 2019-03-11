
Screen screen = new Screen();

PImage fontData;

Game game;

public void setup(){
  size(780,585);
  frameRate(60);
  smooth(0);
  GlobalSettings.mainClass = this;
  screen.init();
  GlobalSettings.setScreen(screen);
  init();
}

public void draw(){
  update();
  //println(frameRate);
}

public void init() {
  fontData = loadImage("/res/Font.png");
  GlobalSettings.setFontData(fontData);
  // --initialize objects here--
  game = new Game();
  GlobalSettings.setGame(game);
}
  
public void update() {
  tick();
  render();
}

// -- fun stuff below --

void render() {
    screen.background(color(35,58,71, 255));
    game.render();
    screen.render();
}

public void tick() {
  game.update();
}

public void keyPressed(){
  screen.checkKeyPress();
}

public void keyReleased(){
  screen.checkKeyRelease();
}
