extends Node2D

var animations_state="ON"
var discord_state="ON"

func state_changes():
	if Global.animations:
		animations_state="ON"
	if not Global.animations:
		animations_state="OFF"
	if Global.discord_rpc:
		discord_state="ON"
	if not Global.discord_rpc:
		discord_state="OFF"

func _ready():
	state_changes()
	$ui/animations_label.text="Animations: "+animations_state
	$ui/discord_label.text="Discord RPC: "+discord_state
	$ui/back_label.text="Back"

func _on_animations_button_mouse_entered():
	if Global.animations:
		$ui/animations_label.text="> Animations: "+animations_state
		$ui/discord_label.text="Discord RPC: "+discord_state
		$ui/back_label.text="Back"
	else:
		$ui/animations_label.text="Animations: "+animations_state
		$ui/discord_label.text="Discord RPC: "+discord_state
		$ui/back_label.text="Back"

func _on_discord_button_mouse_entered():
	if Global.animations:
		$ui/animations_label.text="Animations: "+animations_state
		$ui/discord_label.text="> Discord RPC: "+discord_state
		$ui/back_label.text="Back"
	else:
		$ui/animations_label.text="Animations: "+animations_state
		$ui/discord_label.text="Discord RPC: "+discord_state
		$ui/back_label.text="Back"

func _on_back_button_mouse_entered():
	if Global.animations:
		$ui/animations_label.text="Animations: "+animations_state
		$ui/discord_label.text="Discord RPC: "+discord_state
		$ui/back_label.text="> Back"
	else:
		$ui/animations_label.text="Animations: "+animations_state
		$ui/discord_label.text="Discord RPC: "+discord_state
		$ui/back_label.text="Back"

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_animations_button_pressed():
	if Global.animations:
		Global.animations=false
		state_changes()
		$ui/animations_label.text="Animations: "+animations_state
	elif not Global.animations:
		Global.animations=true
		state_changes()
		$ui/animations_label.text="> Animations: "+animations_state

func _on_discord_button_pressed():
	if Global.discord_rpc:
		Global.discord_rpc=false
	elif not Global.discord_rpc:
		Global.discord_rpc=true
	state_changes()
	if animations_state=="ON":
		$ui/discord_label.text="> Discord RPC: "+discord_state
	else:
		$ui/discord_label.text="Discord RPC: "+discord_state
