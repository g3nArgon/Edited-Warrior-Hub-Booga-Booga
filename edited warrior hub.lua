-- settings

getgenv().notificationcolor = Color3.fromRGB(80, 80, 80)
getgenv().autoloadinfyield = true -- true or false only if you wanna enable infinite yield automatically
getgenv().autoinfjump = true -- true or false only if u wanna enable infinite jump automatically
getgenv().autocleareffects = true -- if you want cleareffect to auto load
getgenv().autoclearrain = true-- if you want clearrain to auto load
getgenv().autounamedesp = true -- if you want unnamedesp to auto load

--[[


for some reason the functions below arent working and im too lazy to put them back


]]
getgenv().tpspammode = "Around (Best)" -- mode for spam tp
getgenv().tpupval = 10 -- tp distance (spam tp)
getgenv().HealItem = "Bloodfruit" --autoheal item (make sure it is in text form) -
getgenv().speed = 10 -- speed multipler -
getgenv().speedkey = "f" -- speed key (make sure it is a lowercase key) - 
getgenv().loop2 = true -- toggle of speed ^ - 
getgenv().abKey = "g" -- auto break key (make sure it is a lowercase key) - 
getgenv().breaking = true -- auto break toggle (true or false only) -
getgenv().adItem = nil -- i think this is the table for specific items to autodrop (should be held like {"Bloodfruit", "stick"}
getgenv().adKey = "f" -- keybind for autodrop (make sure it is a lowercase key)
getgenv().EatItem = nil -- auto eat item (make sure it is in quotations so for example "Bloodfruit")
getgenv().HungerCheck = false
getgenv().EatUnderSlider = 80 -- eat under what % of hunger only 1 to 100
getgenv().FarmingObject = nil -- custom target for autofarming (make sure it is in quotations so for example "Stone Shelly")
getgenv().TimeBetweenEach = 1 -- time between auto farming

-- ignore stuff
getgenv().speedState = true -- ignore
getgenv().abState = false
getgenv().dropping = false
getgenv().autoDropState = false
getgenv().Hunger = nil

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/vep1032/VepStuff/main/VL"))()
local NotificationHolder =
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
local inviteModule =
    loadstring(
    game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Discord%20Inviter/Source.lua")
)()
local s = VLib:Window("Warrior Hub", "Edited Version", "W")
getgenv().notifColor = Color3.fromRGB(getgenv().notificationcolor)



--Main

local Main = s:Tab("Main")
Main:Label("Warrior Hub - Edited")
Main:Label("Toggle GUI with RCTRL")
Main:Label("Edited By GeneralOfAR")
Main:Button(
    "Destroy GUI",
    function()
        game:GetService("CoreGui").Library:Destroy()
    end
)
Main:Button(
    "Join Discord",
    function()
        inviteModule.Join("https://discord.gg/EdHhqP7TzZ")
    end
)
Main:Colorpicker(
    "Notification Color",
    Color3.fromRGB(80, 80, 80),
    function(t)
        getgenv().notifColor = t
    end
)
Main:Button(
    "Credits",
    function()
        Notification:Notify(
            {
                Title = "Credits",
                Description = "Vinyxu for Discord Prompt, BocusLuke for Notifications, Booga Bitches, Engo/Future and me lol (edited by generalofar and g3n)"
            },
            {OutlineColor = getgenv().notifColor, Time = 5, Type = "default"}
        )
    end
)

--Combat

local Combat = s:Tab("Combat")
getgenv().killing = false
--thx to engo future for isAlive and canBeTargeted functions :) i'm too lazy to make something like this lol
local function isAlive(plr)
    local plr = plr or game:GetService("Players").LocalPlayer
    if
        plr and plr.Character and
            ((plr.Character:FindFirstChild("Humanoid")) and
                (plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("Humanoid").Health > 0) and
                (plr.Character:FindFirstChild("HumanoidRootPart")) and
                (plr.Character:FindFirstChild("Head")))
     then
        return true
    end
end
local function canBeTargeted(plr, doTeamCheck)
    if
        isAlive(plr) and plr ~= game:GetService("Players").LocalPlayer and
            (doTeamCheck and plr.Team ~= game:GetService("Players").LocalPlayer.Team or not doTeamCheck) and
            plr.Name ~= "balls" and
            plr.Name ~= "ballsnumber2"
     then
        return true
    end
    return false
end
local function useAura()
    spawn(
        function()
            while getgenv().killing == true and wait(0.1) do
                for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                    if
                        isAlive() and canBeTargeted(v, false) and
                            (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position -
                                v.Character.HumanoidRootPart.Position).magnitude < 20
                     then
                        local rTV = game:GetService("ReplicatedStorage").RelativeTime.Value
                        local attackTable = {
                            [1] = game:GetService("Workspace").Characters[v.Name].LeftUpperLeg
                        }
                        game:GetService("ReplicatedStorage").Events.SwingTool:FireServer(rTV, attackTable)
                    end
                end
            end
        end
    )
end
Combat:Toggle(
    "Kill Aura",
    function(t)
        getgenv().killing = t
        useAura()
    end
)
getgenv().tpspamv = nil
getgenv().tpupval = 0
getgenv().tpspammode = "Normal"
getgenv().tping = false
Combat:Toggle(
    "Teleport Spam",
    function(t)
        getgenv().tping = t
        spawn(
            function()
                while getgenv().tping and wait(0.1) do
                    for i, v in pairs(game:GetService("Players"):GetChildren()) do
                        if v.Name:lower():find(getgenv().tpspamv:lower()) then
                            if v.Name == "balls" or v.Name == "balls2" then
                                Notification:Notify(
                                    {Title = "TP Spam", Description = "You cant't kill this person"},
                                    {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
                                )
                                return
                            elseif getgenv().tpspammode == "Normal" then
                                player = game:GetService("Players").LocalPlayer.Character
                                player.HumanoidRootPart.CFrame =
                                    CFrame.new(
                                    v.Character.HumanoidRootPart.Position.x,
                                    v.Character.HumanoidRootPart.Position.y,
                                    v.Character.HumanoidRootPart.Position.z
                                )
                            elseif getgenv().tpspammode == "Up" then
                                player = game:GetService("Players").LocalPlayer.Character
                                player.HumanoidRootPart.CFrame =
                                    CFrame.new(
                                    v.Character.HumanoidRootPart.Position.x,
                                    v.Character.HumanoidRootPart.Position.y + getgenv().tpupval,
                                    v.Character.HumanoidRootPart.Position.z
                                )
                            elseif getgenv().tpspammode == "Down" then
                                player = game:GetService("Players").LocalPlayer.Character
                                player.HumanoidRootPart.CFrame =
                                    CFrame.new(
                                    v.Character.HumanoidRootPart.Position.x,
                                    v.Character.HumanoidRootPart.Position.y - getgenv().tpupval,
                                    v.Character.HumanoidRootPart.Position.z
                                )
                            elseif getgenv().tpspammode == "Around (Best)" then
                                player = game:GetService("Players").LocalPlayer.Character
                                player.HumanoidRootPart.CFrame =
                                    CFrame.new(
                                    v.Character.HumanoidRootPart.Position.x + math.random(-7, 7),
                                    v.Character.HumanoidRootPart.Position.y,
                                    v.Character.HumanoidRootPart.Position.z + math.random(-7, 7)
                                )
                            end
                        end
                    end
                    if getgenv().tping then
                        game:GetService("Workspace").Gravity = 0
                        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = 0
                    end
                    if not getgenv().tping then
                        game:GetService("Workspace").Gravity = 196.2
                        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = getgenv().GJumpPower
                    end
                end
            end
        )
    end
)
Combat:Dropdown(
    "TP Spam Mode",
    {"Around (Best)", "Up", "Down", "Normal"},
    function(t)
        getgenv().tpspammode = t
    end
)
Combat:Slider(
    "TP Spam Distance",
    0,
    10,
    0,
    function(t)
        getgenv().tpupval = t
    end
)
Combat:Textbox(
    "TP Spam Name",
    true,
    function(t)
        getgenv().tpspamv = t
        Notification:Notify(
            {Title = "TP Spam", Description = "Name set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Combat:Textbox(
    "Normal TP",
    true,
    function(t)
        for i, v in pairs(game:GetService("Players"):GetChildren()) do
            if v.Name:lower():find(t:lower()) then
                if v.Name == "balls" or v.Name == "balls2" then
                    Notification:Notify(
                        {Title = "TP Spam", Description = "You cant't kill this person"},
                        {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
                    )
                    return
                else
                    local player = game:GetService("Players").LocalPlayer.Character
                    player.HumanoidRootPart.CFrame =
                        CFrame.new(
                        v.Character.HumanoidRootPart.Position.x,
                        v.Character.HumanoidRootPart.Position.y,
                        v.Character.HumanoidRootPart.Position.z
                    )
                end
            end
        end
    end
)
getgenv().HealthCheck = false
getgenv().Health = nil
local function checkHealth()
    spawn(
        function()
            while getgenv().HealthCheck == true and wait() do
                getgenv().Health = game:GetService("Players").LocalPlayer.Character.Humanoid.Health
                --print(Health)
            end
        end
    )
end
local function heal()
    spawn(
        function()
            while wait(1) and getgenv().HealthCheck == true do
                if getgenv().Health ~= 100 and getgenv().HealItem ~= nil then
                    repeat
                        game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer(getgenv().HealItem)
                        wait(0.15)
                    until getgenv().Health == 100
                end
            end
        end
    )
end
Combat:Toggle(
    "Auto Heal",
    function(t)
        getgenv().HealthCheck = t
        checkHealth()
        heal()
    end
)
Combat:Textbox(
    "Auto Heal Item",
    true,
    function(t)
        getgenv().HealItem = t
        Notification:Notify(
            {Title = "Auto Heal", Description = "Item set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)

--Movement

local Movement = s:Tab("Movement")
Movement:Toggle(
    "Speed (Hold Key)",
    function(t)
        getgenv().speedState = t
        spawn(
            function()
                local plr = game:GetService("Players").LocalPlayer
                local char = plr.Character
                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                local hum = char:FindFirstChild("HumanoidRootPart")
                mouse.KeyDown:connect(
                    function(key)
                        if key == getgenv().speedkey:lower() and getgenv().speedState then
                            getgenv().loop2 = true
                            while getgenv().loop2 do
                                hum.CFrame = hum.CFrame + hum.CFrame.lookVector * getgenv().speed
                                wait()
                            end
                        end
                    end
                )
                mouse.KeyUp:connect(
                    function(key)
                        if key == getgenv().speedkey:lower() then
                            getgenv().loop2 = false
                        end
                    end
                )
            end
        )
    end
)
Movement:Slider(
    "Speed Multiplier",
    0,
    100,
    3,
    function(t)
        getgenv().speed = t
    end
)
Movement:Textbox(
    "Speed Key",
    true,
    function(t)
        getgenv().speedkey = t
        Notification:Notify(
            {Title = "Speed", Description = "Keybind set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
getgenv().GJumpPower = 50
Movement:Button(
    "Infinity Jump",
    function()
        local Player = game:GetService "Players".LocalPlayer
        local UIS = game:GetService "UserInputService"
        local function Action(Object, Function)
            if Object ~= nil then
                Function(Object)
            end
        end
        UIS.InputBegan:connect(
            function(UserInput)
                if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
                    Action(
                        Player.Character.Humanoid,
                        function(self)
                            if
                                self:GetState() == Enum.HumanoidStateType.Jumping or
                                    self:GetState() == Enum.HumanoidStateType.Freefall
                             then
                                Action(
                                    self.Parent.HumanoidRootPart,
                                    function(self)
                                        self.Velocity = Vector3.new(0, getgenv().GJumpPower, 0)
                                    end
                                )
                            end
                        end
                    )
                end
            end
        )
    end
)
Movement:Slider(
    "Jump Power",
    0,
    300,
    50,
    function(t)
        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = t
        getgenv().GJumpPower = t
    end
)
Movement:Button(
    "Fly (E to toggle)",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/9tZMx4SW"))()
    end
)
Movement:Button(
    "Sit",
    function()
        game:GetService("Workspace").Characters[game.Players.LocalPlayer.Name].Humanoid.Sit = true
    end
)
Movement:Textbox(
    "Click TP Button",
    true,
    function(t)
        getgenv().tpthing = t
        Notification:Notify(
            {Title = "Click/SelectedButton to tp", Description = "Keybind set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Movement:Button(
    "Click/SelectedButton to tp",
    function()
        local plr = game.Players.LocalPlayer
        hum = plr.Character.HumanoidRootPart
        mouse = plr:GetMouse()

        mouse.KeyDown:connect(
            function(key)
                if key == getgenv().tpthing then
                    if mouse.Target then
                        hum.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
                    end
                end
            end
        )
    end
)

--Auto

local Auto = s:Tab("Auto")
Auto:Toggle(
    "Auto Break (Aim and Hold Key)",
    function(t)
        getgenv().abState = t
        spawn(
            function()
                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                mouse.KeyDown:connect(
                    function(key)
                        if key == getgenv().abKey and getgenv().abState then
                            getgenv().breaking = true
                            while getgenv().breaking and wait(0.01) do
                                local part = game:GetService("Players").LocalPlayer:GetMouse().Target
                                local one = game:GetService("ReplicatedStorage").RelativeTime.Value
                                local two = {part, part, part, part}
                                game:GetService("ReplicatedStorage").Events.SwingTool:FireServer(one, two)
                            end
                        end
                    end
                )
                mouse.KeyUp:connect(
                    function(key)
                        if key == getgenv().abKey then
                            getgenv().breaking = false
                        end
                    end
                )
            end
        )
    end
)
Auto:Textbox(
    "Auto Break Key",
    true,
    function(t)
        getgenv().abKey = t:lower()
        Notification:Notify(
            {Title = "Auto Break", Description = "Key set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
getgenv().autoPickUpPicking = false
local function useAutoPickUp()
    spawn(
        function()
            while getgenv().autoPickUpPicking == true do
                for _, v in pairs(game:GetService("Workspace").Items:GetChildren()) do
                    if
                        v ~= nil and v.PrimaryPart ~= nil and
                            (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position -
                                v.PrimaryPart.Position).magnitude < 20
                     then
                        game:GetService("ReplicatedStorage").Events.PickupItem:InvokeServer(v)
                    end
                end
                game:GetService("RunService").RenderStepped:wait()
            end
        end
    )
end
Auto:Toggle(
    "Auto Pick Up",
    function(t)
        getgenv().autoPickUpPicking = t
        useAutoPickUp()
    end
)
getgenv().autoTPPUItem = nil
getgenv().autoTPPickUpMode = "Item Select"
getgenv().autoTPPickUp = false
Auto:Toggle(
    "Auto TP Pick Up",
    function(t)
        getgenv().autoTPPickUp = t
        spawn(
            function()
                while getgenv().autoTPPickUp == true and wait(1.5) do
                    if getgenv().autoTPPickUpMode == "Item Select" then
                        for _, v in pairs(game:GetService("Workspace").Items:GetChildren()) do
                            if v ~= nil and v.Name == getgenv().autoTPPUItem then
                                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                                    v.PrimaryPart.CFrame
                                wait(1)
                                game:GetService("ReplicatedStorage").Events.PickupItem:InvokeServer(v)
                                if getgenv().autoTPPickUp == false then
                                    break
                                end
                            end
                        end
                    elseif getgenv().autoTPPickUpMode == "Any" then
                        for _, v in pairs(game:GetService("Workspace").Items:GetChildren()) do
                            if v ~= nil and v.Name ~= "fafgdf" then
                                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                                    v.PrimaryPart.CFrame
                                wait(1)
                                game:GetService("ReplicatedStorage").Events.PickupItem:InvokeServer(v)
                                if getgenv().autoTPPickUp == false then
                                    break
                                end
                            end
                        end
                    end
                end
                if getgenv().autoTPPickUp then
                    game:GetService("Workspace").Gravity = 0
                    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = 0
                end
                if not getgenv().autoTPPickUp then
                    game:GetService("Workspace").Gravity = 196.2
                    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = getgenv().GJumpPower
                end
            end
        )
    end
)
Auto:Dropdown(
    "Auto TP Pick Up Mode",
    {"Item Select", "Any"},
    function(t)
        getgenv().autoTPPickUpMode = t
    end
)
Auto:Textbox(
    "Auto TP Pick Up Item",
    true,
    function(t)
        getgenv().autoTPPUItem = t
        Notification:Notify(
            {Title = "Auto TP Pick Up", Description = "Item set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Auto:Toggle(
    "Auto Drop (Hold Key)",
    function(t)
        getgenv().autoDropState = t
        spawn(
            function()
                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                mouse.KeyDown:connect(
                    function(key)
                        if key == getgenv().adKey and getgenv().autoDropState then
                            getgenv().dropping = true
                            while getgenv().dropping and wait() do
                                local asd = getgenv().adItem
                                game:GetService("ReplicatedStorage").Events.DropBagItem:FireServer(asd)
                            end
                        end
                    end
                )
                mouse.KeyUp:connect(
                    function(key)
                        if key == getgenv().adKey then
                            getgenv().dropping = false
                        end
                    end
                )
            end
        )
    end
)
Auto:Textbox(
    "Auto Drop Item",
    true,
    function(t)
        getgenv().adItem = t
        Notification:Notify(
            {Title = "Auto Drop", Description = "Item set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Auto:Textbox(
    "Auto Drop Key",
    true,
    function(t)
        getgenv().adKey = t
        Notification:Notify(
            {Title = "Auto Drop", Description = "Key set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
getgenv().EatUnder = getgenv().EatUnderSlider .. "%"
local function checkHunger()
    spawn(
        function()
            while getgenv().HungerCheck == true and wait() do
                getgenv().Hunger =
                    game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Panels.Toolbar.Stats.PlayerStats.Hunger.AmountLabel.Text
            end
        end
    )
end
local function eat()
    spawn(
        function()
            while wait(1) and getgenv().HungerCheck == true do
                if getgenv().Hunger <= getgenv().EatUnder and getgenv().EatItem ~= nil then
                    repeat
                        game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer(getgenv().EatItem)
                        wait(0.15)
                    until getgenv().Hunger >= getgenv().EatUnder
                end
            end
        end
    )
end
Auto:Toggle(
    "Auto Eat",
    function(t)
        getgenv().HungerCheck = t
        checkHunger()
        eat()
    end
)
Auto:Textbox(
    "Auto Eat Item",
    true,
    function(t)
        getgenv().EatItem = t
        Notification:Notify(
            {Title = "Auto Eat", Description = "Item set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Auto:Slider(
    "Auto Eat Hunger",
    1,
    100,
    80,
    function(t)
        getgenv().EatUnderSlider = t
    end
)

--Misc

local Misc = s:Tab("Misc")
Misc:Toggle(
    "Color Changing Skin (Laggy on very bad pcs)",
    function(t)
        getgenv().cCS = t
        spawn(
            function()
                while getgenv().cCS and wait(0.3) do
                    wait(0.15)
                    do
                        local ohString1 = "skin"
                        local ohString2 = "Dark Brown"
                        game:GetService("ReplicatedStorage").Events.CosmeticChange:FireServer(ohString1, ohString2)
                    end
                    wait(0.15)
                    do
                        local ohString3 = "skin"
                        local ohString4 = "Tan"
                        game:GetService("ReplicatedStorage").Events.CosmeticChange:FireServer(ohString3, ohString4)
                    end
                    wait(0.15)
                    do
                        local ohString5 = "skin"
                        local ohString6 = "White"
                        game:GetService("ReplicatedStorage").Events.CosmeticChange:FireServer(ohString5, ohString6)
                    end
                    wait(0.15)
                    do
                        local ohString7 = "skin"
                        local ohString8 = "Pale"
                        game:GetService("ReplicatedStorage").Events.CosmeticChange:FireServer(ohString7, ohString8)
                    end
                end
            end
        )
    end
)
Misc:Textbox(
    "Craft Item",
    true,
    function(t)
        local crString1 = t
        game:GetService("ReplicatedStorage").Events.CraftItem:FireServer(crString1)
        Notification:Notify(
            {Title = "Craft", Description = "Attemped to craft " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Misc:Button(
    "Craft Lvl 1000 Golden Boat (you have to be on water)",
    function()
        local ohCFrame2 =
            CFrame.new(
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.x,
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.y,
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.z,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            1
        )
        local ohNumber3 = 0
        game:GetService("ReplicatedStorage").Events.PlaceStructure:FireServer("Golden Sailboat", ohCFrame2, ohNumber3)
        Notification:Notify(
            {Title = "Craft", Description = "Attemped to craft Golden Sailboat"},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Misc:Button(
    "Craft Mag Set",
    function()
        game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("Magnetite Mask")
        game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("Magnetite Chestplate")
        game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("Magnetite Greaves")
        game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("Magnetite Stick")
        game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("Magnetite Pick")
        game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("Magnetite Axe")
        Notification:Notify(
            {Title = "Craft", Description = "Attemped to craft a mag set"},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Misc:Dropdown(
    "Shelly Teleports",
    {"Random Small Shelly", "Random Big Shelly", "Random Giant Shelly"},
    function(t)
        if t == "Random Small Shelly" then
            shelly = "Stone Shelly"
        elseif t == "Random Big Shelly" then
            shelly = "Big Stone Shelly"
        elseif t == "Random Giant Shelly" then
            shelly = "Giant Shelly"
        end
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
            game:GetService("Workspace").Critters[shelly].Head.CFrame
    end
)
Misc:Dropdown(
    "Meteor Teleports",
    {"Crystal Meteor", "Magnetite Meteor"},
    function(t)
        if t == "Crystal Metor" then
            meteor = "Crystal Meteor Core"
        elseif t == "Magnetite Meteor" then
            meteor = "Meteor Core"
        end
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
            game:GetService("Workspace").Resources[meteor].PrimaryPart.CFrame
    end
)
Misc:Dropdown(
    "Ore and Other Teleports",
    {"Coal Node", "Iron Node", "Gold Node", "Stone Node", "Dead Tree", "Goober", "Beached Boi"},
    function(t)
        if t == "Beached Boi" then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                game:GetService("Workspace").Resources[t].Tail.CFrame
        else
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                game:GetService("Workspace").Resources[t].PrimaryPart.CFrame
        end
    end
)
Misc:Dropdown(
    "Deployable Teleports",
    {"Chest", "Plant Box"},
    function(t)
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
            game:GetService("Workspace").Deployables[t].PrimaryPart.CFrame
    end
)
Misc:Dropdown(
    "Lobbys",
    {"Unused Lobby", "Lobby"},
    function(t)
        if t == "Unused Lobby" then
            coordinatesx = -189
            coordinatesy = -3
            coordinatesz = 17004
        else
            coordinatesx = -1683
            coordinatesy = -3
            coordinatesz = -4144
        end
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
            game:GetService("Players").LocalPlayer.Character:MoveTo(
            Vector3.new(coordinatesx, coordinatesy, coordinatesz)
        )
    end
)
Misc:Button(
    "Infinity Yield",
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
)
Misc:Button(
    "Server Hop",
    function()
        local Servers =
            game.HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/4787629450/servers/Public?sortOrder=Asc&limit=100")
        )
        for i, v in pairs(Servers.data) do
            if v.playing ~= v.maxPlayers then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
            end
        end
    end
)

--Auto Farm

local AutoFarm = s:Tab("Auto Farm")
AutoFarm:Label("You should use auto pick up for collecting")
AutoFarm:Label("Equip a pick or an axe depending on what you select")
getgenv().farmingMineTarget = nil
getgenv().farming = false
getgenv().autoFarmTping = false
getgenv().farmingMode = "Resources"
local function farm()
    spawn(
        function()
            while getgenv().farming do
                getgenv().farmingMineTarget =
                    game:GetService("Workspace")[getgenv().farmingMode][getgenv().FarmingObject].PrimaryPart
                local af2Table2 = {
                    [1] = getgenv().farmingMineTarget
                }
                local af2Number1 = game:GetService("ReplicatedStorage").RelativeTime.Value
                game:GetService("ReplicatedStorage").Events.SwingTool:FireServer(af2Number1, af2Table2)
                wait()
            end
        end
    )
end
local function farmtp()
    spawn(
        function()
            while getgenv().autoFarmTping do
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                    CFrame.new(
                    game:GetService("Workspace")[getgenv().farmingMode][getgenv().FarmingObject].PrimaryPart.Position.x,
                    game:GetService("Workspace")[getgenv().farmingMode][getgenv().FarmingObject].PrimaryPart.Position.y +
                        3,
                    game:GetService("Workspace")[getgenv().farmingMode][getgenv().FarmingObject].PrimaryPart.Position.z
                )
                wait(getgenv().TimeBetweenEach)
            end
        end
    )
end
AutoFarm:Toggle(
    "Auto Farm",
    function(t)
        getgenv().farming = t
        getgenv().autoFarmTping = t
        farm()
        farmtp()
        if getgenv().farming then
            game:GetService("Workspace").Gravity = 0
            game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = 0
        end
        if not getgenv().farming then
            game:GetService("Workspace").Gravity = 196.2
            game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = getgenv().GJumpPower
        end
    end
)
AutoFarm:Dropdown(
    "Mode",
    {"Resources", "Critters", "Deployables"},
    function(t)
        getgenv().farmingMode = t
    end
)
AutoFarm:Dropdown(
    "Target",
    {
        "Iron Node",
        "Coal Node",
        "Magnetite Iceberg",
        "Totem of the Moon",
        "Dead Tree",
        "Gold Node",
        "Stone Node",
        "Ancient Tree",
        "Ancient Feather Tree",
        "Stone Shelly"
    },
    function(t)
        getgenv().FarmingObject = t
        Notification:Notify(
            {Title = "Auto Farm", Description = "Target set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
AutoFarm:Textbox(
    "Custom Target",
    true,
    function(t)
        getgenv().FarmingObject = t
        Notification:Notify(
            {Title = "Auto Farm", Description = "Target set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
getgenv().autoPlantPlant = "Bloodfruit"
AutoFarm:Slider(
    "Wait Time",
    0.1,
    15,
    1,
    function(t)
        getgenv().TimeBetweenEach = t
    end
)
AutoFarm:Label("For Auto Plant item don't write the plant name")
AutoFarm:Label("Write the name of the item you use to plant it")
getgenv().autoPlantPlant = nil
getgenv().planting = false
AutoFarm:Toggle(
    "Auto Plant",
    function(t)
        getgenv().planting = t
        spawn(
            function()
                while getgenv().planting == true and wait() do
                    for _, v in pairs(game:GetService("Workspace").Deployables:GetChildren()) do
                        if
                            v.Name == "Plant Box" and
                                (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position -
                                    v.PrimaryPart.Position).magnitude < 60
                         then
                            game.ReplicatedStorage.Events.InteractStructure:FireServer(v, getgenv().autoPlantPlant)
                        end
                    end
                end
            end
        )
    end
)
AutoFarm:Textbox(
    "Auto Plant Item",
    true,
    function(t)
        getgenv().autoPlantPlant = t
        Notification:Notify(
            {Title = "Auto Plant", Description = "Item set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)

--Render

local Render = s:Tab("Render")
Render:Button(
    "Remove Rain",
    function()
        if workspace:FindFirstChild("RainPart") ~= nil then
            game:GetService("Workspace").RainPart:Destroy()
            game.ReplicatedStorage.Sounds.Nature.Rain:Stop()
            game.ReplicatedStorage.Sounds.Nature.Thunder:Stop()
            game.Lighting.Rain:Destroy()
            game.ReplicatedStorage.Skies.Shine:Clone().Parent = game.Lighting
        end
    end
)
Render:Slider(
    "Fov",
    0,
    120,
    70,
    function(t)
        game:GetService "Workspace".Camera.FieldOfView = t
    end
)
Render:Button(
    "UnnamedESP",
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua", true))(

        )
    end
)
Render:Button(
    "Clear Effects",
    function()
        game.Lighting.FogEnd = 1200000
        game.Lighting.Brightness = 3
        game.Lighting.GlobalShadows = false
    end
)

--Building

local Building = s:Tab("Building")
Building:Button(
    "Place Chest Campfire (1 Chest, 4 Campfires)",
    function()
        local Fires = 1
        local Event = game:GetService("ReplicatedStorage").Events.PlaceStructure
        h = game:GetService("Players").LocalPlayer.Character.LowerTorso.Position
        local c = h.x + 5
        local d = h.y - 2
        local e = h.z
        local j = h.x
        local k = h.y - 2
        local l = h.z
        local aa = h.x - 5
        local bb = h.y - 2
        local cc = h.z
        local aaa = h.x
        local bbb = h.y - 2
        local ccc = h.z + 5
        local aaaa = h.x
        local bbbb = h.y - 2
        local cccc = h.z - 5
        for i = 1, 1 do
            local C_1 = "Chest"
            local C_2 = CFrame.new(j, k, l, 1, 0, 0, 0, 1, -5.56028681e-08, 0, -5.56028681e-08, 1)
            local C_3 = 0
            Event:FireServer(C_1, C_2, C_3)
        end
        for i = 1, Fires do
            local A_1 = "Campfire"
            local A_2 = CFrame.new(c, d, e, 1, 0, 0, 0, 1, -5.56028681e-08, 0, -5.56028681e-08, 1)
            local A_3 = 0
            Event:FireServer(A_1, A_2, A_3)
        end
        for i = 1, Fires do
            local B_1 = "Campfire"
            local B_2 = CFrame.new(aa, bb, cc, 1, 0, 0, 0, 1, -5.56028681e-08, 0, -5.56028681e-08, 1)
            local B_3 = 0
            Event:FireServer(B_1, B_2, B_3)
        end
        for i = 1, Fires do
            local D_1 = "Campfire"
            local D_2 = CFrame.new(aaa, bbb, ccc, 1, 0, 0, 0, 1, -5.56028681e-08, 0, -5.56028681e-08, 1)
            local D_3 = 0
            Event:FireServer(D_1, D_2, D_3)
        end
        for i = 1, Fires do
            local E_1 = "Campfire"
            local E_2 = CFrame.new(aaaa, bbbb, cccc, 1, 0, 0, 0, 1, -5.56028681e-08, 0, -5.56028681e-08, 1)
            local E_3 = 0
            Event:FireServer(E_1, E_2, E_3)
        end
    end
)
Building:Button(
    "Place Plant Box",
    function()
        local ohCFrame2 =
            CFrame.new(
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.x,
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.y - 3,
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.z,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            1
        )
        local ohNumber3 = 0
        game:GetService("ReplicatedStorage").Events.PlaceStructure:FireServer("Plant Box", ohCFrame2, ohNumber3)
    end
)
Building:Button(
    "Egg Farm (4 Nests, 2 Campfires)",
    function()
        local ohCFrame2 =
            CFrame.new(
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.x,
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.y - 3,
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.z,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            1
        )
        local ohNumber3 = 0
        local ohCFrame3 =
            CFrame.new(
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.x + 2,
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.y - 3,
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.z,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            1
        )
        game:GetService("ReplicatedStorage").Events.PlaceStructure:FireServer("Nest", ohCFrame2, ohNumber3)
        game:GetService("ReplicatedStorage").Events.PlaceStructure:FireServer("Nest", ohCFrame2, ohNumber3)
        game:GetService("ReplicatedStorage").Events.PlaceStructure:FireServer("Nest", ohCFrame2, ohNumber3)
        game:GetService("ReplicatedStorage").Events.PlaceStructure:FireServer("Nest", ohCFrame2, ohNumber3)
        game:GetService("ReplicatedStorage").Events.PlaceStructure:FireServer("Campfire", ohCFrame2, ohNumber3)
        game:GetService("ReplicatedStorage").Events.PlaceStructure:FireServer("Campfire", ohCFrame3, ohNumber3)
    end
)
Building:Button(
    "Place Stone Floor",
    function()
        local A_1 = "Stone Wall"
        local A_2 =
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -4, -4) *
            CFrame.Angles(4.7, 0, 0)
        local A_3 = 0
        local Event = game:GetService("ReplicatedStorage").Events.PlaceStructure
        Event:FireServer(A_1, A_2, A_3)
    end
)
Building:Textbox(
    "Item To Place",
    true,
    function(t)
        getgenv().buildthing = t
        Notification:Notify(
            {Title = "Selected Item", Description = "Item set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Building:Textbox(
    "Loop Amount",
    true,
    function(t)
        getgenv().loopamountthing = t
        Notification:Notify(
            {Title = "Selected Loop Amount", Description = "Loop amount set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Building:Textbox(
    "X Position",
    true,
    function(t)
        getgenv().buildxposition = t
        Notification:Notify(
            {Title = "Selected X Position", Description = "X Position set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Building:Textbox(
    "Y Position",
    true,
    function(t)
        getgenv().builyxposition = t
        Notification:Notify(
            {Title = "Selected Y Position", Description = "Y Position set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Building:Textbox(
    "Z Position",
    true,
    function(t)
        getgenv().buildzposition = t
        Notification:Notify(
            {Title = "Selected Z Position", Description = "Z Position set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Building:Textbox(
    "X Rotation",
    true,
    function(t)
        getgenv().buildxrotation = t
        Notification:Notify(
            {Title = "Selected X Rotation", Description = "X Rotation set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Building:Textbox(
    "Y Rotation",
    true,
    function(t)
        getgenv().builyxrotation = t
        Notification:Notify(
            {Title = "Selected Y Rotation", Description = "Y Rotation set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Building:Textbox(
    "Z Rotation",
    true,
    function(t)
        getgenv().buildzrotation = t
        Notification:Notify(
            {Title = "Selected Z Rotation", Description = "Z Rotation set to " .. t},
            {OutlineColor = getgenv().notifColor, Time = 3, Type = "default"}
        )
    end
)
Building:Button(
    "Place Custom",
    function()
        local A_1 = tostring(getgenv().buildthing)
        local A_4 = getgenv().buildxposition, getgenv().buildyposition, getgenv().buildzposition
        local A_5 = getgenv().buildxrotation, getgenv().buildyrotation, getgenv().buildzrotation
        local A_2 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(A_4) * CFrame.Angles(A_5)
        local A_3 = 0
        local Event = game:GetService("ReplicatedStorage").Events.PlaceStructure
        Event:FireServer(A_1, A_2, A_3)
    end
)

-- trolling - completely made by g3n

local Trolling = s:Tab("Trolling")
Trolling:Label("Godmode removes all playability (cannot damage things)")
Trolling:Button(
    "Godmode",
    function()
        local lplayer = game.Players.LocalPlayer
        lplayer.Character.Humanoid.Name = 1
        local l = lplayer.Character["1"]:Clone()
        l.Parent = lplayer.Character
        l.Name = "Humanoid"
        wait(0.1)
        lplayer.Character["1"]:Destroy()
        game:GetService("Workspace").CurrentCamera.CameraSubject = lplayer.Character
        lplayer.Character.Animate.Disabled = true
        wait(0.1)
        lplayer.Character.Animate.Disabled = false
        lplayer.Character.Humanoid.DisplayDistanceType = "None"
    end
)
Trolling:Button(
    "Stuck Animation",
    function()
        game.Players.LocalPlayer.Character.Animate.Disabled = true
    end
)
Trolling:Button(
    "No Animation",
    function()
        game.Players.LocalPlayer.Character.Animate.Disabled:Destroy()
    end
)
Trolling:Button(
    "Block Head",
    function()
        game.Players.LocalPlayer.Character.Head.Mesh:Destroy()
    end
)
Trolling:Button(
    "No Face",
    function()
        game.Players.LocalPlayer.Character.Head.Face:Destroy()
    end
)
Trolling:Button(
    "Invisible",
    function()
        -- tp body to some place safe first
        game.Players.LocalPlayer.Character.LowerTorso:Destroy()
    end
)

-- settings setup yey

if getgenv().autocleareffects == true then
    game.Lighting.FogEnd = 1200000
    game.Lighting.Brightness = 3
    game.Lighting.GlobalShadows = false
end
if getgenv().autoclearrain == true then
    if workspace:FindFirstChild("RainPart") ~= nil then
        game:GetService("Workspace").RainPart:Destroy()
        game.ReplicatedStorage.Sounds.Nature.Rain:Stop()
        game.ReplicatedStorage.Sounds.Nature.Thunder:Stop()
        game.Lighting.Rain:Destroy()
        game.ReplicatedStorage.Skies.Shine:Clone().Parent = game.Lighting
    end
end
if getgenv().autounamedesp == true then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua", true))()
end
if getgenv().autoloadinfyield == true then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end
if getgenv().autoinfjump == true then
    local Player = game:GetService'Players'.LocalPlayer;
    local UIS = game:GetService'UserInputService';
    local function Action(Object, Function) if Object ~= nil then Function(Object); end end
    UIS.InputBegan:connect(function(UserInput)
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
            Action(Player.Character.Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(self.Parent.HumanoidRootPart, function(self)
                        self.Velocity = Vector3.new(0, getgenv().GJumpPower, 0);
                    end)
                end
            end)
        end
    end)
end
