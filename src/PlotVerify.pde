import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

/********************************************************
 * Reads the x, y and z coordinates of a Lorenz system  *
 * generated wit given values for the parameters sigma, *
 * beta and rho.                                        *
 *                                                      *
 * Version: 12/07/2016                                  *
 * Author: Chaitanya Varier                             *
 ********************************************************
 */


BufferedReader readerX, readerY, readerZ;

PVector[] vecs = new PVector[6000];
public static ArrayList<PVector> sysPoints = new ArrayList<PVector>();
public static int iter = 0;

PeasyCam camera;
 
void setup() {
  
  camera = new PeasyCam(this, 500);
  colorMode(HSB);
  readerX = createReader("LPoints10_0-2_66-28_0X.txt");
  readerY = createReader("LPoints10_0-2_66-28_0Y.txt");
  readerZ = createReader("LPoints10_0-2_66-28_0Z.txt");
  
  fullScreen(P3D);
  
  for (int i = 0; i < vecs.length; i++) {
    
    try {
      
      vecs[i] = new PVector(Float.parseFloat(readerX.readLine()), Float.parseFloat(readerY.readLine()), 
        Float.parseFloat(readerZ.readLine()));
      
    } catch (IOException e) {
      
      e.printStackTrace();
      
    }
    
  }
  
}
 
void draw() {
  
  background(0);
  
  translate(50, 50, -100);
  scale(5);
  
  if (iter < 6000)
    sysPoints.add(vecs[iter]);
    
  else
    exit();
  
  // Attractor 1 & 2
  stroke(0, 255, 255);
  strokeWeight(3);
  
  float attracX1 = -8.358359191, attracY1 = -8.41142473, attracZ1 = 26.87020614;
  point(attracX1, attracY1, attracZ1);
  
  float attracX2 = 8.281888215, attracY2 = 8.508647967, attracZ2 = 27.11247407;
  point(attracX2, attracY2, attracZ2);
  
  
  // Attractor midpoint
  point((attracX1 + attracX2)/2, (attracY1 + attracY2)/2, (attracZ1 + attracZ2)/2);
  
  stroke(250);
  strokeWeight(1);
  
  for (int j = 0; j < sysPoints.size(); j++ )
    point(sysPoints.get(j).x, sysPoints.get(j).y, sysPoints.get(j).z);
  
  iter++;
}