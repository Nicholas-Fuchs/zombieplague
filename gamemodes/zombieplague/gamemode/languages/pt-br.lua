local Language = {ID = "pt-br",
	PrettyName = "Português Brasileiro",
	Values = 
	{
		Server = {
			ZombiesWin = "Os zombies tomaram o mundo!",
			HumansWin = "Os humanos acabaram com a praga!",
			RoundDraw = "Ninguém ganhou!",
			RoundSimple = "O virus está a solta!",
			RoundSwarm = "Swarm mode!",
			RoundPlague = "Plague mode!",
			NoticeFirstZombie = "%s é o primeiro zombie!!",
			NoticeInfect = "%s foi infectado por %s...",
			NoticeSelfInfect = "%s usou o T-Virus!",
			NoticeAntidote = "%s usou um antidoto...",
			NoticeGetCured = "%s foi curado por %s...",
			NoticeNemesis = "%s é um nemesis!!!",
			NoticeSurvivor = "%s é um survivor!!!",
			NoticeSwarm = "Modo swarm!!!",
			MultiInfection = "Modo multi-infecção!!!",
			NoticePlague = "Modo Plague!",
			NoticeVotemapEnded = "A votação de mapa acabou! %s será o próximo mapa!",
			NoticeNotAllowed = "Você não pode fazer isso agora!",
			NoticeHasHability = "Sua classe tem uma habilidade especial! Escreva: 'zp_ability' no console para usá-la!",
			LastZombieLeft = "O último zombie saiu, %s é o novo zombie!",
			LastHumanLeft = "O último humano saiu, %s é o novo humano!",
			ExtraItemCantBuy = "Você não pode comprar isso agora!",
			ExtraItemEnought = "Você não tem ammo packs o suficiente para comprar isso!",
			ExtraItemChoose = "Você precisa escolher um item válido!", -- Maybe this will never be called
			ExtraItemCantOpen = "Você não pode abrir esse menu agora!",
			ExtraItemBought = "Você comprou: '%s'.",
			AmmoPackWithdraw = "Você sacou %s ammo packs, agora você tem %s ammo packs em sua conta.",
			AmmoPackDeposit = "Você depositou %s ammo packs, agora você tem %s ammo packs em sua conta.",
			AmmoPackNotEnought = "Você não tem essa quantia!",
			AmmoPackGivePlyNotFound = "Jogador não encontrado!",
			AmmoPackGiveInvalidAmount = "Quantia inválida (Deve ser um número).",
			AmmoPackGiveName = "Jogador %s te deu %d ammo packs!",
			AmmoPackTakeName = "%s retirou %d dos seus ammo packs!",
			AmmoPackNoAmmoPacks = "Você está zerado!",
			AmmoPackBalance = "Seu saldo é de %d ammo packs!",
			AmmoPackPlayerNotFound = "Player '%s' not found!",
			AmmoPackGiverMessage = "You gave %d to %s!",
			CommandInvalidArgument = "Argumento inválido para esse comando!",
			CommandNotAccess = "Você não tem acesso a esse comando!",
		},
		Client = {
			ClassClass = "Classe",
			ClassHealth = "Vida",
			ClassArmor = "Colete",
			ClassGravity = "Gravidade",
			ClassRunSpeed = "Velocidade da corrida",
			ClassSpeed = "Velocidade",
			ClassBattery = "Bateria",
			AP = "Ammo Packs",
			APNotEnought = "Você não tem ammo packs o suficiente!",
			MenuZombieChoose = "Classes de Zombie",
			MenuHumanChoose = "Classes de Humanos",
			MenuWeaponChoose = "Armas",
			MenuExtraItemChoose = "Itens Extras",
			MenuLanguageChoose = "Linguas",
			MenuRoundChoose = "Escolha de Round",
			MenuSpectator = "Ficar como espectador",
			MenuNonSpectator = "Jogar",
			MenuAdmin = "Menu de Admin",
			MenuAdminGiveAmmoPacks = "Dar Ammo Packs",
			MenuBack = "Voltar",
			MenuNext = "Próximo",
			MenuClose = "Fechar"
		}
	}
}
Dictionary:AddLanguage(Language)