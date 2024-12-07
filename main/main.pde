//Library
import processing.sound.*;
SoundFile pistol;
SoundFile runout;
SoundFile refill;
SoundFile hit;
PImage gun,intro,open;
// Spawn 10 enemies in the main program
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PVector velocity = new PVector(0, 0); // To store the map velocity
PVector translation = new PVector(0, 0); // Translation of the map
int backforce;
boolean fire;
Map myMap;
//
int score;
//AMMO
PVector Current = new PVector();
int ammo;
int maxAmmo = 12;
ArrayList<Ammo> ammos = new ArrayList<Ammo>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
boolean empty;
int maxHealth = 130;
int currentHealth;
//All for the invincible after hurt
boolean invincible = false; // Invincibility flag
int invincibilityStartTime = 0; // Start time of invincibility
int invincibilityDuration = 60; // Duration of invincibility in frames
//
boolean gameStarted;
boolean gameOver;
boolean showInstructions;
/*
I gonna figure out the slope of it. So.... k=dy/dx
or think another way, slope rate is actually the ratio of bullet.y : bullet.x
thus, what I am actually do, is geting the ratio of user click the mouse
and input this value to bullet to have an ray
*/
void setup() {
  size(400, 400);
  
  score = 0;
  currentHealth = maxHealth;
  // Sound initialization
  pistol = new SoundFile(this, "pistol.wav");
  runout = new SoundFile(this, "runout.wav");
  refill = new SoundFile(this, "refill.wav");
  hit = new SoundFile(this, "hit.wav");
  gun = loadImage("gun.png");
  intro = loadImage("intro.jpg");
  open = loadImage("open.jpg");
  
  myMap = new Map();
  Current.x = 25;
  Current.y = -102;

  // Initialize Ammo
  ammo = maxAmmo;
  empty = false;

  // Fill ammo list
  for (int i = 0; i < ammo; i++) {
    ammos.add(new Ammo());
  }

  // ENEMY INITIALIZATION
  for (int i = 0; i < 50; i++) {
    enemies.add(new Enemy(random(width * 8), random(height * 8)));
  }
}

void draw(){
  if (!gameStarted) {
    drawStartScreen();
  } else if (showInstructions) {
    drawInstructionsScreen();
  } else {
    drawGame();
  }
}


void drawStartScreen() {
 
 // textAlign(CENTER);
  fill(255);
  textSize(32);
  image(open,0,0,400,400);
}

void drawInstructionsScreen() {
  background(0);
  /*
  textAlign(CENTER);
  fill(255);
  textSize(24);
  text("How to Play", width / 2, height / 2 - 60);
  textSize(16);
  text("Use WASD to move", width / 2, height / 2 - 20);
  text("Click to shoot", width / 2, height / 2 + 10);
  text("Press 'B' to go back", width / 2, height / 2 + 60);
  */
  image(intro,0,0);
}


void drawGame() {
  background(255);

 // Apply velocity for smooth movement
  translation.add(velocity);

  // Update enemy positions to reflect movement in the opposite direction of the player
  for (Enemy enemy : enemies) {
    enemy.position.add(velocity); // Update enemy position in opposite direction of player movement
  }

  // Display the map
  pushMatrix();
  translate(translation.x, translation.y);
  myMap.display();
  popMatrix();

  // Display all enemies
  for (Enemy enemy : enemies) {
    enemy.display();
    enemy.move();
  }
  
  
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
      score ++;
      //sound
    //  if (!hit.isPlaying()) {
    hit.play();
     // }
     // enemy.px = direction
      break;
    }
  }
  }

  // Check for collision between player and enemies
  if (!invincible) {
    for (Enemy enemy : enemies) {
      float playerDistance = dist(width / 2, height / 2, enemy.position.x, enemy.position.y);
      if (playerDistance < (70 / 2 + enemy.size / 2)) {
        currentHealth -= 30;
        invincible = true;
        invincibilityStartTime = frameCount; // Start invincibility
        println("Player hit! Current health: " + currentHealth);
        if (currentHealth <= 0) {
          gameOver = true;
        }
      }
    }
  }

  // Handle invincibility timer
  if (invincible && frameCount > invincibilityStartTime + invincibilityDuration) {
    invincible = false; // End invincibility after duration
  }
  
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
    ellipse(3 + random(3), -105 - random(8), 22 + frameCount % 8, 22 + frameCount % 8);
    ellipse(3 + random(3), -105 + random(8), 22 + frameCount % 8, 22 + frameCount % 8);
    noStroke();
    fill(255, 12, 12, 15);
    ellipse(3 + random(3), -95 + random(8), 32 + frameCount % 8, 32 + frameCount % 8);
    backforce();
  }
  
  //Foot
   // println(walk);
  if(velocity.x!=0||velocity.y!= 0 ){
   // int m = frameCount%30;
    fill(0);
    rect(-20,-10 + sin(frameCount * 0.2) * 15,20,30);
    rect(20,-10 - sin(frameCount * 0.2) * 15,20,30);
  
  }
  
  
  //Hand
  fill(255, 229, 204);
 // rect(+20, -70, 20, 20);
 quad(0,-80,10,-60,0,-40,-10,-60);

 
  //Body
  fill(224);
  //arms
  quad(0,-40,-10,-60,-40,-10,-20,-10);
  quad(0,-40,10,-60,40,-10,20,-10);
  //body
  fill(208,28,28);
  rect(-40, -10, 80, 30);
  //shoulder
  ellipse(30,5,30,35);
  ellipse(-30,5,30,35);

  //Gun
  fill(0);
  rect(0, Current.y + backforce, 10, 45);
  //println(Current.x, Current.y );
  
  //Head
  noStroke();
  fill(0,0,51);
  triangle(-20,-40,-30,0,10,0);
  ellipse(0, 0, 50, 50);

  popMatrix();
  
  //A nowhere circle, ok now the circle is for the gun
  noFill();
  ellipse(width / 2, height / 2, 220, 220); 
  
  //Debug
  //println("now the bullet location is"+bulletSpeed);
  fill(232,218,28);
 // ellipse(bulletLocation.x,bulletLocation.y,20,20);
 // ------------------------------------UI-----------------------Layer---------------------TOP----------------//
  //weapon UI
  image(gun, 260, 0);
 //Health Bar
  fill(102,0,0);
  rect(30,30,130,20);
  fill(255,0,0);
  rect(30,30,currentHealth,20);
 
 // Display Ammo UI
  for (int i = 0; i < ammos.size(); i++) {
    int x = 280 + i * 8; // Spacing between ammo icons
    ammos.get(i).display(x);
  }
    textSize(24);
    fill(255);
  if (empty) {
   
    text("Press 'R' to reload", 110, 300);
    //  
  }
    //
    text("Your Score:"+score,30,80);
 //-------------------------------------------------------------------------------------------------------//
 //----Game Over------//
  if(gameOver){
    gameOver();
    noLoop();
  }
 
}


void mousePressed() {
 
  //Ammo
   if(ammo>0){
  ammo = ammo -1;
  ammos.remove(ammos.size() - 1); 
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
    direction.mult(8); // Set bullet speed

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
  
  //
  if (!gameStarted) {
    if (key == 'S' || key == 's') {
      gameStarted = true;
    } else if (key == 'H' || key == 'h') {
      showInstructions = true;
    }
  } else if (showInstructions) {
    if (key == 'B' || key == 'b') {
      showInstructions = false;
    }
  }
  
  

  
  // Set velocity values
  if (key == 'W' || key == 'w') {
    velocity.y = 2;
  //   walk = true;
  } else if (key == 'S' || key == 's') {
    velocity.y = -2;
   //  walk = true;
  } else if (key == 'A' || key == 'a') {
    velocity.x = 2;
   //  walk = true;
  } else if (key == 'D' || key == 'd') {
    velocity.x = -2;
  //  walk = true;
  } else
  {
    //walk = false;
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

void gameOver(){
  println("game over");
 
  background(0);
  textSize(48);
  text("Game Over",100,height/2);
  noLoop(); //https://processing.org/reference/noLoop_.html

}
