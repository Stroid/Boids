//Boids - DEV

ArrayList<Agent> agents;
ArrayList<PVector> obstacles;

void setup() {
  size(1280, 720);
  stroke(#FFFFFF);
  strokeWeight(5);
  agents = new ArrayList();
  obstacles = new ArrayList();
  for (int i = 0; i<200; i++) {
    agents.add(new Agent(random(width), random(height)));
  }
  obstacles.add(new PVector(width/2, height/2));
}

void draw() {
  background(#002d40);
  for (int i = 0; i < agents.size(); i++) {
    agents.get(i).update();
    agents.get(i).display();
  }
  for (int i = 0; i < obstacles.size(); i++){
    PVector obstacle = obstacles.get(i);
    pushMatrix();
    translate(obstacle.x, obstacle.y);
    ellipse(0,0, 20, 20);
    popMatrix();
  }
  println(frameRate);
}
