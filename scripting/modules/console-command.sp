void Command_Create() {
    RegAdminCmd("+sm_gravitygun_grab", Command_CapturePlayer, ADMFLAG_GENERIC);
    RegAdminCmd("-sm_gravitygun_grab", Command_ReleasePlayer, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_distance_increase", Command_IncreaseDistance, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_distance_decrease", Command_DecreaseDistance, ADMFLAG_GENERIC);
}

public Action Command_CapturePlayer(int client, int args) {
    UseCase_CapturePlayer(client);

    return Plugin_Handled;
}

public Action Command_ReleasePlayer(int client, int args) {
    UseCase_ReleaseTarget(client);

    return Plugin_Handled;
}

public Action Command_IncreaseDistance(int client, int args) {
    float step = Command_GetDistanceStep(args);

    UseCase_IncreaseDistance(client, step);

    return Plugin_Handled;
}

public Action Command_DecreaseDistance(int client, int args) {
    float step = Command_GetDistanceStep(args);

    UseCase_DecreaseDistance(client, step);

    return Plugin_Handled;
}

static float Command_GetDistanceStep(int args) {
    return args == 0 ? Variable_DefaultDistanceStep() : GetCmdArgFloat(1);
}
