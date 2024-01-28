static func patch():
	var script_path = "res://data/StickerAttribute.gd"
	var patched_script : GDScript = preload("res://data/StickerAttribute.gd")

	if !patched_script.has_source_code():
		var file : File = File.new()
		var err = file.open(script_path, File.READ)
		if err != OK:
			push_error("Check that %s is included in Modified Files"% script_path)
			return
		patched_script.source_code = file.get_as_text()
		file.close()

	var code_lines:Array = patched_script.source_code.split("\n")
	
	var class_name_index = code_lines.find("class_name StickerAttribute")
	if class_name_index >= 0:
		code_lines.remove(class_name_index)

	var code_index = code_lines.find("export (float) var weight:float = 1.0")
	if code_index >= 0:
		# adds epic and legendary as valid rarities to sticker attributes
		code_lines[code_index+1] = get_code("more_upgrades")


	patched_script.source_code = ""
	for line in code_lines:
		patched_script.source_code += line + "\n"
	var err = patched_script.reload()
	if err != OK:
		push_error("Failed to patch %s." % script_path)
		return


static func get_code(block_name:String)->String:
	var blocks:Dictionary = {}
	
	blocks["more_upgrades"] = """
export (int, "Common,Uncommon,Rare,Epic,Legendary") var rarity:int = 1 
	"""

	return blocks[block_name]
