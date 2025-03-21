extends Node2D

func _ready():
	Global.from_preview=0
	if Global.discord_rpc:
		Global._update_discord_activity("In main menu", "")
	$ui/ver.text="Ver "+Global.version
	print("Game Owned:")
	print(Steam.isSubscribed())
	if not Steam.isSubscribed():
		$ui/ColorRect.show()

func _on_upload_button_mouse_entered():
	if Global.animations==true:
		$ui/upload_label.text="> Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Settings"
	else:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Credits"

func _on_update_button_mouse_entered():
	if Global.animations==true:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="> Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Credits"
	else:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Credits"

func _on_open_workshop_button_mouse_entered():
	if Global.animations==true:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="> Open Workshop"
		$ui/settings_label.text="Credits"
	else:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Credits"

func _on_settings_button_mouse_entered():
	if Global.animations==true:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="> Credits"
	else:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Credits"

func _on_settings_button_pressed():
	#get_tree().change_scene_to_file("res://scenes/settings.tscn")
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _on_open_workshop_button_pressed():
	Steam.activateGameOverlayToWebPage("https://steamcommunity.com/app/488860/workshop/")

func _on_upload_button_pressed():
	Global.mode="upload"
	get_tree().change_scene_to_file("res://scenes/upload_scene.tscn")

func _on_update_button_pressed():
	$ui/blur.show()

func _on_confirm_button_pressed():
	Global.mode="update"
	Global.update_item_id=int($ui/blur/enter_mod_id.text)
	$ui/blur.hide()
	if Global.update_item_id:
		get_tree().change_scene_to_file("res://scenes/upload_scene.tscn")
	$ui/blur/enter_mod_id.clear()
