
Screen screen = new Screen();

PImage fontData;

Game game;

Text frameRateText;

public void setup(){
  size(780,585);
  frameRate(120);
  smooth(0);
  GlobalSettings.mainClass = this;
  screen.init();
  GlobalSettings.setScreen(screen);
  init();
}

public void draw(){
  update();
}

public void init() {
  fontData = loadImage("/res/Font.png");
  GlobalSettings.setFontData(fontData);
  // --initialize objects here--
  game = new Game();
  GlobalSettings.setGame(game);
  frameRateText = new Text(10,175,color(0,0,0),1);
  frameRateText.isInstant(true);
}

long lastUpdateTime = 0;

double nsPerFrame = 1000000000 / 60;

double frameTime;

public void update() {
  long now = System.nanoTime();
  
  if(now - lastUpdateTime > nsPerFrame){
    frameTime = now - lastUpdateTime;
    lastUpdateTime = now;
    tick();
    render();
  }
}

// -- fun stuff below --


void render() {
    screen.background(color(35,58,71, 255));
    game.render();
    frameRateText.render();
    screen.render();
}

public void tick() {
  game.update();
  frameRateText.setText(nf((float)(1000000000/frameTime),3,2));
  frameRateText.update();
}

public void keyPressed(){
  screen.checkKeyPress();
}

public void keyReleased(){
  screen.checkKeyRelease();
}
