// Spawn 10 enemies in the main program
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PVector velocity = new PVector(0, 0); // To store the map velocity
PVector translation = new PVector(0, 0); // Translation of the map
int backforce;
boolean fire;
Map myMap;

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
  //
  float angle = atan2(mouseY - height / 2, mouseX - width / 2);


  //
  pushMatrix();
  
  translate(width / 2, height / 2); 
  rotate(angle + PI / 2);  
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
 
  fill(255, 229, 204);
  rect(+20, -70, 20, 20);

 

  fill(255, 0, 0);
  rect(-40, -10, 80, 30);
  rect(+20, -50, 20, 40); 


  fill(0);
  rect(+25, -102 + backforce, 10, 45);


  stroke(0);
  fill(0);
  ellipse(0, 0, 60, 60);

  popMatrix();

  noFill();
  ellipse(width / 2, height / 2, 350, 350); 
}


void mousePressed() {
  fire = true; // 当鼠标按下时，开火
}

void backforce() {
  if (fire && backforce < 18) {
    backforce += 3;
  } 
  if (!fire && backforce > 18) {
    backforce--;
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
