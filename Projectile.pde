class Projectile {

  float x = 0;
  float y = 0;
  float xSize = 10;
  float ySize = 40;
  float dirXP = 0;
  float dirYP = 0;
  float speed = 0;
  boolean outBounds = false;
  int damage = 5;

  Projectile (float x_, float y_, float dirXP_, float dirYP_, float speedFinal_) {
    x = x_;
    y = y_;
    speed = sqrt(pow(dirXP_, 2) + pow(dirYP_, 2));
    dirXP = dirXP_ * speedFinal_/speed;
    dirYP = dirYP_ * speedFinal_/speed;
  }

  //FUNCTIONS
  void run() {
    display();
    move();
    die();
    //projCollision();
    //hit();
  }


  void display() {
    if (frameCount % 2 == 0) {
      fill(255, 255, 0);
    }
    else {
      fill(255, 30, 0);
    }
    //rectMode(CENTER);
    //ellipse(x, y, 100, 100);
    //fill(128);
    //ellipse(x, y, 95, 95);
    rect(x, y, xSize, ySize);
  }

  void move() {
    x = x + dirXP;
    y = y + dirYP;
  }

  void die() {
    if (x < 0 || x> width || y < 0 || y > height-10) {
      outBounds = true;
    }
  }

 void projCollision() {
    if (projs.size() >= 1) {
      for (int i = 0; i <= xSize; i++) {
        joe.bbx[i] = int(joe.x) - int(joe.xSize/2) + i;
        joe.bby[i] = int(joe.y) - int(joe.ySize/2) + i;
        for (int j = projs.size() - 1; j >= 0; j--) {
          Projectile p = projs.get(j);
          if (p.x == joe.bbx[i] && p.y == joe.bby[i]) {
            joe.HP -= p.damage;
            println("DAMAGE");
          }
        }
      }
    }
  }

  /*void hit() {
   for (float i = -10; i >= 10; i++) {
   if (x+i == joe.x && y+i == joe.y) {
   joe.HP -= 5;
   }
   }
   }*/
}

