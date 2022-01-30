
local base=0x80E00000

local MDIOADDR=base+0x7e4
local MDIOWR=base+0x7e8
local MDIORD=base+0x7ec
local MDIOCTRL=base+0x7F0



local linkstat=false

function tohex(v)
  return string.format("0x%x",v)
end  

function setmdio_address(op,phyaddr,regaddr)
local w = (op << 10) | ((phyaddr & 0x1f) << 5) | (regaddr & 0x1f )  
 --print("Set MDIOADDR "..tohex(w))
 cpu.w32(MDIOADDR,w)

end

function mdio_wait()
local w
  repeat
    w=cpu.r32(MDIOCTRL)
  until (w & 1)==0   --bit.isclear(w,0)
end

function mdio_read(regadr)

  mdio_wait()
  setmdio_address(1,1,regadr)
  cpu.w32(MDIOCTRL, (1<<3) | 1)   -- bit.set(0,3,0)) -- set Enable and Status
  mdio_wait()
  cpu.w32(MDIOCTRL,0)
  return  cpu.r32(MDIORD) & 0xffff  --bit.band(cpu.r32(MDIORD),0xffff)
end

function checklink()

local t,ln
 
  
    local mdiostat=mdio_read(0x1)
    ln= (mdiostat & (1<<2)) ~= 0   --bit.isset(mdiostat,2)
    if ln then
      print("Link established")
    else 
      print("no link")
    end
end

-- local ptable = {
--   coroutine.create(checklink)
-- }

-- local dispatcher=coroutine.wrap(
--     function ()
--     local k,c

--       while true do
--         for k,c in pairs(ptable) do
--           coroutine.resume(c,k)
--           coroutine.yield()
--         end
--       end
--     end
-- )

-- print()

print("MDIOCTRL Reg: "..tohex(cpu.r32(MDIOCTRL)))

print("MDIO Basic Mode Config:"..tohex(mdio_read(0x0)))

local mdiostat=mdio_read(0x1)
print("MDIO Status Word:"..tohex(mdiostat))
checklink()



-- _.always(dispatcher)


