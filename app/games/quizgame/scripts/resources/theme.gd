extends Resource
class_name QuizTheme

@export var theme: Array[QuizQuestion]

func load_quizs(quizs: Array[QuizQuestion]):
	theme = quizs
