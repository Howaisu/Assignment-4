class Enemy {
  PVector position; //this is the position now, and it will move among the map, and later, it will going to catch the player
  float size; //whatever
  int maxHealth = 30;
  int health;
  //
   boolean hit;
  //
  float px,py;
  Enemy(float x, float y) {
    position = new PVector(x, y);
    size = 20; // 20x20
    hit = false;
    health = maxHealth;
  }

  // 
  void display() {
    fill(0, 255, 0); //g
    noStroke(); 
    if(hit){
     fill(255,0,0);
    }
    ellipse(position.x+px, position.y+py, size, size); 
  }
  
  void hurt() {
    hit = true;
    health -= 20; // deduct 20 per time
    px = random(-10,10);
    py = random(-10,10);
    
    //println("killed");
    /*if (health <= 0) {
      // death
      println("Enemy defeated!");
    }*/
  // hit = false;
  }
}
