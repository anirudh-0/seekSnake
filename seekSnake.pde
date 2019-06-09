Follower head = new Follower(new PVector(50, 50));
Follower [] body = new Follower[15];
Food[] f = new Food[15];

void setup() {
  //size(600, 400);
  fullScreen();
  colorMode(HSB);
  noStroke();
  head.maxForce = 0.12;
  for (int i =0; i<body.length; i++) {
    body[i] = new Follower(head.pos);
    body[i].body = true;
    if (i==0) {
      body[i].size = head.size - 4;
      body[i].hue = (head.hue + 20)%255;
    } else {
      body[i].size = body[i-1].size -0.5;
      body[i].hue = (body[i-1].hue + 10)%255;
    }
  }

  for (int i =0; i<f.length; i++) {
    f[i] = new Food();
  }
}
void draw() {
  background(0);
  for (int i =0; i<f.length; i++) {
    f[i].show();
  }
  Food nearest = find();
  head.seek(nearest.pos);
  head.update();
  head.show();
  for (int i =0; i<body.length; i++) {
    if (i==0) {
      body[i].seek(head.pos);
      continue;
    }
    body[i].seek(body[i-1].pos);
  }
  for (int i =0; i<body.length; i++) {
    body[i].update();
    body[i].show();
  }
}

Food find() {
  Food a = f[0];
  float minD = head.pos.dist(a.pos);
  float d;
  
  for (int i =0; i<f.length; i++) {
    d = f[i].pos.dist(head.pos)-head.size;
    if(d<minD){
     minD=d;
     a = f[i];
    }
    if(d<=0){
     f[i] = new Food(); 
    }
  }
  return a;
}
