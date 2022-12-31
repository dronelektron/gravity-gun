static ConVar g_pluginEnabled = null;
static ConVar g_showActivity = null;

void Variable_Create() {
    g_pluginEnabled = CreateConVar("sm_gravitygun_enable", "1", "Enable (1) or disable (0) plugin");
    g_showActivity = CreateConVar("sm_gravitygun_show_activity", "1", "Show (1) or hide (0) admin activity for all players");
}

bool Variable_PluginEnabled() {
    return g_pluginEnabled.IntValue == 1;
}

bool Variable_ShowActivity() {
    return g_showActivity.IntValue == 1;
}
