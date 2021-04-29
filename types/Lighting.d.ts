interface Lighting extends Instance {
	InventoryItem: ImageButton & {
		ViewportFrame: ViewportFrame;
	};
	Sky: Sky;
	Bloom: BloomEffect;
	["Workspace.d.ts"]: Script & {
		["Workspace.d.ts2"]: Script;
	};
	["Don'tDelete"]: ScreenGui & {
		Leaderboard: Frame & {
			UIAspectRatioConstraint: UIAspectRatioConstraint;
			ScrollingFrame: ScrollingFrame & {
				UIListLayout: UIListLayout;
				UIAspectRatioConstraint: UIAspectRatioConstraint;
				ImageLabel: ImageLabel & {
					Username: TextLabel;
					RoCoins: TextLabel;
					Level: TextLabel;
					CryptoBucks: TextLabel;
					Cash: TextLabel;
				};
			};
			ImageLabel: ImageLabel & {
				UIAspectRatioConstraint: UIAspectRatioConstraint;
			};
		};
		InventoryFrame: Frame & {
			GpuSort: ImageButton;
			DeleteItem: ImageButton;
			UIAspectRatioConstraint: UIAspectRatioConstraint;
			FanSort: ImageButton;
			MoveItem: ImageButton;
			GPURackSort: ImageButton;
			Frame: ImageLabel & {
				GpuName: TextLabel;
				UIAspectRatioConstraint: UIAspectRatioConstraint;
				["Btc/s"]: TextLabel;
				TextLabel: TextLabel;
				Price: TextLabel;
				["W/s"]: TextLabel;
				ScrollingFrame: ScrollingFrame & {
					UIGridLayout: UIGridLayout;
					Selection: ImageButton & {
						ViewportFrame: ViewportFrame;
					};
				};
				ExitButton: TextButton;
			};
			UtilitiesSort: ImageButton;
			DecorSort: ImageButton;
		};
		RocoinExchange: Frame & {
			ImageLabel: ImageLabel & {
				ImageButton: ImageButton;
				Percentage: TextLabel;
				Rate: TextLabel;
				ExitButton: TextButton;
			};
		};
		LoadingScreen: Frame & {
			LoadingLogo: ImageLabel;
		};
		CustomizeFrame: Frame & {
			["Colour Selector"]: Frame & {
				LocalScript: LocalScript & {
					dragger: ModuleScript;
				};
				Colour: Frame;
				Wheel: ImageLabel & {
					Ring: ImageLabel;
				};
				Slider: ImageLabel & {
					Slide: Frame;
				};
			};
			Current: TextLabel;
			Frame: ImageLabel & {
				ExitButton: TextButton;
			};
			Selected: TextLabel;
			UIAspectRatioConstraint: UIAspectRatioConstraint;
			SetColor: ImageLabel;
		};
		ShopScroll: Frame & {
			Center: ImageButton & {
				Price: TextLabel;
			};
			UIAspectRatioConstraint: UIAspectRatioConstraint;
			Right: ImageButton;
			Left: ImageButton;
			Buy: ImageButton;
		};
		EnergyFrame: Frame & {
			Frame: ImageLabel & {
				ExitButton: TextButton;
			};
		};
		TutorialFrame: Frame & {
			Frame: ImageLabel & {
				ExitButton: TextButton;
			};
			UIAspectRatioConstraint: UIAspectRatioConstraint;
			Label: TextLabel;
		};
		SettingsFrame: Frame & {
			ImageLabel: ImageLabel & {
				SettingType: ImageLabel & {
					TextLabel: TextLabel;
					ImageButton: ImageButton;
				};
				StatType: ImageLabel;
				ExitButton: TextButton;
			};
		};
		HUD: Frame & {
			LevelBar: ImageLabel & {
				UIAspectRatioConstraint: UIAspectRatioConstraint;
				TextLabel: TextLabel;
				ImageLabel: ImageLabel;
			};
			Sidebar: ImageLabel & {
				SettingsButton: ImageButton;
				InventoryButton: ImageButton;
				UIAspectRatioConstraint: UIAspectRatioConstraint;
				CustomizeButton: ImageButton;
				EnergyButton: ImageButton;
				ShopButton: ImageButton;
			};
		};
	};
	ColorCorrection: ColorCorrectionEffect;
}
