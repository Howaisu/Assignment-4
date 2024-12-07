class Enemy {
  PImage ghost;
  PVector position; //this is the position now, and it will move among the map, and later, it will going to catch the player
  PVector move;
  float size; //whatever
  int maxHealth = 30;
  int health;
  int xMove,yMove,speed;
  //
   boolean hit;
  //
  float px,py;
  Enemy(float x, float y) {
    ghost = loadImage("ghost.png");
    position = new PVector(x, y);
    size = 25; // 
    hit = false;
    health = maxHealth;
    speed = 3;
    move = new PVector();
  }

  // 
  void display() {
    fill(0, 255, 0); //g
    noStroke(); 
    if(hit){
     fill(255,0,0);
    }
    ellipse(position.x+px, position.y+py, size, size); 
    image(ghost,position.x+px-10, position.y+py-10);
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
  
  void move()
  { 
     // Move towards the player (width/2,height/2)
    PVector playerPosition = new PVector(width / 2, height / 2); //write in the location of player
    PVector direction = PVector.sub(playerPosition, position);  // get the direction
    direction.normalize();  //normalize again(before I got an issue without this, it told me something can't be float, I searched and found it need this thing)
    direction.mult(1); // Set enemy speed
    //debug check whether activated
    println(direction);
    position.add(direction); //running to there
    
    //old method
  /*  if(position.x > width/2)
    {
      //  move = new PVector(0,2);
      xMove = -speed;
    }else if(position.x < width/2)
    {
      xMove = speed;
    }else if(position.y > height/2)
    {
      yMove = speed;
    }
    else if(position.y < height/2)
    {
      yMove = -speed;
    }
    move = new PVector(xMove,yMove);
    position.add(move);
  */
    
  }

}
