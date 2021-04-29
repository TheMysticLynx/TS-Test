/* eslint-disable prettier/prettier */
import { KnitServer } from "@rbxts/knit";
import DataService from "./Services/DataService";

const Services = game.GetService("ServerScriptService").FindFirstChild("TS")?.FindFirstChild("Services");

if (Services !== undefined) {
	Services.GetChildren().forEach((i: Instance) => {
		if (i.IsA("ModuleScript")) {
			require(i);
			print(i.Name)
		}
	});
}

KnitServer.Start();