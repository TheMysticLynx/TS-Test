/* eslint-disable prettier/prettier */
import Roact, { Event } from "@rbxts/roact";
import ClientDataService from "client/Modules/ClientDataService";
import { ProfileTemplate } from "shared/DataModule";
import { Item } from "shared/Item";

interface props {
    item: Item;
    count: number
    previewRef: Roact.Ref<ViewportFrame>
    MouseButtonClick: () => void
}

interface state {
    selected: boolean
}

export class InventoryItem extends Roact.Component<props, state> {
	viewportRef: Roact.Ref<ViewportFrame>;
    debounce: boolean;
    
    state: state = {
        selected: false
    }

    public constructor(props: props) {
        super(props)
        this.viewportRef = Roact.createRef<ViewportFrame>();
        this.debounce = false;
    }

    didMount() {
        const camera: Camera = new Instance("Camera");
        const viewport = this.viewportRef.getValue();
        const model = this.props.item.Model.Clone();

        model.PrimaryPart = model.FindFirstChildWhichIsA("BasePart");
        model.SetPrimaryPartCFrame(new CFrame());
        model.SetPrimaryPartCFrame(new CFrame(model.GetBoundingBox()[0].Position.mul(-1)))
        model.Parent = viewport;

        if (viewport === undefined) {
            error("This is a problem.")
        }

        camera.Parent = viewport;
        viewport.CurrentCamera = camera;
        
        const zoom = model.GetBoundingBox()[1].Magnitude * .75;

        camera.CFrame = new CFrame(new Vector3(zoom, zoom, 0), new Vector3(0,0,0))
        
        spawn(function() {
            while (wait(.05)) {
                try {
                    model.SetPrimaryPartCFrame(model.GetPrimaryPartCFrame().mul(CFrame.fromEulerAnglesXYZ(0,.05,0)))
                } catch(error){
                    break
                };
            }
        })

    }

    didUpdate(pProps: props, pState: state) {
        if (pState.selected && this.state.selected) {
            this.setState({selected: false})
        }

    }

    render() {
        const BGTransparency = this.state.selected ? .5 : 1;

        if (this.state.selected) {
            const camera: Camera = new Instance("Camera");
            const viewport = this.props.previewRef.getValue();
            viewport?.ClearAllChildren();
            const model = this.props.item.Model.Clone();
    
            model.PrimaryPart = model.FindFirstChildWhichIsA("BasePart");
            model.SetPrimaryPartCFrame(new CFrame());
            model.SetPrimaryPartCFrame(new CFrame(model.GetBoundingBox()[0].Position.mul(-1)))
            model.Parent = viewport;
    
            if (viewport === undefined) {
                error("This is a problem.")
            }
    
            camera.Parent = viewport;
            viewport.CurrentCamera = camera;
            
            const zoom = model.GetBoundingBox()[1].Magnitude * .75;
    
            camera.CFrame = new CFrame(new Vector3(zoom, zoom, 0), new Vector3(0,0,0))
            
            spawn(function() {
                while (wait(.05)) {
                    try {
                        model.SetPrimaryPartCFrame(model.GetPrimaryPartCFrame().mul(CFrame.fromEulerAnglesXYZ(0,.05,0)))
                    } catch(error){
                        break
                    };
                }
            })
        }

		return (
         <imagebutton
            Key="Selection"
            BackgroundTransparency={1}
            Image="rbxassetid://6656697737"
            Size={new UDim2(0.178, 0, 0.286, 0)}
            Event = {{
                MouseButton1Click: () => {this.props.MouseButtonClick(); this.setState({selected: true})}
            }}
            
        >
            <textlabel
                Key="Count"
                BackgroundTransparency={1}
                Font={Enum.Font.SourceSans}
                Size={new UDim2(0.35, 0, 0.35, 0)}
                Text= {tostring(this.props.count)}
                TextColor3={Color3.fromRGB(255, 255, 255)}
                TextScaled={true}
                TextSize={14}
                TextStrokeTransparency={0}
                TextWrapped={true}
            />
            <viewportframe Ref={ this.viewportRef }
                BackgroundTransparency={BGTransparency}
                Position={new UDim2(0.095, 0, 0.095, 0)}
                Size={new UDim2(0.8, 0, 0.8, 0)}
            />
        </imagebutton>
		);
	}
}
