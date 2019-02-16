-- Settings menu.
BWE_HUD = BWE_HUD or {}

local LAM2 = LibStub("LibAddonMenu-2.0")

function BWE_HUD.CreateSettings()

        local panelData = {
                type = "panel",
                name = BWE_HUD.menuName,
                displayName = BWE_HUD.menuName,
                author = BWE_HUD.author,
                registerForRefresh = true,
                registerForDefaults = true,
        }
        
        LAM2:RegisterAddonPanel(BWE_HUD.menuName, panelData)

        local optionsTable = {}
    
    -- Category. --
        table.insert(optionsTable, {
            type = "header",
            name = ZO_HIGHLIGHT_TEXT:Colorize("Target Frame Settings"),
        })
    
        table.insert(optionsTable, {
                type = "checkbox",
                name = "Use Target Frame",
                default = BWE_HUD.SV.target.enabled,
                getFunc = function() return BWE_HUD.SV.target.enabled end,
                setFunc = function(newValue) 
                    BWE_HUD.SV.target.enabled = newValue
                    ReloadUI()
                end,
                warning = "Requires UI Reload"
        })
    
        table.insert(optionsTable, {
            type = "submenu",
            name = "Target Frame",
            controls = {
                [1] = {
                    type = "checkbox",
                    name = "Unlock Frame",
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.targetUnlock,
                    getFunc = function() return BWE_HUD.targetUnlock end,
                    setFunc = function(newValue) BWE_HUD.targetUnlocker(newValue) end,					
                },
                [2] = {
                    type = "checkbox",
                    name = "Prefer User ID over Character Name",
                    tooltip = "Use @Example instead",                    
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.defaults.target.useACCID,
                    getFunc = function() return BWE_HUD.SV.target.useACCID end,
                    setFunc = function(newValue) BWE_HUD.SV.target.useACCID = newValue end,
                },
                [3] = {
                    type = "header",
                    name = "Color Settings",
                },
                [4] = {
                    type = "checkbox",
                    name = "Use Specific Target Colors",
                    tooltip = "Enemies=Red Guards=Yellow",    
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.defaults.target.uRColor,
                    getFunc = function() return BWE_HUD.SV.target.uRColor end,
                    setFunc = function(newValue) BWE_HUD.SV.target.uRColor = newValue end,
                },
                [5] = {
                    type = "checkbox",
                    name = "Use Custom Color",
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.defaults.target.custom.enabled,
                    getFunc = function() return BWE_HUD.SV.target.custom.enabled end,
                    setFunc = function(newValue) 
                        BWE_HUD.SV.target.custom.enabled = newValue 
                        BWE_HUD.ReinitFrame()
                    end,
                },
                [6] = {
                    type = "colorpicker",
                    name = "Target Frame Color",
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = function() return unpack(BWE_HUD.SV.target.custom.Color) end,
                    getFunc = function() return unpack(BWE_HUD.SV.target.custom.Color) end,
                    setFunc = function(r, g, b, a) 
                        BWE_HUD.SV.target.custom.Color = {r, g, b, a} 
                        BWE_HUD.ReinitFrame()
                    end,
                },
                [7] = {
                    type = "header",
                    name = "Opacity Settings",
                },
                [8] = {
                    type = "slider",
                    name = "Target Frame Opacity",
                    min = 10,
                    max = 100,
                    step = 5,
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.defaults.target.opacity.barAlpha,
                    getFunc = function() return zo_round(BWE_HUD.SV.target.opacity.barAlpha*100) end,
                    setFunc = function(newValue) 
                        BWE_HUD.SV.target.opacity.barAlpha = zo_roundToNearest((newValue/100), .01),
                        BWE_HUD.ReinitFrame()
                    end,
                },
                [9] = {
                    type = "slider",
                    name = "Background Opacity",
                    min = 0,
                    max = 100,
                    step = 5,
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.defaults.target.opacity.bgAlpha,
                    getFunc = function() return zo_round(BWE_HUD.SV.target.opacity.bgAlpha*100) end,
                    setFunc = function(newValue) 
                        BWE_HUD.SV.target.opacity.bgAlpha = zo_roundToNearest((newValue/100), .01),
                        BWE_HUD.ReinitFrame()
                    end,
                },
                [10] = {
                    type = "slider",
                    name = "Gloss Opacity",
                    min = 0,
                    max = 100,
                    step = 5,
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.defaults.target.opacity.glossAlpha,
                    getFunc = function() return zo_round(BWE_HUD.SV.target.opacity.glossAlpha*100) end,
                    setFunc = function(newValue) 
                        BWE_HUD.SV.target.opacity.glossAlpha = zo_roundToNearest((newValue/100), .01),
                        BWE_HUD.ReinitFrame()
                    end,
                },
                [11] = {
                    type = "header",
                    name = "Size Settings",
                },
                [12] = {
                    type = "slider",
                    name = "Text Size",
                    min = 12,
                    max = 24,
                    step = 1,
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.defaults.target.textSize,
                    getFunc = function() return zo_round(BWE_HUD.SV.target.textSize) end,
                    setFunc = function(newValue) 
                        BWE_HUD.SV.target.textSize = zo_round(newValue)
                        BWE_HUD.ReinitFrame()
                    end,
                },
                [13] = {
                    type = "slider",
                    name = "Bar Width",
                    min = 125,
                    max = 500,
                    step = 5,
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.defaults.target.size.width,
                    getFunc = function() return zo_round(BWE_HUD.SV.target.size.width) end,
                    setFunc = function(newValue) 
                        BWE_HUD.SV.target.size.width = zo_round(newValue)
                        BWE_HUD.ReinitFrame()
                    end,
                },
                [14] = {
                    type = "slider",
                    name = "Bar Height",
                    min = 40,
                    max = 100,
                    step = 5,
                    disabled = not BWE_HUD.SV.target.enabled,
                    default = BWE_HUD.defaults.target.size.height,
                    getFunc = function() return zo_round(BWE_HUD.SV.target.size.height) end,
                    setFunc = function(newValue) 
                        BWE_HUD.SV.target.size.height = zo_round(newValue)
                        BWE_HUD.ReinitFrame()
                    end,
                },                
            },
        })
    
    LAM2:RegisterOptionControls(BWE_HUD.menuName, optionsTable)
end
