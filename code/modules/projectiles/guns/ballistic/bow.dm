/obj/item/gun/ballistic/bow
	name = "wooden bow"
	desc = "Some sort of primitive projectile weapon. Used to fire arrows."
	icon_state = "bow"
	item_state = "bow"
	icon_prefix = "bow"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY //need both hands to fire
	force = 5
	mag_type = /obj/item/ammo_box/magazine/internal/bow
	fire_sound = 'sound/weapons/bowfire.wav'
	slot_flags = ITEM_SLOT_BACK
	item_flags = NONE
	casing_ejector = FALSE
	inaccuracy_modifier = 0 //to counteract the innaccuracy from WEAPON_HEAVY, bows are supposed to be accurate but only able to be fired with both hands
	pin = null
	no_pin_required = TRUE
	trigger_guard = TRIGGER_GUARD_NONE //so ashwalkers can use it
	spawnwithmagazine = TRUE

/obj/item/gun/ballistic/bow/shoot_with_empty_chamber()
	return

/obj/item/gun/ballistic/bow/chamber_round()
	chambered = magazine.get_round(1)

/obj/item/gun/ballistic/bow/process_chamber()
	chambered = null
	magazine.get_round(0)
	update_icon()

/obj/item/gun/ballistic/bow/attack_self(mob/living/user)
	if (chambered)
		var/obj/item/ammo_casing/AC = magazine.get_round(0)
		user.put_in_hands(AC)
		chambered = null
		to_chat(user, "<span class='notice'>You gently release the bowstring, removing the arrow.</span>")
	else if (get_ammo())
		to_chat(user, "<span class='notice'>You draw back the bowstring.</span>")
		playsound(src, 'sound/weapons/bowdraw.wav', 75, 0) //gets way too high pitched if the freq varies
		chamber_round()
	update_icon()

/obj/item/gun/ballistic/bow/attackby(obj/item/I, mob/user, params)
	if (magazine.attackby(I, user, params, 1))
		to_chat(user, "<span class='notice'>You notch the arrow.</span>")
		update_icon()

/obj/item/gun/ballistic/bow/update_icon_state()
	icon_state = "[initial(icon_state)]_[get_ammo() ? (chambered ? "firing" : "loaded") : "unloaded"]"

/obj/item/gun/ballistic/bow/can_shoot()
	return chambered

/obj/item/gun/ballistic/bow/ashen
	name = "bone bow"
	desc = "Some sort of primitive projectile weapon made of bone and sinew. Used to fire arrows."
	icon_state = "ashenbow"
	item_state = "ashenbow"
	force = 8

/obj/item/gun/ballistic/bow/pipe
	name = "pipe bow"
	desc = "Some sort of pipe-based projectile weapon made of string and lots of bending. Used to fire arrows."
	icon_state = "pipebow"
	item_state = "pipebow"
	force = 2
