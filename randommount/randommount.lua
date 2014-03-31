local slots_flying_mount, slots_ground_mount, slots_sea_mount = {}, {}, {}
local slots_strider = {}

-- Sea Mount Database
-- GetCompanionInfo("MOUNT", i) doesn't provide a way to distinguish between (fast land/slow sea) and (slow land/fast sea)
local seaMounts = {
    30174,  --Riding Turtle
    64731,  --Sea Turtle
    --the following should be detected as sea only, added anyways as fallback
    98718,  --Subdued Seahorse
    75207 --Abyssal Seahorse
}

-- Waterwalking Mount Database
-- GetCompanionInfo("MOUNT", i) doesn't provide a way to distinguish waterwalking mounts
local striderMounts = {
    118089  --Azure Water Strider
}

-- Check if mount can swim fast
local function IsSeaMount(creatureSpellID)
  for _, value in ipairs(seaMounts) do
    if value == creatureSpellID then
      return true
    end
  end
  return false
end

-- Check if mount can waterwalk
local function IsStriderMount(creatureSpellID)
  for _, value in ipairs(striderMounts) do
    if value == creatureSpellID then
      return true
    end
  end
  return false
end

--GetCompanionInfo("MOUNT") 6th return values
-- 07 0b00000111 Air only
-- 12 0b00001100 Sea only
-- 15 0b00001111 Air/Sea
-- 23 0b00010111 Air/Land
-- 29 0b00011101 Land/Sea
-- 31 0b00011111 Air/Land/Sea
--Capabilities Bitmasks
-- 01 0b00000001 ???
-- 02 0b00000010 Usable for air
-- 04 0b00000100 ???
-- 08 0b00001000 Usable for water
-- 16 0b00010000 Usable for land

for i = 1, GetNumCompanions("MOUNT") do
  local _,name,spellID,_,_,typeID = GetCompanionInfo("MOUNT", i)

  if typeID == 7 or typeID == 15 or typeID == 23 or typeID == 31 then
    slots_flying_mount[#slots_flying_mount + 1] = i
  end

  if typeID == 12 or IsSeaMount(spellID) then
    slots_sea_mount[#slots_sea_mount + 1] = i
  end

  if typeID == 23 or typeID == 29 or typeID == 31 then
    slots_ground_mount[#slots_ground_mount + 1] = i
  end

  if IsStriderMount(typeID) then
    slots_strider[#slots_strider + 1] = i
  end
end

if IsMounted() == nil then
  local slotID

  if IsFlyableArea() then
    slotID = slots_flying_mount[random(#slots_flying_mount)]
  else
    if IsSwimming() and #slots_strider > 0 then
      slotID = slots_sea_mount[random(#slots_strider_mount)]
    else
      slotID = slots_ground_mount[random(#slots_ground_mount)]
    end
  end

  CallCompanion("MOUNT", slotID)
else
  Dismount()
end

