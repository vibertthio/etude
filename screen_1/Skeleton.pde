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
  int id = -1;

  //Variable
  PGraphics canvas;
  int fCount; // frameCount : 0
  int numberOfPeople; // number of people : 1
  Joint[] joints; //32 position data : 2 ~ 33
  int rightHandState, leftHandState; // hand state : 34 ~ 35
  boolean appearance;

  //color
  color jointColor = color (255, 255, 255);
  color boneColor = color (210, 215, 211);


  //constructor
  Skeleton(PGraphics _canvas, int _id) {
    joints = new Joint[numberOfJoints];
    appearance = false;
    canvas = _canvas;
    id = _id;

    //v_state
    s_pose1 = new Vstate ( 0, 150 );
    s_pose2 = new Vstate ( 0, 150 );
    s_pose3_l = new Vstate ( 100, 150 );
    s_pose3_r = new Vstate ( 100, 150 );
    s_squat = new Vstate ( 500, 500 );
    s_pose4 = new Vstate (150, 140 );
  }

  void set(int[] dataBuffer) {
    appearance = true;
    fCount = dataBuffer[0];
    numberOfPeople = dataBuffer[1];
    rightHandState = dataBuffer[34];
    leftHandState = dataBuffer[35];
    for(int i = 0, n = numberOfJoints ; i < n; i++) {
      if(i == JointType_HandRight) {
        joints[i] = new JointHand(i, dataBuffer[2*i+2], dataBuffer[2*i+3], rightHandState, canvas);
      }
      else if(i == JointType_HandLeft) {
        joints[i] = new JointHand(i, dataBuffer[2*i+2], dataBuffer[2*i+3], leftHandState, canvas);
      }
      else {
        joints[i] = new Joint(i, dataBuffer[2*i+2], dataBuffer[2*i+3], canvas);
      }
    }
  }

  void update(int[] dataBuffer) {
    fCount = dataBuffer[0];
    numberOfPeople = dataBuffer[1];
    rightHandState = dataBuffer[34];
    leftHandState = dataBuffer[35];
    joints[JointType_HandRight].handState = rightHandState;
    joints[JointType_HandLeft].handState = leftHandState;
    for(int i = 0, n = numberOfJoints ; i < n; i++) {
      joints[i].update(dataBuffer[2*i+2], dataBuffer[2*i+3]);
    }


    s_pose1.set( pose1Detection() );
    s_pose2.set( pose2Detection() );

    if ( leftHandNearShoulder() &&
         ( leftHandState==2 || leftHandState==3 ) ) {
      // println("left set!");
      s_pose3_l.set( pose3LDetection() );
    }
    if ( rightHandNearShoulder() &&
         ( rightHandState==2 || rightHandState==3 ) ) {
      // println("right set!");
      s_pose3_r.set( pose3RDetection() );
    }

    s_squat.set( squatDetection() );
    if ( ! s_squat.getState() ) {
      //println("No Squat!!!!!!!");
      s_pose4.set( pose4Detection() );
    }
  }

  //display
  void display(){
    if(appearance) {

      //draw bones
      canvas.stroke(boneColor, 255);
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
      canvas.noStroke();
      for(int i=0; i<numberOfJoints; i++) {
        canvas.fill(jointColor);
        drawJoint(i);
      }
    }

  }

  void drawJoint(int jointType) {
    joints[jointType].display();
  }

  void drawBone(int jointType1, int jointType2) {
    //joints[jointType1].display();
    canvas.line(joints[jointType1].getX(), joints[jointType1].getY(),
         joints[jointType2].getX(), joints[jointType2].getY());
  }



  //posture detection
  //posture definition
  Vstate s_pose1;
  Vstate s_pose2;
  Vstate s_pose3_l;
  Vstate s_pose3_r;
  Vstate s_squat;
  Vstate s_pose4;

  //pose 1
  float TresholdAngle_HandAbove = 81;
  float TresholdAngle_ElbowIn = 120;
  boolean pose1Detection () {
    if ( handsBothRaised() ) {
      PVector horizon = new PVector(1, 0);
      PVector rhand = joints[JointType_HandRight].pos.copy();
      rhand.sub(joints[JointType_ShoulderRight].pos);
      PVector lhand = joints[JointType_HandLeft].pos.copy();
      lhand.sub(joints[JointType_ShoulderLeft].pos);
      float r = degrees ( PVector.angleBetween(rhand, horizon) );
      float l =  degrees ( PVector.angleBetween(lhand, horizon.mult(-1)) );

      //debug
      // print("r = " + str(r) );
      // print("  l = " + str(l) );

      if ( r > TresholdAngle_HandAbove &&
           l > TresholdAngle_HandAbove )
           return true;
      else {
        return false;
      }
    }

    return false;
  }
  boolean handsBothRaised() {
    float limit= ( joints[JointType_SpineShoulder].getY()
                   - joints[JointType_Head].getY() ) / 2;
    if ( joints[JointType_SpineShoulder].getY()
         - joints[JointType_ElbowLeft].getY() > limit
      && joints[JointType_SpineShoulder].getY()
         - joints[JointType_ElbowRight].getY() > limit ) {
      return true;
    }
    else {
      return false;
    }
  }
  boolean soundPose1() {
    if ( s_pose1.getHoldGate() && s_pose1.getState() ) {
      String head = "/p" + str(id) + "/pose1";
      OscMessage osc = new OscMessage(head);
      osc.add(1);
      oscP5.send(osc, myRemoteLocation);
      //debug
      // oscP5.send(osc, myRemoteLocation3);

      backgroundDotsVibrationTimer.startTimer();
      return true;
    }
    return false;
  }

  //pose2
  boolean pose2Detection () {
    if (leftElbowNearShoulder()
       && rightElbowNearShoulder() ) {

      PVector horizon = new PVector(1, 0);
      PVector rElbow = joints[JointType_HandRight].pos.copy();
      rElbow.sub(joints[JointType_ElbowRight].pos);
      float r = degrees ( PVector.angleBetween(rElbow, horizon)) ;
      //print("r = " + str(r) );
      if ( r > TresholdAngle_ElbowIn ) {
        return true;
      }

      PVector lElbow = joints[JointType_HandLeft].pos.copy();
      lElbow.sub(joints[JointType_ElbowLeft].pos);
      float l = degrees ( PVector.angleBetween(lElbow, horizon.mult(-1)) );
      //print("  l = " + str(l) );
      if ( l > TresholdAngle_ElbowIn ) {
        return true;
      }


      return false;
    }
    return false;
  }
  boolean leftElbowNearShoulder () {
    float limit= ( joints[JointType_SpineShoulder].getY()
                   - joints[JointType_Head].getY() ) / 2;
    float d = abs ( joints[JointType_ElbowLeft].getY()
                - joints[JointType_SpineShoulder].getY() ) ;
    float h = abs ( joints[JointType_SpineShoulder].getY() - joints[JointType_HandLeft].getY() );
    return ( d < limit && h > limit ) ;
  }
  boolean rightElbowNearShoulder () {
    float limit= ( joints[JointType_SpineShoulder].getY()
                   - joints[JointType_Head].getY() ) / 2;
    float d = abs ( joints[JointType_ElbowRight].getY()
                   - joints[JointType_SpineShoulder].getY() );
    float h = abs ( joints[JointType_SpineShoulder].getY() - joints[JointType_HandLeft].getY() );
    // print("  h = " + str(h) );
    // print("  d = " + str(d) );
    // print("  limit = " + str(limit) );
    return ( d < limit && h > limit ) ;
  }
  boolean soundPose2() {
    if ( s_pose2.getHoldGate() && s_pose2.getState() ) {
      String head = "/p" + str(id) + "/pose2";
      OscMessage osc = new OscMessage(head);
      osc.add(1);
      oscP5.send(osc, myRemoteLocation);
      return true;
    }
    return false;
  }

  //pose3
  boolean pose3LDetection () {
    if ( leftHandState == 3 && leftHandNearShoulder() )
      return true;
    else //2
      return false;
  }
  boolean pose3RDetection () {
    if ( rightHandState == 3 && rightHandNearShoulder() )
      return true;
    else //2
      return false;
  }
  boolean leftHandNearShoulder() {
    float limit = dist(
      joints[JointType_ShoulderLeft].getX(),
      joints[JointType_ShoulderLeft].getY(),
      joints[JointType_SpineShoulder].getX(),
      joints[JointType_SpineShoulder].getY()
    ) / 0.7 ;

    float d = dist(
      joints[JointType_ShoulderLeft].getX(),
      joints[JointType_ShoulderLeft].getY(),
      joints[JointType_HandLeft].getX(),
      joints[JointType_HandLeft].getY()
    );

    return ( d < limit );
  }
  boolean rightHandNearShoulder() {
    float limit = dist(
      joints[JointType_ShoulderRight].getX(),
      joints[JointType_ShoulderRight].getY(),
      joints[JointType_SpineShoulder].getX(),
      joints[JointType_SpineShoulder].getY()
    ) / 0.7 ;

    float d = dist(
      joints[JointType_ShoulderRight].getX(),
      joints[JointType_ShoulderRight].getY(),
      joints[JointType_HandRight].getX(),
      joints[JointType_HandRight].getY()
    );

    return ( d < limit );
  }
  boolean soundPose3_l() {
    if ( s_pose3_l.getHoldGate() && s_pose3_l.getState() ) {
      String head = "/p" + str(id) + "/pose3_l";
      OscMessage osc = new OscMessage(head);
      osc.add(1);
      oscP5.send(osc, myRemoteLocation);
      return true;
    }
    return false;
  }
  boolean soundPose3_r() {
    if ( s_pose3_r.getHoldGate() && s_pose3_r.getState() ) {
      String head = "/p" + str(id) + "/pose3_r";
      OscMessage osc = new OscMessage(head);
      osc.add(1);
      oscP5.send(osc, myRemoteLocation);
      return true;
    }
    return false;
  };

  //pose4
  //detection of squat
  boolean squatDetection() {
    float neck = abs ( joints[JointType_SpineShoulder].getY()
                       - joints[JointType_Head].getY() ) / 1.5 ;
    float d_l = abs ( joints[JointType_KneeLeft].getY()
                       - joints[JointType_HipLeft].getY() ) ;
    float d_r = abs ( joints[JointType_KneeRight].getY()
                       - joints[JointType_HipRight].getY() ) ;
    return ( d_l < neck && d_r < neck ) ;
  }
  boolean pose4Detection() {
    //left is higher
    float d = abs ( joints[JointType_AnkleLeft].getY()
                      - joints[JointType_AnkleRight].getY() ) ;
    if ( leftLegIsHigher() ) {
      float limit = abs ( joints[JointType_KneeRight].getY()
                        - joints[JointType_AnkleRight].getY() ) / 1.5;
      return ( d / limit > 0.72 ) ;
    }

    //right is higher
    else {
      float limit = abs ( joints[JointType_KneeLeft].getY()
                        - joints[JointType_AnkleLeft].getY() ) / 1.5;
      return ( d / limit > 0.72 ) ;
    }
  }
  boolean leftLegIsHigher() {
    //detect the height of two ankles
    return ( joints[JointType_AnkleLeft].getY()
            < joints[JointType_AnkleRight].getY() );
  }

  boolean soundPose4() {
    //TODO
    if ( s_pose4.getGate() && s_pose4.getState() ) {
      String head = "/p" + str(id) +  "/pose4";
      OscMessage osc = new OscMessage(head);
      osc.add(1);
      oscP5.send(osc, myRemoteLocation);
      return true;
    }
    return false;
  }

  void thereminSignal() {
    //left heand
    String head = "/p" + str(id) +  "/l";
    OscMessage osc = new OscMessage(head);
    osc.add(joints[JointType_HandLeft].getX());
    osc.add(joints[JointType_HandLeft].getY());
    oscP5.send(osc, myRemoteLocation2);

    //right hand
    head = "/p" + str(id) +  "/r";
    osc = new OscMessage(head);
    osc.add(joints[JointType_HandRight].getX());
    osc.add(joints[JointType_HandRight].getY());
    oscP5.send(osc, myRemoteLocation2);
  }


}
