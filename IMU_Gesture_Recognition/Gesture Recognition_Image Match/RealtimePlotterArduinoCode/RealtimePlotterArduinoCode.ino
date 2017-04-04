//Mux control pins
int s0 = 8;
int s1 = 9;
int s2 = 10;
int s3 = 11;
int leng=10;

//Mux in "SIG" pin
int SIG_pin = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(s0, OUTPUT); 
  pinMode(s1, OUTPUT); 
  pinMode(s2, OUTPUT); 
  pinMode(s3, OUTPUT); 

  digitalWrite(s0, LOW);
  digitalWrite(s1, LOW);
  digitalWrite(s2, LOW);
  digitalWrite(s3, LOW);

  Serial.begin(9600);
}

int16_t value = 0;
int8_t direction = 10;
void loop() {
  // put your main code here, to run repeatedly:
  for (int i = 0 ; i < leng ; i++){
    switch (i) {
      case 0:
      Serial.print(readMux(i));
      break;
      case 1:
      Serial.print(readMux(i));
      break;
      case 2:
      Serial.print(readMux(i));
      break;
      case 3:
      Serial.print(readMux(i));
      break;
      case 4:
      Serial.print(readMux(i));
      break;
      case 5:
      Serial.print(readMux(i));
      break;
      case 6:
      Serial.print(readMux(i));
      break;
      case 7:
      Serial.print(readMux(i));
      break;
      case 8:
      Serial.print(readMux(i));
      break;
      case 9:
      Serial.print(readMux(i));
      break;
    }
    if (i < leng)
      Serial.print(" ");
  }
  Serial.println('\r');
  delay(100);
}

int readMux(int channel){
  int controlPin[] = {s0, s1, s2, s3};

  int muxChannel[16][4]={
    {0,0,0,0}, //channel 0
    {1,0,0,0}, //channel 1
    {0,1,0,0}, //channel 2
    {1,1,0,0}, //channel 3
    {0,0,1,0}, //channel 4
    {1,0,1,0}, //channel 5
    {0,1,1,0}, //channel 6
    {1,1,1,0}, //channel 7
    {0,0,0,1}, //channel 8
    {1,0,0,1}, //channel 9
    {0,1,0,1}, //channel 10
    {1,1,0,1}, //channel 11
    {0,0,1,1}, //channel 12
    {1,0,1,1}, //channel 13
    {0,1,1,1}, //channel 14
    {1,1,1,1}  //channel 15
  };

  //loop through the 4 sig
  for(int i = 0; i < 4; i ++){
    digitalWrite(controlPin[i], muxChannel[channel][i]);
  }

  //read the value at the SIG pin
  int val = analogRead(SIG_pin);

  //return the value
  return val;
}
