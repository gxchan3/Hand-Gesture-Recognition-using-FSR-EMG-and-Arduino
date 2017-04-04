/*
Gesture recognition by using IMU and Gesture Recognition Toolkit of Nick Gillian

Author: Giray Yillikci
*/

import oscP5.*;
import netP5.*;
import processing.serial.*;
import processing.video.*;
import java.awt.*;

String serialPortName = "/dev/cu.usbmodem1421";
Serial serialPort;
boolean mockupSerial = false;
byte[] inBuffer = new byte[100]; // holds serial message
int leng = 10;
int w = 660;
int h = 800;

//variables for movie playback
Movie theMov;
Boolean play = false;
float current = 0;
float vol = 0.5; //volumn
Boolean ff = false;
Boolean fb = false;

//variables for gesture recognize
int cGes = 0;
int pGes = 0;
int lapseGes = 0;
int delay = 30;

//Set the pipeline mode (CLASSIFICATION_MODE or REGRESSION_MODE), the number of inputs and the number of outputs
final int pipelineMode = GRT.CLASSIFICATION_MODE;
final int numInputs = leng;
final int numOutputs = 1;

//Create a new GRT instance, this will initalize everything for us and send the setup message to the GRT GUI
GRT grt = new GRT( pipelineMode, numInputs, numOutputs, "127.0.0.1", 5000, 5001 , true );

//Create some global variables to hold our data
float[] data = new float[ numInputs ];
float[] targetVector = new float[ numOutputs ];
PFont font;

//declare PImage variable to load images
PImage pause_sym;
PImage play_sym;
PImage ff_sym;
PImage fb_sym;
PImage hv_sym;
PImage lv_sym;
PImage line_sym;
void setup() {
  size(660,800);
  frameRate(30);
  
  //load the video file
  theMov = new Movie(this, "4.mp4");
  theMov.loop();
  theMov.pause();
  theMov.volume(0.5);
  
  //load images file
  pause_sym = loadImage("images/pause.png");
  play_sym = loadImage("images/play.png");
  ff_sym = loadImage("images/ff.png");
  fb_sym = loadImage("images/bf.png");
  hv_sym = loadImage("images/hv.png");
  lv_sym = loadImage("images/lv.png");
  line_sym = loadImage("images/line.png");
  
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

void movieEvent(Movie m) { 
  m.read(); 
}