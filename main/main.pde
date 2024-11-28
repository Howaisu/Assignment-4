//hello world
//UPADTE with a better joints
ArrayList<Leg> legs;  // ArrayList to "hold" multiple legs, really important, PVector only able to set once
color headColor = color(59, 41, 23);
color bodyColor = color(37, 15, 10);
//leg controller
boolean toggleGroup = true;  // set up as true
int frameInterval = 15;  // length of time: 1s

void setup() {
  size(400, 400);
  legs = new ArrayList<Leg>();  // Initialize the ArrayList

  // Add right legs
  legs.add(new Leg(360, 40, 220, 160)); // 1st right leg
  legs.add(new Leg(400, 100, 220, 180)); // 2nd right leg
  legs.add(new Leg(380, 310, 220, 200)); // 3rd right leg
  legs.add(new Leg(360, 400, 220, 220)); // 4th right leg

  // Add left legs

  legs.add(new Leg(60, 400, 180, 220)); // 4th left leg
   legs.add(new Leg(40, 40, 180, 160)); // 1st left leg
    legs.add(new Leg(0, 100, 180, 180)); // 2nd left leg
     legs.add(new Leg(40, 310, 180, 200)); // 3rd left leg
}

void draw() {
  background(255);  // Refresh background
 // Draw all legs
 for (Leg leg : legs) {
  //  leg.update();
    leg.display();
  }
  //super difficult organical legs
   // Switch, in a span of time
  if (frameCount % frameInterval == 0) {
    toggleGroup = !toggleGroup;  //switching 
  }

  // Using a switch two seperate leg movements
  if (toggleGroup) {
    // first move
    for (int i = 0; i < legs.size(); i++) {
      if (i % 2 == 0) {  
        Leg leg = legs.get(i);
        leg.update();
      
      }
    }
  } else {
    //second move
    for (int i = 0; i < legs.size(); i++) {
      if (i % 2 != 0) {  
        Leg leg = legs.get(i);
        leg.update();
      }
      
    }
  }
  // Draw body
  noStroke();
  fill(bodyColor);
  ellipse(200, 280, 160+(frameCount%width)/40, 200+(frameCount%width)/40);  // body

  // Draw center
  fill(255, 0, 0);
  ellipse(200, 180, 20, 20);

  // Draw head
  fill(headColor);
  ellipse(200, 140, 100, 80);  // head

 
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
    velocity = new PVector(0, 8); // Initial velocity for vertical movement
    knee = new PVector(); // Initialize the knee vector
  }

  void update() {
    position.add(velocity);
    
    // Reverse velocity if leg goes beyond certain vertical bounds
    if (position.y <= startY - 10 || position.y >= startY + 230) {
      velocity.y = -velocity.y;
    }
    // Constrain the leg's movement to prevent it from going too far
    position.y = constrain(position.y, startY - 10, startY + 230);
  }

  void display() {
    stroke(0);
    strokeWeight(4);
    float centerX = (position.x + end.x) / 2;  // 
    float centerY = (position.y + end.y) / 2 - 30; // The Knee is adjusted vertically to create a bend
    float range = 10;  //


    // UPDATE: Reversed the joint for a better and natural feeling
   // 
   // using sin coop with framecount to make a steady shifting
    knee.x = map(sin(frameCount * 0.05), -1, 1, centerX - range, centerX + range);
   // knee.y = (position.y + end.y) / 2 - 30; // The Knee is adjusted vertically to create a bend
     knee.y = map(sin(frameCount * 0.05), -1, 1, centerY - range, centerY + range); // The Knee is adjusted vertically to create a bend
    // Draw lines for legs (from foot to knee, and from knee to end(center))
    line(position.x, position.y, knee.x, knee.y);
    line(knee.x, knee.y, end.x, end.y);

    // Draw foot and knee as circles for better visualization
    fill(0);
    ellipse(position.x, position.y, 5, 5); // Foot
    ellipse(knee.x, knee.y, 5, 5); // Knee
  }
}
