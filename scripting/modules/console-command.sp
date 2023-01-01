void Command_Create() {
    RegAdminCmd("sm_gravitygun", Command_SettingsMenu, ADMFLAG_GENERIC);
    RegAdminCmd("+sm_gravitygun_grab", Command_CapturePlayer, ADMFLAG_GENERIC);
    RegAdminCmd("-sm_gravitygun_grab", Command_ReleasePlayer, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_throw", Command_ThrowPlayer, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_trace_mode", Command_TraceMode, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_capture_mode", Command_CaptureMode, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_distance", Command_Distance, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_speed_factor", Command_SpeedFactor, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_throw_speed", Command_ThrowSpeed, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_cone_angle", Command_ConeAngle, ADMFLAG_GENERIC);
    RegAdminCmd("sm_gravitygun_cone_distance", Command_ConeDistance, ADMFLAG_GENERIC);
}

public Action Command_SettingsMenu(int client, int args) {
    Menu_Settings(client);

    return Plugin_Handled;
}

public Action Command_CapturePlayer(int client, int args) {
    UseCase_CapturePlayer(client);

    return Plugin_Handled;
}

public Action Command_ReleasePlayer(int client, int args) {
    UseCase_ReleaseTarget(client);

    return Plugin_Handled;
}

public Action Command_ThrowPlayer(int client, int args) {
    float speed = args == 0 ? Client_GetThrowSpeed(client) : GetCmdArgFloat(1);

    UseCase_ThrowPlayer(client, speed);

    return Plugin_Handled;
}

public Action Command_TraceMode(int client, int args) {
    if (args < 1) {
        int traceMode = Client_GetTraceMode(client);

        MessageReply_ValueOfParameterInteger(client, PARAMETER_TRACE_MODE, traceMode);
    } else {
        int traceMode = GetCmdArgInt(1);

        if (Client_SetTraceMode(client, traceMode)) {
            MessageReply_ValueOfParameterIntegerChanged(client, PARAMETER_TRACE_MODE, traceMode);
        }
    }

    return Plugin_Handled;
}

public Action Command_CaptureMode(int client, int args) {
    if (args < 1) {
        int captureMode = Client_GetCaptureMode(client);

        MessageReply_ValueOfParameterInteger(client, PARAMETER_CAPTURE_MODE, captureMode);
    } else {
        int captureMode = GetCmdArgInt(1);

        if (Client_SetCaptureMode(client, captureMode)) {
            MessageReply_ValueOfParameterIntegerChanged(client, PARAMETER_CAPTURE_MODE, captureMode);
        }
    }

    return Plugin_Handled;
}

public Action Command_Distance(int client, int args) {
    if (args < 1) {
        float distance = Client_GetDistance(client);

        MessageReply_ValueOfParameterFloat(client, PARAMETER_DISTANCE, distance);
    } else {
        float distance = GetCmdArgFloat(1);

        if (Client_SetDistance(client, distance)) {
            MessageReply_ValueOfParameterFloatChanged(client, PARAMETER_DISTANCE, distance);
        }
    }

    return Plugin_Handled;
}

public Action Command_SpeedFactor(int client, int args) {
    if (args < 1) {
        float speedFactor = Client_GetSpeedFactor(client);

        MessageReply_ValueOfParameterFloat(client, PARAMETER_SPEED_FACTOR, speedFactor);
    } else {
        float speedFactor = GetCmdArgFloat(1);

        if (Client_SetSpeedFactor(client, speedFactor)) {
            MessageReply_ValueOfParameterFloatChanged(client, PARAMETER_SPEED_FACTOR, speedFactor);
        }
    }

    return Plugin_Handled;
}

public Action Command_ThrowSpeed(int client, int args) {
    if (args < 1) {
        float throwSpeed = Client_GetThrowSpeed(client);

        MessageReply_ValueOfParameterFloat(client, PARAMETER_THROW_SPEED, throwSpeed);
    } else {
        float throwSpeed = GetCmdArgFloat(1);

        if (Client_SetThrowSpeed(client, throwSpeed)) {
            MessageReply_ValueOfParameterFloatChanged(client, PARAMETER_THROW_SPEED, throwSpeed);
        }
    }

    return Plugin_Handled;
}

public Action Command_ConeAngle(int client, int args) {
    if (args < 1) {
        float coneAngle = Client_GetConeAngle(client);

        MessageReply_ValueOfParameterFloat(client, PARAMETER_CONE_ANGLE, coneAngle);
    } else {
        float coneAngle = GetCmdArgFloat(1);

        if (Client_SetConeAngle(client, coneAngle)) {
            MessageReply_ValueOfParameterFloatChanged(client, PARAMETER_CONE_ANGLE, coneAngle);
        }
    }

    return Plugin_Handled;
}

public Action Command_ConeDistance(int client, int args) {
    if (args < 1) {
        float coneDistance = Client_GetConeDistance(client);

        MessageReply_ValueOfParameterFloat(client, PARAMETER_CONE_DISTANCE, coneDistance);
    } else {
        float coneDistance = GetCmdArgFloat(1);

        if (Client_SetConeDistance(client, coneDistance)) {
            MessageReply_ValueOfParameterFloatChanged(client, PARAMETER_CONE_DISTANCE, coneDistance);
        }
    }

    return Plugin_Handled;
}
