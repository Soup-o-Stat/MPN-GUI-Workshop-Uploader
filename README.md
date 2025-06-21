# MPN GUI Workshop Uploader

[![itch.io](https://img.shields.io/badge/itch.io-Download_Workshop_Uploader-red)](https://soup-o-stat.itch.io/mpn-gui-workshop-uploader)

## What is it?

**MPN GUI Workshop Uploader** is a graphical interface tool for publishing mods to the Steam Workshop for the game MADNESS Project Nexus. This repository contains the project's source code which you're free to use and modify as you wish!

## How to Use it

1. Make sure you have:
   - The Steam client running
   - A legitimate copy of the game
   - An active internet connection

2. **Publishing a Mod**:
   - Click the "Upload mod" button
   - Fill in all required fields
   - Click "Preview and Publish"
   - Review the information and click "Upload!" if everything looks correct
   - Your mod is now published! You can manage its visibility settings through Steam.

3. **Updating a Mod**:
   - Click "Update mod"
   - Enter the mod's ID (found in the mod's Steam page URL, e.g., in `https://steamcommunity.com/sharedfiles/filedetails/?id=3428043862` the ID is `3428043862`)
   - Follow the same steps as for publishing

## How to Run the Project in Godot

1. Clone the repository:

```bash
git clone https://github.com/Soup-o-Stat/MPN-GUI-Workshop-Uploader.git
```

2. Open Godot 4.4+ and import the project (select the project folder and open `project.godot`)

**Required addons** for proper functionality:
- GodotSteam (version 4.13 or higher)
- DiscordRPC (version 1.3.1 or higher)

These addons should install automatically on first run.

## How to Build the Project

1. In Godot, select: Project → Export
2. Choose your target platform
3. Fill in required parameters, select output folder, and click "Export"
