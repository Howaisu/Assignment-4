int backforce;
boolean fire;
int x,y;

void setup() {
  size(400, 400);
}

void draw() {
  background(255); // Refresh
  
  // Calculate the angle between the character's position and the mouse
  float angle = atan2(mouseY - height / 2, mouseX - width / 2); // rotate function
  //rotate from here
  pushMatrix();
  translate(width / 2, height / 2); // Move origin to character's center
  rotate(angle + PI / 2); // Rotate to face the mouse, adjusted by PI/2 for original downward direction

  // Draw the character
  println("Debug: The fire == "+fire);//debug
  
  //fire
  if(fire == true){
    stroke(255,0,0,30);
    fill(255,255,0,50);
    ellipse(+30+random(3), -105 - random(8),22+frameCount%8,22+frameCount%8);  
    ellipse(+30+random(3), -105 + random(8),22+frameCount%8,22+frameCount%8);  
    noStroke();
    fill(255,12,12,15);
    ellipse(+30+random(3), -95 + random(8),32+frameCount%8,32+frameCount%8);  
    backforce();
  }
  else
  {
  
  }
  stroke(0);
  
  // Hand
  fill(255, 229, 204);
  rect(+20, -70, 20, 20);

  // Body
  fill(255, 0, 0);
  rect(-40, -10, 80, 30);
  rect(+20, -50, 20, 40);//arm

  // Gun
  fill(0);
  rect(+25, -102+backforce, 10, 45);

  stroke(255, 0, 0);
 // line(+25, +52, mouseX - width / 2, mouseY - height / 2);

  // Head
  stroke(0);
  fill(0);
  ellipse(0, 0, 60, 60);

  popMatrix();

  noFill();
  ellipse(width / 2, height / 2, 350, 350); // Circle around character, just useless
  

}

  void mousePressed(){
   fire = true;
  }
  
  void backforce(){
    //backforce animation
   if (fire && backforce < 18) {
    backforce += 3;
    
    } 
    if (!fire && backforce > 18) {
    backforce --;
    }
    
   if (backforce >= 18) {
   fire = false;
   backforce = 0;
  } else {
   
  }
  
}
