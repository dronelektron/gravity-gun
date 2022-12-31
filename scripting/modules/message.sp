void MessagePrint_PlayerNotFound(int client) {
    PrintToChat(client, "%s%t", PREFIX, "Player not found");
}

void MessagePrint_InvalidObserverMode(int client) {
    PrintToChat(client, "%s%t", PREFIX, "Invalid observer mode");
}

void MessagePrint_PlayerAlreadyCaptured(int client, int target, int owner) {
    PrintToChat(client, "%s%t", PREFIX, "Player already captured", target, owner);
}

void MessagePrint_YouCannotCaptureOwner(int client, int target) {
    PrintToChat(client, "%s%t", PREFIX, "You cannot capture owner", target);
}

void MessagePrint_TargetHasImmunity(int client, int target) {
    PrintToChat(client, "%s%t", PREFIX, "Target has immunity", target);
}

void MessagePrint_NoPlayerToThrow(int client) {
    PrintToChat(client, "%s%t", PREFIX, "No player to throw");
}

void Message_PlayerCaptured(int client, int target) {
    if (Variable_ShowActivity()) {
        ShowActivity2(client, PREFIX, "%t", "Player captured", target);
    } else {
        PrintToChat(client, "%s%t", PREFIX, "Player captured", target);
    }

    LogMessage("\"%L\" captured \"%L\"", client, target);
}

void Message_PlayerReleased(int client, int target) {
    if (Variable_ShowActivity()) {
        ShowActivity2(client, PREFIX, "%t", "Player released", target);
    } else {
        PrintToChat(client, "%s%t", PREFIX, "Player released", target);
    }

    LogMessage("\"%L\" released \"%L\"", client, target);
}

void Message_PlayerThrown(int client, int target, float speed) {
    if (Variable_ShowActivity()) {
        ShowActivity2(client, PREFIX, "%t", "Player thrown", target, speed);
    } else {
        PrintToChat(client, "%s%t", PREFIX, "Player thrown", target, speed);
    }

    LogMessage("\"%L\" threw \"%L\" at a speed of %.2f u/s", client, target, speed);
}

void MessageReply_ValueOfParameterInteger(int client, const char[] parameter, int value) {
    char valueString[PARAMETER_VALUE_MAX_SIZE];

    IntToString(value, valueString, sizeof(valueString));
    MessageReply_ValueOfParameter(client, parameter, valueString);
}

void MessageReply_ValueOfParameterFloat(int client, const char[] parameter, float value) {
    char valueString[PARAMETER_VALUE_MAX_SIZE];

    Format(valueString, sizeof(valueString), "%.2f", value);
    MessageReply_ValueOfParameter(client, parameter, valueString);
}

void MessageReply_ValueOfParameter(int client, const char[] parameter, const char[] value) {
    ReplyToCommand(client, "%s%t", PREFIX, "Value of parameter", parameter, value);
}

void MessageReply_ValueOfParameterIntegerChanged(int client, const char[] parameter, int value) {
    char valueString[PARAMETER_VALUE_MAX_SIZE];

    IntToString(value, valueString, sizeof(valueString));
    MessageReply_ValueOfParameterChanged(client, parameter, valueString);
}

void MessageReply_ValueOfParameterFloatChanged(int client, const char[] parameter, float value) {
    char valueString[PARAMETER_VALUE_MAX_SIZE];

    Format(valueString, sizeof(valueString), "%.2f", value);
    MessageReply_ValueOfParameterChanged(client, parameter, valueString);
}

void MessageReply_ValueOfParameterChanged(int client, const char[] parameter, const char[] value) {
    ReplyToCommand(client, "%s%t", PREFIX, "Value of parameter changed", parameter, value);
}
