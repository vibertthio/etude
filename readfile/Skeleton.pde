class Skeleton {
  //Joint Macro
  int JointType_Head = 0;
  int JointType_SpineShoulder = 1;
  int JointType_SpineMid = 2;
  int JointType_SpineBase = 3;
  int JointType_ShoulderRight = 4;
  int JointType_ShoulderLeft = 5;

  int JointType_ElbowRight = 6;
  int JointType_HandRight = 7;

  int JointType_ElbowLeft = 8;
  int JointType_HandLeft = 9;

  int JointType_HipRight = 10;
  int JointType_AnkleRight = 11;
  int JointType_KneeRight = 12;

  int JointType_HipLeft = 13;
  int JointType_AnkleLeft = 14;
  int JointType_KneeLeft = 15;

  //Constant
  int numberOfJoints = 16;

  //Variable
  int fCount; // frameCount : 0
  int numberOfPeople; // number of people : 1
  Joint[] joints; //32 position data : 2 ~ 33
  int rightHandState, leftHandState; // hand state : 34 ~ 35
  boolean appearance;

  //color
  color jointColor = color (255, 255, 255);
  color boneColor = color (210, 215, 211);


  //constructor
  Skeleton() {
    joints = new Joint[numberOfJoints];
    appearance = false;
  }

  void set(int[] dataBuffer) {
    appearance = true;
    fCount = dataBuffer[0];
    numberOfPeople = dataBuffer[1];
    rightHandState = dataBuffer[34];
    leftHandState = dataBuffer[35];
    for(int i = 0, n = numberOfJoints ; i < n; i++) {
      if(i == JointType_HandRight) {
        joints[i] = new JointHand(i, dataBuffer[2*i+2], dataBuffer[2*i+3], rightHandState);
      }
      else if(i == JointType_HandLeft) {
        joints[i] = new JointHand(i, dataBuffer[2*i+2], dataBuffer[2*i+3], leftHandState);
      }
      else {
        joints[i] = new Joint(i, dataBuffer[2*i+2], dataBuffer[2*i+3]);
      }
    }
  }

  //display
  void display(){
    if(appearance) {

      //draw bones
      stroke(boneColor, 255);
      drawBone(JointType_Head, JointType_SpineShoulder);
      drawBone(JointType_SpineShoulder, JointType_SpineMid);
      drawBone(JointType_SpineMid, JointType_SpineBase);
      drawBone(JointType_SpineShoulder, JointType_ShoulderRight);
      drawBone(JointType_SpineShoulder, JointType_ShoulderLeft);
      drawBone(JointType_SpineBase, JointType_HipRight);
      drawBone(JointType_SpineBase, JointType_HipLeft);
      // Right Arm
      drawBone(JointType_ShoulderRight, JointType_ElbowRight);
      drawBone(JointType_ElbowRight, JointType_HandRight);
      // Left Arm
      drawBone(JointType_ShoulderLeft, JointType_ElbowLeft);
      drawBone(JointType_ElbowLeft, JointType_HandLeft);
      // Right Leg
      drawBone(JointType_HipRight, JointType_KneeRight);
      drawBone(JointType_KneeRight, JointType_AnkleRight);
      // Left Leg
      drawBone(JointType_HipLeft, JointType_KneeLeft);
      drawBone(JointType_KneeLeft, JointType_AnkleLeft);

      //draw joints
      noStroke();
      for(int i=0; i<numberOfJoints; i++) {
        fill(jointColor);
        drawJoint(i);
      }
    }

  }



  void drawJoint(int jointType) {
    joints[jointType].display();
  }

  void drawBone(int jointType1, int jointType2) {
    //joints[jointType1].display();
    line(joints[jointType1].getX(), joints[jointType1].getY(),
         joints[jointType2].getX(), joints[jointType2].getY());
  }










}
