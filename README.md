# Overview

This is a ruby demo implementation of Conway's Game of Life!

To play, the game will ask you to load a seed, then will automatically progress through generations and display them.

# Running the Application

Execute the following command with ruby (Version 2.6.3p62) in a bash terminal:

    ruby main.rb

You will then be continually prompted to advance time and be able to preview the effects of time progression.

**This application is confirmed to run specifically with the following ruby version on macOS: (2.6.3p62 (2019-04-16 revision 67580) [universal.x86_64-darwin19])**

# Loading Seeds

When you run the application, it will list off all of the available seeds to run. 
To load and run one of the listed seeds, simply enter its name 

# How it Works

After a seed is loaded, the application will simulate a grid starting with that seed.

During the simulation, a new generation will automatically and repeatedly be created and displayed.

The application will loop in this manner for 500 cycles by default, and then exit. To edit the number of cycles, view the below section "Configuring the Application."

# Creating Your Own Seed

You may also add your own seeds should you want to test them on your own.

When creating a seed, follow the convention found in the demo files; dead cells should be periods (.) amd live cells should be capital Xs (X).

For the application to find the seed, just save it as a .txt file in the "seeds" directory (./seeds)
You may then run the application with that seed as per above instructions.

# Configuring the Application

By default the application will simulate 500 generations as this is the default in the config file. 
You can change this number to anything to run more or fewer generations.

To run the application infinitely, just remove the "cycles" attribute from the "config.json" file.