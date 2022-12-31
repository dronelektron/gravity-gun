void UseCase_CapturePlayer(int client) {
    if (!Variable_PluginEnabled()) {
        return;
    }

    int target = UseCase_TraceTarget(client);

    if (!UseCase_IsTargetCapturable(client, target)) {
        return;
    }

    int clientId = GetClientUserId(client);
    float distance = UseCase_GetCurrentDistance(client, target);

    Client_SetTarget(client, target);
    Client_SetCurrentDistance(client, distance);
    UseCase_RemoveClientSpeedLimit(target);
    CreateTimer(RETENTION_TIMER_INTERVAL, UseCaseTimer_PlayerRetention, clientId, RETENTION_TIMER_FLAGS);
    Message_PlayerCaptured(client, target);
}

bool UseCase_IsTargetCapturable(int client, int target) {
    if (target == CLIENT_NOT_FOUND) {
        MessagePrint_PlayerNotFound(client);

        return false;
    }

    if (UseCase_IsInvalidObserverMode(client)) {
        MessagePrint_InvalidObserverMode(client);

        return false;
    }

    int owner = Client_GetOwner(target);

    if (owner != CLIENT_NOT_FOUND) {
        MessagePrint_PlayerAlreadyCaptured(client, target, owner);

        return false;
    }

    bool isClientCapturedByTarget = Client_GetTarget(target) == client;

    if (isClientCapturedByTarget) {
        MessagePrint_YouCannotCaptureOwner(client, target);

        return false;
    }

    if (!CanUserTarget(client, target)) {
        MessagePrint_TargetHasImmunity(client, target);

        return false;
    }

    return true;
}

int UseCase_TraceTarget(int client) {
    if (Client_GetTraceMode(client) == TRACE_MODE_LINE) {
        return GetClientAimTarget(client);
    }

    return UseCase_FindNearestTargetInCone(client);
}

int UseCase_FindNearestTargetInCone(int client) {
    int target = CLIENT_NOT_FOUND;
    float targetAngle = 180.0;
    float coneAngle = Client_GetConeAngle(client);
    float coneDistance = Client_GetConeDistance(client);

    for (int i = 1; i <= MaxClients; i++) {
        if (!IsClientInGame(i) || !IsPlayerAlive(i) || client == i) {
            continue;
        }

        float angle = Math_CalculateAngleToCone(client, i);
        float distance = Math_CalculateDistance(client, i);
        bool isTargetInCone = angle < coneAngle && distance < coneDistance;
        bool isTargetAngleSmaller = angle < targetAngle;

        if (isTargetInCone && isTargetAngleSmaller) {
            target = i;
            targetAngle = angle;
        }
    }

    return target;
}

float UseCase_GetCurrentDistance(int client, int target) {
    if (Client_GetCaptureMode(client) == CAPTURE_MODE_STATIC) {
        return Client_GetDistance(client);
    }

    return Math_CalculateDistance(client, target);
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
    float distance = Client_GetCurrentDistance(client);
    float speedFactor = Client_GetSpeedFactor(client);
    float velocity[VECTOR_SIZE];

    Math_CalculateVelocityToDestination(client, target, distance, speedFactor, velocity);
    TeleportEntity(target, NULL_VECTOR, NULL_VECTOR, velocity);
}

void UseCase_ApplyForceOnce(int client, int target, float speed) {
    float direction[VECTOR_SIZE];

    Math_CalculateThrowDirection(client, speed, direction);
    TeleportEntity(target, NULL_VECTOR, NULL_VECTOR, direction);
}

bool UseCase_IsInvalidObserverMode(int client) {
    int observerMode = GetEntProp(client, Prop_Send, "m_iObserverMode");

    return IsClientObserver(client) && observerMode != OBSERVER_MODE_FREE_CAMERA;
}

void UseCase_RemoveClientSpeedLimit(int client) {
    SetEntityMoveType(client, MOVETYPE_ISOMETRIC);
}

void UseCase_RestoreClientSpeedLimit(int client) {
    SetEntityMoveType(client, MOVETYPE_WALK);
}

void UseCase_LoadClientSettings(int client) {
    if (UseCase_IsAdmin(client) && UseCase_IsRealClient(client)) {
        SettingsStorage_Apply(SettingsStorage_LoadClient, client);
    }
}

void UseCase_SaveClientSettings(int client) {
    if (UseCase_IsAdmin(client) && UseCase_IsRealClient(client)) {
        SettingsStorage_Apply(SettingsStorage_SaveClient, client);
    }
}

bool UseCase_IsAdmin(int client) {
    AdminId id = GetUserAdmin(client);

    return id != INVALID_ADMIN_ID && GetAdminFlag(id, Admin_Generic, Access_Effective);
}

bool UseCase_IsRealClient(int client) {
    return !IsFakeClient(client) && !IsClientSourceTV(client);
}
