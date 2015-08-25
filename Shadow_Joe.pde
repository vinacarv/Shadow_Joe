ShadowMan joe;
Enemy enemy;

/*PImage playerIdleL;  
 PImage playerIdleR;
 PImage playerJumpL;
 PImage playerJumpR;
 PImage playerRunL;
 PImage playerRunR;
 */
int bgchange = 2;
int R = 20;
int G = 200;
int B = 180;
int i = 0;

ArrayList<Projectile> projs;

/*
final static PVector playerPos = new PVector(); 
 final static PVector playerSpd = new PVector();
 final static PVector bulletSpd = new PVector();
 
 final static byte  playerVel  = 3, bulletVel = 5, fps = 60;
 final static byte  playerSize = 20, holeSize = playerSize>>1;
 final static byte  aimSize = 5, bulletSize = 4, bulletGap = 3;
 
 final static color aimColor = 0, bg = 255;
 final static color playerColor = #FF0000, bulletColor = #0000FF
 */

void setup() {
  size (800, 600);
  smooth();
  imageMode(CENTER);
  frameRate(60);
  joe = new ShadowMan (width/2, -50);
  enemy = new Enemy (200, 200);
  projs = new ArrayList<Projectile>();
}


void draw() {
  //BG GETS A RATE-OF-CHANGE (bgchange) EVERY 250 FRAMES
  //AND A RANDOM VALUE TO R, G AND B
  /*if (frameCount%250 == 1) {
   int bgchange = int(random(5));
   R = int(random(120));
   G = int(random(120));
   B = int(random(120));
   }
   
   //THE RATE-OF-CHANGE IS APPLIED TO R, G AND B EVERY FRAME
   R = R+bgchange;
   G = G+bgchange;
   B = B+bgchange;*/

  //THE BG CHANGES TO THE NEW, BRIGHTER COLOR EVERY FRAME
  //background(R, G, B, 128);
  background(#94AABF);
  fill(50, 255, 90);
  noStroke();  
  rect(0, height-10, width, height);
  //CALL FUNCTIONALITY
  joe.run();
  enemy.run();
  //ellipse(joe.x, joe.y, 20, 20);

  for (int i = projs.size() -1; i >= 0; i--) {
    Projectile p = projs.get(i);
    p.run();    
    //    for (int h = 0; h <= joe.xSize; h++) {
    //      joe.bbx[h] = int(joe.x) - int(joe.xSize/2) + h;
    //      joe.bby[h] = int(joe.y) - int(joe.ySize/2) + h;
    //      //for (int j = projs.size() - 1; j >= 0; j--) {
    //      //Projectile p = projs.get(j);
    //      if (p.x == joe.bbx[h] && p.y == joe.bby[h]) {
    //        joe.HP -= p.damage;
    //        println("DAMAGE");
    //     }
    if (p.outBounds == true) {
      projs.remove(i);
    }
    if (sqrt(pow(p.x-joe.x, 2) + pow(p.y-joe.y, 2)) <= 20) {
      fill(255, 0, 0);
      joe.HP -= 5;
    }
  }


  //if(frameCount % 15 == 0){
  //myProjs[i] = new Projectile(120, 120, enemy.dirX, enemy.dirY);
  // i++;

  //projAttack(enemy.dirX, enemy.dirY);

  //  println("grounded = " + joe.grounded);
  //    println("xSpeed = " + joe.xSpeed);
  //    println("ySpeed = " + joe.ySpeed);
  println("keyUp= " + joe.keyUp);
  println("keyLeft = " + joe.keyLeft);
  println("keyRight  = " + joe.keyRight);
  //    println("jumpCount = " + joe.jumpCount);
  //    println("y = " + joe.y);
  //    println(frameRate);
  println(projs.size());
  println(enemy.projAttacking);
  //  println(

  textSize(20);
  fill(255);
  text(frameRate, 10, 60);
} //CLOSES DRAW ===================================


void keyPressed() {
  if (keyPressed) {
    if (key == 'w' && joe.jumpCount > 0) {
      joe.ySpeed = -35;
      joe.jumpCount -= 1;
      joe.keyUp = true;
    }
    if (key =='s')joe.keyDown = true;
    if (key =='a')joe.keyLeft = true;
    if (key =='d')joe.keyRight = true;
  }
}

void keyReleased() {
  if (!keyPressed) {
    if (key =='w')joe.keyUp = false;  
    if (key =='s')joe.keyDown = false;
    if (key =='a')joe.keyLeft = false;
    if (key =='d')joe.keyRight = false;
  }
}



/*void mousePressed() {
 projs.add (new Projectile (enemy.x, enemy.y, enemy.dirX, enemy.dirY, 45));
 }
 */

//Inside bounding box (bb)? true if yes. Use for hit calc and 
//interference calc
//void inBB(obj){
//obj = obj_;
// if (x + (xSize/2) or  obj.xSize

