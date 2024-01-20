extends ContentInfo

var baseitem_patch    = preload("res://mods/sticker_tiers/scripts/BaseItem_patch.gd")
var stickeritem_patch    = preload("res://mods/sticker_tiers/scripts/StickerItem_patch.gd")
var itemfactory_patch = preload("res://mods/sticker_tiers/scripts/ItemFactory_patch.gd")
var stickerattribute_patch = preload("res://mods/sticker_tiers/scripts/StickerAttribute_patch.gd")


func _init():
	print("loaded")
	baseitem_patch.patch()
	stickeritem_patch.patch()
	itemfactory_patch.patch()
	stickerattribute_patch.patch()
	
	# =========================
	# ToDo:
	# - check how weather is added to battles and how we can adjust calculations based on weather
	# - add sandstorm weather to battles
	# - test TOAST for elemental reaction resistance trigger
	#
	# =========================
	
	# =========================
	# updates all existing applicable attributes to apply epic and legendary rarity
	# =========================
	var compatibility = preload("res://data/sticker_attributes/compatibility.tres")
	#compatibility.rarity = 3
	
	var ap_all = preload("res://data/sticker_attributes/ap_refund_all.tres")
	#ap_all.rarity = 3
	
	# =========================
	# updates all new attributes to apply epic and legendary rarity, if applicable
	# =========================
	var treasure_trove = preload("res://mods/sticker_tiers/data/sticker_attributes/treasure_trove.tres")
	treasure_trove.rarity = 4
	var passive_wall = preload("res://mods/sticker_tiers/data/sticker_attributes/passive_wall.tres")
	passive_wall.rarity = 3
	var duration_reducer = preload("res://mods/sticker_tiers/data/sticker_attributes/duration_reducer.tres")
	duration_reducer.rarity = 3
	var duration_extender = preload("res://mods/sticker_tiers/data/sticker_attributes/duration_extender.tres")
	duration_extender.rarity = 3
	var reaction_negator = preload("res://mods/sticker_tiers/data/sticker_attributes/reaction_negator.tres")
	reaction_negator.rarity = 4
	
	var elemental_resistance_air = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_air.tres")
	elemental_resistance_air.rarity = 4
	var elemental_resistance_astral = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_astral.tres")
	elemental_resistance_astral.rarity = 4
	var elemental_resistance_beast = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_beast.tres")
	elemental_resistance_beast.rarity = 4
	var elemental_resistance_earth = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_earth.tres")
	elemental_resistance_earth.rarity = 4
	var elemental_resistance_fire = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_fire.tres")
	elemental_resistance_fire.rarity = 4
	var elemental_resistance_glass = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_glass.tres")
	elemental_resistance_glass.rarity = 4
	var elemental_resistance_glitter = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_glitter.tres")
	elemental_resistance_glitter.rarity = 4
	var elemental_resistance_ice = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_ice.tres")
	elemental_resistance_ice.rarity = 4
	var elemental_resistance_lightning = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_lightning.tres")
	elemental_resistance_lightning.rarity = 4
	var elemental_resistance_metal = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_metal.tres")
	elemental_resistance_metal.rarity = 4
	var elemental_resistance_plant = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_plant.tres")
	elemental_resistance_plant.rarity = 4
	var elemental_resistance_plastic = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_plastic.tres")
	elemental_resistance_plastic.rarity = 4
	var elemental_resistance_poison = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_poison.tres")
	elemental_resistance_poison.rarity = 4
	var elemental_resistance_water = preload("res://mods/sticker_tiers/data/sticker_attributes/elemental_resistance_water.tres")
	elemental_resistance_water.rarity = 4
	
	# =========================
	# add all new attributes to corresponding attribute profiles
	# =========================
	var attribute_profile_attack = preload("res://data/sticker_attribute_profiles/attack.tres")
	attribute_profile_attack.attributes.push_back(treasure_trove)
	attribute_profile_attack.attributes.push_back(passive_wall)
	attribute_profile_attack.attributes.push_back(duration_reducer)
	attribute_profile_attack.attributes.push_back(duration_extender)
	attribute_profile_attack.attributes.push_back(reaction_negator)

	var attribute_profile_misc = preload("res://data/sticker_attribute_profiles/misc.tres")
	attribute_profile_misc.attributes.push_back(treasure_trove)
	attribute_profile_misc.attributes.push_back(passive_wall)
	attribute_profile_misc.attributes.push_back(duration_extender)
	attribute_profile_misc.attributes.push_back(reaction_negator)
	
	var attribute_profile_status = preload("res://data/sticker_attribute_profiles/status.tres")
	attribute_profile_status.attributes.push_back(treasure_trove)
	attribute_profile_status.attributes.push_back(passive_wall)
	attribute_profile_status.attributes.push_back(duration_extender)
	attribute_profile_status.attributes.push_back(reaction_negator)
	
	var attribute_profile_pure_passive = preload("res://data/sticker_attribute_profiles/pure_passive.tres")
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_air)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_astral)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_beast)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_earth)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_fire)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_glass)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_glitter)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_ice)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_lightning)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_metal)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_plant)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_plastic)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_poison)
	attribute_profile_pure_passive.attributes.push_back(elemental_resistance_water)
	
	var attribute_profile_pure_passive_attack = preload("res://data/sticker_attribute_profiles/pure_passive_attack.tres")
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_air)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_astral)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_beast)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_earth)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_fire)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_glass)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_glitter)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_ice)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_lightning)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_metal)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_plant)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_plastic)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_poison)
	attribute_profile_pure_passive_attack.attributes.push_back(elemental_resistance_water)
	
	var attribute_profile_pure_passive_status = preload("res://data/sticker_attribute_profiles/pure_passive_status.tres")
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_air)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_astral)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_beast)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_earth)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_fire)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_glass)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_glitter)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_ice)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_lightning)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_metal)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_plant)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_plastic)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_poison)
	attribute_profile_pure_passive_status.attributes.push_back(elemental_resistance_water)
	
	
	
