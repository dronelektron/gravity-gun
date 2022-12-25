static ConVar g_pluginEnabled = null;
static ConVar g_captureMode = null;
static ConVar g_captureDistance = null;
static ConVar g_captureDistanceStep = null;
static ConVar g_throwSpeed = null;
static ConVar g_speedFactor = null;
static ConVar g_traceMode = null;
static ConVar g_coneAngle = null;
static ConVar g_coneDistance = null;
static ConVar g_showActivity = null;

void Variable_Create() {
    g_pluginEnabled = CreateConVar("sm_gravitygun_enable", "1", "Enable (1) or disable (0) plugin");
    g_captureMode = CreateConVar("sm_gravitygun_capture_mode", "1", "Capture mode (0 - default distance, 1 - dynamic distance)");
    g_captureDistance = CreateConVar("sm_gravitygun_capture_distance", "128.0", "Default capture distance");
    g_captureDistanceStep = CreateConVar("sm_gravitygun_capture_distance_step", "64.0", "Default capture distance step for increase/decrease");
    g_throwSpeed = CreateConVar("sm_gravitygun_throw_speed", "1000.0", "Default throw speed");
    g_speedFactor = CreateConVar("sm_gravitygun_speed_factor", "5.0", "How fast to move a player");
    g_traceMode = CreateConVar("sm_gravitygun_trace_mode", "1", "Trace mode (0 - line, 1 - cone)");
    g_coneAngle = CreateConVar("sm_gravitygun_cone_angle", "15.0", "Cone angle (in degrees)");
    g_coneDistance = CreateConVar("sm_gravitygun_cone_distance", "2048.0", "Cone distance");
    g_showActivity = CreateConVar("sm_gravitygun_show_activity", "1", "Show (1) or hide (0) admin activity for all players");
}

bool Variable_PluginEnabled() {
    return g_pluginEnabled.IntValue == 1;
}

int Variable_CaptureMode() {
    return g_captureMode.IntValue;
}

float Variable_CaptureDistance() {
    return g_captureDistance.FloatValue;
}

float Variable_CaptureDistanceStep() {
    return g_captureDistanceStep.FloatValue;
}

float Variable_ThrowSpeed() {
    return g_throwSpeed.FloatValue;
}

float Variable_SpeedFactor() {
    return g_speedFactor.FloatValue;
}

int Variable_TraceMode() {
    return g_traceMode.IntValue;
}

float Variable_ConeAngle() {
    return g_coneAngle.FloatValue;
}

float Variable_ConeDistance() {
    return g_coneDistance.FloatValue;
}

bool Variable_ShowActivity() {
    return g_showActivity.IntValue == 1;
}
