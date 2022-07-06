ArrayList<FishClass> school = new ArrayList<FishClass>();
float searchRadius = 100;
float seperationPow = 500;

void setup() {
  size(600, 600);
  for (int i = 0; i < 20; i++) {
    school.add(new FishClass(seperationPow));
  }
}

void draw() {
  background(150);
  
  for (int i = 0; i < school.size(); i++) {
    FishClass fish = school.get(i);
    // changing the color of the initial fish BOOMERANG
    if (i == 0) {
      fill(255,255,255,100);
      circle(fish.x, fish.y, searchRadius*2);
    } 
    
    ArrayList<FishClass> nearbyFishes = new ArrayList<FishClass>();
    for (int j = 0; j < school.size(); j++) {
      if (i != j) { //  don't need to check same fish and only need to check near fish
        FishClass otherFish = school.get(j);
        // BOOMERANG will remove i == 0 after testing is done.
         if (i == 0 && getDistance(fish, otherFish) < searchRadius) {
           nearbyFishes.add(otherFish);
         } 
      }
    }
    
    // Steering Fish!
    if (nearbyFishes.size() > 0) {
      fish.seperation(nearbyFishes);
    }
    
    fish.update();
    fish.show();
  }
  
}

float getDistance(FishClass fish1, FishClass fish2) {
  float deltaX = fish2.x - fish1.x;
  float deltaY = fish2.y - fish1.y;
  
  return (sqrt(deltaX*deltaX + deltaY*deltaY));
}

float getAngle(FishClass fish1, FishClass fish2) {
  float deltaX = fish2.x - fish1.x;
  float deltaY = fish2.y - fish1.y;
  float theta = atan(deltaY/deltaX);
  if (fish1.x < fish2.x) {
    theta += PI;
  }
  return theta;
}


class FishClass {
  float x;
  float y;
  float velocity;
  float theta;
  float deltaTheta;
  float len;
  color fishColor;
  float thetaAcc;
  // Boid Control Parameters
  float seperationPower;
  FishClass(float sepPow) {
    x = random(width);
    y = random(height);
    velocity = 3.0;
    theta = random(2*PI);
    len = 15;
    deltaTheta = 0.1;
    seperationPower = sepPow;
    fishColor = color(150, 100, 255);
    thetaAcc = 0;
  }
  
  void update() {
    x += velocity * cos(theta);
    y += velocity * sin(theta);
    
    if (x > width) {
      x = 0;
    } else if (x < 0) {
      x = width;
    }
    
    if (y > height) {
      y = 0;
    } else if (y < 0) {
      y = height;
    }
  }
  
  void show() {
    fill(fishColor);
    
    triangle(x + 2*len*cos(theta), y + 2*len*sin(theta),
    x + len*cos(theta+2*PI/3), y + len*sin(theta+2*PI/3),
    x + len*cos(theta+4*PI/3), y + len*sin(theta+4*PI/3));
  }
  
  void seperation(ArrayList<FishClass> localFishes) {
    
  }
  
  void alignment(ArrayList<FishClass> localFishes) {
    
  }
  
  void cohesion(ArrayList<FishClass> localFishes) {
    
  }
  
}
