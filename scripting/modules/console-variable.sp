static ConVar g_pluginEnabled = null;
static ConVar g_defaultDistanceEnabled = null;
static ConVar g_defaultDistance = null;
static ConVar g_defaultDistanceStep = null;
static ConVar g_defaultThrowSpeed = null;
static ConVar g_speedFactor = null;
static ConVar g_traceMode = null;
static ConVar g_coneAngle = null;
static ConVar g_coneDistance = null;
static ConVar g_showActivity = null;

void Variable_Create() {
    g_pluginEnabled = CreateConVar("sm_gravitygun_enable", "1", "Enable (1) or disable (0) plugin");
    g_defaultDistanceEnabled = CreateConVar("sm_gravitygun_default_distance_enable", "1", "Enable (1) or disable (0) default capture distance");
    g_defaultDistance = CreateConVar("sm_gravitygun_default_distance", "128.0", "Default capture distance, must be at least 64.0");
    g_defaultDistanceStep = CreateConVar("sm_gravitygun_default_distance_step", "64.0", "Default distance step for increase/decrease");
    g_defaultThrowSpeed = CreateConVar("sm_gravitygun_default_throw_speed", "1000.0", "Default throw speed");
    g_speedFactor = CreateConVar("sm_gravitygun_speed_factor", "5.0", "How fast to move a player");
    g_traceMode = CreateConVar("sm_gravitygun_trace_mode", "1", "Trace mode (0 - line, 1 - cone)");
    g_coneAngle = CreateConVar("sm_gravitygun_cone_angle", "15.0", "Cone angle (in degrees)");
    g_coneDistance = CreateConVar("sm_gravitygun_cone_distance", "2048.0", "Cone distance");
    g_showActivity = CreateConVar("sm_gravitygun_show_activity", "1", "Show (1) or hide (0) admin activity for all players");
}

bool Variable_PluginEnabled() {
    return g_pluginEnabled.IntValue == 1;
}

bool Variable_DefaultDistanceEnabled() {
    return g_defaultDistanceEnabled.IntValue == 1;
}

float Variable_DefaultDistance() {
    return g_defaultDistance.FloatValue;
}

float Variable_DefaultDistanceStep() {
    return g_defaultDistanceStep.FloatValue;
}

float Variable_DefaultThrowSpeed() {
    return g_defaultThrowSpeed.FloatValue;
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
