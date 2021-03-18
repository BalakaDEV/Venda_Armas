local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("venda_armas")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 150.15, ['y'] = -2203.34, ['z'] = 4.69 }
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "comprar-ak47" then
		TriggerServerEvent("comprar-arma","ak47")

	elseif data == "comprar-ak74u" then
		TriggerServerEvent("comprar-arma","ak74u")

	elseif data == "comprar-tec9" then
		TriggerServerEvent("comprar-arma","tec9")

	elseif data == "comprar-hk" then
		TriggerServerEvent("comprar-arma","hk")

	elseif data == "comprar-five" then
		TriggerServerEvent("comprar-arma","five")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("fechar-nui")
AddEventHandler("fechar-nui", function()
	ToggleActionMenu()
	onmenu = false
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
    local balaka = 1000

		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]
			local idBancada = prodMachine[id]

			if distance <= 3 then
        balaka = 5
          DrawMarker(29,v.x,v.y,v.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
          if distance <= 1.2 then
            balaka = 5
            DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] PARA ~r~NEGOCIAR~w~.")
            if IsControlJustPressed(0,38) then
            DisableControlAction(2, 167,  true)
            ToggleActionMenu()
            onmenu = true
          end
        end
      end
    end
    Citizen.Wait(balaka)
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PED PART
-----------------------------------------------------------------------------------------------------------------------------------------
local freeForAll = 0

local pedList = {
  {
      ["coords"] = { 150.5,-2203.73,4.69,31.440612792969 },
      ["hash"] = 0xC2FBFEFE,
      ["hash2"] = "a_m_m_soucent_04",
      ["weapon"] = "WEAPON_ASSAULTRIFLE_MK2",
  },
  {
      ["coords"] = { 152.78,-2202.76,4.69,95.370109558105 },
      ["hash"] =  0x231AF63F,
      ["hash2"] = "g_m_y_ballaorig_01",
      ["weapon"] = "WEAPON_MACHINEPISTOL",
  },
  {
      ["coords"] = { 147.32,-2204.58,4.69,307.68884277344 },
      ["hash"] = 0x841BA933,
      ["hash2"] = "ig_g",
      ["weapon"] = "WEAPON_PISTOL_MK2",
  },
}

Citizen.CreateThread(function()
    for k,v in pairs(pedList) do
        RequestModel(GetHashKey(v["hash2"]))
        while not HasModelLoaded(GetHashKey(v["hash2"])) do
            Citizen.Wait(10)
        end

        local ped = CreatePed(4,v["hash"],v["coords"][1],v["coords"][2],v["coords"][3] - 1,v["coords"][4],false,true)
        FreezeEntityPosition(ped,true)
        SetEntityInvincible(ped,true)
        SetBlockingOfNonTemporaryEvents(ped,true)

        if v["weapon"] ~= nil then
            GiveWeaponToPed(ped,GetHashKey(v["weapon"]),1,true,true)
        end
    end

    Citizen.Wait(1000)

    while true do
        local idle = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for k,v in pairs(pedList) do
            local distance = #(coords - vec3(v["coords"][1],v["coords"][2],v["coords"][3]))
            if distance <= 3 then
                idle = 4
                if v["name"] ~= nil then
                    drawSimple(v["coords"][1],v["coords"][2],v["coords"][3] + 1,v["name"],500)
                end
            end
        end
        Citizen.Wait(idle)
    end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end
