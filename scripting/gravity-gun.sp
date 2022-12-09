#include <sourcemod>
#include <sdktools>

#include "gg/math"
#include "gg/message"
#include "gg/use-case"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/math.sp"
#include "modules/message.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Gravity gun",
    author = "Dron-elektron",
    description = "Allows you to manipulate players",
    version = "0.1.0",
    url = "https://github.com/dronelektron/gravity-gun"
};

public void OnPluginStart() {
    Command_Create();
    Variable_Create();
    LoadTranslations("gravity-gun.phrases");
    AutoExecConfig(true, "gravity-gun");
}

public void OnClientConnected(int client) {
    UseCase_ResetTarget(client);
}

public void OnClientDisconnect(int client) {
    UseCase_ReleasePlayer(client);
}
