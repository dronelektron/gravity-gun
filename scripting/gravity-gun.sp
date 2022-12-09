#include <sourcemod>
#include <sdktools>

#include "gg/math"
#include "gg/message"
#include "gg/use-case"

#include "modules/client.sp"
#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/math.sp"
#include "modules/message.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Gravity gun",
    author = "Dron-elektron",
    description = "Allows you to manipulate players",
    version = "1.0.0",
    url = "https://github.com/dronelektron/gravity-gun"
};

public void OnPluginStart() {
    Command_Create();
    Variable_Create();
    HookEvent("dod_round_start", Event_RoundStart);
    LoadTranslations("gravity-gun.phrases");
    AutoExecConfig(true, "gravity-gun");
}

public void OnClientConnected(int client) {
    Client_Reset(client);
}

public void OnClientDisconnect(int client) {
    UseCase_ReleaseTarget(client);
    UseCase_ReleaseFromOwner(client);
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_ReleaseAllTargets();
}
