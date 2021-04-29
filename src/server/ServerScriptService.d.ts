interface ServerScriptService extends Instance {
	TS: Folder & {
		PlotManager: ModuleScript;
		OnJoinOnLeave: Script;
		services: Folder & {
			DataService: ModuleScript;
		};
	};
}
