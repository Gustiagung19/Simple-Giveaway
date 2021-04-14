ESX = nil 
Citizen.CreateThread(function() 
while ESX == nil do 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
Citizen.Wait(0) 
end 
end)
codeusetime = nil
RegisterNetEvent("checkcode")
-- Fungsi Event Handler Mengikuti Setelah Mendaftar Event Terlebih Dahulu
AddEventHandler("checkcode", function(code)
    if code == Config.code then
        xPlayer = ESX.GetPlayerFromId(source)
        MySQL.Async.fetchAll('SELECT * FROM gusti_giveaway WHERE id = @id',{
            ['@id'] = xPlayer.getIdentifier()
        },
        function (result)
            if result[1] == nil then
            else
            codeusetime = (result[1].usetime)
            end

            if result[1] == nil then 
                MySQL.Async.execute('INSERT INTO gusti_giveaway (id, usetime) VALUES (@id, @usetime)',{ 
                    ['id'] = xPlayer.getIdentifier(),
                    ['usetime'] = 1
                })
            xPlayer.addMoney(Config.money)
            TriggerClientEvent('codechat', -1 ,_U("Successfully"))
            elseif codeusetime < Config.Maxuse then
                MySQL.Async.execute('UPDATE gusti_giveaway SET usetime = @usetime WHERE id = @id',{ 
                    ['@usetime'] = codeusetime + 1,
                    ['@id'] = xPlayer.getIdentifier()
                })
                xPlayer.addMoney(Config.money)
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Berhasil Menerima', length = 5000 })
            elseif codeusetime == Config.Maxuse then
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Telah Melebihi Jumlah Penggunaan', length = 5000 })
            end
        end)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Kode Salah, Silahkan Coba Lagi', length = 5000 })
    end
end)


