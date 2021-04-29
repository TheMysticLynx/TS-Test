/* eslint-disable prettier/prettier */
import { KnitServer, RemoteProperty, RemoteSignal } from "@rbxts/knit";

const Plots: Array<boolean> = new Array<boolean>(10, false);

declare global {
	interface KnitServices {
		PlotService: typeof PlotService;
	}
}

const PlotService = KnitServer.CreateService({
	Name: "PlotService",

	PlayerPlots: new Map<string, number>(),

	getPlayerPlots() {
		return KnitServer.Services.PlotService.PlayerPlots;
	},

	assignPlot(player: Player) {
		for (let i = 0; i < Plots.size(); i++) {
			if (Plots[i] === false) {
				this.PlayerPlots.set(player.Name, i);
				Plots[i] = true;
				return;
			}
		}
		print(Plots)
		player.Kick("A error occured while assigning a plot...");
	},

	unassignPlot(player: Player) {
		const plot = this.PlayerPlots.get(player.Name);
	
		if (plot !== undefined) {
			Plots[plot] = false;
			this.PlayerPlots.delete(player.Name);
		}
	},

	Client: {
		getPlayerPlots() {
			return KnitServer.Services.PlotService.getPlayerPlots();
		}
	}
});

export = PlotService