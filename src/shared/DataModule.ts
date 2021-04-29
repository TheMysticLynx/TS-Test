import { KnitServer, RemoteSignal } from "@rbxts/knit";
import { GetService } from "@rbxts/knit/src/Knit/KnitClient";
import ProfileService from "@rbxts/profileservice";
import { Profile } from "@rbxts/profileservice/globals";
import type { Item } from "shared/Item";

export interface ProfileTemplate {
	Money: number;
	Items: Map<string, number>;
	Plots: Map<string, boolean>;
	//PlotData: Array<number>;
}

let ProfileStore = ProfileService.GetProfileStore<ProfileTemplate>("Data", {
	Money: 0,
	Items: new Map<string, number>([
		["Basic Fan", 1],
		["Basic Gpu", 1],
		["Basic Generator", 1],
		["Basic Rack", 1],
	]),
	Plots: new Map<string, boolean>([
		["5_10", true],
		["5_9", true],
		["6_10", true],
		["6_9", true],
	]),
	//PlotData: new Array<number>(),
});

if (game.GetService("RunService").IsStudio()) {
	ProfileStore = ProfileStore.Mock;
}

const Profiles = new Map<Player, Profile<ProfileTemplate>>();

export function initPlayer(player: Player) {
	const profile = ProfileStore.LoadProfileAsync("Player_" + player.UserId, "ForceLoad");
	if (profile) {
		profile.Reconcile();

		profile.ListenToRelease(() => {
			Profiles.delete(player);
			player.Kick("Profile was loaded in a external server. Please rejoin.");
		});

		if (player.IsDescendantOf(game.GetService("Players"))) {
			Profiles.set(player, profile);
			//Callback would go here
		} else {
			profile.Release();
		}
	} else {
		player.Kick("There was a issue loading your profile");
	}
}

export function releasePlayer(player: Player) {
	Profiles.get(player)?.Release();
	Profiles.delete(player);
}

export { Profiles };
