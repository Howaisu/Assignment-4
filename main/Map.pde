/*
I have a better algorithm, but may not fit with this program. if user pressed move key, let the line moves between x0 and x1, and this range is
the range of block size. So the whole area never changes, always 400*400

wait a minute.... does it have to be this difficult?????
DO I even need a parameter? why not just draw the map, and using the keys to control push/pull the matrix
WHAT AM I DOING NOW?????
*/
class Map {
  int size;


  Map() {
    size = 30; 
  }


  void display() {
    
    background(125);
    
    stroke(0);
    for (int x = 0; x < height*10; x += size) {
      for (int y = 0; y < width*10; y += size) {
        //
        line(x, y, x + size, y);
        line(x, y, x, y + size);
      }
    }


  }
}
