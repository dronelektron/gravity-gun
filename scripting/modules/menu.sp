void Menu_Settings(int client) {
    Menu menu = new Menu(MenuHandler_Settings);

    menu.SetTitle("%T", GRAVITY_GUN_SETTINGS, client);

    Menu_AddItemParameterInteger(menu, PARAMETER_TRACE_MODE, client, Client_GetTraceMode(client));
    Menu_AddItemParameterInteger(menu, PARAMETER_CAPTURE_MODE, client, Client_GetCaptureMode(client));
    Menu_AddItemParameterFloat(menu, PARAMETER_DISTANCE, client, Client_GetDistance(client));
    Menu_AddItemParameterFloat(menu, PARAMETER_SPEED_FACTOR, client, Client_GetSpeedFactor(client));
    Menu_AddItemParameterFloat(menu, PARAMETER_THROW_SPEED, client, Client_GetThrowSpeed(client));
    Menu_AddItemParameterFloat(menu, PARAMETER_CONE_ANGLE, client, Client_GetConeAngle(client));
    Menu_AddItemParameterFloat(menu, PARAMETER_CONE_DISTANCE, client, Client_GetConeDistance(client));

    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_Settings(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, PARAMETER_TRACE_MODE)) {
            Menu_TraceMode(param1);
        } else if (StrEqual(info, PARAMETER_CAPTURE_MODE)) {
            Menu_CaptureMode(param1);
        } else if (StrEqual(info, PARAMETER_DISTANCE)) {
            Menu_Distance(param1);
        } else if (StrEqual(info, PARAMETER_SPEED_FACTOR)) {
            Menu_SpeedFactor(param1);
        } else if (StrEqual(info, PARAMETER_THROW_SPEED)) {
            Menu_ThrowSpeed(param1);
        } else if (StrEqual(info, PARAMETER_CONE_ANGLE)) {
            Menu_ConeAngle(param1);
        } else {
            Menu_ConeDistance(param1);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_TraceMode(int client) {
    Menu menu = new Menu(MenuHandler_TraceMode);

    menu.SetTitle("%T", PARAMETER_TRACE_MODE, client);

    Menu_AddItem(menu, ITEM_TRACE_MODE_LINE, client);
    Menu_AddItem(menu, ITEM_TRACE_MODE_CONE, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_TraceMode(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        int traceMode;

        if (StrEqual(info, ITEM_TRACE_MODE_LINE)) {
            traceMode = TRACE_MODE_LINE;
        } else {
            traceMode = TRACE_MODE_CONE;
        }

        Client_SetTraceMode(param1, traceMode);
        MessageReply_ValueOfParameterIntegerChanged(param1, PARAMETER_TRACE_MODE, traceMode);
        Menu_TraceMode(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void Menu_CaptureMode(int client) {
    Menu menu = new Menu(MenuHandler_CaptureMode);

    menu.SetTitle("%T", PARAMETER_CAPTURE_MODE, client);

    Menu_AddItem(menu, ITEM_CAPTURE_MODE_STATIC, client);
    Menu_AddItem(menu, ITEM_CAPTURE_MODE_DYNAMIC, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_CaptureMode(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        int captureMode;

        if (StrEqual(info, ITEM_CAPTURE_MODE_STATIC)) {
            captureMode = CAPTURE_MODE_STATIC;
        } else {
            captureMode = CAPTURE_MODE_DYNAMIC;
        }

        Client_SetCaptureMode(param1, captureMode);
        MessageReply_ValueOfParameterIntegerChanged(param1, PARAMETER_CAPTURE_MODE, captureMode);
        Menu_CaptureMode(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void Menu_Distance(int client) {
    Menu menu = new Menu(MenuHandler_Distance);

    menu.SetTitle("%T", PARAMETER_DISTANCE, client);

    char info[INFO_MAX_SIZE];

    for (float distance = DISTANCE_MIN; distance <= DISTANCE_MAX; distance *= 2.0) {
        int distanceInteger = RoundToFloor(distance);

        IntToString(distanceInteger, info, sizeof(info));

        menu.AddItem(info, info);
    }

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_Distance(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        float distance = StringToFloat(info);

        Client_SetDistance(param1, distance);
        MessageReply_ValueOfParameterFloatChanged(param1, PARAMETER_DISTANCE, distance);
        Menu_Distance(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void Menu_SpeedFactor(int client) {
    Menu menu = new Menu(MenuHandler_SpeedFactor);

    menu.SetTitle("%T", PARAMETER_SPEED_FACTOR, client);

    char info[INFO_MAX_SIZE];

    for (float speedFactor = SPEED_FACTOR_MIN; speedFactor <= SPEED_FACTOR_MAX; speedFactor += 1.0) {
        int speedFactorInteger = RoundToFloor(speedFactor);

        IntToString(speedFactorInteger, info, sizeof(info));

        menu.AddItem(info, info);
    }

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_SpeedFactor(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        float speedFactor = StringToFloat(info);

        Client_SetSpeedFactor(param1, speedFactor);
        MessageReply_ValueOfParameterFloatChanged(param1, PARAMETER_SPEED_FACTOR, speedFactor);
        Menu_SpeedFactor(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void Menu_ThrowSpeed(int client) {
    Menu menu = new Menu(MenuHandler_ThrowSpeed);

    menu.SetTitle("%T", PARAMETER_THROW_SPEED, client);

    char info[INFO_MAX_SIZE];

    for (float throwSpeed = THROW_SPEED_MIN; throwSpeed <= THROW_SPEED_MAX; throwSpeed += 500.0) {
        int throwSpeedInteger = RoundToFloor(throwSpeed);

        IntToString(throwSpeedInteger, info, sizeof(info));

        menu.AddItem(info, info);
    }

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_ThrowSpeed(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        float throwSpeed = StringToFloat(info);

        Client_SetThrowSpeed(param1, throwSpeed);
        MessageReply_ValueOfParameterFloatChanged(param1, PARAMETER_THROW_SPEED, throwSpeed);
        Menu_ThrowSpeed(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void Menu_ConeAngle(int client) {
    Menu menu = new Menu(MenuHandler_ConeAngle);

    menu.SetTitle("%T", PARAMETER_CONE_ANGLE, client);

    char info[INFO_MAX_SIZE];

    for (float coneAngle = CONE_ANGLE_MIN; coneAngle <= CONE_ANGLE_MAX; coneAngle += 5.0) {
        int coneAngleInteger = RoundToFloor(coneAngle);

        IntToString(coneAngleInteger, info, sizeof(info));

        menu.AddItem(info, info);
    }

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_ConeAngle(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        float coneAngle = StringToFloat(info);

        Client_SetConeAngle(param1, coneAngle);
        MessageReply_ValueOfParameterFloatChanged(param1, PARAMETER_CONE_ANGLE, coneAngle);
        Menu_ConeAngle(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void Menu_ConeDistance(int client) {
    Menu menu = new Menu(MenuHandler_ConeDistance);

    menu.SetTitle("%T", PARAMETER_CONE_DISTANCE, client);

    char info[INFO_MAX_SIZE];

    for (float coneDistance = CONE_DISTANCE_MIN; coneDistance <= CONE_DISTANCE_MAX; coneDistance *= 2.0) {
        int coneDistanceInteger = RoundToFloor(coneDistance);

        IntToString(coneDistanceInteger, info, sizeof(info));

        menu.AddItem(info, info);
    }

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_ConeDistance(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        float coneDistance = StringToFloat(info);

        Client_SetConeDistance(param1, coneDistance);
        MessageReply_ValueOfParameterFloatChanged(param1, PARAMETER_CONE_DISTANCE, coneDistance);
        Menu_ConeDistance(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void MenuHandler_Default(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_End) {
        delete menu;
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_Settings(param1);
    }
}

void Menu_AddItem(Menu menu, const char[] phrase, int client) {
    char item[ITEM_MAX_SIZE];

    Format(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(phrase, item);
}

void Menu_AddItemParameterInteger(Menu menu, const char[] phrase, int client, int parameterValue) {
    char item[ITEM_MAX_SIZE];

    Format(item, sizeof(item), "%T [ %d ]", phrase, client, parameterValue);

    menu.AddItem(phrase, item);
}

void Menu_AddItemParameterFloat(Menu menu, const char[] phrase, int client, float parameterValue) {
    char item[ITEM_MAX_SIZE];

    Format(item, sizeof(item), "%T [ %.2f ]", phrase, client, parameterValue);

    menu.AddItem(phrase, item);
}
