static ConVar g_pluginEnabled = null;
static ConVar g_defaultDistanceEnabled = null;
static ConVar g_defaultDistance = null;
static ConVar g_defaultDistanceStep = null;

void Variable_Create() {
    g_pluginEnabled = CreateConVar("sm_gravitygun_enable", "1", "Enable (1) or disable (0) plugin");
    g_defaultDistanceEnabled = CreateConVar("sm_gravitygun_default_distance", "1", "Enable (1) or disable (0) default capture distance");
    g_defaultDistance = CreateConVar("sm_gravitygun_distance", "128.0", "Default capture distance, must be at least 128.0");
    g_defaultDistanceStep = CreateConVar("sm_gravitygun_distance_step", "64.0", "Default distance step for addition/subtraction");
}

bool Variable_PluginEnabled() {
    return g_pluginEnabled.IntValue == 1;
}

bool Variable_DefaultDistanceEnabled() {
    return g_defaultDistanceEnabled.IntValue == 1;
}

float Variable_DefaultDistance() {
    float defaultDistance = g_defaultDistance.FloatValue;

    if (defaultDistance < DISTANCE_MIN) {
        defaultDistance = DISTANCE_MIN;
    }

    return defaultDistance;
}

float Variable_DefaultDistanceStep() {
    return g_defaultDistanceStep.FloatValue;
}
