
public static class ArrayLoader {

  public static int[][] loadArrayFromString(String[] mat) {
    ArrayList<String> data = new ArrayList<String>();
    for(String temp: mat) {
      data.add(temp);
    }

    int[][] temp1 = new int[data.size()][data.get(0).split(",").length];

    for (int i = 0; i < temp1.length; i++) {
      String[] temp2 = data.get(i).split(",");
      for (int j = 0; j < temp2.length; j++) {
        temp1[i][j] = Integer.parseInt(temp2[j])-1;
      }
    }
    return temp1;
  }
}