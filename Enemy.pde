PImage enemyIdleL;
PImage enemyIdleR;
PImage enemyJumpL;
PImage enemyJumpR;
PImage enemyRunL;
PImage enemyRunR;


class Enemy {

  float x = 0;
  float y = 0;
  float xSpeed = 0;
  float ySpeed = 0;
  float xSize = 35;
  float ySize = 35;
  float gravity = 1;
  float acceleration = .4;
  int jumpCount = 0;
  boolean right = true;
  boolean grounded = false;
  boolean airAttacking = false;
  boolean projAttacking = false;
  boolean groundAttacking = false;  
  float dirX = 0;
  float dirY = 0;
  


  //CONSTRUCTOR
  Enemy (float x_, float y_) {
    x = x_;
    y = y_;
  }

  //FUNCTIONS
  void run() {
    display();
    move();
    roomCollision();
    jumps();
    track();
    attack();
    projAttack();
  }

  //Draws the object
  void display() {
    ellipse (x,y,xSize,ySize);
    enemyIdleL = loadImage("playeridlel.png"); 
    enemyIdleR = loadImage("playeridler.png");
    enemyJumpL = loadImage("playerjumpl.png");
    enemyJumpR = loadImage("playerjumpr.png");
    enemyRunL = loadImage("playerrunl.png");
    enemyRunR = loadImage("playerrunr.png");
    //determine direction
    //if (xSpeed > 0.01) right = true;
    if (xSpeed < 0.01) right = false;
    //show images
    if (right == true && grounded == true && xSpeed <.5) {
      image(enemyIdleR, x, y - ySize/2);
    }
    if (right == false && grounded == true && xSpeed >-.5) {
      image(enemyIdleL, x, y - ySize/2);
    }
    if (right == true && grounded == false) {
      image(enemyJumpR, x, y - ySize/2);
    }
    if (right == false && grounded == false) {
      image(enemyJumpL, x, y - ySize/2);
    }
    if (right == true && grounded == true & xSpeed > .5) {
      image(enemyRunR, x, y - ySize/2);
    }
    if (right == false && grounded == true && xSpeed <-.5) {
      image(enemyRunL, x, y - ySize/2);
    }
  }

  //CAUSES OBJECTS TO MOVE
  void move() {
    x += xSpeed;
    y += ySpeed;
    ySpeed = ySpeed+gravity;
    //MAX SPEEDS
    if (ySpeed > 15) {//if speed is greater than...
      ySpeed = 15; //...Then keep ySpeed from being more than...
    }
    if (ySpeed <-12) {
      ySpeed = -12;
    }
    if (xSpeed >12) {
      xSpeed = 12;
    }
    if (xSpeed <-12) {
      xSpeed = -12;
    }
  }

  //Causes object to collide with the edges of the screen
  void roomCollision() {
    if (x + xSize/2 > width && xSpeed > 0) {
      x = width - xSize/2;
    }
    if (x - xSize/2 < 0 && xSpeed < 0) {
      x = xSize/2;
    }  
    //height-10 is bottom of screen minus grass bar (10px high)
    if (y + ySize/2 > height-10 && ySpeed > 0) {
      y = height - ySize/2;
      grounded = true;
    }  
    if (y + ySize/2 < height) {
      grounded = false;
    }  
    if (y - ySize/2 < 0) {
      y = 0 + ySize/2;
    }
  }

  //Checks and returns if the object is grounded.
  void jumps() {
    if (grounded == true) jumpCount = 2;
    if (jumpCount < 0) jumpCount = 0;
    if (jumpCount > 2) jumpCount = 2;
    //jumps with joe   
    if (dirY < 0 && millis() % 10 == 0) {
      ySpeed = -12;
      jumpCount -= 1;
      //airAttack();
      //projAttack();
    } 
    if (dirX > 3) {
    }
  }

  void attack() {
    if ((dirX > 0 && dirX <= 10) || (dirX < 0 && dirX >= -10)) {
      if (grounded == true ) {
        xSpeed = 0;
        fill (255, 255, 0);
        noStroke();
        //rectMode(CENTER);
        textSize(20);
        text("!!!", x, y - ySize - 5); 
        rect(x - xSize/2, y - ySize/2, 20, 20);
        boolean groundAttacking = true;
      }
      else {
        boolean groundAttacking = false;
      }
    }
  }

    void airAttack() {
      if (grounded == false) {
        stroke (255, 255, 0);
        //rectMode(CENTER);
        strokeWeight(24);
        line(x, y, joe.x, joe.y);
      }
      else {
        boolean airAttacking = false;
      }
    }

    void projAttack() {
      if (millis() % 20 == 0) {
        projs.add (new Projectile (x, y - xSize/2, enemy.dirX, enemy.dirY, 30));
        boolean projAttacking = true;
      }
      else {
        boolean projAttacking = false;
      }
    }

    //Tracks the player position
    void track() {
      dirX = joe.x - x;
      dirY = joe.y - y;
      if (dirX < 0) {
        xSpeed -= acceleration; 
        right = false;
      } 
      if (dirX > 0) {
        xSpeed += acceleration; 
        right = true;
      }
      if ((dirX > 0 && dirX <= 10) || (dirX < 0 && dirX >= -10)) {
        xSpeed = 0;
      }
    } 




    /*released
     if (keyLeft == false && keyRight == false) {
     if (xSpeed < -5) xSpeed += acceleration*3;
     else if (xSpeed > 5) xSpeed -= acceleration*3;
     else xSpeed = 0;
     }*/
  }


