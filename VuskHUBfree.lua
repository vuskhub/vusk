local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Vusk HUB",
    Icon = 0,
    LoadingTitle = "Vusk HUB",
    LoadingSubtitle = "by VuskScripts",
    ShowText = "Rayfield",
    Theme = "Default",

    ToggleUIKeybind = "K",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = true,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Big Hub"
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
    Note = "Key: 1026 ",
    FileName = "Key",
    SaveKey = true,
    GrabKeyFromSite = false,
    Key = {"1026"}
}

})

----------------------------------------------------
-- ABAS
----------------------------------------------------

local MainTab = Window:CreateTab("Home", "home")
local SettingsTab = Window:CreateTab("Settings", "settings")
local UniversalTab = Window:CreateTab("Universal", "globe")
local ForestTab = Window:CreateTab("99 Nights in the Forest", "trees")
local MuscleTab = Window:CreateTab("Muscle Legends", "dumbbell")

----------------------------------------------------
-- ABA PRINCIPAL
----------------------------------------------------

MainTab:CreateLabel("Vusk HUB v1.0")
MainTab:CreateLabel("Developed by VuskScripts")
MainTab:CreateDivider()
MainTab:CreateLabel("📍 Supported Games")
MainTab:CreateLabel("• 99 Nights in the Forest")
MainTab:CreateLabel("• Muscle Legends")

----------------------------------------------------
-- ABA CONFIGURAÇÕES
----------------------------------------------------

SettingsTab:CreateLabel("Vusk HUB Settings")

SettingsTab:CreateButton({
    Name = "🗑 Destroy Hub",
    Callback = function()
        Rayfield:Destroy()
    end
})

-- Reload Hub
SettingsTab:CreateButton({
    Name = "🔄 Reload Hub",
    Callback = function()
        Rayfield:Destroy()
        task.wait(0.3)
        
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/vuskhub/vusk/91bfaa96786211704219167f8fb4a1970225d398/VuskHUBfree.lua"))()
        end)
        
        if success then
            print("✅ Vusk HUB Reloaded successfully!")
        else
            warn("❌ Reload error: " .. tostring(err))
        end
    end
})

----------------------------------------------------
--ABA UNIVERSAL
----------------------------------------------------

UniversalTab:CreateButton({
    Name = "✈️ Fly Mobile",
    Callback = function()
    
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-Mobile-239891"))()
    
        print("Fly Mobile Executed ")
    end
})

----------------------------------------------------
-- ABA 99 NIGHTS IN THE FOREST
----------------------------------------------------

ForestTab:CreateButton({
    Name = "Moondiety 🔑",
    Callback = function()
    
    loadstring(game:HttpGet("https://rawscripts.net/raw/99-Nights-in-the-Forest-STRONGHOLDS-KEYLESS-auto-farm-bring-item-teleports-and-more-by-Moondiety-44416"))()
    
        print("Moondiety Executed")
    end
})

----------------------------------------------------
-- ABA MUSCLE LEGENDS
----------------------------------------------------

MuscleTab:CreateLabel("Key Silence 2026: SOT")

MuscleTab:CreateButton({
    Name = "Silence",
    Callback = function()
    
    loadstring(game:HttpGet("https://rawscripts.net/raw/Muscle-Legends-Silence-Best-Ml-Script-82856"))()
    
        print("Silence Executed")
    end
})
