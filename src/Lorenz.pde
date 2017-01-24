import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

/**************************************************************
 * Computes and plots the Lorenz system iteratively for given *
 * values of the system parameters sigma, beta and rho. Next, *
 * a text file is generated containing a list of all the      * 
 * points traversed.                                          * 
 *                                                            *
 * Version: 12/07/2016                                        *
 * Author: Chaitanya Varier                                   *
 **************************************************************
 */
 
// Utility constants
public static final int transientPoints = 39;
public static final int maxPoints = 6000;
public static final int cursorPoints = 5, cursorWeight = 3, normalWeight = 1;
public static final float xOrig = 0.1, yOrig = 0.1, zOrig = 0.1;
public static final float flairConstant = 1e-6;
public static final float pi = 3.14159265358979;

// System parameters
public static final float sigmaIdeal = 10.0, betaIdeal = 8.0/3, rhoIdeal = 28.0;
public static final float sigma = sigmaIdeal, beta = betaIdeal, rho = rhoIdeal;
public static final float dt = 0.01;

// State variables
public static float x = xOrig, y = yOrig, z = zOrig;
public static int hue = 0, saturation = 255, brightness = 255;
public static int cursorHue = 0, cursorSaturation = 0;
public static float flair = 1.00, flairSin = 0;
public static int flairIter = 0, flairMaxIters = 100;
public static boolean flairExp = true, active = true;

// Objects
public static ArrayList<PVector> sysPoints = new ArrayList<PVector>();
public static PrintWriter outputX, outputY, outputZ;
public static PFont tF;

PeasyCam camera;

void setup () {
  
  camera = new PeasyCam(this, 500);
  colorMode(HSB);
  fullScreen(P3D);
  tF = createFont("Cambria", 16, true);
  textMode(SHAPE);
  
  String name = "LPoints" + (int)sigma + "_" + (int) (sigma * 100) % 100 + "-" + 
    (int) beta + "_" + (int) (beta * 100) % 100 + "-" + (int) rho + "_" + (int) (rho * 100) % 100;
    
  String nameX = name + "X.txt", nameY = name + "Y.txt", nameZ = name + "Z.txt";
  
  outputX = createWriter(nameX);
  outputY = createWriter(nameY);
  outputZ = createWriter(nameZ);
  
}


void draw () {
 
  if (active) {
   
    background(0);
   
    float dx = (sigma * (y - x)) * dt;
    float dy = (x * (rho - z) - y) * dt;
    float dz = (x * y - beta * z) * dt;
    
    x += dx;
    y += dy;
    z += dz;
    
    sysPoints.add(new PVector(x, y, z));
    
    translate(50, 50, -100);
    scale(5);
    stroke(250);
    noFill();
  
    beginShape();
    
    for (int i = 0; i < sysPoints.size(); i ++) {
      
      float curX = sysPoints.get(i).x;
      float curY = sysPoints.get(i).y;
      float curZ = sysPoints.get(i).z;
      
      if (i > transientPoints) {
        
        hue = (int) ((Math.sin(curX/curZ) + 1) * 127.0);
        cursorHue = hue;
        saturation = 255;
        cursorSaturation = saturation;
        brightness = 255;
        strokeWeight(normalWeight);
        
      } else if (i <= transientPoints && sysPoints.size() > transientPoints) {
        
        hue = (int) ((Math.sin(sysPoints.get(transientPoints).x/sysPoints.get(transientPoints).z + 1) * 127.0));
        cursorHue = hue;
        saturation = 255;
        cursorSaturation = saturation;
        brightness = 255;
        strokeWeight(normalWeight);
        
      } 
      
      if (i >= (sysPoints.size() - 1) - cursorPoints) {
        
        hue = 255 - cursorHue;
        saturation = 240;
        brightness = 255;
        strokeWeight(cursorWeight);
        
      }
      
      stroke(hue, saturation, brightness);
      
      // Add flair (expansion/contraction)
      if (flairExp) {
        
        flair += flairConstant;
        
        curX *= flair;
        curY *= flair;
        curZ *= flair;
        
      } else {
        
        flair -= flairConstant;
        
        curX *= flair;
        curY *= flair;
        curZ *= flair;
        
      }
      
      if (flairIter == flairMaxIters) {
        
        flairExp = !flairExp;
        flairIter = 0;
        
      }
      
      if (flairSin >= pi)
        flairSin = 0;
      
      // Add flair (sinusoidal perturbations)
      curX += curX * 0.01 * Math.sin(flairSin);
      curY += curY * 0.01 * Math.sin(flairSin);
      curZ += curZ * 0.01 * Math.sin(flairSin);
      
      flairSin += 0.2;
        
      vertex(curX, curY, curZ);
      
    }
    
    if (sysPoints.size() > maxPoints) {
      
      active = false;
      
      // Write list of all point coordinates to text files
      for (int j = 0; j < sysPoints.size(); j++) {
        
        outputX.println(sysPoints.get(j).x);
        outputY.println(sysPoints.get(j).y);
        outputZ.println(sysPoints.get(j).z);
        
      }
      
      sysPoints.clear();
      outputX.close();
      outputY.close();
      outputZ.close();
      exit();
      
    }
    
    endShape();
    
    flairIter++;
    
  }
  
}