static char g_configPath[PLATFORM_MAX_PATH];

void SettingsStorage_BuildConfigPath() {
    BuildPath(Path_SM, g_configPath, sizeof(g_configPath), "configs/gravity-gun.txt");
}

void SettingsStorage_Apply(StorageOperation operation, int client) {
    KeyValues kv = new KeyValues("Gravity gun");
    char steam[MAX_AUTHID_LENGTH];

    if (FileExists(g_configPath)) {
        kv.ImportFromFile(g_configPath);
    }

    GetClientAuthId(client, AuthId_Steam3, steam, sizeof(steam));
    Call_StartFunction(INVALID_HANDLE, operation);
    Call_PushCell(kv);
    Call_PushCell(client);
    Call_PushString(steam);
    Call_Finish();

    delete kv;
}

void SettingsStorage_LoadClient(KeyValues kv, int client, const char[] steam) {
    if (!kv.JumpToKey(steam)) {
        return;
    }

    int traceMode = kv.GetNum(KEY_TRACE_MODE, TRACE_MODE_DEFAULT);
    int captureMode = kv.GetNum(KEY_CAPTURE_MODE, CAPTURE_MODE_DEFAULT);
    float distance = kv.GetFloat(KEY_DISTANCE, DISTANCE_DEFAULT);
    float speedFactor = kv.GetFloat(KEY_SPEED_FACTOR, SPEED_FACTOR_DEFAULT);
    float throwSpeed = kv.GetFloat(KEY_THROW_SPEED, THROW_SPEED_DEFAULT);
    float coneAngle = kv.GetFloat(KEY_CONE_ANGLE, CONE_ANGLE_DEFAULT);
    float coneDistance = kv.GetFloat(KEY_CONE_DISTANCE, CONE_DISTANCE_DEFAULT);

    Client_SetTraceMode(client, traceMode);
    Client_SetCaptureMode(client, captureMode);
    Client_SetDistance(client, distance);
    Client_SetSpeedFactor(client, speedFactor);
    Client_SetThrowSpeed(client, throwSpeed);
    Client_SetConeAngle(client, coneAngle);
    Client_SetConeDistance(client, coneDistance);
}

void SettingsStorage_SaveClient(KeyValues kv, int client, const char[] steam) {
    int traceMode = Client_GetTraceMode(client);
    int captureMode = Client_GetCaptureMode(client);
    float distance = Client_GetDistance(client);
    float speedFactor = Client_GetSpeedFactor(client);
    float throwSpeed = Client_GetThrowSpeed(client);
    float coneAngle = Client_GetConeAngle(client);
    float coneDistance = Client_GetConeDistance(client);

    kv.JumpToKey(steam, CREATE_KEY_YES);
    kv.SetNum(KEY_TRACE_MODE, traceMode);
    kv.SetNum(KEY_CAPTURE_MODE, captureMode);
    kv.SetFloat(KEY_DISTANCE, distance);
    kv.SetFloat(KEY_SPEED_FACTOR, speedFactor);
    kv.SetFloat(KEY_THROW_SPEED, throwSpeed);
    kv.SetFloat(KEY_CONE_ANGLE, coneAngle);
    kv.SetFloat(KEY_CONE_DISTANCE, coneDistance);
    kv.Rewind();
    kv.ExportToFile(g_configPath);
}
