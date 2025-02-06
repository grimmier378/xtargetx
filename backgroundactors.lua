local mq = require 'mq'
local actors = require 'actors'

local max_xtargs = 1

if mq.TLO.Me.XTargetSlots() ~= nil then
    max_xtargs = mq.TLO.Me.XTargetSlots()
end


local actor = actors.register(function(message)

end)

local function casting(line, arg1)
    local ID
    local slowPct = mq.TLO.Spell(mq.TLO.Target.Slowed()).SlowPct() or 0
    ID = mq.TLO.Target.ID()
    if slowPct > 0 then
        actor:send({ script = 'xtargetx', },
            { script = 'xtargetx', id = 'slowed', targetID = ID, result = "CAST_SUCCESS", slowPct = slowPct, })
    else
        actor:send({ script = 'xtargetx', },
            { script = 'xtargetx', id = 'slowed', targetID = ID, result = "CAST_FAILED", })
    end
    if mq.TLO.Target.Mezzed() then
        actor:send({ script = 'xtargetx', },
            { script = 'xtargetx', id = 'mezzed', targetID = ID, result = "CAST_SUCCESS", })
    else
        actor:send({ script = 'xtargetx', },
            { script = 'xtargetx', id = 'mezzed', targetID = ID, result = "CAST_FAILED", })
    end
    if mq.TLO.Target.Snared() then
        actor:send({ script = 'xtargetx', },
            { script = 'xtargetx', id = 'snared', targetID = ID, result = "CAST_SUCCESS", })
    else
        actor:send({ script = 'xtargetx', },
            { script = 'xtargetx', id = 'snared', targetID = ID, result = "CAST_FAILED", })
    end

    -- if mq.TLO.Me.Class.ShortName() == 'SHM' then
    --     if mq.TLO.Me.Casting.Subcategory() == 'Slow' then
    --         ID = mq.TLO.Target.ID()
    --         local slowPct = mq.TLO.Me.Casting.SlowPct()
    --         if slowPct ~= 0 and slowPct ~= nil then
    --             while mq.TLO.Me.Casting() ~= nil do
    --                 mq.delay(1)
    --             end
    --             local result = mq.TLO.Cast.Result()
    --             actor:send({ script = 'xtargetx', },
    --                 { script = 'xtargetx', id = 'slowed', targetID = ID, result = result, slowPct = slowPct, })
    --         end
    --     else
    --         ID = mq.TLO.Target.ID()
    --         local slowPct = mq.TLO.Me.Casting.SlowPct()
    --         if slowPct ~= 0 and slowPct ~= nil then
    --             while mq.TLO.Me.Casting() ~= nil do
    --                 mq.delay(1)
    --             end
    --             local result = mq.TLO.Cast.Result()
    --             actor:send({ script = 'xtargetx', },
    --                 { script = 'xtargetx', id = 'slowed', targetID = ID, result = result, slowPct = slowPct, })
    --         end
    --     end
    -- elseif mq.TLO.Me.Class.ShortName() == 'BRD' then
    --     if string.find(arg1, "Dirge of the Sleepwalker") then
    --         while mq.TLO.Me.Casting() ~= nil do
    --             mq.delay(1)
    --         end
    --         local result = mq.TLO.Cast.Result()
    --         actor:send({ script = 'xtargetx', }, { script = 'xtargetx', id = 'mezzed', targetID = ID, result = result, })
    --     elseif mq.TLO.Me.Casting.Subcategory() == 'Enthrall' then
    --         if mq.TLO.Me.Casting.AERange() > 0 then
    --             if mq.TLO.Me.XTarget() > 0 then
    --                 for i = 1, max_xtargs do
    --                     if mq.TLO.Me.XTarget(i).Type() == 'NPC' then
    --                         if mq.TLO.Me.XTarget(i).Distance() <= mq.TLO.Me.Casting.AERange() then
    --                             ID = mq.TLO.Me.XTarget(i).ID()
    --                             actor:send({ script = 'xtargetx', },
    --                                 { script = 'xtargetx', id = 'mezzed', targetID = ID, result = 'CAST_SUCCESS', })
    --                         end
    --                     end
    --                 end
    --             end
    --             return
    --         end
    --         ID = mq.TLO.Target.ID()
    --         while mq.TLO.Me.Casting() ~= nil do
    --             mq.delay(1)
    --         end
    --         local result = mq.TLO.Cast.Result()
    --         actor:send({ script = 'xtargetx', }, { script = 'xtargetx', id = 'mezzed', targetID = ID, result = result, })
    --     elseif mq.TLO.Me.Casting.Subcategory() == 'Slow' then
    --         ID = mq.TLO.Target.ID()
    --         local slowPct = mq.TLO.Me.Casting.SlowPct()
    --         if slowPct ~= 0 and slowPct ~= nil then
    --             while mq.TLO.Me.Casting() ~= nil do
    --                 mq.delay(1)
    --             end
    --             local result = mq.TLO.Cast.Result()
    --             actor:send({ script = 'xtargetx', },
    --                 { script = 'xtargetx', id = 'slowed', targetID = ID, result = result, slowPct = slowPct, })
    --         end
    --     end
    -- elseif mq.TLO.Me.Class.ShortName() == 'ENC' then
    --     if mq.TLO.Me.Casting.Subcategory() == 'Slow' then
    --         ID = mq.TLO.Target.ID()
    --         local slowPct = mq.TLO.Me.Casting.SlowPct()
    --         if slowPct ~= 0 and slowPct ~= nil then
    --             while mq.TLO.Me.Casting() ~= nil do
    --                 mq.delay(1)
    --             end
    --             local result = mq.TLO.Cast.Result()
    --             actor:send({ script = 'xtargetx', },
    --                 { script = 'xtargetx', id = 'slowed', targetID = ID, result = result, slowPct = slowPct, })
    --         end
    --     elseif string.find(arg1, "Noctambulate") then
    --         while mq.TLO.Me.Casting() ~= nil do
    --             mq.delay(1)
    --         end
    --         local result = mq.TLO.Cast.Result()
    --         actor:send({ script = 'xtargetx', }, { script = 'xtargetx', id = 'mezzed', targetID = ID, result = result, })
    --     elseif mq.TLO.Me.Casting.Subcategory() == 'Enthrall' then
    --         if mq.TLO.Me.Casting.AERange() > 0 then
    --             if mq.TLO.Me.XTarget() > 0 then
    --                 for i = 1, max_xtargs do
    --                     if mq.TLO.Me.XTarget(i).Type() == 'NPC' then
    --                         if mq.TLO.Me.XTarget(i).Distance() <= mq.TLO.Me.Casting.AERange() then
    --                             ID = mq.TLO.Me.XTarget(i).ID()
    --                             actor:send({ script = 'xtargetx', },
    --                                 { script = 'xtargetx', id = 'mezzed', targetID = ID, result = 'CAST_SUCCESS', })
    --                         end
    --                     end
    --                 end
    --             end
    --             return
    --         end
    --         ID = mq.TLO.Target.ID()
    --         while mq.TLO.Me.Casting() ~= nil do
    --             mq.delay(1)
    --         end
    --         local result = mq.TLO.Cast.Result()
    --         actor:send({ script = 'xtargetx', }, { script = 'xtargetx', id = 'mezzed', targetID = ID, result = result, })
    --     else
    --         ID = mq.TLO.Target.ID()
    --         local slowPct = mq.TLO.Me.Casting.SlowPct()
    --         if slowPct ~= 0 and slowPct ~= nil then
    --             while mq.TLO.Me.Casting() ~= nil do
    --                 mq.delay(1)
    --             end
    --             local result = mq.TLO.Cast.Result()
    --             actor:send({ script = 'xtargetx', },
    --                 { script = 'xtargetx', id = 'slowed', targetID = ID, result = result, slowPct = slowPct, })
    --         end
    --     end
    -- elseif mq.TLO.Me.Class.ShortName() == 'BST' then
    --     if mq.TLO.Me.Casting.Subcategory() == 'Slow' then
    --         ID = mq.TLO.Target.ID()
    --         local slowPct = mq.TLO.Me.Casting.SlowPct()
    --         if slowPct ~= 0 and slowPct ~= nil then
    --             while mq.TLO.Me.Casting() ~= nil do
    --                 mq.delay(1)
    --             end
    --             local result = mq.TLO.Cast.Result()
    --             actor:send({ script = 'xtargetx', },
    --                 { script = 'xtargetx', id = 'slowed', targetID = ID, result = result, slowPct = slowPct, })
    --         end
    --     else
    --         ID = mq.TLO.Target.ID()
    --         local slowPct = mq.TLO.Me.Casting.SlowPct()
    --         if slowPct ~= 0 and slowPct ~= nil then
    --             while mq.TLO.Me.Casting() ~= nil do
    --                 mq.delay(1)
    --             end
    --             local result = mq.TLO.Cast.Result()
    --             actor:send({ script = 'xtargetx', },
    --                 { script = 'xtargetx', id = 'slowed', targetID = ID, result = result, slowPct = slowPct, })
    --         end
    --     end
    -- end
end

--mq.TLO.Spell(mq.TLO.Target.Slowed()).SlowPct()

mq.event('casting', "You begin casting #1#", casting)
mq.event('singing', "You begin singing #1#", casting)

while true do
    mq.doevents()
    mq.delay(1)
end
