//Library
import processing.sound.*;
SoundFile pistol;
SoundFile runout;
SoundFile refill;
SoundFile hit;
// Spawn 10 enemies in the main program
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PVector velocity = new PVector(0, 0); // To store the map velocity
PVector translation = new PVector(0, 0); // Translation of the map
int backforce;
boolean fire;
Map myMap;
//
PVector Current = new PVector();
int ammo;
int maxAmmo = 12;
ArrayList<Ammo> ammos = new ArrayList<Ammo>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
boolean empty;
/*
I gonna figure out the slope of it. So.... k=dy/dx
or think another way, slope rate is actually the ratio of bullet.y : bullet.x
thus, what I am actually do, is geting the ratio of user click the mouse
and input this value to bullet to have an ray
*/
void setup() {
  size(400, 400);
  //Sound
  pistol = new SoundFile(this, "pistol.wav");
  runout = new SoundFile(this, "runout.wav");
  refill = new SoundFile(this, "refill.wav");
  hit = new SoundFile(this, "hit.wav");
  
  
  
  myMap = new Map();
  //
   Current.x = 25;
   Current.y = -102;
  // Initialize Ammo
  ammo = maxAmmo;
  empty = false;
   // Fill ammo list
  for (int i = 0; i < ammo; i++) {
    ammos.add(new Ammo());
  }
  // ENEMY INITIAL
  for (int i = 0; i < 50; i++) {
    enemies.add(new Enemy(random(width*2), random(height*2)));
  }
}

void draw() {
  background(255);

  // Apply velocity for smooth movement
  translation.add(velocity);

  // Use translate() to move the map and enemies
  pushMatrix();
  translate(translation.x, translation.y);
  myMap.display();
  // Display all enemies
  for (Enemy enemy : enemies) {
    enemy.display();
  }
  popMatrix();
  
  
  //BUllet Layer
  // Update and display all bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();
    
    // Remove bullet if it moves off screen
    if (b.position.x < 0 || b.position.x > width || b.position.y < 0 || b.position.y > height) {
      bullets.remove(i); //It's not that important for ArrayList, but I still think I need include this one
      continue;  
  }
    for (int j = enemies.size() - 1; j >= 0; j--) {
    //IDK why it won't work after hit few enemies, I need to solve it. It works well at beginning
    Enemy enemy = enemies.get(j);
   
    float distance = dist(b.position.x, b.position.y, enemy.position.x, enemy.position.y);
    
    
    if (distance < enemy.size / 2) {
      bullets.remove(i);  
      enemy.hurt();      
      println("hit!");
     // enemy.px = direction
      break;
    }
  }
  }

  //
 
  
  float angle = atan2(mouseY - height / 2, mouseX - width / 2);
  //
  pushMatrix();
  /*
  From here, I will think about how to calculate the bullet trajectory
  */
  
  
  //
  translate(width / 2, height / 2); 
  rotate(angle + PI / 2);  
  //Firing
  if (fire) {
    stroke(255, 0, 0, 30);
    fill(255, 255, 0, 50);
    ellipse(+30 + random(3), -105 - random(8), 22 + frameCount % 8, 22 + frameCount % 8);
    ellipse(+30 + random(3), -105 + random(8), 22 + frameCount % 8, 22 + frameCount % 8);
    noStroke();
    fill(255, 12, 12, 15);
    ellipse(+30 + random(3), -95 + random(8), 32 + frameCount % 8, 32 + frameCount % 8);
    backforce();
  }
  //Hand
  fill(255, 229, 204);
  rect(+20, -70, 20, 20);

 
  //Body
  fill(255, 0, 0);
  rect(-40, -10, 80, 30);
  rect(+20, -50, 20, 40); 

  //Gun
  fill(0);
  rect(Current.x, Current.y + backforce, 10, 45);
  //println(Current.x, Current.y );
  
  //Head
  stroke(0);
  fill(0);
  ellipse(0, 0, 60, 60);

  popMatrix();
  
  //A nowhere circle, ok now the circle is for the gun
  noFill();
  ellipse(width / 2, height / 2, 220, 220); 
  
  //Debug
  //println("now the bullet location is"+bulletSpeed);
  fill(232,218,28);
 // ellipse(bulletLocation.x,bulletLocation.y,20,20);
 // ------------------------------------UI-----------------------Layer---------------------TOP----------------//
 // Display Ammo UI
  for (int i = 0; i < ammos.size(); i++) {
    int x = 280 + i * 8; // Spacing between ammo icons
    ammos.get(i).display(x);
  }

  if (empty) {
    textSize(24);
    fill(255);
    text("Press 'R' to reload", 110, 300);
    //
    
  }
 
 //-------------------------------------------------------------------------------------------------------//
}


void mousePressed() {
 
  //Ammo
   if(ammo>0){
  ammo = ammo -1;
  ammos.remove(ammos.size() - 1); //after adding reload , here is no longer make sense
   }
  println(ammo);
   //Boom
  
  
 if (ammo > 0) {
    ammo -= 1;
    ammos.remove(ammos.size() - 1);
    empty = ammo == 0; // Update empty status

    fire = true;
    //sound
    if (!pistol.isPlaying()) {
    pistol.play();
  }

    // Bullet direction and creation
    PVector direction = new PVector(mouseX - width / 2, mouseY - height / 2);
    direction.normalize();
    println(direction.x,direction.y);
    direction.mult(5); // Set bullet speed

    Bullet newBullet = new Bullet(width / 2, height / 2, direction);
    bullets.add(newBullet);
  } else {
    empty = true;
    if (!runout.isPlaying()) {
    runout.play();
    }
  }
  
 


  
}

void backforce() {
  if (fire && backforce < 18) {
    backforce += 3; //backforce
  } 
  if (!fire && backforce > 18) {
    backforce--;  //returns
  }
  if (backforce >= 18) {
    fire = false;
    backforce = 0;
  }
  
}




void keyPressed() {
  // Set velocity values
  if (key == 'W' || key == 'w') {
    velocity.y = 2;
  } else if (key == 'S' || key == 's') {
    velocity.y = -2;
  } else if (key == 'A' || key == 'a') {
    velocity.x = 2;
  } else if (key == 'D' || key == 'd') {
    velocity.x = -2;
  } 
    // Reload ammo

  
  if (key == 'R' || key == 'r') {
  
   // println(a);
    if (!refill.isPlaying()) {
    refill.play();
    }
    
    ammo = maxAmmo;
    ammos.clear();
    for (int i = 0; i < ammo; i++) {
      ammos.add(new Ammo());
    }
    empty = false; // Reset empty status
    
  }
  

}

void keyReleased() {
  // Stop movement in the corresponding direction when the key is released
  if (key == 'W' || key == 'w' || key == 'S' || key == 's') {
    velocity.y = 0;
  } else if (key == 'A' || key == 'a' || key == 'D' || key == 'd') {
    velocity.x = 0;
  }
}
