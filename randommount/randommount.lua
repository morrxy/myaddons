local slots_flying_mount, slots_ground_mount, slots_water_mount = {}, {}, {}

for i = 1, GetNumCompanions("MOUNT") do
  local _,name,_,_,_,typeID = GetCompanionInfo("MOUNT", i)

  if typeID == 15 or typeID == 31 then -- flying mounts
    slots_flying_mount[#slots_flying_mount + 1] = i
  elseif typeID == 29 then -- ground mounts
    slots_ground_mount[#slots_ground_mount + 1] = i
  elseif typeID == 12 then -- water mounts
    slots_water_mount[#slots_water_mount + 1] = i
  end

end

-- if already mounted, unmount
-- if not mount, if in flyable area random select a flyable mount else
-- random select a ground mount
if IsMounted() == nil then
  if IsFlyableArea() then
    local slotID = slots_flying_mount[random(#slots_flying_mount)]
    CallCompanion("MOUNT", slotID)
  else
    local slotID = slots_ground_mount[random(#slots_ground_mount)]
    CallCompanion("MOUNT", slotID)
  end
else
  Dismount()
end

