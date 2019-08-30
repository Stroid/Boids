class Agent {
  PVector pos; //Agent possition vector
  PVector vel; //Agent velocity vector
  PVector acc; //Agent acceleration vector

  float accelerationLimit = 1;   // Max acceleration per tick
  float velocityLimit = 5; // Max velocity per tick
  float separationDistance = 20; // Radius at which boids avoid others
  float alignmentDistance = 80; // Radius at which boids align with others
  float cohesionDistance = 180;  // Radius at which boids approach others
  float separationForce = 0.10;  // Speed to avoid at
  float alignmentForce = 0.10;   // Speed to align with other boids
  float cohesionForce = 0.1;   // Speed to move towards other boids

  Agent(float x, float y) {
    //Initialise the vectors
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();  

    //Initialise a starting force in a random direction
    PVector force = PVector.fromAngle(random(TWO_PI));
    force.setMag(3);
    this.addForce(force);
  }

  void update() {
    //Update agent
    stering_behavior();
    acc.limit(accelerationLimit);

    vel.add(acc);//Change the velocity
    vel.limit(velocityLimit);
    pos.add(vel);//Move the agent
    acc.mult(0); //Reset the acceleration
    this.edges();
  }

  void display() {
    //Draw agent
    pushMatrix();
    translate(pos.x, pos.y);
    point(0, 0);
    popMatrix();
  }

  void stering_behavior() {
    ArrayList<PVector>separation_flock = new ArrayList();
    ArrayList<PVector>alignment_flock = new ArrayList();
    ArrayList<PVector>Cohesion_flock = new ArrayList();

    for (int i = 0; i < agents.size(); i++) {
      Agent other_agent = agents.get(i);
      if (this.pos.dist(other_agent.pos) < this.separationDistance) {
        separation_flock.add(other_agent.pos);
      }
      if (this.pos.dist(other_agent.pos) < this.alignmentDistance) {
        alignment_flock.add(other_agent.vel);
      }
      if (this.pos.dist(other_agent.pos) < this.cohesionDistance) {
        Cohesion_flock.add(other_agent.pos);
      }
    }

    //Seperation
    PVector separation_force = new PVector();
    for (int i = 0; i < separation_flock.size(); i++) {
      separation_force.add(this.pos);
      separation_force.sub(separation_flock.get(i));
    }
    separation_force.limit(separationForce);
    addForce(separation_force);

    //Alignment
    PVector alignment_force = new PVector();
    for (int i = 0; i < alignment_flock.size(); i++) {
      alignment_force.add(alignment_flock.get(i));
    }
    alignment_force.limit(alignmentForce);
    addForce(alignment_force);
    
    //Cohesion
    PVector cohesion_force = new PVector();
    for (int i = 0; i < Cohesion_flock.size(); i++) {
      cohesion_force.add(Cohesion_flock.get(i));
      cohesion_force.sub(this.pos);
    }
    cohesion_force.limit(cohesionForce);
    addForce(cohesion_force);
  }

  void edges() {
>>>>>>> dev
    //If agent travels outside the window, wrap adround to the outher side.
    float x = pos.x; 
    float y = pos.y; 

    if (x < 0)
      x += width; 
    else if (x > width)
      x -= width; 

    if (y < 0)
      y += height; 
    else if (y > height)
      y -= height; 

    this.pos.set(x, y);
  }


  void addForce(PVector force) {
    //Add a force to the acceleration vector
    this.acc.add(force);
  }
}
