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

void Message_PlayerCaptured(int client, int target) {
    ShowActivity2(client, PREFIX, "%t", "Player captured", target);
    LogMessage("\"%L\" captured \"%L\"", client, target);
}

void Message_PlayerReleased(int client, int target) {
    ShowActivity2(client, PREFIX, "%t", "Player released", target);
    LogMessage("\"%L\" released \"%L\"", client, target);
}
