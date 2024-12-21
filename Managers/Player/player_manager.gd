extends Resource


class_name PlayerManager

@export var money: float = 1200.0

func save():
	pass

func load_save():
	pass


func add_funds(amount: float) -> float:
	money += amount
	return money

func get_funds() -> float:
	return money
