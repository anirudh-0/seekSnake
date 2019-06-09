class Follower {
  PVector pos, vel, acc;
  float maxSpeed = 4;
  float maxForce = 1.2;
  float size = random(14, 18);
  float hue = random(255);
  boolean body = false;
  Follower(PVector a) {
    pos = a.copy();
    vel = new PVector();
    acc = new PVector();
  }
  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void seek(PVector a) {
    PVector target = a.copy();
    if (body) {
      PVector dir = PVector.sub(pos,target).normalize();
      dir.setMag(30);
      target.add(dir);
    }
    PVector desired = PVector.sub(target, pos);
    //desired.normalize();
    //desired.mult(maxSpeed);
    desired.limit(maxSpeed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void show() {
    fill(hue, 255, 255);
    ellipse(pos.x, pos.y, 2*size, 2*size);
  }
}
