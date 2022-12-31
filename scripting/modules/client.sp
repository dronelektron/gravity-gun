static int g_target[MAXPLAYERS + 1];
static int g_owner[MAXPLAYERS + 1];
static float g_currentDistance[MAXPLAYERS + 1];
static int g_traceMode[MAXPLAYERS + 1];
static int g_captureMode[MAXPLAYERS + 1];
static float g_distance[MAXPLAYERS + 1];
static float g_speedFactor[MAXPLAYERS + 1];
static float g_throwSpeed[MAXPLAYERS + 1];
static float g_coneAngle[MAXPLAYERS + 1];
static float g_coneDistance[MAXPLAYERS + 1];

void Client_Reset(int client) {
    g_target[client] = CLIENT_NOT_FOUND;
    g_owner[client] = CLIENT_NOT_FOUND;
    g_traceMode[client] = TRACE_MODE_DEFAULT;
    g_captureMode[client] = CAPTURE_MODE_DEFAULT;
    g_distance[client] = DISTANCE_DEFAULT;
    g_speedFactor[client] = SPEED_FACTOR_DEFAULT;
    g_throwSpeed[client] = THROW_SPEED_DEFAULT;
    g_coneAngle[client] = CONE_ANGLE_DEFAULT;
    g_coneDistance[client] = CONE_DISTANCE_DEFAULT;
}

int Client_GetTarget(int client) {
    return g_target[client];
}

int Client_GetOwner(int client) {
    return g_owner[client];
}

void Client_SetTarget(int client, int target) {
    g_target[client] = target;
    g_owner[target] = client;
}

void Client_RemoveTarget(int client, int target) {
    g_target[client] = CLIENT_NOT_FOUND;
    g_owner[target] = CLIENT_NOT_FOUND;
}

float Client_GetCurrentDistance(int client) {
    return g_currentDistance[client];
}

void Client_SetCurrentDistance(int client, float distance) {
    g_currentDistance[client] = distance;
}

int Client_GetTraceMode(int client) {
    return g_traceMode[client];
}

bool Client_SetTraceMode(int client, int traceMode) {
    if (ValueInRange(traceMode, TRACE_MODE_LINE, TRACE_MODE_CONE)) {
        g_traceMode[client] = traceMode;

        return true;
    }

    return false;
}

int Client_GetCaptureMode(int client) {
    return g_captureMode[client];
}

bool Client_SetCaptureMode(int client, int captureMode) {
    if (ValueInRange(captureMode, CAPTURE_MODE_STATIC, CAPTURE_MODE_DYNAMIC)) {
        g_captureMode[client] = captureMode;

        return true;
    }

    return false;
}

float Client_GetDistance(int client) {
    return g_distance[client];
}

bool Client_SetDistance(int client, float distance) {
    if (ValueInRange(distance, DISTANCE_MIN, DISTANCE_MAX)) {
        g_distance[client] = distance;

        return true;
    }

    return false;
}

float Client_GetSpeedFactor(int client) {
    return g_speedFactor[client];
}

bool Client_SetSpeedFactor(int client, float speedFactor) {
    if (ValueInRange(speedFactor, SPEED_FACTOR_MIN, SPEED_FACTOR_MAX)) {
        g_speedFactor[client] = speedFactor;

        return true;
    }

    return false;
}

float Client_GetThrowSpeed(int client) {
    return g_throwSpeed[client];
}

bool Client_SetThrowSpeed(int client, float throwSpeed) {
    if (ValueInRange(throwSpeed, THROW_SPEED_MIN, THROW_SPEED_MAX)) {
        g_throwSpeed[client] = throwSpeed;

        return true;
    }

    return false;
}

float Client_GetConeAngle(int client) {
    return g_coneAngle[client];
}

bool Client_SetConeAngle(int client, float coneAngle) {
    if (ValueInRange(coneAngle, CONE_ANGLE_MIN, CONE_ANGLE_MAX)) {
        g_coneAngle[client] = coneAngle;

        return true;
    }

    return false;
}

float Client_GetConeDistance(int client) {
    return g_coneDistance[client];
}

bool Client_SetConeDistance(int client, float coneDistance) {
    if (ValueInRange(coneDistance, CONE_DISTANCE_MIN, CONE_DISTANCE_MAX)) {
        g_coneDistance[client] = coneDistance;

        return true;
    }

    return false;
}

static bool ValueInRange(any value, any min, any max) {
    return min <= value && value <= max;
}
