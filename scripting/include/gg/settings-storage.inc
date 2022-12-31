#if defined _gg_settings_storage_included
 #endinput
#endif
#define _gg_settings_storage_included

#define CREATE_KEY_YES true

#define KEY_TRACE_MODE "trace mode"
#define KEY_CAPTURE_MODE "capture mode"
#define KEY_DISTANCE "distance"
#define KEY_SPEED_FACTOR "speed factor"
#define KEY_THROW_SPEED "throw speed"
#define KEY_CONE_ANGLE "cone angle"
#define KEY_CONE_DISTANCE "cone distance"

typedef StorageOperation = function void (KeyValues kv, int client, const char[] steam);
