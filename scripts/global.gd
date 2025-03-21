extends Node

var AppID="488860"
var ItemID
var version="1.0.2"
var steam_running=false
var current_item_id=0

# settings
var animations=false
var discord_rpc=true

#mod settings
var mod_name="New mod"
var mod_description="Your description"
var icon_path=""
var mod_tags=[]
var mod_path=""

var from_preview=0
var mode="upload"
var update_item_id=0

func _set_discord_activity():
	DiscordRPC.app_id = 1348698462837014610
	DiscordRPC.details = ""
	DiscordRPC.state = ""
	DiscordRPC.large_image = "icon"
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()

func _update_discord_activity(details, state):
	DiscordRPC.details = details
	DiscordRPC.state = state
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()

func steam_init():
	OS.set_environment("SteamAppID", AppID)
	OS.set_environment("SteamGameID", AppID)
	Steam.steamInit()
	var steam_init_success = Steam.steamInit()
	var isRunning=Steam.isSteamRunning()
	if !isRunning:
		print("Error steam running")
		steam_running=false
	print("steam is running")
	var id=Steam.getSteamID()
	var nickname=Steam.getFriendPersonaName(id)
	print(nickname)
	print(id)
	steam_running=true
	print(steam_running)

func _ready():
	_set_discord_activity()
	steam_init()
	
func _process(delta):
	Steam.run_callbacks()
	
