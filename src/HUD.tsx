import Roact from "@rbxts/roact";

interface UiProps {
	InventoryButtonCallback: () => void;
	EnergyButtonCallback: () => void;
	ShopButtonCallback: () => void;
	SettingsButtonCallback: () => void;
	CustomizeButtonCallback: () => void;
}

interface UiState {
	levelBarFill: number;
}

export class HUD extends Roact.Component<UiProps, UiState> {
	state: UiState = {
		levelBarFill: 0,
	};

	render() {
		return (
			<frame Key="HUD" BackgroundTransparency={1} Size={new UDim2(1, 0, 1, 0)}>
				<imagelabel
					Key="Sidebar"
					AnchorPoint={new Vector2(1, 0.5)}
					BackgroundTransparency={1}
					Image="rbxassetid://6656522487"
					Position={new UDim2(1, 0, 0.5, 0)}
					Size={new UDim2(0.072, 0, 0.477, 0)}
				>
					<imagebutton
						Key="InventoryButton"
						BackgroundTransparency={1}
						Image="rbxassetid://6656525961"
						Position={new UDim2(0.171, 0, 0.045, 0)}
						Size={new UDim2(0.654, 0, 0.161, 0)}
						Event={{
							MouseButton1Click: this.props.InventoryButtonCallback,
						}}
					/>
					<imagebutton
						Key="EnergyButton"
						BackgroundTransparency={1}
						Image="rbxassetid://6656527057"
						Position={new UDim2(0.171, 0, 0.232, 0)}
						Size={new UDim2(0.654, 0, 0.161, 0)}
						Event={{
							MouseButton1Click: this.props.EnergyButtonCallback,
						}}
					/>
					<imagebutton
						Key="ShopButton"
						BackgroundTransparency={1}
						Image="rbxassetid://6656528700"
						Position={new UDim2(0.171, 0, 0.422, 0)}
						Size={new UDim2(0.654, 0, 0.161, 0)}
						Event={{
							MouseButton1Click: this.props.ShopButtonCallback,
						}}
					/>
					<imagebutton
						Key="SettingsButton"
						BackgroundTransparency={1}
						Image="rbxassetid://6656531850"
						Position={new UDim2(0.171, 0, 0.792, 0)}
						Size={new UDim2(0.654, 0, 0.161, 0)}
						Event={{
							MouseButton1Click: this.props.SettingsButtonCallback,
						}}
					/>
					<imagebutton
						Key="CustomizeButton"
						BackgroundTransparency={1}
						Image="rbxassetid://6656531008"
						Position={new UDim2(0.171, 0, 0.608, 0)}
						Size={new UDim2(0.654, 0, 0.161, 0)}
						Event={{
							MouseButton1Click: this.props.CustomizeButtonCallback,
						}}
					/>
					<uiaspectratioconstraint AspectRatio={0.263} />
				</imagelabel>
				<imagelabel
					Key="LevelBar"
					AnchorPoint={new Vector2(0.5, 1)}
					BackgroundTransparency={1}
					Image="rbxassetid://6656537672"
					Position={new UDim2(0.5, 0, 1, -15)}
					Size={new UDim2(0.319, 0, 0.017, 0)}
				>
					<imagelabel
						BackgroundTransparency={1}
						Image="rbxassetid://6656538559"
						Position={new UDim2(0, 0, -0.057, 0)}
						Size={new UDim2(this.state.levelBarFill, 0, 1.067, 0)}
					/>
					<textlabel
						BackgroundTransparency={1}
						Font={Enum.Font.SourceSansBold}
						Position={new UDim2(0.381, 0, -2.633, 0)}
						Size={new UDim2(0.24, 0, 2, 0)}
						Text="Level 1"
						TextColor3={Color3.fromRGB(255, 255, 255)}
						TextScaled={true}
						TextSize={14}
						TextWrapped={true}
					/>
					<uiaspectratioconstraint AspectRatio={33.933} />
				</imagelabel>
			</frame>
		);
	}
}
/*
<frame Key="HUD" BackgroundTransparency={1} Size={new UDim2(1, 0, 1, 0)}>
	<imagelabel
		Key="Sidebar"
		AnchorPoint={new Vector2(1, 0.5)}
		BackgroundTransparency={1}
		Image="rbxassetid://6656522487"
		Position={new UDim2(1, 0, 0.5, 0)}
		Size={new UDim2(0.072, 0, 0.477, 0)}
	>
		<imagebutton
			Key="InventoryButton"
			BackgroundTransparency={1}
			Image="rbxassetid://6656525961"
			Position={new UDim2(0.171, 0, 0.045, 0)}
			Size={new UDim2(0.654, 0, 0.161, 0)}
		/>
		<imagebutton
			Key="EnergyButton"
			BackgroundTransparency={1}
			Image="rbxassetid://6656527057"
			Position={new UDim2(0.171, 0, 0.232, 0)}
			Size={new UDim2(0.654, 0, 0.161, 0)}
		/>
		<imagebutton
			Key="ShopButton"
			BackgroundTransparency={1}
			Image="rbxassetid://6656528700"
			Position={new UDim2(0.171, 0, 0.422, 0)}
			Size={new UDim2(0.654, 0, 0.161, 0)}
		/>
		<imagebutton
			Key="SettingsButton"
			BackgroundTransparency={1}
			Image="rbxassetid://6656531850"
			Position={new UDim2(0.171, 0, 0.792, 0)}
			Size={new UDim2(0.654, 0, 0.161, 0)}
		/>
		<imagebutton
			Key="CustomizeButton"
			BackgroundTransparency={1}
			Image="rbxassetid://6656531008"
			Position={new UDim2(0.171, 0, 0.608, 0)}
			Size={new UDim2(0.654, 0, 0.161, 0)}
		/>
		<uiaspectratioconstraint AspectRatio={0.263} />
	</imagelabel>
	<imagelabel
		Key="LevelBar"
		AnchorPoint={new Vector2(0.5, 1)}
		BackgroundTransparency={1}
		Image="rbxassetid://6656537672"
		Position={new UDim2(0.5, 0, 1, -15)}
		Size={new UDim2(0.319, 0, 0.017, 0)}
	>
		<imagelabel
			BackgroundTransparency={1}
			Image="rbxassetid://6656538559"
			Position={new UDim2(0, 0, -0.057, 0)}
			Size={new UDim2(0, 0, 1.067, 0)}
		/>
		<textlabel
			BackgroundTransparency={1}
			Font={Enum.Font.SourceSansBold}
			Position={new UDim2(0.381, 0, -2.633, 0)}
			Size={new UDim2(0.24, 0, 2, 0)}
			Text="Level 1"
			TextColor3={Color3.fromRGB(255, 255, 255)}
			TextScaled={true}
			TextSize={14}
			TextWrapped={true}
		/>
		<uiaspectratioconstraint AspectRatio={33.933} />
	</imagelabel>
</frame>;
*/
