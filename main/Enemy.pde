class Enemy {
  PVector position; //this is the position now, and it will move among the map, and later, it will going to catch the player
  float size; //whatever

  //
   boolean hit;
  //
  Enemy(float x, float y) {
    position = new PVector(x, y);
    size = 20; // 20x20
    hit = false;
  }

  // 
  void display() {
    fill(0, 255, 0); //g
    noStroke(); 
    ellipse(position.x, position.y, size, size); 
  }
}
