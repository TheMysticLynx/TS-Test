/* eslint-disable prettier/prettier */
import { Players } from "@rbxts/services";
import Roact from '@rbxts/roact';
import { App } from "./GuiComponents/App";

const playerGui = Players.LocalPlayer.FindFirstChild("PlayerGui") as PlayerGui;

Roact.mount(<App/>, playerGui, "RoactGUI");

/*
export function f<T extends Item>(player: Player, myClass: { new (): T, prototype: T }) {
	Items.forEach((element) => {
        print(element.Name)
		if (element instanceof myClass) {
			//Generate UI item
            const count = Profiles.get(player)?.Data.Items.get(element.Name)
            if (count === undefined) error("No profile")
            
            if (count > 0) {

            }
		}
	});
}
*/