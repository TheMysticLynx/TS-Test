/* eslint-disable prettier/prettier */
import { KnitServer, RemoteProperty, RemoteSignal } from "@rbxts/knit";
import { RunService } from "@rbxts/services";
import { Profiles, ProfileTemplate } from "shared/DataModule";

declare global {
	interface KnitServices {
		DataService: typeof DataService;
	}
}

const DataService = KnitServer.CreateService({
	Name: "DataService",

    GetData: function (player: Player) {
        return Profiles.get(player)?.Data
    },
	
	Client: {
		dataChanged: new RemoteSignal<(data: ProfileTemplate) => void>(),

		GetData (player: Player) {
            return KnitServer.Services.DataService.GetData(player);
        }
	},
	
	SetPlayerData (player: Player, data: ProfileTemplate) {
		const d = Profiles.get(player);
		if (!d || !d.Data) return;
	
		d.Data = data;
	
		this.Client.dataChanged.Fire(player, data);	
	},

});

export = DataService