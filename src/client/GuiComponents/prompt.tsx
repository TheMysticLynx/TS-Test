/* eslint-disable prettier/prettier */
import Roact, { createRef } from "@rbxts/roact";

interface props {
	name: string;
	description: string;
	cost: string;
	usage: string;
	temp: string;
	rocoin: string;
	transparency: number;
    passback: (frame?: Frame, imagelabel?: ImageLabel, textLabel?: TextLabel) => void
}

export class Prompt extends Roact.Component<props, props> {
    frame: Roact.Ref<Frame>
    imageLabel: Roact.Ref<ImageLabel>
    textLabel: Roact.Ref<TextLabel>

    constructor(props: props) {
        super(props);
        this.frame = Roact.createRef();
        this.imageLabel = Roact.createRef();
        this.textLabel = Roact.createRef();
    }
    
    didMount() {
        this.props.passback(this.frame.getValue(), this.imageLabel.getValue(), this.textLabel.getValue());
    }

	render() {
		return (
			<frame
				Key="Prompt"
				AnchorPoint={new Vector2(0.5, 0.5)}
				BackgroundTransparency={1}
				Position={new UDim2(0.5, 0, 0.5, 0)}
				Size={new UDim2(1, 0, 1, 0)}
			>
				<frame
					AnchorPoint={new Vector2(0.5, 0.5)}
					BackgroundTransparency={1}
					Position={new UDim2(0.5, 0, 0.5, 0)}
					Size={new UDim2(0.304, 0, 0.628, 0)}
				>
					<imagelabel
						Key="Prompt"
						AnchorPoint={new Vector2(0.5, 0)}
						BackgroundTransparency={1}
						Image="rbxassetid://6760300420"
						Position={new UDim2(0.5, 0, 0, 0)}
						Size={new UDim2(1, 0, 0.619, 0)}
					>
						<textlabel
							Key="Buy"
							BackgroundTransparency={1}
							Font={Enum.Font.Roboto}
							Position={new UDim2(0, 0, 0.049, 0)}
							Size={new UDim2(1, 0, 0.116, 0)}
							Text="  Buy"
							TextColor3={Color3.fromRGB(255, 255, 255)}
							TextScaled={true}
							TextSize={14}
							TextWrapped={true}
							TextXAlignment={Enum.TextXAlignment.Left}
						/>
						<textlabel
							Key="Item Name"
							BackgroundTransparency={1}
							Font={Enum.Font.Roboto}
							Position={new UDim2(0, 0, 0.259, 0)}
							Size={new UDim2(1, 0, 0.101, 0)}
							Text={this.props.name}
							TextColor3={Color3.fromRGB(255, 255, 255)}
							TextScaled={true}
							TextSize={14}
							TextWrapped={true}
						/>
						<textlabel
							Key="Description"
							BackgroundTransparency={1}
							Font={Enum.Font.Roboto}
							Position={new UDim2(0.214, 0, 0.36, 0)}
							Size={new UDim2(0.571, 0, 0.304, 0)}
							Text={this.props.description}
							TextColor3={Color3.fromRGB(188, 188, 188)}
							TextScaled={true}
							TextSize={20}
							TextTruncate={Enum.TextTruncate.AtEnd}
							TextWrapped={true}
						/>
						<imagelabel
							AnchorPoint={new Vector2(0.5, 0.5)}
							BackgroundTransparency={1}
							Image="rbxassetid://6656675417"
							Position={new UDim2(0.2, 0, 0.727, 0)}
							Size={new UDim2(0.078, 0, 0.128, 0)}
						>
							<uiaspectratioconstraint />
						</imagelabel>
						<imagelabel
							AnchorPoint={new Vector2(0.5, 0.5)}
							BackgroundTransparency={1}
							Image="rbxassetid://6656680129"
							Position={new UDim2(0.5, 0, 0.731, 0)}
							Size={new UDim2(0.069, 0, 0.113, 0)}
						>
							<uiaspectratioconstraint />
						</imagelabel>
						<textlabel
							Key="Cost"
							BackgroundTransparency={1}
							Font={Enum.Font.Roboto}
							Position={new UDim2(0, 0, 0.929, 0)}
							Size={new UDim2(1, 0, 0.071, 0)}
							Text={this.props.cost}
							TextColor3={Color3.fromRGB(0, 255, 59)}
							TextScaled={true}
							TextSize={14}
							TextWrapped={true}
						/>
						<imagelabel
							AnchorPoint={new Vector2(0.5, 0.5)}
							BackgroundTransparency={1}
							Image="rbxassetid://6762466084"
							Position={new UDim2(0.8, 0, 0.722, 0)}
							Size={new UDim2(0.031, 0, 0.113, 0)}
						>
							<uiaspectratioconstraint AspectRatio={0.444} />
						</imagelabel>
						<textlabel
							Key="Usage"
							BackgroundTransparency={1}
							Font={Enum.Font.Roboto}
							Position={new UDim2(0.35, 0, 0.809, 0)}
							Size={new UDim2(0.3, 0, 0.071, 0)}
							Text={this.props.usage}
							TextColor3={Color3.fromRGB(195, 195, 195)}
							TextScaled={true}
							TextSize={14}
							TextWrapped={true}
						/>
						<textlabel
							Key="RoCoin"
							BackgroundTransparency={1}
							Font={Enum.Font.Roboto}
							Position={new UDim2(0.048, 0, 0.809, 0)}
							Size={new UDim2(0.3, 0, 0.071, 0)}
							Text={this.props.rocoin}
							TextColor3={Color3.fromRGB(195, 195, 195)}
							TextScaled={true}
							TextSize={14}
							TextWrapped={true}
						/>
						<textlabel
							Key="Temp"
							BackgroundTransparency={1}
							Font={Enum.Font.Roboto}
							Position={new UDim2(0.649, 0, 0.809, 0)}
							Size={new UDim2(0.3, 0, 0.071, 0)}
							Text={this.props.temp}
							TextColor3={Color3.fromRGB(195, 195, 195)}
							TextScaled={true}
							TextSize={14}
							TextWrapped={true}
						/>
					</imagelabel>
					<imagelabel
						Key="Push Button"
						AnchorPoint={new Vector2(0.5, 1)}
						BackgroundTransparency={1}
						Image="rbxassetid://6760300502"
						Position={new UDim2(0.5, 0, 1, 0)}
						Size={new UDim2(0.3, 0, 0.253, 0)}
                        Transparency={this.props.transparency}
					>
						<textlabel
							BackgroundTransparency={1}
							Font={Enum.Font.Roboto}
							Size={new UDim2(1, 0, 1, 0)}
							Text="E"
							TextColor3={Color3.fromRGB(255, 255, 255)}
							TextScaled={true}
							TextSize={14}
							TextWrapped={true}
                            Transparency={this.props.transparency}
						/>
					</imagelabel>
					<uiaspectratioconstraint AspectRatio={0.845} />
				</frame>
			</frame>
		);
	}
}
