/* eslint-disable prettier/prettier */
import Roact from "@rbxts/roact";
import DataServiceModule from "client/Modules/ClientDataService";
import { HUD } from "./Hud";
import { Inventory } from "./Inventory";

interface AppProps {

}

interface StateProps {
	HUDVisible: boolean
	InventoryVisible: boolean
}

export class App extends Roact.Component<AppProps, StateProps> {
	state = {
		HUDVisible: true,
		InventoryVisible: false,
	}
	inventoryRef: Inventory | undefined;

	constructor(props: AppProps) {
		super(props);
	}

	render() {
		return (
			<screengui ResetOnSpawn={false} Enabled={this.state.HUDVisible}>
				<HUD
					ShopButtonCallback = { () => {
						this.inventoryRef?.setVisibility(false);
					}}
					EnergyButtonCallback = { () => {
						this.inventoryRef?.setVisibility(false);
					}}
					CustomizeButtonCallback = { () => {
						this.inventoryRef?.setVisibility(false);
					}}
					SettingsButtonCallback = { () => {
						this.inventoryRef?.setVisibility(false);
					}}
					InventoryButtonCallback = { () => {
						this.inventoryRef?.setVisibility(true);
					}}
				/>
				<Inventory SetRef={ (i: Inventory) => {print(i); this.inventoryRef = i}}/>
			</screengui>
		);
	}
}
