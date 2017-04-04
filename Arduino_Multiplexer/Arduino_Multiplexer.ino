//Multiplexer control pins
int s0 = 8;
int s1 = 9;
int s2 = 10;
int s3 = 11;
int leng=11;

//Multiplexer in "SIG" pin
int SIG_pin = 0;

void setup() {
  //Set s0-s3 to be output mode
  pinMode(s0, OUTPUT); 
  pinMode(s1, OUTPUT); 
  pinMode(s2, OUTPUT); 
  pinMode(s3, OUTPUT); 

  //Set s0-s3 to be 0 initially
  digitalWrite(s0, LOW);
  digitalWrite(s1, LOW);
  digitalWrite(s2, LOW);
  digitalWrite(s3, LOW);

  //Set analog pin A1 to be input mode
  pinMode(1, INPUT); 
  Serial.begin(28800);
}

int16_t value = 0;
int8_t direction = 10;
void loop() {
  //case 0-9: loop through all 10 FSR sensors
  //case 10-11: loop through analog input A1 and A2 for emg sensors
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
      case 10:
      //Read from 1st EMG sensor
      Serial.print(analogRead(A1)*7);
      break;
      case 11:
      //Read from 2nd EMG sensor
      Serial.print(analogRead(A2));
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

  //Setting the values of digital outputs D8-11
  for(int i = 0; i < 4; i ++){
    digitalWrite(controlPin[i], muxChannel[channel][i]);
  }

  //Read the value of the SIG pin
  int val = analogRead(SIG_pin);

  //return the value
  return val;
}
