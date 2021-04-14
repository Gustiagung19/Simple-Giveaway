RegisterCommand("giveaway",function(args,rawCommand)
    TriggerServerEvent("checkcode",rawCommand[1])
end)
RegisterNetEvent("codechat")
-- Fungsi Event Handler Mengikuti Setelah Mendaftar Event Terlebih Dahulu
AddEventHandler("codechat", function(msg)
TriggerEvent('chat:addMessage', {
    color = { 255, 0, 0},
    multiline = true,
    args = {_U('system'), msg }
  })
end)