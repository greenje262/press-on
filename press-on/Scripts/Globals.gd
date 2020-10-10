extends Node

onready var safe = true
onready var barks = ["come back", "please don't leave me here", "won't you be lonely?", "you need me", "stay here", "don't go", "you can't leave", "i can't take this", "give up", "i love you", "you're going in circles", "i'll never let you go", "it's safe here", "there's nothing out there", "you won't find it", "you're hurting me", "not like this", "it's not over", "don't abandon me"]
onready var maze = preload("res://Scenes/Maze.tscn")
onready var player = preload("res://Scenes/Player.tscn")

func _ready():
	print(len(barks))
