# Hand-Gesture-Recognition-using-FSR-EMG-and-Arduino
Using FSR and EMG sensors to recognize hand gesture using GRT machine learning

This repository includes the Arduino sketch for acquiring 10 FSRs and 2 EMG sensors data. Also the Processing sketch and the usage of GRT GUI created by Nick Gillian are included. The GUI version for GRT (Gesture Recognition Toolkit) is created by Nick Gillian. The information about the program can be referred to http://www.nickgillian.com/wiki/pmwiki.php/GRT/GUI. Both the Windows and Mac versions of the program can be downloaded from that website as well.

## Instructions
1. Upload RealtimePlotterArduino.ino to Arduino Board (folder: RealtimePlotterArduino)
- Remember to check the port name
2. Run the Processing Sketch: “IMU_Gesture_Recognition.pde” (folder: IMU_GRT-master)
3. Run GRT (Folder: GRT_V0.1_18_OSX)

Record the realtime data
1. Click the Processing window so that it is the active window
2. Click “r” to record the first gesture
3. Click “r” again to stop record
4. Click “]” to record the second gesture (click ‘r’ to start recording and ‘r’ again to stop recording)
5. Repeat 1-4 until all the gestures are recorded
6. Go to the ‘Training Tool’ to train the data
7. Go to the ‘Prediction Tool’ to start the mapping from real time sensors measurement to the corresponding hand gesture.
