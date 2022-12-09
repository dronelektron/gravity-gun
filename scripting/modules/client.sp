static int g_target[MAXPLAYERS + 1];
static int g_owner[MAXPLAYERS + 1];
static float g_distance[MAXPLAYERS + 1];

void Client_Reset(int client) {
    g_target[client] = CLIENT_NOT_FOUND;
    g_owner[client] = CLIENT_NOT_FOUND;
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

float Client_GetDistance(int client) {
    return g_distance[client];
}

void Client_SetDistance(int client, float distance) {
    g_distance[client] = distance;
}
