extends Node2D

var local_mod_icon=""

func reset_mods_params():
	var mod_name="New mod"
	var mod_description="Your description"
	var icon_path=""
	var mod_tags=[]
	var mod_path=""

func _ready():
	reset_mods_params()
	Steam.connect("item_created", _on_item_created, CONNECT_PERSIST)

func _on_item_created(result: int, file_id: int, accept_tos: bool):
	print("Done 2")
	var handler_id=Steam.startItemUpdate(488860, file_id)
	#print(file_id)
	#var mod_id=current_item_id
	#var metadata:ConfigFile=ConfigFile.new()
	#var mod_title=mod_name
	#if Steam.setItemTitle(handler_id, str(mod_name))==false:
		#$message/message.text="Error with setting title"
	#if Steam.setItemPreview(handler_id, icon_path)==false:
		#$message/message.text="Error with setting icon"
	#if Steam.setItemDescription(handler_id, mod_description)==false:
		#$message/message.text="Error with setting description"
	#if Steam.setItemTags(handler_id, mod_tags)==false:
		#$message/message.text="Error with setting description"
	#if Steam.setItemContent(handler_id, mod_path)==false:
		#$message/message.text="Error with mod content path or something else"
	#Steam.submitItemUpdate(handler_id, "")
	#if result==0:
		#$message/message.text="Error. Something went wrong. Well, fuck"
	#else:
		#$message/message.text="Done!"
	#$message/confirm.show()
	#print("Done 3")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

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
	
func _on_mod_directory_selected(path: String):
	Global.mod_path = path
	print("Selected folder: ", Global.mod_path)
