-- Credits (QBCore: qb-menu) Edited to work Standalone.

local sendData = nil

-- Functions
local function openMenu(data)
    if not data or not next(data) then return end
    SetNuiFocus(true, true)
    sendData = data
    SendNUIMessage({
        action = 'OPEN_MENU',
        data = table.clone(data)
    })
end

local function closeMenu()
    sendData = nil
    SetNuiFocus(false)
    SendNUIMessage({
        action = 'CLOSE_MENU'
    })
end

-- Events
RegisterNetEvent('xm_menu:client:openMenu', function(data)
    openMenu(data)
end)

RegisterNetEvent('xm_menu:client:closeMenu', function()
    closeMenu()
end)

-- NUI Callbacks
RegisterNUICallback('clickedButton', function(option, cb)
    PlaySoundFrontend(-1, 'Highlight_Cancel', 'DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SetNuiFocus(false)
    if sendData then
        local dataIndex = tonumber(option.id)
        local data = sendData[dataIndex]
        sendData = nil
        if data then
            if data.params then
                if data.params.event then
                    if data.params.isServer then
                        TriggerServerEvent(data.params.event, data.params.args)
                    elseif data.params.isCommand then
                        ExecuteCommand(data.params.event)
                    elseif data.params.isQBCommand then
                        TriggerServerEvent('QBCore:CallCommand', data.params.event, data.params.args)
                    elseif data.params.isAction then
                        data.params.event(data.params.args)
                    else
                        TriggerEvent(data.params.event, data.params.args)
                    end
                end
            else
                print("^5[XMMX-DEBUG] ^2(xmmx_menu) ^3No params found for this menu.^0")
            end
        else
            print("^5[XMMX-DEBUG] ^2(xmmx_menu) ^3No data found for this index.^0")
        end
    else
        print("^5[XMMX-DEBUG] ^2(xmmx_menu) ^3No sendData available.^0")
    end
    cb('ok')
end)

RegisterNUICallback('closeMenu', function(_, cb)
    sendData = nil
    SetNuiFocus(false)
    cb('ok')
end)

-- Exports
exports('openMenu', openMenu)
exports('closeMenu', closeMenu)