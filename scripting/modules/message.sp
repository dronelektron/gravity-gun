void MessagePrint_PlayerNotFound(int client) {
    PrintToChat(client, "%s%t", PREFIX, "Player not found");
}

void Message_PlayerCaptured(int client, int target) {
    ShowActivity2(client, PREFIX, "%t", "Player captured", target);
    LogMessage("\"%L\" captured \"%L\"", client, target);
}

void Message_PlayerReleased(int client, int target) {
    ShowActivity2(client, PREFIX, "%t", "Player released", target);
    LogMessage("\"%L\" released \"%L\"", client, target);
}
