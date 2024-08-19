# XM Context Menu (Standalone)
A simple context menu written in React using edited client.lua from qb-menu and incorporating some of the same properties as qb-menu. Sort of a merger of qb-menu with a feel of ox_lib's context menu.

# Credits: QBCore (qb-menu)
- xm_menu/client/main.lua code from qb-menu and edited to work standalone.
- UI re-written in React.

# Preview:
<img src='https://r2.fivemanage.com/images/r365d_3zQhpDwMdrJm.png' width='300'>
<img src='https://r2.fivemanage.com/images/r365d_mrJpK18niXes.png' width='300'>
<img src='https://r2.fivemanage.com/images/r365d_Ui1G5aImlc4k.png' width='300'>
<img src='https://r2.fivemanage.com/images/r365d_p9urrEeY9w2h.png' width='300'>
<img src='https://r2.fivemanage.com/images/r365d_zG3tvvRKPAIc.png' width='800'>


EXAMPLE USAGE:

```lua

-- Exports & Commands:
exports.xm_menu:openMenu(Menu)  -- See test command below
exports.xm_menu:closeMenu()


RegisterNetEvent("xm_menu:client:testMenu2", function(data)
    print(json.encode(data))
end)

RegisterNetEvent('xm_menu:client:testButton', function(data)
    TriggerEvent('QBCore:Notify', data.message)
end)

RegisterCommand("xmenu", function(source, args, raw)
    local Menu = {
        {
            header = "Main Title",
            txt = "Main title description",
            isMenuHeader = true,
        },
        {
            header = "Sub Menu Button",
            txt = "This is line 1. \nThis is line 2. \n This is line 3. \nThis is line 4. \nThis is line 5.",
            icon = "https://r2.fivemanage.com/E8IIxhF98B9ORGy7yQoq6/lccurrgoat.png", -- can be an image link or font awesome icon.
            disabled = false, -- If menu item should be disabled (not clickable / less opacity)
            params = {
                event = "xm_menu:client:testButton",
                args = {
                    message = "This was called by clicking this button"
                }
            }
        },
        {
            header = "Sub Menu Button",
            txt = "This is 1 line.",
            icon = "fas fa-hands",
            params = {
                event = "xm_menu:client:testMenu2",
                args = {
                    number = 1,
                }
            }
        },
        {
            header = "Sub Menu Button",
            txt = "This is line 1. \nThis is line 2. \n This is line 3. \nThis is line 4. \nThis is line 5.",
            icon = "fas fa-hands",
            disabled = false,
            params = {
                event = "xm_menu:client:testMenu2",
                args = {
                    number = 1,
                }
            }
        }       
    }
    exports.xm_menu:openMenu(Menu)
end)

-- EXAMPLE OF SETTING PARAMETERS:
-- bool is true or false
params = {
    event = "your:event",
    isServer = bool,
    isCommand = bool,
    isQBCommand = bool,
    isAction = bool,
    args = {
        arg1 = ?,
        arg2 = ?
    }
}
```
