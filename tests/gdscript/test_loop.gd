extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_slab_and_eye() -> void:
	var rules = Rules.new()
	assert_false(rules.slab_ready(false), "missing mesh rejected")
	assert_true(rules.slab_ready(true), "mesh accepted")
	assert_false(rules.eye_current(false), "inactive camera rejected")
	assert_true(rules.eye_current(true), "current camera accepted")

func test_annex_gate() -> void:
	var rules = Rules.new()
	assert_false(rules.may_annex(9.0), "far")
	assert_true(rules.may_annex(1.0), "close")
	assert_true(load("res://scenes/annex.tscn") != null, "annex loads")

func test_second_lamp() -> void:
	var rules = Rules.new()
	assert_false(rules.second_lamp(0.0), "lamp off")
	rules.spare_energy = 0.0
	assert_false(rules.may_annex(1.0), "annex waits")
	rules.spare_energy = 1.2
	assert_true(rules.may_annex(1.0), "annex opens")
