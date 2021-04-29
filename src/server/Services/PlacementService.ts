/* eslint-disable prettier/prettier */
import { KnitServer } from "@rbxts/knit";
import ProfileService from "@rbxts/profileservice";
import { Workspace } from "@rbxts/services";
import { Profiles } from "shared/DataModule";
import { Item } from "shared/Item";
import { Placeable } from "shared/Items";
import DataService from "./DataService";

/* eslint-disable prettier/prettier */
declare global {
	interface KnitServices {
		PlacementService: typeof PlacementService;
	}
}

const PlacementService = KnitServer.CreateService({
    Name: "PlacementService",
    
    PlaceItem<T extends Placeable>(i: T, x: number, z: number, r: number, player: Player) {
        x = math.floor(x * 2) / 2
        z = math.floor(z * 2) / 2
        //Validate

        const model = i.Model.Clone();
        model.PrimaryPart = model.FindFirstChildWhichIsA("BasePart");
        model.SetPrimaryPartCFrame(new CFrame(0,0,0));
        const offset = model.PrimaryPart?.Position;

        const plotNum: number | undefined = KnitServer.Services.PlotService.getPlayerPlots().get(player.Name);
        if (plotNum === undefined) {
            return;
        }

        const plotPart = game.Workspace.Plots.FindFirstChild(tostring(plotNum))?.FindFirstChild("Spots")?.FindFirstChild("1.1") as Part;
        const yOffset = plotPart.Position.Y + (plotPart.Size.Y / 2) + (model.GetBoundingBox()[1].Y / 2);
        model.SetPrimaryPartCFrame(new CFrame(math.floor(x * 2) / 2, yOffset, math.floor(z * 2) / 2).mul(CFrame.Angles(0,math.rad(90 * r), 0)))

        if (!this.Client.ValidatePlace(player, model, r)) {
            model.Destroy()
            return
        }

        //Take from inventory
        
        //Place

        model.Parent = Workspace
    },
    
    Client: {
        placeItem<T extends Placeable>(player: Player, i: T, x: number, z: number, r: number) {
            KnitServer.Services.PlacementService.PlaceItem(i, x, z, r, player);
        },

        ValidatePlace(player: Player, model: Model, r: number): boolean {
            //make model
            const offset = model.PrimaryPart?.Position;
    
            const plotNum: number | undefined = KnitServer.Services.PlotService.getPlayerPlots().get(player.Name);
            if (plotNum === undefined) {
                return false;
            }
    
            const plotPart = game.Workspace.Plots.FindFirstChild(tostring(plotNum))?.FindFirstChild("Spots")?.FindFirstChild("1.1") as Part;
            const yOffset = plotPart.Position.Y + (plotPart.Size.Y / 2) + (model.GetBoundingBox()[1].Y / 2);

            //Check inventory
            const itemCount = Profiles.get(player)?.Data.Items.get(model.Name);
            // eslint-disable-next-line roblox-ts/lua-truthiness
            if (!itemCount) {
                return false;
            }

            const orientation = model.GetBoundingBox()[0]
            const size =  model.GetBoundingBox()[1];

            const rotation = CFrame.fromEulerAnglesYXZ(
                orientation.ToEulerAnglesYXZ()[0],
                orientation.ToEulerAnglesYXZ()[1],
                orientation.ToEulerAnglesYXZ()[2]
            )
            
            const adjustedSize = new CFrame(size).mul(rotation).Position;

            //Get 4 sides
            const sides = new Array<Vector3>(4);
            sides[0] = new Vector3(orientation.Position.X - adjustedSize.X, 0, orientation.Position.Z - adjustedSize.Z);
            sides[1] = new Vector3(orientation.Position.X + adjustedSize.X, 0, orientation.Position.Z + adjustedSize.Z);
            sides[2] = new Vector3(orientation.Position.X - adjustedSize.X, 0, orientation.Position.Z + adjustedSize.Z);
            sides[3] = new Vector3(orientation.Position.X + adjustedSize.X, 0, orientation.Position.Z - adjustedSize.Z);
            //Check that all 4 corners are in plots

            let shouldBreak = false

            sides.forEach(side => {
                let passed = false;
                DataService.GetData(player)?.Plots.forEach((value, key) => {
                    if (value === true) {
                        const part = game.Workspace.Plots.FindFirstChild(tostring(plotNum))?.FindFirstChild("Spots")?.FindFirstChild(key.split("_").join(".")) as Part;
                        part.Color = new Color3(math.random(), math.random(), math.random())
                        if(side.X > part.Position.X - (part.Size.X / 2) && side.X < part.Position.X + (part.Size.X / 2)) {
                            if (side.Z > part.Position.Z - (part.Size.Z / 2) && side.Z < part.Position.Z + (part.Size.Z / 2)) {
                                passed = true;
                            }
                        }

                    }
                })

                if (!passed) {
                    shouldBreak = true;
                    return
                }
            });

            if (shouldBreak) {
                return false;
            }

            const boundsPart = new Instance("Part");
            boundsPart.CanCollide = false;
            boundsPart.Size = size;
            boundsPart.CFrame = orientation;
            boundsPart.Parent = Workspace;
            const connection = boundsPart.Touched.Connect(function() {})
            if(boundsPart.GetTouchingParts().size() > 0) {
                return false;
            }
            connection.Disconnect();
            boundsPart.Destroy();
            return true;
        }
    }    
})

export = PlacementService;