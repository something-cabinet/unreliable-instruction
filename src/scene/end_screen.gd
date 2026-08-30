extends Control

## Shared by the win and lose screens: both are a headline and a way out.


func _on_return_button_pressed() -> void:
	SoundManager.play_button_click_sfx()
	GameManager.go_back_to_title_screen()


func play_button_hover_sfx() -> void:
	SoundManager.play_button_hover_sfx()
