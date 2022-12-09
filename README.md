# Gravity gun

Allows you to grab and move players

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/gravity-gun/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_gravitygun_enable - Enable (1) or disable (0) plugin [default: "1"]
* sm_gravitygun_default_distance - Enable (1) or disable (0) default capture distance [default: "1"]
* sm_gravitygun_distance - Default capture distance, must be at least 128.0 [default: "128.0"]
* sm_gravitygun_distance_step - Default distance step for addition/subtraction [default: "64.0"]

### Console Commands

* sm_gravitygun_grab - Grab a player
* sm_gravitygun_distance_add [step] - Add capture distance
* sm_gravitygun_distance_subtract [step] - Subtract capture distance

If you do not specify a `step`, then the value from `sm_gravitygun_distance_step` will be used.

### Usage

* Open console
* Bind the following commands
	* bind "..." "+sm_gravitygun_grab"
	* bind "..." "sm_gravitygun_distance_add"
	* bind "..." "sm_gravitygun_distance_subtract"

Notice the "+" sign in front of the "sm_gravitygun_grab" command, this command works both on pressing and releasing the button.
