
public class Music {

  // Each sound effect has its own clip, loaded with its own sound file.
  SoundFile music;
  
  int posX = 0;
  int posY = 0;
  float panDistance = 1000;
  float volume = 1;

  // Constructor to construct each element of the enum with its own sound file.
  Music(String name) {
    music = new SoundFile(GlobalSettings.mainClass,"res/" + name + ".wav");
  }

  // Play or Re-play the sound effect from the beginning, by rewinding.
  public void play() {
    if(music.isPlaying()) {
      music.stop();
    }
    music.cue(0);
    music.play();
  }
  
  public void update() {
    int camX = (int) (GlobalSettings.getScreen().getCamX() + (GlobalSettings.getScreen().getPixelWidth()/2));
    int camY = (int) (GlobalSettings.getScreen().getCamY() + (GlobalSettings.getScreen().getPixelHeight()/2));
    double distance = dist(posX, posY, camX, camY);
    music.pan(constrain(map(posX - camX, -panDistance, panDistance, -1, 1),-1,1));
    music.amp(constrain(map((float) distance, 0, panDistance, volume, 0),0,volume));
  }
  
  public void playAt(int x, int y) {
    posX = x;
    posY = y;
    play();
  }

  public void stop() {
    music.stop();
  }
  
  public boolean isPlaying() {
    return music.isPlaying();
  }
}