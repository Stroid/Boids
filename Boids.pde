//Boids - DEV

ArrayList<Agent> agents;

void setup() {
  size(1280, 720);
  stroke(#FFFFFF);
  strokeWeight(5);
  agents = new ArrayList();

  for (int i = 0; i<200; i++) {
    agents.add(new Agent(random(width), random(height)));
  }
}

void draw() {
  background(#002d40);
  for (int i = 0; i < agents.size(); i++) {
    agents.get(i).update();
    agents.get(i).display();
  }
  println(frameRate);
}
