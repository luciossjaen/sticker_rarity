enum Rarity{RARITY_COMMON, RARITY_UNCOMMON, RARITY_RARE, RARITY_EPIC, RARITY_LEGENDARY}

class_name LuciossRarityColor

const LUCIOSS_RARITY_COLOR:Dictionary = {
	Rarity.RARITY_COMMON:Color.black, 
	Rarity.RARITY_UNCOMMON:Color("225d31"), 
	Rarity.RARITY_RARE:Color("35379d"),
	Rarity.RARITY_EPIC:Color("BA55D3"),
	Rarity.RARITY_LEGENDARY:Color("DAA520")
}

static func patch():
	
	var file : File = File.new()
	var script_MoveButton = "res://battle/ui/MoveButton.gd"
	var patched_MoveButton : GDScript = preload("res://battle/ui/MoveButton.gd")
	file.open(script_MoveButton, File.READ)
	patched_MoveButton.source_code = file.get_as_text()
	file.close()
	
	var script_MoveAttributeLabel = "res://battle/ui/MoveAttributeLabel.gd"
	var patched_MoveAttributeLabel : GDScript = preload("res://battle/ui/MoveAttributeLabel.gd")
	file.open(script_MoveAttributeLabel, File.READ)
	patched_MoveAttributeLabel.source_code = file.get_as_text()
	file.close()
	
	var script_ExchangeButton = "res://menus/exchange/ExchangeButton.gd"
	var patched_ExchangeButton : GDScript = preload("res://menus/exchange/ExchangeButton.gd")
	file.open(script_ExchangeButton, File.READ)
	patched_ExchangeButton.source_code = file.get_as_text()
	file.close()
	
	var script_MoveLabel = "res://menus/party_character/MoveLabel.gd"
	var patched_MoveLabel : GDScript = preload("res://menus/party_character/MoveLabel.gd")
	file.open(script_MoveLabel, File.READ)
	patched_MoveLabel.source_code = file.get_as_text()
	file.close()
	
	var script_ItemButton = "res://menus/inventory/ItemButton.gd"
	var patched_ItemButton : GDScript = preload("res://menus/inventory/ItemButton.gd")
	file.open(script_ItemButton, File.READ)
	patched_ItemButton.source_code = file.get_as_text()
	file.close()
	
	var code_lines:Array = []
	var code_index = null
	
	# =======================
	# "res://battle/ui/MoveButton.gd"
	# =======================

	code_lines = patched_MoveButton.source_code.split("\n")

	code_index = code_lines.find("		var color = BaseItem.get_rarity_color(move.rarity if move else BaseItem.Rarity.RARITY_COMMON)")
	if code_index >= 0:
		code_lines[code_index] = "		var color = Color.cyan"
		
	code_index = code_lines.find("		var color = BaseItem.get_rarity_color(move.rarity if move else BaseItem.Rarity.RARITY_COMMON)")
	if code_index >= 0:
		code_lines[code_index] = "		var color = Color.cyan"


	patched_MoveButton.source_code = ""
	for line in code_lines:
		patched_MoveButton.source_code += line + "\n"
	#var err = patched_MoveButton.reload()
	#if err != OK:
	#	push_error("Failed to patch %s." % script_MoveButton)
	#	return
		
		
static func get_code(block_name:String)->String:
	var blocks:Dictionary = {}
	
	blocks["rarity_values"] = """
	var rarity_values:Dictionary = {
		Rarity.RARITY_COMMON:0, 
		Rarity.RARITY_UNCOMMON:300, 
		Rarity.RARITY_RARE:500,
		Rarity.RARITY_EPIC:1250,
		Rarity.RARITY_LEGENDARY: 2000
	}
	
	"""

	return blocks[block_name]
