## Lorenz Sonified
Processing programs for generating sonifications of the Lorenz system based on position of strange attractors and relative node distance.

## Visualization
In this repo, you will find a file called Lorenz.pde, which contains code for visualizing the animated Lorenz system in real time. You may adjust the system parameters sigma, beta and rho to modify the overall path traversed by the system. The ideal values, as given in the code, generate a system with the iconic butterfly attractors. Adjusting these values can potentially lead to some highly chaotic and interesting patterns.

Included, are two video files, one containing the visualized animation synced to the sonification and the other containing the skeleton of the system and the attractors used as reference points for the distance measurements.

## Sonification
The code which generates the sonification is found in CreatePiece.pde. The tempo setting algorithm works by determining a spatial mapping of the distances between adjacent nodes traversed by the Lorenz system graph to a range of time intervals. The same concept is applied for calculating the current pitch, however the distance between the current node and the midpoint of the Lorenz attractors is used instead.

The piece is generated as a continuous stream of sine tones produced by patching a high pass Moog filter to a note sequencer.

## Possible Improvements/Further steps

- Add multiple Lorenz systems to the same plot (with different starting points and system parameters),
  then combine the musical sequences produced by each of these plots to form one cohesive piece with harmony

- Try the same procedure with different mathematical systems such as the Mandelbrot set

- Attempt to form musical pieces using different metadata about the system, such as hue and perturbations   
