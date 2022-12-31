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
* sm_gravitygun_capture_mode - Capture mode (0 - default distance, 1 - dynamic distance) [default: "1"]
* sm_gravitygun_capture_distance - Default capture distance [default: "128.0"]
* sm_gravitygun_capture_distance_step - Default capture distance step for increase/decrease [default: "64.0"]
* sm_gravitygun_throw_speed - Default throw speed [default: "1000.0"]
* sm_gravitygun_speed_factor - How fast to move a player [default: "5.0"]
* sm_gravitygun_trace_mode - Trace mode (0 - line, 1 - cone) [default: "1"]
* sm_gravitygun_cone_angle - Cone angle (in degrees) [default: "15.0"]
* sm_gravitygun_cone_distance - Cone distance [default: "2048.0"]

### Console Commands

* sm_gravitygun_grab - Grab a player
* sm_gravitygun_throw [speed] - Throw a player
* sm_gravitygun_distance_increase [step] - Increase capture distance
* sm_gravitygun_distance_decrease [step] - Decrease capture distance

If you do not specify a `step`, then the value from `sm_gravitygun_capture_distance_step` will be used.
If you do not specify a `speed`, then the value from `sm_gravitygun_throw_speed` will be used.

### Notes

Bind the `sm_gravitygun_grab` command as follows:

```
bind "your_button" "+sm_gravitygun_grab"
```

Notice the `+` sign in front of the `sm_gravitygun_grab` command, this command works both on pressing and releasing the button:

* When the button is pressed, the player is captured
* When the button is not pressed, the player is released
