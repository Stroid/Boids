//Boids

ArrayList<Agent> agents;

void setup() {
  size(630, 480);
  stroke(#FFFFFF);
  strokeWeight(5);
  agents = new ArrayList();

  for (int i = 0; i<5; i++) {
    agents.add(new Agent(random(width), random(height)));
  }
}

void draw() {
  background(#002d40);
  for (int i = 0; i < agents.size(); i++) {
    agents.get(i).update();
    agents.get(i).display();
  }
}
