class Bullet {
  PVector position;  // Position of the bullet
  PVector velocity;  // Velocity of the bullet
  int spawnTime;     // Time when the bullet was created (in milliseconds)
  boolean visible;   // Visibility of the bullet

  // Constructor
  Bullet(float startX, float startY, PVector initialVelocity) {
    position = new PVector(startX, startY);
    velocity = initialVelocity.copy();  // Copy the given velocity vector
    spawnTime = millis();  // Record the time when the bullet was created, this is a trick for make the bullet showing not in center haha
    visible = false;       // Initially, bullet is not visible
  }

  // Update the bullet's position
  void update() {
    // Make the bullet visible after 200 milliseconds
    if (millis() - spawnTime > 200) {
      visible = true; //Then it will have a distance from the body, and it CANNOT be too long, or it will feel lag
    }

    
      position.add(velocity);
    
  }

  // Display the bullet
  void display() {
    // Display the bullet only if it is visible
  
     noStroke();
    if (visible) {
      fill(255, 255, 51); // fire!
    }
    else
    {
      noFill();
    }
      
      ellipse(position.x, position.y, 5, 3); // Draw bullet as an ellipse
    
  }
}
