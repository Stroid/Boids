class Agent{
  PVector pos; //Agent possition vector
  PVector vel; //Agent velocity vector
  PVector acc; //Agent acceleration vector
  
  float accelerationLimit = 1;   // Max acceleration per tick
  float separationDistance = 60; // Radius at which boids avoid others
  float alignmentDistance = 80; // Radius at which boids align with others
  float choesionDistance = 180;  // Radius at which boids approach others
  float separationForce = 0.15;  // Speed to avoid at
  float alignmentForce = 0.25;   // Speed to align with other boids
  float choesionForce = 0.1;   // Speed to move towards other boids
  
  Agent(float x, float y){
    //Initialise the vectors
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();  
    
    //Initialise a starting force in a random direction
    PVector force = PVector.fromAngle(random(TWO_PI));
    force.setMag(2);
    this.addForce(force);
}

  void update(){
    //Update agent
    vel.add(acc);//Change the velocity
    pos.add(vel);//Move the agent
    acc.mult(0); //Reset the acceleration
    this.edges();
}
  
  void display(){
    //Draw agent
    pushMatrix();
    translate(pos.x, pos.y);
    point(0,0);
    popMatrix();
  }
  
  void stering_behavior(){
    for(int i = 0; i < agents.size(); i++){
      Agent other_agent = agents.get(i);
    }
  }
  
  void edges(){
    //If agent travels outside the window, wrap adround to the outher side.
    float x = pos.x;
    float y = pos.y;
    
    if(x < 0)
      x += width;
    else if(x > width)
      x -= width;
    
    if(y < 0)
      y += height;
    else if(y > height)
      y -= height;
    
    this.pos.set(x,y);
  }
  
  
  void addForce(PVector force){
    //Add a force to the acceleration vector
    this.acc.add(force);
  }
}
