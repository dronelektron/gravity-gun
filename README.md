# Gravity gun

Allows you to grab, move and throw players

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/gravity-gun/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_gravitygun_enable - Enable (1) or disable (0) plugin [default: "1"]
* sm_gravitygun_show_activity - Show (1) or hide (0) admin activity for all players [default: "1"]

### Console Commands

* sm_gravitygun - Open personal settings menu
* sm_gravitygun_grab - Grab a player
* sm_gravitygun_throw [speed] - Throw a player

If you do not specify a `speed`, then the value from `sm_gravitygun_throw_speed` will be used.

### Console Commands (personal settings)

* sm_gravitygun_trace_mode [value] - Trace mode (line - 0, cone - 1) [default: "1"]
* sm_gravitygun_capture_mode [value] - Capture mode (static - 0, dynamic - 1) [default: "1"]
* sm_gravitygun_distance [value] - Capture distance (min - 64.0, max - 32768.0) [default: "128.0"]
* sm_gravitygun_speed_factor [value] - How fast to move a player (min - 1.0, max - 10.0) [default: "5.0"]
* sm_gravitygun_throw_speed [value] - Throw speed (min - 256.0, max - 32768.0) [default: "1024.0"]
* sm_gravitygun_cone_angle [value] - Cone angle in degrees (min - 5.0, max - 60.0) [default: "15.0"]
* sm_gravitygun_cone_distance [value] - Cone distance (min - 64.0, max - 32768.0) [default: "512.0"]

##### Trace Mode

* Static - Grab a player at a distance specified in the console variable `sm_gravitygun_distance`
* Dynamic - Grab a player at a distance between you and them

##### Capture Mode

* Line - The player who crossed the line will be captured
* Cone - The player who is inside the cone and who is closer to the crosshair will be captured

### Notes

Bind the `sm_gravitygun_grab` command as follows:

```
bind "your_button" "+sm_gravitygun_grab"
```

Notice the `+` sign in front of the `sm_gravitygun_grab` command, this command works both on pressing and releasing the button:

* When the button is pressed, the player is captured
* When the button is not pressed, the player is released
