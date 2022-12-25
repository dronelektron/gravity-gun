void UseCase_CapturePlayer(int client) {
    if (!Variable_PluginEnabled()) {
        return;
    }

    int target = UseCase_TraceTarget(client);

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

    if (!CanUserTarget(client, target)) {
        MessagePrint_TargetHasImmunity(client, target);

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

int UseCase_TraceTarget(int client) {
    if (Variable_TraceMode() == TRACE_MODE_LINE) {
        return GetClientAimTarget(client);
    }

    return UseCase_FindNearestTargetInCone(client);
}

int UseCase_FindNearestTargetInCone(int client) {
    int target = CLIENT_NOT_FOUND;
    float targetAngle = 180.0;
    float coneAngle = Variable_ConeAngle();
    float coneDistance = Variable_ConeDistance();

    for (int i = 1; i <= MaxClients; i++) {
        if (!IsClientInGame(i) || !IsPlayerAlive(i) || client == i) {
            continue;
        }

        float angle = Math_CalculateAngleToCone(client, i);
        float distance = Math_CalculateDistance(client, i);

        if (angle <= coneAngle && distance < coneDistance && angle < targetAngle) {
            target = i;
            targetAngle = angle;
        }
    }

    return target;
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

void UseCase_ThrowPlayer(int client, float speed) {
    int target = Client_GetTarget(client);

    if (target == CLIENT_NOT_FOUND) {
        MessagePrint_NoPlayerToThrow(client);

        return;
    }

    int targetId = GetClientUserId(target);

    Client_RemoveTarget(client, target);
    CreateTimer(FLIGHT_TIMER_INTERVAL, UseCaseTimer_PlayerFlight, targetId, FLIGHT_TIMER_FLAGS);
    UseCase_ApplyForceOnce(client, target, speed);
    Message_PlayerThrown(client, target, speed);
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
    float distance = Client_GetDistance(client);
    float speedFactor = Variable_SpeedFactor();
    float velocity[VECTOR_SIZE];

    Math_CalculateVelocityToDestination(client, target, distance, speedFactor, velocity);
    TeleportEntity(target, NULL_VECTOR, NULL_VECTOR, velocity);
}

void UseCase_ApplyForceOnce(int client, int target, float speed) {
    float direction[VECTOR_SIZE];

    Math_CalculateThrowDirection(client, speed, direction);
    TeleportEntity(target, NULL_VECTOR, NULL_VECTOR, direction);
}

float UseCase_GetInitialDistance(int client, int target) {
    if (Variable_CaptureMode() == CAPTURE_MODE_FIXED) {
        float distance = Variable_CaptureDistance();

        if (distance < DISTANCE_MIN) {
            distance = DISTANCE_MIN;
        }

        return distance;
    }

    return Math_CalculateDistance(client, target);
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
