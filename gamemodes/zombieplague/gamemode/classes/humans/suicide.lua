ZPClass.Name = "HumanSuicideClassName"
ZPClass.Description = "HumanSuicideClassDescription"
ZPClass.MaxHealth = 50
ZPClass.Armor = 50
ZPClass.PModel = "models/player/guerilla.mdl"
ZPClass.Speed = 180
ZPClass.RunSpeed = 220
ZPClass.CrouchSpeed = 0.5
ZPClass.Gravity = 0.9
ZPClass.Breath = 50

local ActivationAction = function(ply)
	ply:Kill()
	local explosion = ents.Create("env_explosion") -- https://facepunch.com/showthread.php?t=1021105 / Brandan
	explosion:SetKeyValue("spawnflags", 144)
	explosion:SetKeyValue("iMagnitude", 3000)
	explosion:SetKeyValue("iRadiusOverride", 256)
	explosion:SetOwner(ply)
	explosion:SetPos(ply:GetPos())
	explosion:Spawn()
	explosion:Activate()
	explosion:Fire("explode","",0)
end
ZPClass.Ability = ClassManager:CreateClassAbility(true, ActivationAction)
ZPClass.Ability.CanUseAbility = function()
	return RoundManager:GetRoundState() == ROUND_PLAYING && RoundManager:CountZombiesAlive() > 0
end

if(ZPClass:ShouldBeEnabled()) then
	ClassManager:AddZPClass("SuicideHuman", ZPClass, TEAM_HUMANS)
end