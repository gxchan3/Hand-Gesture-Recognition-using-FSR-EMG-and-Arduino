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

void setup() {
  size(600,600);
  frameRate(30);
  
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