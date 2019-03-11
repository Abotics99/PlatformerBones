
public class WorldLoader {
  
  private int[][] layer;
  private int width;
  private int height;
  ArrayList<Object> objects = new ArrayList<Object>();

  public WorldLoader(String file) {
    String[] inTemp = loadStrings("res/" + file + ".tmx");
    ArrayList<String> in = new ArrayList<String>();
    for(String tmp:inTemp){
      in.add(tmp);
    }
    while (in.size() > 0) {
      String temp = in.get(0);
      in.remove(0);
      if(temp.contains("<layer")) {
        int beginning = temp.indexOf("width=\"") + 7;
        int end = temp.substring(beginning).indexOf('\"')+beginning;
        this.width = Integer.parseInt(temp.substring(beginning, end));
        beginning = temp.indexOf("height=\"") + 8;
        end = temp.substring(beginning).indexOf("\"") + beginning;
        this.height = Integer.parseInt(temp.substring(beginning, end));
        in.get(0);
        in.remove(0);
        String[] mat = new String[height];
        for(int i =0;i<height;i++) {
          mat[i] = in.get(0);
          in.remove(0);
        }
        this.layer = ArrayLoader.loadArrayFromString(mat);
      }
      if(temp.contains("<object ")) {
        int beginning = temp.indexOf("gid=\"") + 5;
        int end = temp.substring(beginning).indexOf('\"')+beginning;
        int id = Integer.parseInt(temp.substring(beginning, end));
        beginning = temp.indexOf("x=\"") + 3;
        end = temp.substring(beginning).indexOf("\"") + beginning;
        int posX = Integer.parseInt(temp.substring(beginning, end));
        beginning = temp.indexOf("y=\"") + 3;
        end = temp.substring(beginning).indexOf("\"") + beginning;
        int posY = Integer.parseInt(temp.substring(beginning, end));
        objects.add(new Object(id, posX, posY));
      }
    }
  }

  public int[][] getLayer() {
    return layer;
  }

  public int getWidth() {
    return width;
  }

  public int getHeight() {
    return height;
  }

  public ArrayList<Object> getObjects() {
    return objects;
  }
  
  
}