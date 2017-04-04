/*
Gesture recognition by using IMU and Gesture Recognition Toolkit of Nick Gillian

Author: Giray Yillikci
*/

import oscP5.*;
import netP5.*;
import processing.serial.*;

String serialPortName = "/dev/cu.usbmodem1421";
Serial serialPort;
boolean mockupSerial = false;
byte[] inBuffer = new byte[100]; // holds serial message
int leng = 10;

//variables for gesture recognize
int cGes = 0;
int pGes = 0;
int lapseGes = 0;
int delay = 30;
int predictedGes = 0;

//Images variable for holding the images file
PImage open;
PImage fist_left;
PImage up;
PImage down;
PImage open_right;
PImage open_left;
PImage fist_right;
PImage previous;
PImage thumb;
PImage middle;
PImage pinky;

//Set the pipeline mode (CLASSIFICATION_MODE or REGRESSION_MODE), the number of inputs and the number of outputs
final int pipelineMode = GRT.TIMESERIES_MODE;
final int numInputs = leng;
final int numOutputs = 1;

//Create a new GRT instance, this will initalize everything for us and send the setup message to the GRT GUI
GRT grt = new GRT( pipelineMode, numInputs, numOutputs, "127.0.0.1", 5000, 5001 , true );

//Create some global variables to  hold our data
float[] data = new float[ numInputs ];
float[] targetVector = new float[ numOutputs ];
PFont font;

void setup() {
  size(600,600);
  frameRate(30);
  
  //Load the images
  open = loadImage("images/open.JPG");
  fist_left = loadImage("images/fist_left.JPG");
  up = loadImage("images/up.JPG");
  down = loadImage("images/down.JPG");
  open_right = loadImage("images/open_right.JPG");
  open_left = loadImage("images/open_left.jpg");
  fist_right = loadImage("images/fist_right.JPG");
  thumb = loadImage("images/thumb.JPG");
  middle = loadImage("images/middle.JPG");
  pinky = loadImage("images/pinky.JPG");
  //Load the font
  font = loadFont("SansSerif-48.vlw");
  serialPort = new Serial(this, serialPortName, 115200);
}

void draw() {
  background(0);  
  
  if( !grt.getInitialized() ){
    background(255,0,0);  
    println("WARNING: GRT Not Initalized. You need to call the setup function!");
    return;
  }
  if (mockupSerial || serialPort.available() > 0) {
    String myString = "";
    if (!mockupSerial) {
      try {
        serialPort.readBytesUntil('\r', inBuffer);
      }
      catch (Exception e) {
      }
      myString = new String(inBuffer);
    }
    else {
      //myString = mockupSerialFunction();
    }

    //println(myString);
    // split the string at delimiter (space)
    String[] nums = split(myString, ' ');
    //Draw the info text
    grt.drawInfoText(20,20);
    //Grab the mouse data and send it to the GRT backend via OSC
    data[0]=float(nums[0]);
    for (int k = 1 ; k < leng ; k++){
      data[k] = int(nums[k]);
    }
    grt.sendData( data );
  }
}

void keyPressed(){
  
  switch( key ){
    case 'i':
      grt.init( pipelineMode, numInputs, numOutputs, "127.0.0.1", 5000, 5001, true );
      break;
    case '[':
      grt.decrementTrainingClassLabel();
      break;
    case ']':
      grt.incrementTrainingClassLabel();
      break;
    case 'r':
      if( grt.getRecordingStatus() ){
        grt.stopRecording();
      }else grt.startRecording();
      break;
    case 't':
      grt.startTraining();
      break;
    case 's':
      grt.saveTrainingDatasetToFile( "TrainingData.txt" );
      break;
    case 'l':
      grt.loadTrainingDatasetFromFile( "TrainingData.txt" );
      break;
    case 'c':
      grt.clearTrainingDataset();
    break;
    default:
      break;
  }
  
}