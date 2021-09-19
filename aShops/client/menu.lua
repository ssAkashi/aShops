isMenuOpen = false
local Items = {}
local mainMenu = RageUI.CreateMenu(Config.menu.menuTitle, Config.menu.menuDescription)
local secondMenu = RageUI.CreateSubMenu(mainMenu, Config.menu.menuTitle, Config.menu.menuDescription2)
mainMenu:SetRectangleBanner(Config.menu.bannerMenuColor.r,Config.menu.bannerMenuColor.g,Config.menu.bannerMenuColor.b,Config.menu.bannerMenuColor.opacity)
secondMenu:SetRectangleBanner(Config.menu.bannerMenuColor.r,Config.menu.bannerMenuColor.g,Config.menu.bannerMenuColor.b,Config.menu.bannerMenuColor.opacity)
mainMenu.Closed = function()
    isMenuOpen = false
    table.remove(Items)
end
local hasMoney = false

function OpenShopMenu()
    if isMenuOpen then
        isMenuOpen = false
        RageUI.Visible(mainMenu, false)
    else
        isMenuOpen = true
        RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while isMenuOpen do
                Wait(0)
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Separator(Config.messages.category:format(Config.messages.eat))
                    for category,item in pairs(Config.items.categoryEat) do
                        RageUI.Button(item.label, Config.messages.buyDesc:format(item.label, item.price), { RightLabel = "→→" }, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback('aShops:getMoney', function(money) 
                                    if money >= item.price then
                                        hasMoney = true
                                    else
                                        ESX.ShowNotification(Config.messages.dontHaveMoney:format(item.price - money))
                                        isMenuOpen = false
                                    end
                                end)
                                table.insert(Items, {
                                    itemLabel    = item.label,
                                    itemName     = item.name,
                                    itemPrice    = item.price,
                                    itemCategory = Config.messages.eat
                                })
                            end
                        }, secondMenu)
                    end
                    RageUI.Separator(Config.messages.category:format(Config.messages.drink))
                    for category,item in pairs(Config.items.categoryDrink) do
                        RageUI.Button(item.label, Config.messages.buyDesc:format(item.label, item.price), { RightLabel = "→→" }, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback('aShops:getMoney', function(money) 
                                    if money >= item.price then
                                        hasMoney = true
                                    else 
                                        isMenuOpen = false
                                    end
                                end)
                                table.insert(Items, {
                                    itemLabel    = item.label,
                                    itemName     = item.name,
                                    itemPrice    = item.price,
                                    itemCategory = Config.messages.eat
                                })
                            end
                        }, secondMenu)
                    end
                    RageUI.Separator(Config.messages.category:format(Config.messages.other))
                    for category,item in pairs(Config.items.categoryOther) do
                        RageUI.Button(item.label, Config.messages.buyDesc:format(item.label, item.price), { RightLabel = "→→" }, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback('aShops:getMoney', function(money) 
                                    if money >= item.price then
                                        hasMoney = true
                                    else 
                                        isMenuOpen = false
                                    end
                                end)
                                table.insert(Items, {
                                    itemLabel    = item.label,
                                    itemName     = item.name,
                                    itemPrice    = item.price,
                                    itemCategory = Config.messages.eat
                                })
                            end
                        }, secondMenu)
                    end
                end)

                RageUI.IsVisible(secondMenu, function()
                    if IsControlJustPressed(0, 194) then
                        table.remove(Items)
                    end
                    RageUI.Separator("MOYEN DE PAIEMENT")
                    RageUI.Button('Cash', Config.messages.moneyTypeDesc:format("Cash"), {RightLabel = "→→" }, true, {
                        onSelected = function()
                            TriggerServerEvent('aShops:buyItem', Items[1].itemLabel, Items[1].itemName, Items[1].itemPrice, Items[1].itemCategory, Config.cashType)
                        end
                    })
                    RageUI.Button('Banque', Config.messages.moneyTypeDesc:format("Banque"), {RightLabel = "→→" }, true, {
                        onSelected = function()
                            TriggerServerEvent('aShops:buyItem', Items[1].itemLabel, Items[1].itemName, Items[1].itemPrice, Items[1].itemCategory, Config.bankType)
                        end
                    })
                end)
            end
        end)
    end
end