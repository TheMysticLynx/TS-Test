import { KnitServer } from "@rbxts/knit";
import * as DataModule from "shared/DataModule";

game.GetService("Players").PlayerAdded.Connect((player: Player) => {
	DataModule.initPlayer(player);
	KnitServer.Services.PlotService.assignPlot(player);

	const plot = KnitServer.Services.PlotService.getPlayerPlots().get(player.Name);

	if (plot === undefined) {
		player.Kick("Error assigning plot.");
		return;
	}

	//#region Set Spawn
	// eslint-disable-next-line prettier/prettier
	const respawn: SpawnLocation | undefined | Instance = game.Workspace.Plots.FindFirstChild(tostring(plot))?.FindFirstChild("Spawn");
	print(respawn?.Parent?.Name);
	if (respawn?.IsA("SpawnLocation")) {
		player.RespawnLocation = respawn;
		respawn.Color = new Color3(math.random(), math.random(), math.random());
	}
	//#endregion

	//Populate Inventory

	//#region Plot Loading
	//TODO: Plot Loading
	//#endregion
	const d = DataModule.Profiles.get(player)?.Data;
	if (!d || !player) {
		return;
	}

	KnitServer.Services.DataService.SetPlayerData(player, d);
});

game.GetService("Players").PlayerRemoving.Connect((player: Player) => {
	DataModule.releasePlayer(player);
	KnitServer.Services.PlotService.unassignPlot(player);
});
