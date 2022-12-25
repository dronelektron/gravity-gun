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

void MessagePrint_DistanceChanged(int client, float distance) {
    PrintToChat(client, "%s%t", PREFIX, "Distance changed", distance);
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
