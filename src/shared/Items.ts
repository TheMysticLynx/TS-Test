/* eslint-disable prettier/prettier */
import { Item } from "shared/Item";

export class Placeable extends Item {}
export class Equipable extends Item {}

export class Rack extends Placeable {}
export class Decoration extends Placeable {}
export class Utility extends Placeable {}

export class Fan extends Equipable {
    CoolingPower: number;

    constructor(name: string, cost: number, coolingPower: number, model?: Model) {
        super(name, cost, model)
        this.CoolingPower = coolingPower
    }
}

export class Gpu extends Equipable {
    RoCoinPerSec: number;
    PowerUsage: number;

    constructor(name: string, cost: number, powerUsage: number, roCoinPerSec: number, model?: Model) {
        super(name, cost, model)
        this.PowerUsage = powerUsage
        this.RoCoinPerSec = roCoinPerSec
    }
}

const ItemsMap = new Map<string, Item>()

function NewItem(item: Item) {
    ItemsMap.set(item.Name, item)
}

NewItem(new Decoration("Noob", 100000000))
NewItem(new Utility("Basic Generator", 100))
NewItem(new Rack("Basic Rack", 100))
NewItem(new Fan("Basic Fan", 100, 10))
NewItem(new Gpu("Basic Gpu", 100, 100, 1))

export { ItemsMap as Items }