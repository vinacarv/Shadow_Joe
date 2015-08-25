PImage playerIdleL;  
PImage playerIdleR;
PImage playerJumpL;
PImage playerJumpR;
PImage playerRunL;
PImage playerRunR;

class ShadowMan {

  //CLASS VARIABLES
  float x = 0;
  float y = 0;
  float xSpeed = 0;
  float ySpeed = 0;
  float xSize = 35;
  float ySize = 35;
  float gravity = 1;
  float acceleration = 4;
  int jumpCount = 0;
  boolean grounded = false;
  boolean keyUp = false;
  boolean keyDown = false;
  boolean keyLeft = false;
  boolean keyRight = false;
  boolean right = true;
  int HP = 100;
  int[] bbx = new int[36];
  int[] bby = new int[36];

  //CONSTRUCTOR
  ShadowMan (float x_, float y_) {
    x = x_;
    y = y_;
  }

  //FUNCTIONS
  void run() {
    display();
    move();
    roomCollision();
   // projCollision();
    jumps();
    controller();
    displayHP();
  }

  //Draws the object
  void display() {
    //ellipse (x,y,xSize,ySize);
    playerIdleL = loadImage("playeridlel.png"); 
    playerIdleR = loadImage("playeridler.png");
    playerJumpL = loadImage("playerjumpl.png");
    playerJumpR = loadImage("playerjumpr.png");
    playerRunL = loadImage("playerrunl.png");
    playerRunR = loadImage("playerrunr.png");
    //determine direction
    if (xSpeed > 0.01) right = true;
    if (xSpeed < 0.01) right = false;
    //show images
    if (right == true && grounded == true && xSpeed <5) {
      image(playerIdleR, x, y - ySize/2);
    }
    if (right == false && grounded == true && xSpeed >-5) {
      image(playerIdleL, x, y - ySize/2);
    }
    if (right == true && grounded == false) {
      image(playerJumpR, x, y - ySize/2);
    }
    if (right == false && grounded == false) {
      image(playerJumpL, x, y - ySize/2);
    }
    if (right == true && grounded == true & xSpeed > .5) {
      image(playerRunR, x, y - ySize/2);
    }
    if (right == false && grounded == true && xSpeed <-.5) {
      image(playerRunL, x, y - ySize/2);
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
    if (ySpeed <-15) {
      ySpeed = -15;
    }
    if (xSpeed >10) {
      xSpeed = 10;
    }
    if (xSpeed <-10) {
      xSpeed = -10;
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
    if (y + ySize/2 >= height-10 && ySpeed > 0) {
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

  void projCollision() {
    if (projs.size() >= 1) {
      for (int i = 0; i <= xSize; i++) {
        bbx[i] = int(x) - int(xSize/2) + i;
        bby[i] = int(y) - int(ySize/2) + i;
        for (int j = projs.size() - 1; j >= 0; j--) {
          Projectile p = projs.get(j);
          if (p.x == bbx[i] && p.y == bby[i]) {
            HP -= p.damage;
            println("DAMAGE");
          }
        }
      }
    }
  }

  //Checks and returns if the object is grounded.
  void jumps() {
    if (grounded == true) jumpCount = 2;
    if (jumpCount < 0) jumpCount = 0;
    if (jumpCount > 10) jumpCount = 2;
  }

  //allows keyboard input
  void controller() {
    //PRESSED
    //if (keyUp == true && jumpCount > 0){
    //ySpeed = -20;
    //}
    //Move Left or Right
    if (keyLeft == true) xSpeed -= acceleration;
    if (keyRight == true) xSpeed += acceleration;

    //released
    if (keyLeft == false && keyRight == false) {
      /*if (xSpeed < -5){
       xSpeed += acceleration*3;
       
       }
       else if (xSpeed > 5){
       xSpeed -= acceleration*3;
       } */
      //else 
      xSpeed = xSpeed%2;
    }
  }

  void displayHP() {
    textSize(20);
    fill(255);
    text("hp = " + HP, 10, 30);
  }
}

