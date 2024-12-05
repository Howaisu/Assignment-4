/*
I have a better algorithm, but may not fit with this program. if user pressed move key, let the line moves between x0 and x1, and this range is
the range of block size. So the whole area never changes, always 400*400
*/
class Map {
  ArrayList<PVector> points = new ArrayList<PVector>(); //The pvector for blocks; saving x,y value to draw the grid
  int size;
  PVector offset; // Changed to PVector!!
  PVector velocity; // velocity vector, to make it more smooth

  
  Map() {
    size = 15; //The size of block 15
    offset = new PVector(0, 0); // now needs to initialize it to (0, 0)
    velocity = new PVector(0, 0); // starting as 0
    initializePoints(); //First initialize
  }

  // 
  void initializePoints() {
    points.clear(); // clear all the points generated in the array

    //Calculate which points need to be displayed in the window based on the current offset
   //Make it in 400*400
    for (int x = 0; x < width; x += size) {
      for (int y = 0; y < height; y += size) {
        points.add(new PVector(x, y)); //adds all grid point to array
      }
    }
  }
  //-----------VELOCITY-------------//
    // SETTING(Parameter)
  void setVelocity(float vx, float vy,boolean stop) {
   
    println(velocity.x,velocity.y,stop);
    if(stop == false){
     
      velocity.add(vx,vy);
      //IDK what's the best way, I have to limit the speed
      if(velocity.y > 4)
      {
      velocity.y = 4; 
      }else if(velocity.y < -4)
      {
      velocity.y = -4;
      }
       if(velocity.x > 4)
      {
      velocity.x = 4; 
      }else if(velocity.x < -4)
      {
      velocity.x = -4;
      }
      //
      
    }else if(stop == true)
    {
     //velocity.set(0,0); //brake!
     //I need a slow down animation later, but I will move on to another function now
     if(velocity.y > 0)
      {
      velocity.y -= 2; 
      }else if(velocity.y < 0)
       velocity.y += 2; 
      {
       if(velocity.x > 0)
      {
      velocity.x -= 2; 
      }else if(velocity.x < 0)
       velocity.x += 2; 
      }
    }
    
  }

  // APPLYING/ADDING
  void applyVelocity() {
    offset.add(velocity);
  }
  
  //----------------------//

  /* Input value dx, dy to the update parameter of map class
  //Problem: too much lag, I need make it to PVector, to make it comfortable when press 2 keys down
  
  void update() {
    offset.add(dx, dy); //update the moving part
    initializePoints(); //Re-Initialize, to make it keep updating //problem: it can't fill the full screen aftering moved
  }*/

  //display the whole map
  void display() {
    
    //map color
    background(125);
    
    
    // push the map's display together by inputed value dx,dy
    pushMatrix();
    translate(offset.x, offset.y);
    //drawing set
    stroke(0);
    //draw all the points generated by intialize() and saved by PVector ArrayList
    for (PVector point : points) {
      float startX = point.x;
      float startY = point.y;
    
      // ensure inside window only
      if (startX >= -size && startX <= width && startY >= -size && startY <= height) {
        // horizontal
        if (startX + size <= width) {
          line(startX, startY, startX + size, startY);
        }
        // vertical
        if (startY + size <= height) {
          line(startX, startY, startX, startY + size);
        }
      }
    }
    popMatrix();
  }
}
