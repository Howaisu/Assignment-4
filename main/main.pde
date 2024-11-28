//hello world
//A very ugly spider appears!
ArrayList<Leg> legs;  // ArrayList to "hold" multiple legs, really important, PVector only able to set once
color headColor = color(59, 41, 23);
color bodyColor = color(37, 15, 10);
void setup(){
  size(400, 400);
  legs = new ArrayList<Leg>();  // Initialize the ArrayList
  legs.add(new Leg(360, 40, 220, 160)); // 1 right leg
  legs.add(new Leg(400, 100, 220, 180)); // 2 right leg
  legs.add(new Leg(380, 340, 220, 200)); // 3 right leg
  legs.add(new Leg(360, 400, 220, 220)); // 4 right leg
  //left
  legs.add(new Leg(40,40, 180, 160)); // 1 right leg
  legs.add(new Leg(0, 100, 180, 180)); // 2 right leg
  legs.add(new Leg(40, 340, 180, 200)); // 3 right leg
  legs.add(new Leg(60, 400, 180, 220)); // 4 right leg


}

void draw(){
background(255);  // Refreshhhh

  // Draw body
  noStroke();
  fill(bodyColor);
  ellipse(200, 280, 160, 200);  // body
  //center
  fill(255,0,0);
  ellipse(200,180,20,20);
  // Draw head
  fill(headColor);
  ellipse(200, 140, 100, 80);  // head

  // Draw all legs
  for (Leg leg : legs) {
    leg.update();
    leg.display();

  }
}
//
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
    velocity = new PVector(0, 2); // Initial velocity
    knee = new PVector(); // Initialize the knee vector
  }

  void update() {
    position.add(velocity);
    if (position.y <= startY - 10 || position.y >= startY + 100) {
      velocity.y = -velocity.y;
    }
    position.y = constrain(position.y, startY - 10, startY + 100);
  }

  void display() {
    stroke(0);
    strokeWeight(4);
    // Knee calculation
    knee.x = position.x + (position.x < end.x ? 40 : -40); // Set knee x based on position
    knee.y = position.y + (position.y < end.y+45 ? 80 : -80); // Knee y calculation

    // Draw lines for legs
    line(position.x, position.y, knee.x, knee.y);
    line(knee.x, knee.y, end.x, end.y);

    // Draw foot
    fill(0);
    ellipse(position.x, position.y, 5, 5);
    ellipse(knee.x, knee.y, 5, 5); // Joint of knee
  }
}
