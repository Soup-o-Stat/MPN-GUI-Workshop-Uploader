extends Node

var AppID="488860"
var ItemID
var version="1.0 dev"
var steam_running=false
var current_item_id=0

# settings
var animations=false
var discord_rpc=true

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
	steam_init()
	
func _process(delta):
	Steam.run_callbacks()
	
