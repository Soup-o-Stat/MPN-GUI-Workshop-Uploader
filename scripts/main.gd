extends Node2D

var AppID="488860"
var ItemID
var version="0.0.5"
var steam_running=false
var current_item_id=0

var tags=["weapons", "armor", "characters", "origins", "enemies",
"story", "arena", "playground", "gameplay", "sound", "music",
"scripts", "other", "replacment", "overhaul", "QOL",
"balance", "silly", "vanilla-friendly", "custom-stage"]
var mode=""

var mod_name="New mod"
var mod_description="Your description"
var icon_path=""
var mod_tags=[]
var mod_path=""

var mod_name_updated=0
var mod_description_updated=0
var mod_icon_updated=0
var mod_tags_updated=0
var mod_path_updated=0

signal item_created

func reset_mod_params():
	mod_name="New mod"
	mod_description="Your description"
	icon_path=""
	mod_tags=[]
	mod_path=""
	
	mod_name_updated=0
	mod_description_updated=0
	mod_icon_updated=0
	mod_tags_updated=0
	mod_path_updated=0

func update_mod_preview():
	$mode_preview/mod_name.text=mod_name
	$mode_preview/mod_description.text=mod_description

func _process(delta):
	Steam.run_callbacks()

func _ready():
	$ver.text="Ver. "+version
	Steam.connect("item_created", _on_item_created, CONNECT_PERSIST)
	#Steam.connect("item_updated", _on_item_updated)
	update_mod_preview()
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
	match id:
		76561199078124117:
			$credits.text="Created by YOU!"
		76561197970564167:
			$credits.text="Created by... wait, Krinkels, what are you doing here?"
		76561197970713488:
			$credits.text="privet razrabotchik bezumnovo boya, sorry, ya ne govoru po english"
	
	$upload_update.show()
	$setup_mode.hide()
	$mode_preview.hide()
	$enter_something.hide()
	$enter_something/enter_description_table.hide()
	$enter_something/enter_name_table.hide()
	$enter_something/enter_tags.hide()

func _on_upload_mod_button_pressed():
	$upload_update.hide()
	$setup_mode.show()
	$mode_preview.show()
	mode="upload"
	$setup_mode/upload.text="Upload!"
	reset_mod_params()
	update_mod_preview()

func _on_back_button_pressed():
	$mode_preview.hide()
	$setup_mode.hide()
	$upload_update.show()

func _on_icon_choose_pressed():
	var file_dialog = FileDialog.new()
	file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.size=Vector2(800, 500)
	file_dialog.filters = ["*.png ; PNG Images", "*.jpg ; JPEG Images"]
	file_dialog.connect("file_selected", _on_icon_selected)
	add_child(file_dialog)
	file_dialog.popup_centered()

func _on_icon_selected(path: String):
	if is_valid_image(path):
		icon_path = path
		print("Selected icon: ", icon_path)
		var image_texture = Image.load_from_file(icon_path)
		if image_texture:
			image_texture.resize(256, 256)
			var texture=ImageTexture.create_from_image(image_texture)
			$mode_preview/Sprite2D.texture = texture
			print("Image loaded successfully!")
		else:
			print("Failed to load image.")
	else:
		print("Invalid image format! Please select a PNG, or JPEG")
		
func is_valid_image(path: String) -> bool:
	var valid_formats = ["png", "jpg", "jpeg"]
	var extension = path.get_extension().to_lower()
	return valid_formats.has(extension)

func _on_name_button_pressed():
	$enter_something.show()
	$enter_something/enter_name_table.show()

func _on_cancel_name_button_pressed():
	$enter_something.hide()
	$enter_something/enter_name_table.hide()
	$enter_something/enter_name_table/enter_name.text=""

func _on_confirm_name_button_pressed():
	$enter_something.hide()
	$enter_something/enter_name_table.hide()
	if $enter_something/enter_name_table/enter_name.text=="" or $enter_something/enter_name_table/enter_name.text==" ":
		mod_name="New mod"
	else:
		mod_name=str($enter_something/enter_name_table/enter_name.text)
	$enter_something/enter_name_table/enter_name.text=""
	update_mod_preview()
	
func _on_confirm_description_button_pressed():
	$enter_something.hide()
	$enter_something/enter_description_table.hide()
	if $enter_something/enter_description_table/description_table.text=="" or $enter_something/enter_description_table/description_table.text==" ":
		mod_description="Your description"
	else:
		mod_description=$enter_something/enter_description_table/description_table.text
		$enter_something/enter_description_table/description_table.text=""
		update_mod_preview()

func _on_cancel_description_button_pressed():
	$enter_something.hide()
	$enter_something/enter_description_table.hide()
	$enter_something/enter_description_table/description_table.text=""

func _on_description_button_pressed():
	$enter_something.show()
	$enter_something/enter_description_table.show()

func _on_item_created(result: int, file_id: int, accept_tos: bool):
	print("Done 2")
	var handler_id=Steam.startItemUpdate(488860, file_id)
	print(file_id)
	var mod_id=current_item_id
	var metadata:ConfigFile=ConfigFile.new()
	var mod_title=mod_name
	if Steam.setItemTitle(handler_id, str(mod_name))==false:
		print("Error with setting title")
	if Steam.setItemPreview(handler_id, icon_path)==false:
		print("Error with setting icon")
	if Steam.setItemDescription(handler_id, mod_description)==false:
		print("Error with setting description")
	if Steam.setItemTags(handler_id, mod_tags)==false:
		print("Error with setting description")
	if Steam.setItemContent(handler_id, mod_path)==false:
		print("Error with mod content path or something else")
	Steam.submitItemUpdate(handler_id, "")
	if result==0:
		print("Error. Something went wrong. Well, fuck")
	print("Done 3")

func _on_upload_mod_to_workshop_button_pressed():
	if mode=="upload":
		print("Done 0")
		Steam.createItem(488860,  Steam.WORKSHOP_FILE_TYPE_COMMUNITY)
		print("Mod Title: "+ mod_name)
		print("Mod Description: "+mod_description)
		print("Icon Path: "+str(icon_path))
		print("Mod folder path:"+str(mod_path))
		print("Done 1")

func _on_confirm_tags_button_pressed():
	$enter_something/enter_tags.hide()
	$enter_something.hide()

func _on_tags_button_pressed():
	$enter_something/enter_tags.show()
	$enter_something.show()

func _on_mod_directory_folder_pressed():
	var folder_dialog = FileDialog.new()
	folder_dialog.access = FileDialog.ACCESS_FILESYSTEM
	folder_dialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	folder_dialog.size = Vector2(800, 500)
	folder_dialog.connect("dir_selected", _on_mod_directory_selected)
	add_child(folder_dialog)
	folder_dialog.popup_centered()

func _on_mod_directory_selected(path: String):
	mod_path = path
	print("Selected folder: ", mod_path)

func _on_weapons_tag_button_pressed():
	if "weapons" in mod_tags:
		mod_tags.erase("weapons")
		$enter_something/enter_tags/tags/weapons.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("weapons")
		$enter_something/enter_tags/tags/weapons.add_theme_color_override("font_color", Color.RED)

func _on_armor_tag_button_pressed():
	if "armor" in mod_tags:
		mod_tags.erase("armor")
		$enter_something/enter_tags/tags/armor.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("armor")
		$enter_something/enter_tags/tags/armor.add_theme_color_override("font_color", Color.RED)

func _on_characters_tag_button_pressed():
	if "characters" in mod_tags:
		mod_tags.erase("characters")
		$enter_something/enter_tags/tags/characters.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("characters")
		$enter_something/enter_tags/tags/characters.add_theme_color_override("font_color", Color.RED)

func _on_origins_tag_button_pressed():
	if "origins" in mod_tags:
		mod_tags.erase("origins")
		$enter_something/enter_tags/tags/origins.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("origins")
		$enter_something/enter_tags/tags/origins.add_theme_color_override("font_color", Color.RED)

func _on_enemies_tag_button_pressed():
	if "enemies" in mod_tags:
		mod_tags.erase("enemies")
		$enter_something/enter_tags/tags/enemies.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("enemies")
		$enter_something/enter_tags/tags/enemies.add_theme_color_override("font_color", Color.RED)

func _on_story_tag_button_pressed():
	if "story" in mod_tags:
		mod_tags.erase("story")
		$enter_something/enter_tags/tags/story.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("story")
		$enter_something/enter_tags/tags/story.add_theme_color_override("font_color", Color.RED)

func _on_arena_tag_button_pressed():
	if "arena" in mod_tags:
		mod_tags.erase("arena")
		$enter_something/enter_tags/tags/arena.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("arena")
		$enter_something/enter_tags/tags/arena.add_theme_color_override("font_color", Color.RED)
		
func _on_playground_tag_button_pressed():
	if "playground" in mod_tags:
		mod_tags.erase("playground")
		$enter_something/enter_tags/tags/playground.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("playground")
		$enter_something/enter_tags/tags/playground.add_theme_color_override("font_color", Color.RED)

func _on_gameplay_tag_button_pressed():
	if "gameplay" in mod_tags:
		mod_tags.erase("gameplay")
		$enter_something/enter_tags/tags/gameplay.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("gameplay")
		$enter_something/enter_tags/tags/gameplay.add_theme_color_override("font_color", Color.RED)

func _on_sound_tag_button_pressed():
	if "sound" in mod_tags:
		mod_tags.erase("sound")
		$enter_something/enter_tags/tags/sound.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("sound")
		$enter_something/enter_tags/tags/sound.add_theme_color_override("font_color", Color.RED)

func _on_music_tag_button_pressed():
	if "music" in mod_tags:
		mod_tags.erase("music")
		$enter_something/enter_tags/tags/music.add_theme_color_override("font_color", Color.WHITE)
	else:
		mod_tags.append("music")
		$enter_something/enter_tags/tags/music.add_theme_color_override("font_color", Color.RED)
