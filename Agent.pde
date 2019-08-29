class Agent{
  PVector pos;
  PVector vel;
  PVector acc;
  
  ArrayList agents;
  
  Agent(float x, float y, ArrayList<Agent> agents){
    this.agents = agents;
    
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();  
    
    PVector force = PVector.fromAngle(random(TWO_PI));
    force.setMag(2);
    this.addForce(force);
}

  void update(){
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
    
    this.edges();
    
    for(int i = 0; i < agents.size(); i++){
      
    }
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    point(0,0);
    
    popMatrix();
  }
  
  void edges(){
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
    this.acc.add(force);
  }
}
