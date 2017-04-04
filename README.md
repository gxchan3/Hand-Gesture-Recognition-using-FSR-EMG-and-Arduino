# Hand-Gesture-Recognition-using-FSR-EMG-and-Arduino
Using FSR and EMG sensors to recognize hand gesture using GRT machine learning

This repository includes the Arduino sketch for acquiring 10 FSRs and 2 EMG sensors data. Also the Processing sketch and the usage of GRT GUI created by Nick Gillian are included. The GUI version for GRT (Gesture Recognition Toolkit) is created by Nick Gillian. The information about the program can be referred to http://www.nickgillian.com/wiki/pmwiki.php/GRT/GUI. Both the Windows and Mac versions of the program can be downloaded from that website as well.

## Circuit Design
![experimental setup](https://cloud.githubusercontent.com/assets/26737862/24670433/9145af72-19a0-11e7-8cf6-52004ae5951d.png)

## Instructions
### Preparation
1. Upload "Arduino_Multiplexer.ino" to Arduino Board (folder: "Arduino_Multiplexer")
- Remember to check the port name
2. Run the GRT GUI program
2. Run the Processing Sketches in the folder "Gesture Recognition"
- Check the number of inputs if the number of sensors change

### Record the realtime data
1. Click the Processing window so that it is the active window
2. Click “r” to record the first gesture
3. Click “r” again to stop record
4. Click “]” to record the second gesture (click ‘r’ to start recording and ‘r’ again to stop recording)
5. Repeat 1-4 until all the gestures are recorded
6. Go to the 'Pipeline Tool' to select the learning algorithm and the training parameters
6. Go to the ‘Training Tool’, click 'Train' to train the data
7. Go to the ‘Prediction Tool’ to start the mapping from real time sensors measurement to the corresponding hand gesture.

Note: The data training for Time Series Mode is not yet able to be controlled using keyboard keys
## Additional Processing Sketches
1. Matching the gesture recognized into gesture image
Folder "Hand-Gesture-Recognition-using-FSR-EMG-and-Arduino/IMU_Gesture_Recognition/Gesture Recognition_Image Match"

2. Controlling the videoplayback using gesture recognition
Folder "Gesture Recognition_VideoPlayback"
