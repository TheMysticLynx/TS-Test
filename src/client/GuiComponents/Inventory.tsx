/* eslint-disable prettier/prettier */
import { each } from "@rbxts/knit/src/Knit/Util/Promise";
import Roact, { Element } from "@rbxts/roact";
import ClientDataService from "client/Modules/ClientDataService";
import { setPlacementMode, setSelectedPart } from "client/Modules/PlacementManager";
import { ProfileTemplate } from "shared/DataModule";
import { Item } from "shared/Item";
import { Decoration, Fan, Gpu, Items, Placeable, Rack, Utility } from "shared/Items";
import { InventoryItem } from "./InventoryItem"

type Constructor<T extends Item> = { new (...args: never): T, prototype: T };

interface props {
    SetRef: (i: Inventory) => void
}

interface state {
    show: boolean
    BtcSText: number
    PowerUsageText: number
    SellPriceText: number
    ItemName: string
    SortClass: Constructor<Item>
	Inventory?: Map<string, number>
}

export class Inventory extends Roact.Component<props, state> {
	state: state = {
        show: false,
        BtcSText: 0,
        PowerUsageText: 0,
        SellPriceText: 0,
        ItemName: "N/A",
        SortClass: Item,
		Inventory: ClientDataService.GetData()?.Items 
    }
    viewPortRef: Roact.Ref<ViewportFrame>;
    
    setVisibility(v: boolean) {
        this.setState({show: v})
    }

    getItems<T extends Item>( myClass: Constructor<T>) {
        const items: Array<{i: Item, c: number}> = new Array<{i: Item, c: number}>();

        Items.forEach((v: Item) => {

            const count = this.state.Inventory?.get(v.Name)

            if(v instanceof myClass &&  count !== undefined && count > 0) {
                items.push({i: v, c: count});
            }
        });

        return items;
    }

    didMount() {
        this.props.SetRef(this);

		ClientDataService.dataChanged.Connect((d: ProfileTemplate) => {
            this.setState({Inventory: d.Items})
        });
    }

    constructor(props: props) {
        super(props);
        this.viewPortRef = Roact.createRef();
    }

    render() {
        const ItemFrames = new Array<Element>();

        this.getItems(this.state.SortClass).forEach(v => {
            const newState = {
                BtcSText: 0,
                PowerUsageText: 0,
                SellPriceText: v.i.Cost * .75,
                ItemName: v.i.Name,
            }
            if (v instanceof Gpu) {
                newState.BtcSText = v.RoCoinPerSec;
                newState.PowerUsageText = v.PowerUsage
            }

            ItemFrames.push(
                <InventoryItem
                    count={v.c}
                    Key={v.i.Name}
                    item={v.i} 
                    previewRef={this.viewPortRef}
                    MouseButtonClick = {() => {
                        this.setState(newState);
						if(v.i instanceof Placeable) {
							setSelectedPart(v.i)
						}
                    }}
                />
            )
        });


		return (
			<frame
				Key="InventoryFrame"
				AnchorPoint={new Vector2(0.5, 0.5)}
				BackgroundTransparency={1}
				Position={new UDim2(0.5, 0, 0.5, 0)}
				Size={new UDim2(1, 0, 1, 0)}
                Visible={this.state.show}
            >
				<imagelabel
					Key="Frame"
					BackgroundTransparency={1}
					Image="rbxassetid://6656665774"
					Position={new UDim2(0.246, 0, 0.242, 0)}
					Size={new UDim2(0.507, 0, 0.517, 0)}
				>
                    <imagelabel
                        Key="Preview"
                        BackgroundTransparency={1}
                        Image="rbxassetid://6656697737"
                        Position={new UDim2(0.04, 0, 0.185, 0)}
                        Size={new UDim2(0.178, 0, 0.286, 0)}
                    >
                        <viewportframe
                            Ref={this.viewPortRef}
                            Key="1"
                            BackgroundTransparency={1}
                            Position={new UDim2(0.095, 0, 0.095, 0)}
                            Size={new UDim2(0.8, 0, 0.8, 0)}
                        />
                    </imagelabel>

					<textbutton
						Key="ExitButton"
						BackgroundTransparency={1}
						Font={Enum.Font.SourceSans}
						Position={new UDim2(0.935, 0, 0.037, 0)}
						Size={new UDim2(0.044, 0, 0.072, 0)}
						Text="X"
						TextColor3={Color3.fromRGB(255, 255, 255)}
						TextScaled={true}
						TextSize={14}
						TextStrokeColor3={Color3.fromRGB(255, 255, 255)}
						TextWrapped={true}
                        Event={
                            {
                                MouseButton1Click: () => {this.setVisibility(false)}
                            }
                        }
					/>
					<textlabel
						Key="GpuName"
						BackgroundTransparency={1}
						Font={Enum.Font.SourceSans}
						Position={new UDim2(0.06, 0, 0.545, 0)}
						Size={new UDim2(0.132, 0, 0.043, 0)}
						Text= {this.state.ItemName}
						TextColor3={Color3.fromRGB(255, 255, 255)}
						TextScaled={true}
						TextSize={14}
						TextWrapped={true}
					/>
					<imagelabel
						BackgroundTransparency={1}
						Image="rbxassetid://6656675417"
						Position={new UDim2(0.036, 0, 0.607, 0)}
						Size={new UDim2(0.033, 0, 0.058, 0)}
					/>
					<textlabel
						Key="Btc/s"
						BackgroundTransparency={1}
						Font={Enum.Font.SourceSans}
						Position={new UDim2(0.079, 0, 0.607, 0)}
						Size={new UDim2(0.105, 0, 0.058, 0)}
						Text= {tostring(this.state.BtcSText)}
						TextColor3={Color3.fromRGB(255, 255, 255)}
						TextScaled={true}
						TextSize={14}
						TextWrapped={true}
						TextXAlignment={Enum.TextXAlignment.Left}
					/>
					<textlabel
						Key="W/s"
						BackgroundTransparency={1}
						Font={Enum.Font.SourceSans}
						Position={new UDim2(0.079, 0, 0.681, 0)}
						Size={new UDim2(0.105, 0, 0.058, 0)}
						Text= {tostring(this.state.PowerUsageText)}
						TextColor3={Color3.fromRGB(255, 255, 255)}
						TextScaled={true}
						TextSize={14}
						TextWrapped={true}
						TextXAlignment={Enum.TextXAlignment.Left}
					/>
					<imagelabel
						BackgroundTransparency={1}
						Image="rbxassetid://6656680129"
						Position={new UDim2(0.041, 0, 0.681, 0)}
						Size={new UDim2(0.024, 0, 0.058, 0)}
					/>
					<imagebutton
                    //Sell
						BackgroundTransparency={1}
						Image="rbxassetid://6656685771"
						Position={new UDim2(0.042, 0, 0.822, 0)}
						Size={new UDim2(0.167, 0, 0.043, 0)}
					/>
					<imagebutton
                    //Sell All
						BackgroundTransparency={1}
						Image="rbxassetid://6656686528"
						Position={new UDim2(0.042, 0, 0.875, 0)}
						Size={new UDim2(0.167, 0, 0.043, 0)}
					/>
					<textlabel
						BackgroundTransparency={1}
						Font={Enum.Font.SourceSans}
						Position={new UDim2(0.042, 0, 0.764, 0)}
						Size={new UDim2(0.087, 0, 0.058, 0)}
						Text="Sell for"
						TextColor3={Color3.fromRGB(255, 255, 255)}
						TextScaled={true}
						TextSize={14}
						TextWrapped={true}
						TextXAlignment={Enum.TextXAlignment.Left}
					/>
					<textlabel
						Key="Price"
						BackgroundTransparency={1}
						Font={Enum.Font.SourceSans}
						Position={new UDim2(0.131, 0, 0.764, 0)}
						Size={new UDim2(0.078, 0, 0.058, 0)}
						Text= {tostring(this.state.SellPriceText)}
						TextColor3={Color3.fromRGB(45, 220, 53)}
						TextScaled={true}
						TextSize={14}
						TextWrapped={true}
						TextXAlignment={Enum.TextXAlignment.Left}
					/>
					<scrollingframe
						Active={true}
						BackgroundTransparency={1}
						Position={new UDim2(0.271, 0, 0.187, 0)}
						Size={new UDim2(0.694, 0, 0.745, 0)}
					>
                        {ItemFrames}
						<uigridlayout CellPadding={new UDim2(0, 10, 0, 10)} SortOrder={Enum.SortOrder.LayoutOrder} />
					</scrollingframe>
					<uiaspectratioconstraint AspectRatio={1.721} />
				</imagelabel>
				<imagebutton
					Key="GpuSort"
					BackgroundTransparency={1}
					Image="rbxassetid://6656769850"
					Position={new UDim2(0.196, 0, 0.316, 0)}
					Size={new UDim2(0.045, 0, 0.083, 0)}
                    Event = {{
                        MouseButton1Click: () => {
                            this.setState({SortClass: Gpu})
                        }
                    }}
				/>
				<imagebutton
					Key="FanSort"
					BackgroundTransparency={1}
					Image="rbxassetid://6656770262"
					Position={new UDim2(0.196, 0, 0.409, 0)}
					Size={new UDim2(0.045, 0, 0.083, 0)}
                    Event = {{
                        MouseButton1Click: () => {
                            this.setState({SortClass: Fan})
                        }
                    }}
				/>
				<imagebutton
					Key="DecorSort"
					BackgroundTransparency={1}
					Image="rbxassetid://6656770949"
					Position={new UDim2(0.196, 0, 0.588, 0)}
					Size={new UDim2(0.045, 0, 0.083, 0)}
                    Event = {{
                        MouseButton1Click: () => {
                            this.setState({SortClass: Decoration})
                        }
                    }}
				/>
				<imagebutton
					Key="GPURackSort"
					BackgroundTransparency={1}
					Image="rbxassetid://6656770631"
					Position={new UDim2(0.196, 0, 0.499, 0)}
					Size={new UDim2(0.045, 0, 0.083, 0)}
                    Event = {{
                        MouseButton1Click: () => {
                            this.setState({SortClass: Rack})
                        }
                    }}
				/>
				<imagebutton
					Key="UtilitiesSort"
					BackgroundTransparency={1}
					Image="rbxassetid://6656771159"
					Position={new UDim2(0.196, 0, 0.675, 0)}
					Size={new UDim2(0.045, 0, 0.083, 0)}
                    Event = {{
                        MouseButton1Click: () => {
                            this.setState({SortClass: Utility})
                        }
                    }}
				/>
				<uiaspectratioconstraint AspectRatio={1.754} />
				<imagebutton
					Key="DeleteItem"
					BackgroundTransparency={1}
					Image="rbxassetid://6661547244"
					Position={new UDim2(0.506, 0, 0.767, 0)}
					Size={new UDim2(0.1, 0, 0.045, 0)}
				/>
				<imagebutton
					Key="MoveItem"
					BackgroundTransparency={1}
					Image="rbxassetid://6661548573"
					Position={new UDim2(0.396, 0, 0.767, 0)}
					Size={new UDim2(0.1, 0, 0.045, 0)}
				/>
			</frame>
		);
	}
}
