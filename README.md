# Overview

This is a ruby demo of Conway's Game of Life. 
To play, the game will continually prompt you to advance time. Press any key when prompted to view the progression. 

# Running the application

Execute the following command with ruby (Version 2.7.0p0) in a bash terminal:

    ruby main.rb

You will then be continually prompted to advance time and be able to preview the effects of time progression.

# Loading seeds

When you run the application, it will list off all of the available seeds to run. 
To load and run one of the listed seeds, simply enter its name 

# How it Works

After a seed is loaded, the application will simulate a grid starting with that seed.
During the simulation, a new generation will automatically and repeatedly be created and displayed.
The application will loop in this manner for 500 cycles by default, and then exit.

# Creating your own seed

You may also add your own seeds should you want to test them on your own.
When creating a seed, follow the convention found in the demo files; dead cells should be periods (.) amd live cells should be capital Xs (X).
For the application to find the seed, just save it as a .txt file in the "seeds" directory (./seeds)
You may then run the application with that seed as per above instructions.