ExtraItem.ID = "ZPOrbitalStrike"
ExtraItem.Name = "ExtraItemOrbitalStrikeName"
ExtraItem.Price = 30
function ExtraItem:OnBuy(ply)
	local Weap = ply:GetWeapon("m9k_orbital_strike")
	if IsValid(Weap) then
		ply:GiveAmmo(1, Weap:GetPrimaryAmmoType(), true) 
	else
		ply:Give("m9k_orbital_strike")
	end
end
function ExtraItem:ShouldBeEnabled()
	return WeaponManager:ServerHasWeapon("m9k_orbital_strike")
end

WeaponManager:AddWeaponMultiplier("m9k_oribital_cannon", 5)

Dictionary:RegisterPhrase("en-us", "ExtraItemOrbitalStrikeName", "Orbital Strike", false)
Dictionary:RegisterPhrase("pt-br", "ExtraItemOrbitalStrikeName", "Orbital Strike", false)
Dictionary:RegisterPhrase("es-ar", "ExtraItemOrbitalStrikeName", "Golpe Orbital", false)
Dictionary:RegisterPhrase("ru", "ExtraItemOrbitalStrikeName", "Orbital Strike", false)
Dictionary:RegisterPhrase("uk", "ExtraItemOrbitalStrikeName", "Orbital Strike", false)
Dictionary:RegisterPhrase("tchinese", "ExtraItemOrbitalStrikeName", "Orbital Strike", false)
Dictionary:RegisterPhrase("ja", "ExtraItemOrbitalStrikeName", "Orbital Strike", false)
Dictionary:RegisterPhrase("ko", "ExtraItemOrbitalStrikeName", "Orbital Strike", false)