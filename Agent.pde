// To do list...
// *  Add obsticles

class Agent {
  PVector pos; //Agent possition vector
  PVector vel; //Agent velocity vector
  PVector acc; //Agent acceleration vector

  float accelerationLimit = 1;   // Max acceleration per tick
  float velocityLimit = 5;       // Max velocity per tick
  float separationDistance = 60; // Radius at which boids avoid others
  float alignmentDistance = 80;  // Radius at which boids align with others
  float obstacleDistance = 0;   // Radius at witch boids avoid obsticles
  float cohesionDistance = 60;  // Radius at which boids approach others
  float separationForce = 0.05;  // Speed to avoid at
  float alignmentForce = 0.15;   // Speed to align with other boids
  float cohesionForce = 0.05;   //0.1;   // Speed to move towards other boids
  float obstacleForce = 0;     // Speed to avoid obsticle
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
    PVector separation_force = new PVector();
    PVector alignment_force = new PVector();
    PVector cohesion_force = new PVector();
    PVector obstacle_force = new PVector();

    //Stering behavior for other boids
    for (int i = 0; i < agents.size(); i++) {
      Agent other_agent = agents.get(i);
      if (!other_agent.equals(this)) {
        //Seperation
        if (this.pos.dist(other_agent.pos) < this.separationDistance) {
          separation_force.add(this.pos);
          separation_force.sub(other_agent.pos);
        }
        //Alignment
        if (this.pos.dist(other_agent.pos) < this.alignmentDistance) {
          alignment_force.add(other_agent.vel);
        }
        //Cohesion
        if (this.pos.dist(other_agent.pos) < this.cohesionDistance) {
          cohesion_force.add(other_agent.pos);
          cohesion_force.sub(this.pos);
        }

        separation_force.limit(separationForce);
        addForce(separation_force);

        alignment_force.limit(alignmentForce);
        addForce(alignment_force);

        cohesion_force.limit(cohesionForce);
        addForce(cohesion_force);
      }
    }
    for (int i = 0; i < obstacles.size(); i++) {
      PVector obstacle = obstacles.get(i);
      if (this.pos.dist(obstacle) < this.obstacleDistance) {
        obstacle_force.add(this.pos);
        obstacle_force.sub(obstacle);
      }
    }
    obstacle_force.limit(obstacleForce);
    addForce(obstacle_force);
  }
  void edges() {
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
