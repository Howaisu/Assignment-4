// Spawn 10 enemies in the main program
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PVector velocity = new PVector(0, 0); // To store the map velocity
PVector translation = new PVector(0, 0); // Translation of the map
int backforce;
boolean fire;
Map myMap;
//Bullet angle
/*PVector bulletAngle = new PVector(0, 0);
PVector bulletLocation = new PVector(0,0);
PVector direction;
//float k;
float speed = 1;
//PVector currentPosition;
*/
//Didn't make good, make it again:
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
/*
I gonna figure out the slope of it. So.... k=dy/dx
or think another way, slope rate is actually the ratio of bullet.y : bullet.x
thus, what I am actually do, is geting the ratio of user click the mouse
and input this value to bullet to have an ray
*/
void setup() {
  size(400, 400);
  
  myMap = new Map();
  
  // Initialize 10 enemies with random positions
  for (int i = 0; i < 30; i++) {
    enemies.add(new Enemy(random(width*10), random(height*10)));
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
  rect(+25, -102 + backforce, 10, 45);

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
  fill(255,0,0);
 // ellipse(bulletLocation.x,bulletLocation.y,20,20);
}


void mousePressed() {
  //Boom
  fire = true; 
 
  //Bullet track
   // Calculate direction from the center of the screen to the mouse position
  PVector direction = new PVector(mouseX - width / 2, mouseY - height / 2);
  direction.normalize(); // Normalize to get unit vector
  direction.mult(5); // Multiply by the desired bullet speed (e.g., 5)

  // Create a new bullet from the center of the screen
  Bullet newBullet = new Bullet(width / 2, height / 2, direction);
  bullets.add(newBullet); // Add the bullet to the list
  //
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
}

void keyReleased() {
  // Stop movement in the corresponding direction when the key is released
  if (key == 'W' || key == 'w' || key == 'S' || key == 's') {
    velocity.y = 0;
  } else if (key == 'A' || key == 'a' || key == 'D' || key == 'd') {
    velocity.x = 0;
  }
}
