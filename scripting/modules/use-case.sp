void UseCase_CapturePlayer(int client) {
    if (!Variable_PluginEnabled()) {
        return;
    }

    int target = GetClientAimTarget(client);

    if (target == CLIENT_NOT_FOUND) {
        MessagePrint_PlayerNotFound(client);

        return;
    }

    if (UseCase_IsInvalidObserverMode(client)) {
        MessagePrint_InvalidObserverMode(client);

        return;
    }

    int clientId = GetClientUserId(client);
    float distance = Variable_DefaultDistanceEnabled() ? Variable_DefaultDistance() : UseCase_CalculateDistance(client, target);

    Client_SetTarget(client, target);
    Client_SetDistance(client, distance);
    CreateTimer(RETENTION_TIMER_INTERVAL, UseCaseTimer_PlayerRetention, clientId, RETENTION_TIMER_FLAGS);
    Message_PlayerCaptured(client, target);
}

void UseCase_ReleasePlayer(int client) {
    int target = Client_GetTarget(client);

    if (target != CLIENT_NOT_FOUND) {
        Client_RemoveTarget(client, target);
        Message_PlayerReleased(client, target);
    } else {
        int owner = Client_GetOwner(client);

        if (owner != CLIENT_NOT_FOUND) {
            UseCase_ReleasePlayer(owner);
        }
    }
}

public Action UseCaseTimer_PlayerRetention(Handle timer, int clientId) {
    int client = GetClientOfUserId(clientId);

    if (client == INVALID_CLIENT) {
        return Plugin_Stop;
    }

    int target = Client_GetTarget(client);

    if (target == CLIENT_NOT_FOUND) {
        return Plugin_Stop;
    }

    if (!IsPlayerAlive(target) || !Variable_PluginEnabled()) {
        Client_RemoveTarget(client, target);
        Message_PlayerReleased(client, target);

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

    direction[X] = Client_GetDistance(client);

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

bool UseCase_IsInvalidObserverMode(int client) {
    int observerMode = GetEntProp(client, Prop_Send, "m_iObserverMode");

    return IsClientObserver(client) && observerMode == OBSERVER_MODE_FIRST_PERSON;
}
