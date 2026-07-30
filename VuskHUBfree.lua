local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Vusk HUB",
    Icon = 0,
    LoadingTitle = "Vusk HUB",
    LoadingSubtitle = "by VuskScripts",
    ShowText = "VuskHUB",
    Theme = "Default",

    ToggleUIKeybind = "K",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = true,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "VuskHub"
    },

    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    
    KeySystem = true,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Free Version",
        Note = "Key: 1926 ",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"1926"}
    }
})

----------------------------------------------------
-- TABS
----------------------------------------------------

local MainTab = Window:CreateTab("Home", "home")
local SettingsTab = Window:CreateTab("Settings", "settings")
local UniversalTab = Window:CreateTab("Universal", "globe")
local ForestTab = Window:CreateTab("99 Nights in the Forest", "trees")
local MuscleTab = Window:CreateTab("Muscle Legends", "dumbbell")

----------------------------------------------------
-- HOME TAB
----------------------------------------------------

MainTab:CreateLabel("Vusk HUB v1.2")
MainTab:CreateLabel("Free Version")
MainTab:CreateDivider()
MainTab:CreateLabel("📍 Supported Games")
MainTab:CreateLabel("• 99 Nights in the Forest")
MainTab:CreateLabel("• Muscle Legends")

----------------------------------------------------
-- SETTINGS TAB
----------------------------------------------------

SettingsTab:CreateLabel("⚙️ Vusk HUB Settings")
SettingsTab:CreateDivider()
SettingsTab:CreateLabel("📦 Version: v1.2")
SettingsTab:CreateLabel("🆓 Edition: Free")
SettingsTab:CreateLabel("👨‍💻 Developer: VuskScripts")
SettingsTab:CreateLabel("📅 Update Date: 24/07/2026")
SettingsTab:CreateDivider()

SettingsTab:CreateButton({
    Name = "🗑 Destroy Hub",
    Callback = function()
        Rayfield:Destroy()
    end
})

----------------------------------------------------
-- UNIVERSAL TAB
----------------------------------------------------

UniversalTab:CreateButton({
    Name = "✈️ Fly Mobile",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-Mobile-239891"))()
        print("Fly Mobile Executed")
    end
})

-- NO CLIP
local NoClipEnabled = false
local NoClipConnection = nil

local function StartNoClip()
    if NoClipConnection then return end
    
    NoClipConnection = game:GetService("RunService").Stepped:Connect(function()
        if NoClipEnabled then
            local character = game.Players.LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end

local function StopNoClip()
    if NoClipConnection then
        NoClipConnection:Disconnect()
        NoClipConnection = nil
    end
    
    local character = game.Players.LocalPlayer.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

UniversalTab:CreateToggle({
    Name = "👻 No Clip",
    CurrentValue = false,
    Flag = "NoClipUniversal",
    Callback = function(Value)
        NoClipEnabled = Value
        if Value then
            StartNoClip()
            Rayfield:Notify({
                Title = "No Clip",
                Content = "No Clip enabled - Walk through walls.",
                Duration = 4,
                Image = 4483362458
            })
        else
            StopNoClip()
            Rayfield:Notify({
                Title = "No Clip",
                Content = "No Clip disabled.",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

-- ESP
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESPEnabled = false
local ESPObjects = {}

local function CreateESP(player)
    if player == LocalPlayer then return end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 50, 50)
    highlight.OutlineColor = Color3.fromRGB(255, 50, 50)
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = false

    local name = Drawing.new("Text")
    name.Size = 13
    name.Center = true
    name.Outline = true
    name.Color = Color3.fromRGB(255, 255, 255)
    name.Visible = false

    ESPObjects[player] = {Highlight = highlight, Name = name}
end

local function UpdateESP()
    for player, drawings in pairs(ESPObjects) do
        local char = player.Character
        if not ESPEnabled or not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
            drawings.Highlight.Enabled = false
            drawings.Name.Visible = false
            continue
        end

        drawings.Highlight.Adornee = char
        drawings.Highlight.Parent = char
        drawings.Highlight.Enabled = true

        local pos, onScreen = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
        if onScreen then
            drawings.Name.Text = player.Name
            drawings.Name.Position = Vector2.new(pos.X, pos.Y - 40)
            drawings.Name.Visible = true
        else
            drawings.Name.Visible = false
        end
    end
end

for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end

Players.PlayerAdded:Connect(CreateESP)

Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        if ESPObjects[player].Highlight then
            ESPObjects[player].Highlight:Destroy()
        end
        ESPObjects[player].Name:Remove()
        ESPObjects[player] = nil
    end
end)

RunService.RenderStepped:Connect(UpdateESP)

local function ToggleESP(state)
    ESPEnabled = state
    if not state then
        for _, drawings in pairs(ESPObjects) do
            drawings.Highlight.Enabled = false
            drawings.Name.Visible = false
        end
    end
end

UniversalTab:CreateToggle({
    Name = "👁️ ESP",
    CurrentValue = false,
    Flag = "ESPtoggle",
    Callback = function(value)
        ToggleESP(value)
    end,
})

-- INFINITE JUMP
local InfiniteJumpEnabled = false

UniversalTab:CreateToggle({
    Name = "⬆️ Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local Character = game.Players.LocalPlayer.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- SPEED
local SpeedEnabled = false
local SpeedValue = 50

local function SetSpeed(value)
    local Character = game.Players.LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid.WalkSpeed = value
        end
    end
end

UniversalTab:CreateToggle({
    Name = "💨 Speed",
    CurrentValue = false,
    Flag = "Speed",
    Callback = function(Value)
        SpeedEnabled = Value
        SetSpeed(Value and SpeedValue or 16)
    end,
})

-- ANTI AFK
local AntiAFKEnabled = false
local AntiAFKConnection = nil

local function StartAntiAFK()
    if AntiAFKConnection then return end
    AntiAFKConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
        if AntiAFKEnabled then
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), game:GetService("Workspace").CurrentCamera.CFrame)
            task.wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), game:GetService("Workspace").CurrentCamera.CFrame)
            
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid:Move(Vector3.new(1,0,0), false)
                task.wait(0.5)
                character.Humanoid:Move(Vector3.new(-1,0,0), false)
            end
        end
    end)
end

local function StopAntiAFK()
    if AntiAFKConnection then
        AntiAFKConnection:Disconnect()
        AntiAFKConnection = nil
    end
end

UniversalTab:CreateToggle({
    Name = "🛡️ Anti AFK",
    CurrentValue = false,
    Flag = "AntiAFK",
    Callback = function(Value)
        AntiAFKEnabled = Value
        if Value then
            StartAntiAFK()
            Rayfield:Notify({Title = "Anti AFK", Content = "Anti AFK enabled - You won't get kicked for inactivity anymore.", Duration = 4, Image = 4483362458})
        else
            StopAntiAFK()
            Rayfield:Notify({Title = "Anti AFK", Content = "Anti AFK disabled.", Duration = 3, Image = 4483362458})
        end
    end
})

-- INFINITE YIELD
UniversalTab:CreateButton({
    Name = "📜 Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        Rayfield:Notify({Title = "Infinite Yield", Content = "Infinite Yield loaded!", Duration = 3, Image = 4483362458})
    end
})

-- REJOIN GAME
UniversalTab:CreateButton({
    Name = "🔄 Rejoin Game",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end
})

-- EXIT GAME
UniversalTab:CreateButton({
    Name = "❌ Exit Game",
    Callback = function()
        Rayfield:Notify({
            Title = "Exit Game",
            Content = "Closing the game...",
            Duration = 2,
            Image = 4483362458
        })
        task.wait(0.5)
        game:Shutdown()
    end
})

----------------------------------------------------
-- 99 NIGHTS IN THE FOREST TAB
----------------------------------------------------

ForestTab:CreateButton({
    Name = "Moondiety 🔑",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/99-Nights-in-the-Forest-STRONGHOLDS-KEYLESS-auto-farm-bring-item-teleports-and-more-by-Moondiety-44416"))()
        print("Moondiety Executed")
    end
})

----------------------------------------------------
-- MUSCLE LEGENDS TAB
----------------------------------------------------

MuscleTab:CreateLabel("Basic Functions")

-- AUTO CLICKER
local AutoClickEnabled = false
local ClickConnection = nil

local function StartAutoClick()
    if ClickConnection then return end
    ClickConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if AutoClickEnabled then
            local vim = game:GetService("VirtualInputManager")
            vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end
    end)
end

local function StopAutoClick()
    if ClickConnection then
        ClickConnection:Disconnect()
        ClickConnection = nil
    end
end

MuscleTab:CreateToggle({
    Name = "🔥 Auto Click",
    CurrentValue = false,
    Flag = "AutoClickMuscle",
    Callback = function(Value)
        AutoClickEnabled = Value
        if Value then
            StartAutoClick()
            Rayfield:Notify({Title = "Auto Click", Content = "Auto Click enabled - Farming muscles non-stop.", Duration = 3, Image = 4483362458})
        else
            StopAutoClick()
            Rayfield:Notify({Title = "Auto Click", Content = "Auto Click disabled.", Duration = 3, Image = 4483362458})
        end
    end
})

-- SECRET ISLAND
MuscleTab:CreateButton({
    Name = "🏝️ Secret Island",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(1974, 2, 6204)
            Rayfield:Notify({Title = "Secret Island", Content = "Teleported to Secret Island!", Duration = 3, Image = 4483362458})
        end
    end,
})

-- EXTERNAL SCRIPTS
MuscleTab:CreateLabel("📜 Scripts")

MuscleTab:CreateLabel("Key Silence 2026: SOT")
MuscleTab:CreateButton({
    Name = "Silence",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Muscle-Legends-Silence-Best-Ml-Script-82856"))()
        print("Silence Executed")
    end
})

MuscleTab:CreateButton({
    Name = "Speed Hub X",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        print("Speed Hub X Executed")
    end
})

MuscleTab:CreateButton({
    Name = "Nw HUB",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Nw-Hub-Universal-241008"))()
        print("Nw Hub Executed")
    end
})

MuscleTab:CreateButton({
    Name = "Canes Priv",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/googlyeyed1/yummy-duck/refs/heads/main/yummy%20duck", true))()
        print("Canes Priv Executed")
    end
})
