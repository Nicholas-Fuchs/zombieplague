ClassManager = {
	ZombieClasses = {},
	HumanClasses = {}
}
function ClassManager:SearchClasses()
	include("zombieplague/gamemode/classes/zpclass_defaultclasses.lua")
	
	local Files = file.Find("zombieplague/gamemode/classes/zombies/*.lua", "LUA")
	if Files then
		for k, File in pairs(Files) do
			ZPClass = ClassManager:NewZombieClass()
			include("zombieplague/gamemode/classes/zombies/" .. File)
		end
	end
	
	Files = file.Find("zombieplague/gamemode/classes/humans/*.lua", "LUA")
	if Files then
		for k, File in pairs(Files) do
			ZPClass = ClassManager:NewHumanClass()
			include("zombieplague/gamemode/classes/humans/" .. File)
		end
	end
end
function ClassManager:GetZombieClasses()
	return ClassManager.ZombieClasses
end
function ClassManager:GetHumanClasses()
	return ClassManager.HumanClasses
end

function ClassManager:CreateClassAbility(DrainOnActivation, ActivationAction, ResetAction, ResetDelay)
	local Ability = {
		DrainOnActivation = DrainOnActivation,
		Drain = 60,
		MaxAbilityPower = 60
	}
	function Ability:UseAction(ply)
		ActivationAction(ply)

		if ResetAction then
			local ResetTime = ResetDelay or (Ability.Drain - 10)
			ply:SetAbilityTimer("ZPClassAbility", ResetTime, function()
				ResetAction(ply)
			end)
		end
	end
	function Ability:CanUseAbility()
		return true
	end

	return Ability
end

function ClassManager:AddZPClass(ClassID, ZPClass, TeamID)
	if ZombieClass || (TeamID == TEAM_HUMANS || TeamID == TEAM_ZOMBIES) then
		local ZPTeamClasses = (TeamID == TEAM_HUMANS) and ClassManager.HumanClasses or ClassManager.ZombieClasses
		ZPTeamClasses[ClassID] = ZPClass

		resource.AddFile(ZPClass.PModel)
	else
		print("Invalid ZP class: " .. ClassID)
	end
end
function ClassManager:GetZPClass(ID, TeamID)
	return ((TeamID == TEAM_HUMANS) and ClassManager.HumanClasses or ClassManager.ZombieClasses)[ID] or SafeTableRandom(ZPTeamClasses)
end
function ClassManager:SetZPClass(ply, ClassID, TeamID)
	if TeamID == TEAM_HUMANS then
		ply:SetHumanClass(ClassManager:GetHumanClass(ClassID))
	else
		ply:SetZombieClass(ClassManager:GetZombieClass(ClassID))
	end
end
function ClassManager:NewHumanClass()
	return {Name = "HumanDefaultClassName",
		Description = "HumanDefaultClassDescription",
		MaxHealth = 100,
		Armor = 0,
		PModel = "models/player/gasmask.mdl",
		Speed = 190,
		RunSpeed = 230,
		CrouchSpeed = 0.4,
		Gravity = 1,
		Battery = 100,
		Breath = 100,
		JumpPower = 170,
		Footstep = true,
		DamageAmplifier = 1,
		FallFunction = function()return true end,
		ShouldBeEnabled = function()return true end,
		Order = 100
	}
end
function ClassManager:NewZombieClass()
	local ZombieClass = {Name = "ZombieDefaultClassName",
		Description = "ZombieDefaultClassDescription",
		MaxHealth = 2000,
		PModel = "models/player/zombie_classic.mdl",
		Speed = 250,
		RunSpeed = 270,
		CrouchSpeed = 0.4,
		Gravity = 0.7,
		Breath = 100,
		Footstep = false,
		JumpPower = 170,
		DamageAmplifier = 1,
		FallFunction = function()return false end,
		ShouldBeEnabled = function()return true end,
		Order = 100
	}
	function ZombieClass:WeaponGive(ply)
		ply:Give(ZOMBIE_KNIFE)
	end
	return ZombieClass
end
function ClassManager:OpenZPClassMenu(ply, IsHuman)
	local Pretty = {}
	local ZPClasses = IsHuman and ClassManager:GetHumanClasses() or ClassManager:GetZombieClasses()

	for ZPClassID, ZPClass in pairs(ZPClasses) do
		Pretty[ZPClassID] = {
			Description = ZPClass.Name .. " - " .. ZPClass.Description,
			PhraseKeys = {ZPClass.Name, ZPClass.Description},
			Order = ZPClass.Order
		}
	end
	
	net.Start("OpenBackMenu")
		net.WriteString(IsHuman and "SendHumanClass" or "SendZombieClass")
		net.WriteTable(Pretty)
	net.Send(ply)
end
net.Receive("RequestAbility", function(len, ply)
	if ply:Alive() && ply:Team() != TEAM_SPECTATOR then
		local Ability = ply:GetZPClass().Ability
		if Ability then
			if !(ply:IsNemesis() || ply:IsSurvivor()) then
				if Ability:CanUseAbility() then
					if ply:GetAbilityPower() >= Ability.Drain then
						if Ability.DrainOnActivation then
							ply:DrainAbilityPower(Ability.Drain)
						end
						Ability:UseAction(ply)
					else
						SendPopupMessage(ply, Dictionary:GetPhrase("NoticeNotEnoughAbilityPower", ply))
					end
				else
					SendPopupMessage(ply, Dictionary:GetPhrase("NoticeNotAllowed", ply))
				end
			else
				SendPopupMessage(ply, Dictionary:GetPhrase("NoticeSpecialClassNotAllowed", ply))
			end
		else
			SendPopupMessage(ply, Dictionary:GetPhrase("NoticeNoAbility", ply))
		end
	else
		SendPopupMessage(ply, Dictionary:GetPhrase("NoticeIsNotAlive", ply))
	end
end)
net.Receive("SendHumanClass", function(len, ply)
	ply:SetNextHumanClass(ClassManager:GetZPClass(net.ReadString(), TEAM_HUMANS))
end)
net.Receive("SendZombieClass", function(len, ply)
	ply:SetNextZombieClass(ClassManager:GetZPClass(net.ReadString(), TEAM_ZOMBIES))
end)
Commands:AddCommand("zombies", "Open zombie class menu.", function(ply, args)
	ClassManager:OpenZPClassMenu(ply, false)
end)
Commands:AddCommand("humans", "Open human class menu.", function(ply, args)
	ClassManager:OpenZPClassMenu(ply, true)
end)
net.Receive("RequestZombieMenu", function(len, ply)
	ClassManager:OpenZPClassMenu(ply, false)
end)
net.Receive("RequestHumanMenu", function(len, ply)
	ClassManager:OpenZPClassMenu(ply, true)
end)

util.AddNetworkString("RequestZombieMenu")
util.AddNetworkString("RequestHumanMenu")
util.AddNetworkString("RequestAbility")
util.AddNetworkString("SendHumanClass")
util.AddNetworkString("SendZombieClass")