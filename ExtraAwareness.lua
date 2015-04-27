
local AutoUpdate = true
_G.ExtraAwarenessVersion = 1.3

if not FileExist(SPRITE_PATH .. "PrinceView/champIcons/Generic.png") then 
    print("<font color=\"#FF794C\"><b>Extra Awareness: </b></font> <font color=\"#FFDFBF\">Missing sprites, download them first!</b></font>")
    return 
end

ExtraAwareness = scriptConfig("ExtraAwareness","ExtraAwareness")
ExtraAwareness:addParam("enabled", "Extra awareness enabled", SCRIPT_PARAM_ONOFF, true)

local LoadedMessage = "Version ".._G.PrinceExtraAwarenessVersion.." loaded. "
local sprites = {}

function OnLoad()
    if not _G.PrinceViewVersion then
        LoadedMessage = LoadedMessage .."Use PrinceView to add time since SS over grey icons"
    end
    
    -- Autoupdate
    if AutoUpdate then
        local ToUpdate = {}
        ToUpdate.Version = _G.PrinceExtraAwarenessVersion
        ToUpdate.UseHttps = true
        
        ToUpdate.Host = "raw.githubusercontent.com"
        ToUpdate.VersionPath = "/redprince/BoL/master/ExtraAwareness.version"
        ToUpdate.ScriptPath =  "/redprince/BoL/master/ExtraAwareness.lua"
        ToUpdate.SavePath = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
        ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>Extra Awareness: </b></font> <font color=\"#FFDFBF\">Updated from "..OldVersion.." to "..NewVersion..". </b></font>") end
        ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>ExtraAwareness: </b></font> <font color=\"#FFDFBF\">"..LoadedMessage.."</b></font>") end
        ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>Extra Awareness: </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
        ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>Extra Awareness: </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
        ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
    end
    
    for i, enemy in ipairs(GetEnemyHeroes()) do
        if FileExist(SPRITE_PATH .. "PrinceView/champIcons/".. enemy.charName ..".png") then
            sprites[i] = createSprite("PrinceView/champIcons/".. enemy.charName ..".png")
            sprites[i]:SetScale(0.4, 0.4)
        else
            PrintChat("[Extra Awareness] Missing sprite icon for "..enemy.charName..". Please download sprites from forum.")
            sprites[i] = createSprite("PrinceView/champIcons/Generic.png")
            sprites[i]:SetScale(0.4, 0.4)
        end
    end
end

function OnDraw()
    if ExtraAwareness.enabled then        
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if not enemy.visible then
                sprites[i]:Draw(GetMinimapX(enemy.pos.x) -10, GetMinimapY(enemy.pos.z) -10, 255)
            end
        end
    end
end

