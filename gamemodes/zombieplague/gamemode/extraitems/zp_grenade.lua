ExtraItem.ID = "ZPGrenade"
ExtraItem.Name = "ExtraItemGrenadeName"
ExtraItem.Price = 1
function ExtraItem:OnBuy(ply)
	local Weap = ply:GetWeapon("weapon_frag")
	if IsValid(Weap) then
		ply:GiveAmmo(1, Weap:GetPrimaryAmmoType(), true) 
	else
		ply:Give("weapon_frag")
	end
	ply:EmitSound( "Grenade.Blip" )
end

WeaponManager:AddWeaponMultiplier("npc_grenade_frag", 5)
