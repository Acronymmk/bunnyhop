--[[

The MIT License (MIT)
Copyright (C) 2023 Acronymmk

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

]]

local timer = {}
local speed_multiplier = 1.150
local jump_multiplier = 1.150
local sideways_multiplier = 1.250

minetest.register_globalstep(function(dtime)
   for _, player in pairs(minetest.get_connected_players()) do
      local player_name = player:get_player_name()
      timer[player_name] = timer[player_name] or 0
      local controls = player:get_player_control()

      if controls.jump and player:get_hp() > 0 then
         if timer[player_name] == 0 then
            timer[player_name] = 0.01
         elseif timer[player_name] > 0.01 and (controls.right or controls.left) then
            local speed = speed_multiplier * sideways_multiplier
            player:set_physics_override({speed = speed, jump = jump_multiplier})
         else
            player:set_physics_override({speed = speed_multiplier, jump = jump_multiplier})
         end
         timer[player_name] = timer[player_name] + dtime
      else
         player:set_physics_override({speed = 1.0, jump = 1.0})
         timer[player_name] = 0
      end
   end
end)