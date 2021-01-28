//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
int x;
int y;

// Add a constructor with parameters to initialize each variable.
 Segment(int x, int y){
 this.x = x;
 this.y = y;
 }


}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment head;
int foodX;
int foodY;
int direction;
int foodeat;
ArrayList<Segment> tail = new ArrayList<Segment>();
//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
size(500,500);
head = new Segment(250,250);
dropFood();
direction = UP;
foodeat = 0;
frameRate(10);
}

void dropFood() {
  //Set the food in a new random location
    foodX = ((int)random(50)*10);
    foodY = ((int)random(50)*10);
    
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(#000000);
  drawFood();
  move();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  fill(200,0,0);
  rect(foodX, foodY, 10, 10);
}

void drawSnake() {
 //Draw the head of the snake followed by its tail) 
 fill(#2EF507);
rect(head.x, head.y, 10 ,10);
 manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
for (int i = 0; i < tail.size(); i++) {
      Segment s = tail.get(i);
      fill(#2EF507);
      rect(s.x,s.y, 10,10);
    }
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
    checkTailCollision();
  drawTail();
  Segment s = new Segment(head.x, head.y);
  tail.add(s);
  tail.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for (int i = 0; i < tail.size(); i++) {
    Segment s = tail.get(i);
  if(head.x == s.x && head.y == s.y){
   foodeat = 1;
   tail.clear();
   Segment s2 = new Segment(head.x, head.y);
   tail.add(s2);
  
  }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake  
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if (key == CODED) {
    if (keyCode == UP && direction != DOWN) {
      direction = UP; 
      
      
    } else if (keyCode == DOWN && direction != UP) {
      direction = DOWN;
    } 
    else if (keyCode == LEFT && direction != RIGHT){
    direction = LEFT;
    }
     else if (keyCode == RIGHT && direction != LEFT){
    direction = RIGHT;
    }
  }
}


void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
    
  switch(direction) {
  case UP:
  head.y -= 10;
    break;
  case DOWN:
   head.y += 10;
    break;
  case LEFT:
   head.x -= 10;
    break;
  case RIGHT:
    head.x += 10;
    break;
  }
  checkBoundaries();
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
   switch(direction) {
  case UP:
  if(head.y == -10){head.y = 500;}
    break;
  case DOWN:
 if(head.y == 510){head.y = 0;}
    break;
  case LEFT:
   if(head.x == -10){head.x = 500;}
    break;
  case RIGHT:
   if(head.x == 510){head.x = 0;}
    break;
  }
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
if(head.y == foodY && head.x == foodX){
foodeat++;
dropFood();
Segment s = new Segment(head.x, head.y);
  tail.add(s);
}
}
