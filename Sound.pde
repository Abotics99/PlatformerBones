
import processing.sound.*;

public class Sound {

  // Each sound effect has its own clip, loaded with its own sound file.
  SoundFile sound;

  float panDistance = 200;
  float volume = 1;

  // Constructor to construct each element of the enum with its own sound file.
  Sound(String name) {
    sound = new SoundFile(GlobalSettings.mainClass,("res/" + name + ".wav"));
  }

  // Play or Re-play the sound effect from the beginning, by rewinding.
  public void play() {
    sound.play(1,volume);
  }
  
  public void playAt(int x, int y) {
    int camX = (int) (GlobalSettings.getScreen().getCamX() + (GlobalSettings.getScreen().getPixelWidth()/2));
    float pan = (float) constrain(map(x - camX, -panDistance, panDistance, -1, 1),-1,1);
    sound.pan(pan);
    sound.play(1,volume);
  }

  public void stop() {
    sound.stop();
  }
}