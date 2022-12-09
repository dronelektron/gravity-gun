static int g_targetId[MAXPLAYERS + 1];
static float g_distance[MAXPLAYERS + 1];

void UseCase_AddDistance(int client, float step) {
    g_distance[client] += step;
}

void UseCase_SubtractDistance(int client, float step) {
    float distance = g_distance[client] - step;

    if (distance >= DISTANCE_MIN) {
        g_distance[client] = distance;
    }
}

void UseCase_CapturePlayer(int client) {
    if (!Variable_PluginEnabled()) {
        return;
    }

    int target = GetClientAimTarget(client);

    if (target == CLIENT_NOT_FOUND) {
        MessagePrint_PlayerNotFound(client);

        return;
    }

    int clientId = GetClientUserId(client);
    int targetId = GetClientUserId(target);

    g_targetId[client] = targetId;

    if (Variable_DefaultDistanceEnabled()) {
        g_distance[client] = Variable_DefaultDistance();
    } else {
        g_distance[client] = UseCase_CalculateDistance(client, target);
    }

    CreateTimer(RETENTION_TIMER_INTERVAL, UseCaseTimer_PlayerRetention, clientId, RETENTION_TIMER_FLAGS);
    Message_PlayerCaptured(client, target);
}

void UseCase_ReleasePlayer(int client) {
    int targetId = g_targetId[client];

    if (targetId != USER_ID_NOT_FOUND) {
        int target = GetClientOfUserId(targetId);

        UseCase_ResetTarget(client);
        Message_PlayerReleased(client, target);
    }
}

void UseCase_ResetTarget(int client) {
    g_targetId[client] = USER_ID_NOT_FOUND;
}

public Action UseCaseTimer_PlayerRetention(Handle timer, int clientId) {
    int client = GetClientOfUserId(clientId);

    if (client == INVALID_CLIENT) {
        return Plugin_Stop;
    }

    int targetId = g_targetId[client];

    if (targetId == USER_ID_NOT_FOUND) {
        return Plugin_Stop;
    }

    int target = GetClientOfUserId(targetId);

    if (target == INVALID_CLIENT || !IsPlayerAlive(target) || !Variable_PluginEnabled()) {
        UseCase_ResetTarget(client);

        return Plugin_Stop;
    }

    UseCase_ApplyForce(client, target);

    return Plugin_Continue;
}

void UseCase_ApplyForce(int client, int target) {
    float clientEyePosition[VECTOR_SIZE];
    float clientEyeAngles[VECTOR_SIZE];
    float targetPosition[VECTOR_SIZE];
    float direction[VECTOR_SIZE];
    float rotatedDirection[VECTOR_SIZE];
    float targetDestination[VECTOR_SIZE];
    float velocity[VECTOR_SIZE];

    direction[X] = g_distance[client];

    GetClientEyePosition(client, clientEyePosition);
    GetClientEyeAngles(client, clientEyeAngles);
    GetClientAbsOrigin(target, targetPosition);
    Math_RotateVector(direction, clientEyeAngles, rotatedDirection);
    AddVectors(clientEyePosition, rotatedDirection, targetDestination);
    SubtractVectors(targetDestination, targetPosition, velocity);
    ScaleVector(velocity, VELOCITY_FACTOR);
    TeleportEntity(target, NULL_VECTOR, NULL_VECTOR, velocity);
}

float UseCase_CalculateDistance(int client, int target) {
    float clientPosition[VECTOR_SIZE];
    float targetPosition[VECTOR_SIZE];

    GetClientAbsOrigin(client, clientPosition);
    GetClientAbsOrigin(target, targetPosition);

    return GetVectorDistance(clientPosition, targetPosition);
}
