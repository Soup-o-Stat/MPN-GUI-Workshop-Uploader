extends Node2D

var local_mod_icon=""

func reset_mods_params():
	if Global.mode=="upload":
		Global.mod_name="New mod"
		Global.mod_description="Your description"
		Global.icon_path=""
		Global.mod_tags=[]
		Global.mod_path=""
	else:
		Global.mod_name=""
		Global.mod_description=""
		Global.icon_path=""
		Global.mod_tags=[]
		Global.mod_path=""

func visibile_input():
	$input_ui/input_name.hide()
	$input_ui/input_description.hide()
	$input_ui/enter_tags.hide()
	$input_ui/enter_tags/enter_custom_tag.hide()
	$input_ui.hide()

func _ready():
	visibile_input()
	if Global.from_preview==0:
		reset_mods_params()
	if Global.discord_rpc:
		if Global.mode=="upload":
			Global._update_discord_activity("Uploading mod", "")
		if Global.mode=="update":
			Global._update_discord_activity("Updating mod", "")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_mod_name_button_pressed():
	$input_ui.show()
	$input_ui/input_name.show()

func _on_name_confirm_button_pressed():
	Global.mod_name=str($input_ui/input_name/enter_name.text)
	$input_ui.hide()
	$input_ui/input_name.hide()
	
func _on_name_cansel_button_pressed():
	$input_ui/input_name.hide()
	$input_ui.hide()
	$input_ui/input_name/enter_name.clear()

func _on_decription_button_pressed():
	$input_ui.show()
	$input_ui/input_description.show()

func _on_confirm_description_buton_pressed():
	Global.mod_description=str($input_ui/input_description/description_table.text)
	$input_ui/input_description.hide()
	$input_ui.hide()

func _on_cancel_description_button_pressed():
	$input_ui/input_description.hide()
	$input_ui.hide()
	$input_ui/input_description/description_table.clear()

func _on_mod_directory_folder_pressed():
	var folder_dialog = FileDialog.new()
	folder_dialog.access = FileDialog.ACCESS_FILESYSTEM
	folder_dialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	folder_dialog.size = Vector2(800, 500)
	folder_dialog.connect("dir_selected", _on_mod_directory_selected)
	add_child(folder_dialog)
	folder_dialog.popup_centered()

func _on_mod_directory_selected(path: String):
	Global.mod_path = path
	print("Selected folder: ", Global.mod_path)

func _on_mod_tags_button_pressed():
	$input_ui/enter_tags.show()
	$input_ui.show()

func _on_confirm_tags_button_pressed():
	$input_ui/enter_tags.hide()
	$input_ui.hide()
	
func _on_custom_tags_button_pressed():
	$input_ui/enter_tags/enter_custom_tag.show()

func _on_confirm_custom_tag_button_pressed():
	Global.mod_tags.append(str($input_ui/enter_tags/enter_custom_tag/enter_tag.text))
	$input_ui/enter_tags/enter_custom_tag/enter_tag.clear()

func _on_back_custom_tag_pressed():
	$input_ui/enter_tags/enter_custom_tag/enter_tag.clear()
	$input_ui/enter_tags/enter_custom_tag.hide()

func _on_weapons_tag_button_pressed():
	if "weapons" in Global.mod_tags:
		Global.mod_tags.erase("weapons")
		$input_ui/enter_tags/tags/weapons.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("weapons")
		$input_ui/enter_tags/tags/weapons.add_theme_color_override("font_color", Color.RED)

func _on_armor_tag_button_pressed():
	if "armor" in Global.mod_tags:
		Global.mod_tags.erase("armor")
		$input_ui/enter_tags/tags/armor.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("armor")
		$input_ui/enter_tags/tags/armor.add_theme_color_override("font_color", Color.RED)

func _on_characters_tag_button_pressed():
	if "characters" in Global.mod_tags:
		Global.mod_tags.erase("characters")
		$input_ui/enter_tags/tags/characters.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("characters")
		$input_ui/enter_tags/tags/characters.add_theme_color_override("font_color", Color.RED)

func _on_origins_tag_button_pressed():
	if "origins" in Global.mod_tags:
		Global.mod_tags.erase("origins")
		$input_ui/enter_tags/tags/origins.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("origins")
		$input_ui/enter_tags/tags/origins.add_theme_color_override("font_color", Color.RED)

func _on_enemies_tag_button_pressed():
	if "enemies" in Global.mod_tags:
		Global.mod_tags.erase("enemies")
		$input_ui/enter_tags/tags/enemies.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("enemies")
		$input_ui/enter_tags/tags/enemies.add_theme_color_override("font_color", Color.RED)

func _on_story_tag_button_pressed():
	if "story" in Global.mod_tags:
		Global.mod_tags.erase("story")
		$input_ui/enter_tags/tags/story.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("story")
		$input_ui/enter_tags/tags/story.add_theme_color_override("font_color", Color.RED)

func _on_arena_tag_button_pressed():
	if "arena" in Global.mod_tags:
		Global.mod_tags.erase("arena")
		$input_ui/enter_tags/tags/arena.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("arena")
		$input_ui/enter_tags/tags/arena.add_theme_color_override("font_color", Color.RED)
		
func _on_playground_tag_button_pressed():
	if "playground" in Global.mod_tags:
		Global.mod_tags.erase("playground")
		$input_ui/enter_tags/tags/playground.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("playground")
		$input_ui/enter_tags/tags/playground.add_theme_color_override("font_color", Color.RED)

func _on_gameplay_tag_button_pressed():
	if "gameplay" in Global.mod_tags:
		Global.mod_tags.erase("gameplay")
		$input_ui/enter_tags/tags/gameplay.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("gameplay")
		$input_ui/enter_tags/tags/gameplay.add_theme_color_override("font_color", Color.RED)

func _on_sound_tag_button_pressed():
	if "sound" in Global.mod_tags:
		Global.mod_tags.erase("sound")
		$input_ui/enter_tags/tags/sound.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("sound")
		$input_ui/enter_tags/tags/sound.add_theme_color_override("font_color", Color.RED)

func _on_music_tag_button_pressed():
	if "music" in Global.mod_tags:
		Global.mod_tags.erase("music")
		$input_ui/enter_tags/tags/music.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("music")
		$input_ui/enter_tags/tags/music.add_theme_color_override("font_color", Color.RED)

func _on_scripts_tag_button_pressed():
	if "scripts" in Global.mod_tags:
		Global.mod_tags.erase("scripts")
		$input_ui/enter_tags/tags/scripts.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("scripts")
		$input_ui/enter_tags/tags/scripts.add_theme_color_override("font_color", Color.RED)

func _on_other_tag_button_pressed():
	if "other" in Global.mod_tags:
		Global.mod_tags.erase("other")
		$input_ui/enter_tags/tags/other.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("other")
		$input_ui/enter_tags/tags/other.add_theme_color_override("font_color", Color.RED)

func _on_replacement_tag_button_pressed():
	if "replacement" in Global.mod_tags:
		Global.mod_tags.erase("replacement")
		$input_ui/enter_tags/tags/replacement.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("replacement")
		$input_ui/enter_tags/tags/replacement.add_theme_color_override("font_color", Color.RED)

func _on_overhaul_tag_button_pressed():
	if "overhaul" in Global.mod_tags:
		Global.mod_tags.erase("overhaul")
		$input_ui/enter_tags/tags/overhaul.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("overhaul")
		$input_ui/enter_tags/tags/overhaul.add_theme_color_override("font_color", Color.RED)

func _on_qol_tag_button_pressed():
	if "QOL" in Global.mod_tags:
		Global.mod_tags.erase("QOL")
		$input_ui/enter_tags/tags/QOL.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("QOL")
		$input_ui/enter_tags/tags/QOL.add_theme_color_override("font_color", Color.RED)

func _on_balance_tag_button_pressed():
	if "balance" in Global.mod_tags:
		Global.mod_tags.erase("balance")
		$input_ui/enter_tags/tags/balance.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("balance")
		$input_ui/enter_tags/tags/balance.add_theme_color_override("font_color", Color.RED)
		
func _on_silly_tag_button_pressed():
	if "silly" in Global.mod_tags:
		Global.mod_tags.erase("silly")
		$input_ui/enter_tags/tags/silly.add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("silly")
		$input_ui/enter_tags/tags/silly.add_theme_color_override("font_color", Color.RED)

func _on_custom_tag_button_pressed():
	if "custom-stage" in Global.mod_tags:
		Global.mod_tags.erase("custom-stage")
		$"input_ui/enter_tags/tags/custom-stage".add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("custom-stage")
		$"input_ui/enter_tags/tags/custom-stage".add_theme_color_override("font_color", Color.RED)

func _on_vanilla_tag_button_pressed():
	if "vanilla-friendly" in Global.mod_tags:
		Global.mod_tags.erase("vanilla-friendly")
		$"input_ui/enter_tags/tags/vanilla-friendly".add_theme_color_override("font_color", Color.WHITE)
	else:
		Global.mod_tags.append("vanilla-friendly")
		$"input_ui/enter_tags/tags/vanilla-friendly".add_theme_color_override("font_color", Color.RED)

func _on_mod_icon_button_pressed():
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
		Global.icon_path = path
		print("Selected icon: ", Global.icon_path)
		var image_texture = Image.load_from_file(Global.icon_path)
		if image_texture:
			image_texture.resize(256, 256)
			local_mod_icon=ImageTexture.create_from_image(image_texture)
			print("Image loaded successfully!")
		else:
			print("Failed to load image.")
	else:
		print("Invalid image format! Please select a PNG, or JPEG")
		
func is_valid_image(path: String):
	var valid_formats = ["png", "jpg", "jpeg"]
	var extension = path.get_extension().to_lower()
	return valid_formats.has(extension)
	
func _on_mod_directory_button_pressed():
	var folder_dialog = FileDialog.new()
	folder_dialog.access = FileDialog.ACCESS_FILESYSTEM
	folder_dialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	folder_dialog.size = Vector2(800, 500)
	folder_dialog.connect("dir_selected", _on_mod_directory_selected)
	add_child(folder_dialog)
	folder_dialog.popup_centered()

func _on_preview_button_pressed():
	print(Global.mod_name)
	print(Global.mod_description)
	print(Global.mod_path)
	print(Global.icon_path)
	print(Global.mod_tags)
	get_tree().change_scene_to_file("res://scenes/preview.tscn")
