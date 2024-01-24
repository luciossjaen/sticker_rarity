extends ContentInfo

var baseitem_patch    = preload("res://mods/sticker_tiers/scripts/BaseItem_patch.gd")
var stickeritem_patch    = preload("res://mods/sticker_tiers/scripts/StickerItem_patch.gd")
var itemfactory_patch = preload("res://mods/sticker_tiers/scripts/ItemFactory_patch.gd")
var stickerattribute_patch = preload("res://mods/sticker_tiers/scripts/StickerAttribute_patch.gd")
var daynightenvironment_patch = preload("res://mods/sticker_tiers/scripts/DayNightEnvironment_patch.gd")
var battlemove_patch = preload("res://mods/sticker_tiers/scripts/BattleMove_patch.gd")

func _init():
	# =========================
	# core file patches
	# =========================
	
	# adds new available rarity and ratity colors to items
	baseitem_patch.patch()
	# adds a value to the new rarities for stickers
	stickeritem_patch.patch()
	# adds a weight for new attribute rarities
	itemfactory_patch.patch()
	# adds support for new rarities to attributes
	stickerattribute_patch.patch()
	# adds visuals of new sandstorm weather to system
	daynightenvironment_patch.patch()
	# adds elemental weather dis/advantages tables to battle
	battlemove_patch.patch()
	
	# =========================
	# adding and updating attributes
	# =========================
	
	update_existing_attribute_rarities()
	add_new_attributes()
	
	
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
	var new_attributes = Datatables.load("res://mods/sticker_tiers/data/sticker_attributes/").table.values()
	for attribute in new_attributes:
		
		# ignores artificial attributes
		if attribute.weight > 0:
			# updates StickerAttribute rarity to provided rarity
			attribute.rarity = attribute.new_rarity
			for profile in attribute_profiles:
				if attribute.attribute_profile.has(profile):
					profile.attributes.push_back(attribute)
					
func on_title_screen():
#	if DLC.has_mod("sticker_recycle_bonus", 1):
#		DLC.mods_by_id["sticker_recycle_bonus"].searchable_cores.append("")
	pass
	
	
	
