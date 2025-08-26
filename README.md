# FreeFireAimAssist

Features:

* **Aimbot**: Simulates auto-aim by detecting targets within a configurable field of view (FOV), with adjustable delay.
* **Speed Boost**: Simulates fast key presses (e.g., shift) for accelerated movement.
* **Simulated Noclip**: Detects and avoids obstacles through movement simulation.
* **Fly Macros**: Simulates high jumps for vertical movement.
* **Configuration GUI**: Rayfield interface to adjust FOV, delay, and toggles.
* **Optional Logging**: Sends logs to a webhook (e.g., Discord) to monitor actions.
* **Safety Limits**: Limits detections per frame and includes robust error handling.
* **Key Control**: Stops the script with the ESC key.

## Requirements:

* **Lua Executor**: Use an executor such as AndroLua, LuaExecutor, or another compatible with emulators (e.g., BlueStacks).
* **Environment Setup**: An emulator such as BlueStacks running Free Fire, with a Lua executor that supports touch/mouse simulation.
* **Libraries**: Rayfield for GUI (automatically loaded via HttpGet). HttpService required for logging (enable it in the emulator if applicable).
* **Image Integration**: Target/obstacle detection is simulated; for real usage, integrate with an emulator API that supports image processing (e.g., OpenCV plugin).

## Installation:

* **Create a GitHub Repository (optional for versioning):**
  Go to github.com and create a new repository named "FreeFireAimAssist".
  Clone the repo to your PC:

  ```bash
  git clone https://github.com/hygark/FreeFireAimAssist.git
  ```

## Add the Script:

Copy the content of `FreeFireAimAssist.lua` into a Lua file in your executor.

## Configuration in Executor:

Use a Lua executor compatible with your emulator (e.g., AndroLua on BlueStacks).

## Load the script via:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/hygark/FreeFireAimAssist/main/FreeFireAimAssist.lua"))()
```

Enable HttpService in the emulator if using webhook logging.

## How to Make It Work?:

* **Adjust Settings:**
  Open the script and edit the `Settings` table:

  * AimbotFOV: Aim field of view (default: 100 pixels).
  * AimbotDelay: Delay between taps (default: 0.1 seconds).
  * TargetColor: Target color (simulated, default: "Red").
  * SpeedBoostKey: Key for speed (default: "LeftShift").
  * SpeedBoostInterval: Interval between presses (default: 0.05 seconds).
  * NoclipSensitivity: Obstacle sensitivity (default: 50 pixels).
  * FlyJumpKey: Key for fly (default: "Space").
  * FlyHeight: Jump height (default: 200 pixels).
  * LogWebhook: Discord webhook URL (create in Discord > Server Settings > Integrations).
  * MaxDetections: Maximum targets per frame (default: 5).
  * GuiEnabled: Enable GUI (default: true).

## Run the Script:

* In the executor: load and run the script.
* If `GuiEnabled` is true, a Rayfield GUI will open.
* Use the GUI to toggle aimbot, speed boost, and fly, or adjust settings.

## Test:

* Open Free Fire in an emulator with the executor.
* The script will simulate taps for aiming, presses for speed, and jumps for fly.
* Monitor the console or webhook for logs (e.g., "Simulated tap at (x, y)").

## Stop the Script:

Press **ESC** to stop the script or use the toggle in the GUI.

## Usage Examples:

* **Basic Test**: Run in an emulator with Free Fire. Aimbot will simulate taps on targets within the FOV, speed boost will trigger quick presses, noclip will avoid obstacles, and fly will simulate jumps.
* **Advanced Logging**: Configure a Discord webhook to receive notifications of detections and actions.
* **Expansion**: Integrate with an emulator API for real image-based target detection.

## Legal and Ethical Notice:

This script is for educational and private testing purposes only. Do not use in public games or for cheating, as it may result in bans.
Always respect Free Fire’s Terms of Service.
For ethical pentesting or automation, adapt it to legal scenarios.

## Contributions:

Feel free to fork the repository on GitHub and contribute with improvements, such as real image detection support or additional features.
