class Bullet {
  PVector position;  // Position of the bullet
  PVector velocity;  // Velocity of the bullet

  // Constructor
  Bullet(float startX, float startY, PVector velocity) {
    this.position = new PVector(startX, startY);
    this.velocity = velocity.copy();  // Copy the given velocity vector
  }

  // Update the bullet's position
  void update() {
    position.add(velocity);
  }

  // Display the bullet
  void display() {
    fill(255,255,51); // fire!
    noStroke();
    ellipse(position.x, position.y, 10, 3); // Draw bullet as a circle
  }
}
