int gesture_reg(int predicted){
//determine the user's gesture
      if (lapseGes == 0){
        cGes = predicted;
        pGes = predicted;
        lapseGes += 1;
      }
      else {
        pGes = cGes;
        cGes = predicted;
        if ( cGes == pGes ){
          lapseGes += 1;
        }
        else {
          lapseGes = 0;
        }
      }
      
      if (lapseGes > 15){
        lapseGes = 0;
        cGes = 0;
        return pGes;
      }
      else
        return 0;
}

void showGesImage(int ges,int y){
  if (ges == 0){
    if (previous == null){
      
    }
    else{
      image(previous,30,y,240,240);
    }
  }
  else if (ges == 1){
    image(open,30,y,240,240);
    previous = open;
  }
  
  else if (ges == 2){
    image(up,30,y,240,240);
    previous = up;
  }
  
  else if (ges == 3){
    image(down,30,y,240,240);
    previous = down;
  }
  else if (ges == 4){
    image(thumb,30,y,240,240);
    previous = thumb;
  }
  else if (ges == 5){
    image(middle,30,y,240,240);
    previous = middle;
  }
  else if (ges == 6){
    image(pinky,30,y,240,240);
    previous = pinky;
  }
  else if (ges == 7){
    image(open_right,30,y,240,240);
    previous = open_right;
  }
  else if (ges == 8){
    image(open_left,30,y,240,240);
    previous = open_left;
  }
  
}