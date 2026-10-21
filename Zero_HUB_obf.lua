local encodedUrl = "aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0thaWEtWmVyby9aZXJvLUhVQi4vcmVmcy9oZWFkcy9tYWluL1plcm8tSFVCLW9iZi5sdWE="

local HttpService = game:GetService("HttpService")
local success, realUrl = pcall(function()
    return HttpService:Base64Decode(encodedUrl)
end)

if success then
    print("✅ กำลังโหลดจากลิงก์: " .. realUrl)
    
    local fetchSuccess, scriptSource = pcall(function()
        return game:HttpGet(realUrl)
    end)
    
    if fetchSuccess and scriptSource then
        local runSuccess, err = pcall(function()
            loadstring(scriptSource)()
        end)
        
        if not runSuccess then
            warn("❌ สคริปต์หลักรันไม่สำเร็จ: " .. tostring(err))
        end
    else
        warn("❌ โหลดสคริปต์จากลิงก์ไม่สำเร็จ (ลิงก์อาจจะเสียหรือผิด)")
    end
else
    warn("❌ ไม่สามารถถอดรหัสได้")
end
