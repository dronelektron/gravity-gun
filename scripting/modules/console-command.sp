void Command_Create() {
    RegAdminCmd("+sm_gravitygun_grab", Command_CapturePlayer, ADMFLAG_GENERIC);
    RegAdminCmd("-sm_gravitygun_grab", Command_ReleasePlayer, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_distance_add", Command_AddDistance, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_distance_subtract", Command_SubtractDistance, ADMFLAG_GENERIC);
}

public Action Command_CapturePlayer(int client, int args) {
    UseCase_CapturePlayer(client);

    return Plugin_Handled;
}

public Action Command_ReleasePlayer(int client, int args) {
    UseCase_ReleasePlayer(client);

    return Plugin_Handled;
}

public Action Command_AddDistance(int client, int args) {
    float step = Command_GetDistanceStep(args);

    UseCase_AddDistance(client, step);

    return Plugin_Handled;
}

public Action Command_SubtractDistance(int client, int args) {
    float step = Command_GetDistanceStep(args);

    UseCase_SubtractDistance(client, step);

    return Plugin_Handled;
}

static float Command_GetDistanceStep(int args) {
    return args == 0 ? Variable_DefaultDistanceStep() : GetCmdArgFloat(1);
}
