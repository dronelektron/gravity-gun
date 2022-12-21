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

    int owner = Client_GetOwner(target);

    if (owner != CLIENT_NOT_FOUND) {
        MessagePrint_PlayerAlreadyCaptured(client, target, owner);

        return;
    }

    bool isClientCapturedByTarget = Client_GetTarget(target) == client;

    if (isClientCapturedByTarget) {
        MessagePrint_YouCannotCaptureOwner(client, target);

        return;
    }

    int clientId = GetClientUserId(client);
    float distance = UseCase_GetInitialDistance(client, target);

    Client_SetTarget(client, target);
    Client_SetDistance(client, distance);
    UseCase_RemoveClientSpeedLimit(target);
    CreateTimer(RETENTION_TIMER_INTERVAL, UseCaseTimer_PlayerRetention, clientId, RETENTION_TIMER_FLAGS);
    Message_PlayerCaptured(client, target);
}

void UseCase_ReleaseAllTargets() {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            UseCase_ReleaseTarget(client);
        }
    }
}

void UseCase_ReleaseFromOwner(int client) {
    int owner = Client_GetOwner(client);

    if (owner != CLIENT_NOT_FOUND) {
        UseCase_ReleaseTarget(owner);
    }
}

void UseCase_ReleaseTarget(int client) {
    int target = Client_GetTarget(client);

    if (target != CLIENT_NOT_FOUND) {
        Client_RemoveTarget(client, target);
        UseCase_RestoreClientSpeedLimit(target);
        Message_PlayerReleased(client, target);
    }
}

void UseCase_ThrowPlayer(int client, float velocity) {
    int target = Client_GetTarget(client);

    if (target == CLIENT_NOT_FOUND) {
        MessagePrint_NoPlayerToThrow(client);

        return;
    }

    int targetId = GetClientUserId(target);

    Client_RemoveTarget(client, target);
    CreateTimer(FLIGHT_TIMER_INTERVAL, UseCaseTimer_PlayerFlight, targetId, FLIGHT_TIMER_FLAGS);
    UseCase_ApplyForceOnce(client, target, velocity);
    Message_PlayerThrown(client, target, velocity);
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

public Action UseCaseTimer_PlayerFlight(Handle timer, int targetId) {
    int target = GetClientOfUserId(targetId);

    if (target == INVALID_CLIENT) {
        return Plugin_Stop;
    }

    int owner = Client_GetOwner(target);

    if (owner != CLIENT_NOT_FOUND || !IsPlayerAlive(target)) {
        return Plugin_Stop;
    }

    int groundEntity = GetEntPropEnt(target, Prop_Send, "m_hGroundEntity");

    if (groundEntity != ENTITY_NOT_FOUND) {
        UseCase_RestoreClientSpeedLimit(target);

        return Plugin_Stop;
    }

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
    float velocityFactor = Variable_VelocityFactor();

    direction[X] = Client_GetDistance(client);

    GetClientEyePosition(client, clientEyePosition);
    GetClientEyeAngles(client, clientEyeAngles);
    GetClientAbsOrigin(target, targetPosition);
    Math_RotateVector(direction, clientEyeAngles[PITCH], clientEyeAngles[YAW], rotatedDirection);
    AddVectors(clientEyePosition, rotatedDirection, targetDestination);
    SubtractVectors(targetDestination, targetPosition, velocity);
    ScaleVector(velocity, velocityFactor);
    TeleportEntity(target, NULL_VECTOR, NULL_VECTOR, velocity);
}

void UseCase_ApplyForceOnce(int client, int target, float velocity) {
    float eyeAngles[VECTOR_SIZE];
    float direction[VECTOR_SIZE];

    GetClientEyeAngles(client, eyeAngles);
    GetAngleVectors(eyeAngles, direction, NULL_VECTOR, NULL_VECTOR);
    ScaleVector(direction, velocity);
    TeleportEntity(target, NULL_VECTOR, NULL_VECTOR, direction);
}

float UseCase_GetInitialDistance(int client, int target) {
    if (Variable_DefaultDistanceEnabled()) {
        float distance = Variable_DefaultDistance();

        if (distance < DISTANCE_MIN) {
            distance = DISTANCE_MIN;
        }

        return distance;
    }

    return UseCase_CalculateDistance(client, target);
}

float UseCase_CalculateDistance(int client, int target) {
    float clientPosition[VECTOR_SIZE];
    float targetPosition[VECTOR_SIZE];

    GetClientAbsOrigin(client, clientPosition);
    GetClientAbsOrigin(target, targetPosition);

    return GetVectorDistance(clientPosition, targetPosition);
}

void UseCase_IncreaseDistance(int client, float step) {
    float distance = Client_GetDistance(client) + step;

    Client_SetDistance(client, distance);
    MessagePrint_DistanceChanged(client, distance);
}

void UseCase_DecreaseDistance(int client, float step) {
    float distance = Client_GetDistance(client) - step;

    if (distance < DISTANCE_MIN) {
        distance = DISTANCE_MIN;
    }

    Client_SetDistance(client, distance);
    MessagePrint_DistanceChanged(client, distance);
}

bool UseCase_IsInvalidObserverMode(int client) {
    int observerMode = GetEntProp(client, Prop_Send, "m_iObserverMode");

    return IsClientObserver(client) && observerMode == OBSERVER_MODE_FIRST_PERSON;
}

void UseCase_RemoveClientSpeedLimit(int client) {
    SetEntityMoveType(client, MOVETYPE_ISOMETRIC);
}

void UseCase_RestoreClientSpeedLimit(int client) {
    SetEntityMoveType(client, MOVETYPE_WALK);
}
