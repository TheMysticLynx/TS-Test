/* eslint-disable prettier/prettier */
export class Item {
	Name: string;
	Cost: number;
	Model: Model;

	constructor(name: string, cost: number, model?: Model) {
		this.Name = name;
		this.Cost = cost;
		
		if (model) {
			this.Model = model;
		} else {
			const temp: Instance | Model | undefined = game.GetService("ReplicatedStorage").FindFirstChild("Models")?.FindFirstChild(name);
			if(temp) {
				assert(temp.IsA("Model"), "No model found for: " + name);
				this.Model = temp
			}
			else {
				error("No model found for: " + name);
			}
		}
		
	}
}
