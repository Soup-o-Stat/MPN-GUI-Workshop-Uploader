extends Node2D

var current_item_id=0

func _ready():
	Global._update_discord_activity("Preview mod", str(Global.mod_name))
	if Global.mode=="upload":
		$ui/publish.text="Upload!"
	else:
		$ui/publish.text="Update!"
	$ui/blur.hide()
	Steam.connect("item_created", _on_item_created, CONNECT_PERSIST)
	Global.from_preview=1
	$ui/mod_name.text=Global.mod_name
	$ui/mod_description.text=Global.mod_description
	$ui/mod_tags.text=str(Global.mod_tags)
	if Global.icon_path!="":
		var image_texture = Image.load_from_file(Global.icon_path)
		if image_texture:
			image_texture.resize(256, 256)
			var texture=ImageTexture.create_from_image(image_texture)
			$ui/Sprite2D.texture = texture

func _on_publish_button_pressed():
	if Global.mode=="upload":
		Steam.createItem(488860,  Steam.WORKSHOP_FILE_TYPE_COMMUNITY)
	if Global.mode=="update":
		update_workshop_mode(Global.update_item_id)

func _on_item_created(result: int, file_id: int, accept_tos: bool):
	print("Done 2")
	var handler_id=Steam.startItemUpdate(488860, file_id)
	var mod_id=current_item_id
	var metadata:ConfigFile=ConfigFile.new()
	var mod_title=Global.mod_name
	Steam.setItemTitle(handler_id, str(Global.mod_name))
	Steam.setItemPreview(handler_id, Global.icon_path)
	Steam.setItemDescription(handler_id, Global.mod_description)
	Steam.setItemTags(handler_id, Global.mod_tags)
	Steam.setItemContent(handler_id, Global.mod_path)
	Steam.submitItemUpdate(handler_id, "")
	print("Done 3")
	if result:
		$ui/blur.show()
		$ui/blur/message.text="Success!"
	else:
		$ui/blur.show()
		$ui/blur/message.text="Error!"

func update_workshop_mode(file_id):
	print("Done 2")
	var handler_id=Steam.startItemUpdate(488860, file_id)
	var mod_id=current_item_id
	var metadata:ConfigFile=ConfigFile.new()
	var mod_title=Global.mod_name
	if Global.mod_name!="":
		Steam.setItemTitle(handler_id, str(Global.mod_name))
	if Global.icon_path!="":
		Steam.setItemPreview(handler_id, Global.icon_path)
	if Global.mod_description!="":
		Steam.setItemDescription(handler_id, Global.mod_description)
	if Global.mod_tags!=[]:
		Steam.setItemTags(handler_id, Global.mod_tags)
	if Global.mod_path!="":
		Steam.setItemContent(handler_id, Global.mod_path)
	Steam.submitItemUpdate(handler_id, "")
	print("Done 3")
	$ui/blur.show()
	$ui/blur/message.text="Success!"

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/upload_scene.tscn")

func _on_confirm_button_pressed():
	$ui/blur.hide()
