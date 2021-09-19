Config = {
    getESX = 'esx:getSharedObject',
    enableBlip = true,
    enableNPC = true,
    notif = "Appuyez sur %s pour accèder à la supérette.",
    cashType = 'money', -- basic esx money type, change that if this is not for your server
    bankType = 'bank', -- basic esx bank type, change that if this is not for your server
    menu = {
        menuTitle = "SHOPS",
        menuDescription = "∑ Welcome to the shop.",
        menuDescription2 = "∑ Choisissez votre moyen de paiement.",
        bannerMenuColor = {r = 0, g = 0, b = 0, opacity = 255},
    },
    messages = {
        eat = "Nourritures",
        drink = "Boissons",
        other = "Autres",
        category = "↓ ~b~%s ~s~↓",
        price = "~g~%s $",
        buyDesc = "Achetez x1 ~b~%s ~s~pour ~g~%s$.",
        moneyTypeDesc = "Payer en argent : ~g~%s",
        notifBuy = "Vous avez acheté x1 ~b~%s ~s~pour ~g~%s$ ~s~dans la catégorie %s.",
        dontHaveMoney = "~r~Vous n'avez pas assez d'argent, il vous manque ~g~%s$."
    },
    items = {
        categoryEat = {
            {name = 'bread', label = "Pain", price = 10},
            {name = 'sandwich', label = "Sandwich", price = 15},
        },
        categoryDrink = {
            {name = 'water', label = "Eau", price = 5},
            {name = 'coca', label = "Coca Cola", price = 6},
        },
        categoryOther = {
            {name = 'phone', label = "Téléphone", price = 100},
        }
    },
    shops = {
        marker = {
            distanceMarker = 10.0, -- for show marker (distance between ped and zones)
            markerType = 22,
            markerColor = {r = 255, g = 0, b = 0, opacity = 255}
        },
        zones = {
            {x = -48.324, y= -1757.468, z = 29.421, blipName = "Épicerie", blipSprite = 52, blipColor = 2, blipScale = 0.8},
        },
        npc = { -- Put the normal coordinates, the -1 is taken into account automatically, if you put -1 here the npc will be too low
            {x = -46.792, y = -1758.245, z = 29.421, heading = 50.322, model = "mp_m_shopkeep_01", dict = "mini@strip_club@idles@bouncer@base", anim = "base"},
        }
    }
}