extends Node2D

func _ready():
	$ui/ver.text="Ver "+Global.version

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
		$ui/settings_label.text="Settings"

func _on_update_button_mouse_entered():
	if Global.animations==true:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="> Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Settings"
	else:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Settings"

func _on_open_workshop_button_mouse_entered():
	if Global.animations==true:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="> Open Workshop"
		$ui/settings_label.text="Settings"
	else:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Settings"

func _on_settings_button_mouse_entered():
	if Global.animations==true:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="> Settings"
	else:
		$ui/upload_label.text="Upload mod"
		$ui/update_label.text="Update mod"
		$ui/open_workshop_label.text="Open Workshop"
		$ui/settings_label.text="Settings"

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
