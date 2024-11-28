//hello world
//UPADTE with a better joints
ArrayList<Leg> legs;  // ArrayList to "hold" multiple legs, really important, PVector only able to set once
color headColor = color(59, 41, 23);
color bodyColor = color(37, 15, 10);

void setup() {
  size(400, 400);
  legs = new ArrayList<Leg>();  // Initialize the ArrayList

  // Add right legs
  legs.add(new Leg(360, 40, 220, 160)); // 1st right leg
  legs.add(new Leg(400, 100, 220, 180)); // 2nd right leg
  legs.add(new Leg(380, 340, 220, 200)); // 3rd right leg
  legs.add(new Leg(360, 400, 220, 220)); // 4th right leg

  // Add left legs
  legs.add(new Leg(40, 40, 180, 160)); // 1st left leg
  legs.add(new Leg(0, 100, 180, 180)); // 2nd left leg
  legs.add(new Leg(40, 340, 180, 200)); // 3rd left leg
  legs.add(new Leg(60, 400, 180, 220)); // 4th left leg
}

void draw() {
  background(255);  // Refresh background

  // Draw body
  noStroke();
  fill(bodyColor);
  ellipse(200, 280, 160, 200);  // body

  // Draw center
  fill(255, 0, 0);
  ellipse(200, 180, 20, 20);

  // Draw head
  fill(headColor);
  ellipse(200, 140, 100, 80);  // head

  // Draw all legs
  for (Leg leg : legs) {
    leg.update();
    leg.display();
  }
}

class Leg {
  PVector position;  
  PVector velocity;
  PVector end;
  PVector knee;
  int startY;

  Leg(int footx, int footy, int endx, int endy) {
    startY = footy;
    position = new PVector(footx, footy);
    end = new PVector(endx, endy);
    velocity = new PVector(0, 2); // Initial velocity for vertical movement
    knee = new PVector(); // Initialize the knee vector
  }

  void update() {
    position.add(velocity);
    
    // Reverse velocity if leg goes beyond certain vertical bounds
    if (position.y <= startY - 10 || position.y >= startY + 100) {
      velocity.y = -velocity.y;
    }
    // Constrain the leg's movement to prevent it from going too far
    position.y = constrain(position.y, startY - 10, startY + 100);
  }

  void display() {
    stroke(0);
    strokeWeight(4);

    // UPDATE: Reversed the joint for a better and natural feeling
    knee.x = (position.x + end.x) / 2;  // Knee is halfway between foot and end horizontally
    knee.y = (position.y + end.y) / 2 - 30; // The Knee is adjusted vertically to create a bend

    // Draw lines for legs (from foot to knee, and from knee to end(center))
    line(position.x, position.y, knee.x, knee.y);
    line(knee.x, knee.y, end.x, end.y);

    // Draw foot and knee as circles for better visualization
    fill(0);
    ellipse(position.x, position.y, 5, 5); // Foot
    ellipse(knee.x, knee.y, 5, 5); // Knee
  }
}
