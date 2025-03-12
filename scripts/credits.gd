extends Node2D

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_bluesky_button_pressed():
	OS.shell_open("https://bsky.app/profile/soupostat.bsky.social")

func _on_tg_button_pressed():
	OS.shell_open("https://t.me/soup_o_stats_basement")
