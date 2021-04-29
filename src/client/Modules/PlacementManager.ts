/* eslint-disable prettier/prettier */

import { KnitServer } from "@rbxts/knit";
import KnitClient, { Player } from "@rbxts/knit/src/Knit/KnitClient";
import { ContextActionService, Players, RunService, Workspace } from "@rbxts/services";
import { Item } from "shared/Item";
import { Items, Placeable } from "shared/Items";
import PlotService from "./PlotService";

const PlacementService = KnitClient.GetService("PlacementService")

let lastItem: Placeable;
let selectedPart: Model | undefined;
let regionOverlayPart: Part | undefined
let partOffset: Vector3 | undefined;
let yOffset: number;

let rotation = 0;
let placementMode = true;

export function setSelectedPart(part: Placeable) {
    lastItem = part;
    ContextActionService.BindAction("placeItem", handleAction, false, Enum.UserInputType.MouseButton1)
    ContextActionService.BindAction("storeItem", handleAction, false, Enum.KeyCode.X)
    ContextActionService.BindAction("exitPlaceMode", handleAction, false, Enum.KeyCode.C)
    ContextActionService.BindAction("rotateCW", handleAction, false, Enum.KeyCode.Q)
    ContextActionService.BindAction("rotateCCW", handleAction, false, Enum.KeyCode.E)

    //Make copy
    selectedPart?.Destroy();
    selectedPart = part.Model.Clone();
    Player.GetMouse().TargetFilter = selectedPart;
    //Strip scripts
    selectedPart.GetDescendants().forEach(element => {
        if (element.IsA("Script") || element.IsA("ModuleScript") || element.IsA("LocalScript")) {
            element.Destroy();
        } else if(element.IsA("BasePart")) {
            element.CanCollide = false;
            element.Transparency = .5;
        }
    });
    //Get offset
    selectedPart.PrimaryPart = selectedPart.FindFirstChildWhichIsA("BasePart")
    selectedPart.SetPrimaryPartCFrame(new CFrame());

    const boundingBox = selectedPart.GetBoundingBox();

    partOffset = boundingBox[0].Position.mul(-1);

    //Setup overlay part
    regionOverlayPart?.Destroy();
    regionOverlayPart = new Instance("Part");
    regionOverlayPart.Position = boundingBox[0].Position;
    regionOverlayPart.Size = boundingBox[1];
    regionOverlayPart.Color = new Color3(0, 1, 0);
    regionOverlayPart.Transparency = .5;
    regionOverlayPart.Parent = selectedPart;
    regionOverlayPart.CanCollide = false;
    selectedPart.Parent = Workspace

    print(PlotService.getPlayerPlots())
    const plotNum: number | undefined = PlotService.getPlayerPlots().get(Players.LocalPlayer.Name);
    if (plotNum === undefined) {
        return;
    }
    const plotPart = game.Workspace.Plots.FindFirstChild(tostring(plotNum))?.FindFirstChild("Spots")?.FindFirstChild("1.1") as Part;
    yOffset = plotPart.Position.Y + (plotPart.Size.Y / 2) + (boundingBox[1].Y / 2);
}

export function setPlacementMode(m: boolean) {
    placementMode = m
}

let itemPos: CFrame = new CFrame();

RunService.RenderStepped.Connect(() => {
    if (selectedPart === undefined || partOffset === undefined || placementMode === false) {
        return
    }
    const mouseHit = Players.LocalPlayer.GetMouse().Hit
    //Move model

    itemPos = new CFrame(math.floor(mouseHit.Position.X * 2) / 2, yOffset, math.floor(mouseHit.Position.Z * 2) / 2).mul(CFrame.Angles(0,math.rad(90 * rotation), 0))
    selectedPart.SetPrimaryPartCFrame(itemPos)
    //Validate
})


function handleAction(actionName: string, state: Enum.UserInputState, inputObject: InputObject): void {
    if (state !== Enum.UserInputState.Begin) {
        return
    }
    print(actionName)
    switch (actionName) {
        case "placeItem":
            print("placeitem")
            PlacementService.placeItem(lastItem, itemPos.X, itemPos.Z, rotation);
            break;
        case "storeItem":
        
            break;
        case "exitPlaceMode":
            selectedPart?.Destroy();
            selectedPart = undefined;
            regionOverlayPart?.Destroy();
            regionOverlayPart = undefined;
            ContextActionService.UnbindAction("placeItem")
            ContextActionService.UnbindAction("storeItem")
            ContextActionService.UnbindAction("exitPlaceMode")
            break
        case "rotateCW":
            print(rotation)
            rotation++
            if (rotation > 3) rotation = 0;
            break;
        case "rotateCCW":
            print(rotation)
            rotation--
            if (rotation < 0) rotation = 3;
    }
}



export {};
