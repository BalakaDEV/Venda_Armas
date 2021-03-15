local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("venda_armas",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "ak47" },
	{ item = "ak74u" },
	{ item = "tec9" },
	{ item = "hk" },
	{ item = "five" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("comprar-arma")
AddEventHandler("comprar-arma",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armas) do
			if item == v.item then
				if item == "ak47" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",300000) then
                            TriggerClientEvent("fechar-nui",source)

                            TriggerClientEvent("progress",source,5000,"Realizando A Compra")
                            vRPclient._playAnim(source,false,{{"mp_common","givetake1_a"}},true)

                            SetTimeout(5000,function()
                                 vRPclient._stopAnim(source,false)
                                 vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTRIFLE_MK2",1)
                                TriggerClientEvent("Notify",source,"sucesso","Você comprou uma <b>AK 47</b>.")
                            end)
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem dinheiro em suas mãos.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "ak74u" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_COMPACTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",200000) then
                            TriggerClientEvent("fechar-nui",source)

                            TriggerClientEvent("progress",source,5000,"Realizando A Compra")
                            vRPclient._playAnim(source,false,{{"mp_common","givetake1_a"}},true)

                            SetTimeout(5000,function()
                                 vRPclient._stopAnim(source,false)
                                 vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMPACTRIFLE",1)
                                TriggerClientEvent("Notify",source,"sucesso","Você comprou uma <b>Mini AK</b>.")
                            end)
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem dinheiro em suas mãos.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end 
                elseif item == "tec9" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_MACHINEPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",180000) then
                            TriggerClientEvent("fechar-nui",source)

                            TriggerClientEvent("progress",source,5000,"Realizando A Compra")
                            vRPclient._playAnim(source,false,{{"mp_common","givetake1_a"}},true)

                            SetTimeout(5000,function()
                                 vRPclient._stopAnim(source,false)
                                 vRP.giveInventoryItem(user_id,"wbody|WEAPON_MACHINEPISTOL",1)
                                TriggerClientEvent("Notify",source,"sucesso","Você comprou uma <b>Tec 9</b>.")
                            end)
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem dinheiro em suas mãos.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end 
                elseif item == "hk" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_SNSPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",30000) then
                            TriggerClientEvent("fechar-nui",source)

                            TriggerClientEvent("progress",source,5000,"Realizando A Compra")
                            vRPclient._playAnim(source,false,{{"mp_common","givetake1_a"}},true)

                            SetTimeout(5000,function()
                                 vRPclient._stopAnim(source,false)
                                 vRP.giveInventoryItem(user_id,"wbody|WEAPON_SNSPISTOL",1)
                                TriggerClientEvent("Notify",source,"sucesso","Você comprou uma <b>HK</b>.")
                            end)
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem dinheiro em suas mãos.")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end 
                elseif item == "five" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",75000) then
                            TriggerClientEvent("fechar-nui",source)

                            TriggerClientEvent("progress",source,5000,"Realizando A Compra")
                            vRPclient._playAnim(source,false,{{"mp_common","givetake1_a"}},true)

                            SetTimeout(5000,function()
                                 vRPclient._stopAnim(source,false)
                                 vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",1)
                                TriggerClientEvent("Notify",source,"sucesso","Você comprou uma <b>Five-Seven</b>.")
                            end)
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem dinheiro em suas mãos.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end 
				end
			end
		end
	end
end)
