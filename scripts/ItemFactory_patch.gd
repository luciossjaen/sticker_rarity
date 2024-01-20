static func patch():
	var script_path = "res://global/ItemFactory.gd"
	var patched_script : GDScript = load("res://global/ItemFactory.gd")

	if !patched_script.has_source_code():
		var file : File = File.new()
		var err = file.open(script_path, File.READ)
		if err != OK:
			push_error("Check that %s is included in Modified Files"% script_path)
			return
		patched_script.source_code = file.get_as_text()
		file.close()

	var code_lines:Array = patched_script.source_code.split("\n")
	
	# replaces default rarity distribution to alter and include epics & legendaries
	var code_index = code_lines.find("const DEFAULT_RARITY_DISTRIBUTION:Array = [")
	if code_index >= 0:
		# removes the 3 default "default" rarity entries
		code_lines.remove(code_index+1) 
		code_lines.remove(code_index+1)
		code_lines.remove(code_index+1)
		code_lines.insert(code_index+1,get_code("default_rarities"))
		
	# replaces default rarity distribution to alter and include epics & legendaries
	code_index = code_lines.find("const BOOTLEG_RARITY_DISTRIBUTION:Array = [")
	if code_index >= 0:
		# removes the 3 default "bootleg" rarity entries
		code_lines.remove(code_index+1) 
		code_lines.remove(code_index+1)
		code_lines.remove(code_index+1)
		code_lines.insert(code_index+1,get_code("bootleg_rarities"))
		
	# replaces default rarity max attributes
	code_index = code_lines.find("const MAX_ATTRIBUTES:Dictionary = {")
	if code_index >= 0:
		code_lines.remove(code_index+1) 
		code_lines.remove(code_index+1)
		code_lines.remove(code_index+1)
		code_lines.insert(code_index+1,get_code("max_attributes"))
		
	# updates bias towards less rare attributes on sticker
	code_index = code_lines.find("		var max_num = MAX_ATTRIBUTES[attr_rarity]")
	if code_index >= 0:
		code_lines.remove(code_index+1) 
		code_lines.remove(code_index+1)
		code_lines.insert(code_index+1,get_code("less_bias"))
		
	# updates forced sticker rarity upgrade to consider epics and legendaries
	code_index = code_lines.find("	if item is StickerItem and item.get_rarity() < BaseItem.Rarity.RARITY_RARE:")
	if code_index >= 0:
		code_lines[code_index] = get_code("more_upgrades")


	patched_script.source_code = ""
	for line in code_lines:
		patched_script.source_code += line + "\n"
	var err = patched_script.reload(true)
	if err != OK:
		push_error("Failed to patch %s." % script_path)
		return


static func get_code(block_name:String)->String:
	var blocks:Dictionary = {}
	blocks["default_rarities"] = """
	{weight = 0.750, value = BaseItem.Rarity.RARITY_COMMON}, 
	{weight = 0.100, value = BaseItem.Rarity.RARITY_UNCOMMON}, 
	{weight = 0.075, value = BaseItem.Rarity.RARITY_RARE},
	{weight = 0.050, value = BaseItem.Rarity.RARITY_EPIC},
	{weight = 0.025, value = BaseItem.Rarity.RARITY_LEGENDARY}
	"""
	
	blocks["bootleg_rarities"] = """
	{weight = 0.100, value = BaseItem.Rarity.RARITY_COMMON}, 
	{weight = 0.100, value = BaseItem.Rarity.RARITY_UNCOMMON}, 
	{weight = 0.100, value = BaseItem.Rarity.RARITY_RARE},
	{weight = 0.400, value = BaseItem.Rarity.RARITY_EPIC},
	{weight = 0.300, value = BaseItem.Rarity.RARITY_LEGENDARY}
	"""
	
	blocks["max_attributes"] = """
	BaseItem.Rarity.RARITY_COMMON:0, 
	BaseItem.Rarity.RARITY_UNCOMMON:2, 
	BaseItem.Rarity.RARITY_RARE:1,
	BaseItem.Rarity.RARITY_EPIC:1,
	BaseItem.Rarity.RARITY_LEGENDARY: 1
	"""
	
	blocks["less_bias"] = """
		var min_num = 1 if item_rarity == attr_rarity else 0
		var bias = 2 if item_rarity == attr_rarity else 1
		num = int(clamp(rand.rand_int(max_num + bias) + 1 - bias, min_num, max_num))
	"""
	
	blocks["more_upgrades"] = """
	if item is StickerItem and item.get_rarity() < BaseItem.Rarity.RARITY_LEGENDARY:
	"""

	return blocks[block_name]
