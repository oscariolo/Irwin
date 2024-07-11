extends HBoxContainer
var id_hold:int = 0
var locked:bool = false
@export var ratio_left:=0.0
@export var ratio_right:=0.0
signal level_clicked(level_id:int)

func _ready():
	$level_button.disabled = locked
	$level_button.text = str(id_hold)

func set_ratios():
	$LeftSpacing.size_flags_stretch_ratio = ratio_left
	$RightSpacing.size_flags_stretch_ratio = ratio_right

func _on_level_button_pressed():
	level_clicked.emit(id_hold)

