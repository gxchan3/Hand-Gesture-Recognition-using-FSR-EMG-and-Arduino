void gesture_reg(int predicted){
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
      
      if (lapseGes > 30){
        vControl(pGes);
        lapseGes = 0;
        cGes = 0;
        pGes = 0;
      }
}
void vControl(int ges){
  if (ges == 1){
    ff = false;
    fb = false;
  }
  if (ges == 2){
    if (play == false){
      theMov.play();
      play = true;
    }
    else {
      theMov.pause();
      play = false;
    }
  }
  else if (ges == 3){
    vol += 0.1;
    theMov.volume(vol);
  }
  else if (ges == 4){
    vol -= 0.1;
    theMov.volume(vol);
  }
  else if (ges == 5){
    ff = true;
    theMov.jump(theMov.time()+2);
  }
  else if (ges == 6){
    fb = true;
    theMov.jump(theMov.time()-2);
  }
}