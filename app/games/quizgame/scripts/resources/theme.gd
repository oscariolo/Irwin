extends Resource
class_name QuizTheme

@export var theme: Array[QuizQuestion]

func _init(quizs: Array[QuizQuestion]):
	theme.append_array(quizs)
