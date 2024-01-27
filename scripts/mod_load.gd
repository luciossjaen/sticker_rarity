extends ContentInfo

var baseitem_patch    = preload("res://mods/sticker_tiers/scripts/BaseItem_patch.gd")
var stickeritem_patch    = preload("res://mods/sticker_tiers/scripts/StickerItem_patch.gd")
var itemfactory_patch = preload("res://mods/sticker_tiers/scripts/ItemFactory_patch.gd")
var stickerattribute_patch = preload("res://mods/sticker_tiers/scripts/StickerAttribute_patch.gd")
var daynightenvironment_patch = preload("res://mods/sticker_tiers/scripts/DayNightEnvironment_patch.gd")
var battlemove_patch = preload("res://mods/sticker_tiers/scripts/BattleMove_patch.gd")

var new_attributes = Datatables.load("res://mods/sticker_tiers/data/sticker_attributes/").table

func _init():
	
	# adds new available rarity and ratity colors to items
	baseitem_patch.patch()
	# adds a value to the new rarities for stickers
	stickeritem_patch.patch()
	# adds a weight for new attribute rarities
	itemfactory_patch.patch()
	# adds support for new rarities to attributes
	stickerattribute_patch.patch()
	
	### disabled weather changes until fully integrated
	# adds visuals of new sandstorm weather to system
	#daynightenvironment_patch.patch()
	# adds elemental weather dis/advantages tables to battle
	#battlemove_patch.patch()
	
	# =========================
	# updates existing attributes
	# =========================
	
	update_existing_attribute_rarities()
	register_commands()
					
func on_title_screen():
	# adds compatibility to Sticker Recycle Bonus - Mod to support all newly added attributes
	if DLC.has_mod("sticker_recycle_bonus", 0):
		var core_dictionary = Datatables.load("res://mods/sticker_tiers/_compatibility/sticker_recycle_bonus/items/").table
		
		
		for core in core_dictionary.keys():
			DLC.mods_by_id["sticker_recycle_bonus"].core_dictionary[core] = core_dictionary[core]
			DLC.mods_by_id["sticker_recycle_bonus"].searchable_cores[core_dictionary[core].template_path] = core
	
	# adds new attributes to system
	add_new_attributes()
	
func register_commands():
	Console.register("cleanly_remove_rarity_tiers", {
			"description":"Cleans savefile of all non-default attributes and rarity tiers to safely remove the Rarity Tiers Revamped mod.",
			"args":[],
			"target":[self, "remove_rarity_tiers"]
		})
		
func remove_rarity_tiers():
	var item_collection = SaveState.inventory.get_snapshot()
	var corrections:Array = []
	var removals:Array = []
	var index:int = 0
	var rarity = null
	
	# removes custom attributes and rarities from sticker in inventory
	for item in item_collection.items:
		if item.has("sticker"):
			index = 0
			removals = []
			rarity = 0
			for attribute in item.attributes:
				var template = load(attribute.template_path).instance()
				# removes custom attributes
				if "/sticker_tiers/" in attribute.template_path:
					removals.append(index)
				# and updates sticker rarity to highest remaining attribute
				else:
					if  template.rarity > rarity:
						rarity = template.rarity
				index += 1
			if removals.size() > 0:
				removals.invert()
				for removal in removals:
					item.attributes.remove(removal)
			item["rarity"] = rarity if rarity <= 2 else 2
	
	corrections.push_back("~cleaned inventory data")
	SaveState.inventory.set_snapshot(item_collection, 1)
	
	var party_snap = SaveState.party.get_snapshot()

	for tape in party_snap.player.tapes:
		for sticker in tape.stickers:
			if sticker == null:
				continue
			if not sticker.get("attributes"):
				continue
			index = 0
			removals = []
			rarity = 0
			for attribute in sticker.attributes:
				var template = load(attribute.template_path).instance()
				# removes custom attributes
				if "/sticker_tiers/" in attribute.template_path:
					removals.append(index)
				# and updates sticker rarity to highest remaining attribute
				else:
					if  template.rarity > rarity:
						rarity = template.rarity
				index += 1
			if removals.size() > 0:
				removals.invert()
				for removal in removals:
					sticker.attributes.remove(removal)
			sticker["rarity"] = rarity if rarity <= 2 else 2
				
	corrections.push_back("~cleaned party tape data")
			
	for partner in party_snap.partners.values():
		for tape in partner.tapes:
			for sticker in tape.stickers:
				if sticker == null:
					continue
				if not sticker.get("attributes"):
					continue
				index = 0
				removals = []
				rarity = 0
				for attribute in sticker.attributes:
					var template = load(attribute.template_path).instance()
					# removes custom attributes
					if "/sticker_tiers/" in attribute.template_path:
						removals.append(index)
					# and updates sticker rarity to highest remaining attribute
					else:
						if  template.rarity > rarity:
							rarity = template.rarity
					index += 1
				if removals.size() > 0:
					removals.invert()
					for removal in removals:
						sticker.attributes.remove(removal)
				sticker["rarity"] = rarity if rarity <= 2 else 2
	
	corrections.push_back("~cleaned partner tape data")
	SaveState.party.set_snapshot(party_snap, 2)
	
	var tape_collection = SaveState.tape_collection.get_snapshot()
	for tape in tape_collection.tapes:
		for sticker in tape.stickers:
			if sticker == null:
				continue
			if not sticker.get("attributes"):
				continue
			index = 0
			removals = []
			rarity = 0
			for attribute in sticker.attributes:
				var template = load(attribute.template_path).instance()
				# removes custom attributes
				if "/sticker_tiers/" in attribute.template_path:
					removals.append(index)
				# and updates sticker rarity to highest remaining attribute
				else:
					if  template.rarity > rarity:
						rarity = template.rarity
				index += 1
			if removals.size() > 0:
				removals.invert()
				for removal in removals:
					sticker.attributes.remove(removal)
			sticker["rarity"] = rarity if rarity <= 2 else 2
	
	corrections.push_back("~cleaned storage tape data")
	SaveState.tape_collection.set_snapshot(tape_collection, 1)
				

	return corrections
	pass
	
func update_existing_attribute_rarities():
	var ap_one = preload("res://data/sticker_attributes/ap_refund_1.tres")
	#ap_one.rarity = 3
	var auto_ending = preload("res://data/sticker_attributes/auto_use_round_ending.tres")
	#auto_ending.rarity = 3
	var auto_after_attack = preload("res://data/sticker_attributes/auto_use_user_attack.tres")
	#auto_after_attack.rarity = 3

	var extra_slot = preload("res://data/sticker_attributes/extra_slot.tres")
	#extra_slot.rarity = 3
	var extra_hit = preload("res://data/sticker_attributes/extra_hit.tres")
	#extra_hit.rarity = 3
	var multitarget = preload("res://data/sticker_attributes/multitarget.tres")
	#multitarget.rarity = 3
	var spec_pass_evasion = preload("res://data/sticker_attributes/specialization_passive_evasion.tres")
	#spec_pass_evasion.rarity = 3
	var stat_pass_evasion = preload("res://data/sticker_attributes/stat_passive_evasion.tres")
	#stat_pass_evasion.rarity = 3
	var stat_prio_chance = preload("res://data/sticker_attributes/stat_priority_chance.tres")
	#stat_prio_chance.rarity = 3
	var use_again = preload("res://data/sticker_attributes/use_again.tres")
	#use_again.rarity = 3
	var use_random = preload("res://data/sticker_attributes/use_random.tres")
	#use_random.rarity = 3
	
	var compatibility = preload("res://data/sticker_attributes/compatibility.tres")
	#compatibility.rarity = 4
	var ap_all = preload("res://data/sticker_attributes/ap_refund_all.tres")
	#ap_all.rarity = 4
	#ap_all.chance_min = 5
	#ap_all.chance_max = 10
		
func add_new_attributes():
	var attribute_profiles = [
		preload("res://data/sticker_attribute_profiles/attack.tres"),
		preload("res://data/sticker_attribute_profiles/misc.tres"),
		preload("res://data/sticker_attribute_profiles/pure_passive.tres"),
		preload("res://data/sticker_attribute_profiles/status.tres"),
		preload("res://data/sticker_attribute_profiles/pure_passive_attack.tres"),
		preload("res://data/sticker_attribute_profiles/pure_passive_status.tres")
	]
	
	# reads and adds new attributes to their corresponding (mapped) profiles	
	for attribute in new_attributes.values():
		
		# ignores artificial attributes
		if attribute.weight > 0:
			# updates StickerAttribute rarity to provided rarity
			attribute.rarity = attribute.new_rarity
			for profile in attribute_profiles:
				if attribute.attribute_profile.has(profile):
					profile.attributes.push_back(attribute)
					
					# if Sticker Recycle Bonus - Mod exists, cultivate needed information into mod data
					if DLC.has_mod("sticker_recycle_bonus", 0):
						DLC.mods_by_id["sticker_recycle_bonus"].attribute_dictionary[profile].push_back(attribute.instance())
	
	# we also have to add the new rarities to the base of Sticker Recycle Bonus to display the correct rarity in menus
	if DLC.has_mod("sticker_recycle_bonus", 0):					
		var stickercoresystem_patch = preload("res://mods/sticker_tiers/_compatibility/sticker_recycle_bonus/scripts/StickerCoreSystem_patch.gd")
		stickercoresystem_patch.patch()
	
	
	
	
