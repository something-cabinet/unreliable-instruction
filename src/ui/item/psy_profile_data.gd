extends Resource
class_name PsyProfileData

## The static content of one psychology report: the tells printed on the paper
## and the answers the finished report is checked against. Kept apart from
## PsyProfile so the same profile can be shown by more than one scene.

## Tell lines listed under "Lying Pattern", one PsyProfileLine each.
@export var lying_patterns: Array[String] = []

@export var correct_stall_owner_name: String = ""
@export var correct_game_name: String = ""
@export var correct_rule_states: Array[bool] = []
