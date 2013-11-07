import com.onformative.leap.LeapMotionP5;

LeapMotionP5 leap;

float roll, pitch, yaw;

void setup() {
  size(500, 500);
  leap = new LeapMotionP5(this);
}

void draw() {
  background(0);
  PVector fingerPos = leap.getTip(leap.getFinger(0));
  //ellipse(fingerPos.x, fingerPos.y, 20, 20);
  //println(fingerPos.x + "\t" + fingerPos.y + "\t" + fingerPos.z);

  //println(leap.getHand(0));

  //pitch = leap.getPitch(leap.getHand(0));
  //yaw = leap.getYaw(leap.getHand(0));
  //roll = leap.getRoll(leap.getHand(0));
  //println(fingerPos.x + "\t" + fingerPos.y + "\t" + roll);

  //println(leap.getVelocity(leap.getHand(0)));
  
  //println(leap.getAcceleration(leap.getHand(0)));
}

