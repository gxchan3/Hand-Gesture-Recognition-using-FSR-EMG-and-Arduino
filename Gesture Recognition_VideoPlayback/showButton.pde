void showButton(){
  if (play == true){
    image(play_sym,120,800-360);
  }
  else if (play == false){
    image(pause_sym,120,800-360);
  }
  else {
  }
  
  if (ff == true){
    image(ff_sym,200,800-360);
  }
  else if (fb == true){
    image(fb_sym,200,800-360);
  }
  
  showVolButton(vol);
}

void showVolButton(float vol){
  int yLine = 800-100;
  int xLine = 480;
  for (float i=0 ; i <= vol; i+=0.1){
    image(line_sym,xLine,yLine,50,50);
    yLine -= 2;
  }
}