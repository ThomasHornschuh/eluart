local r = riscv or ( bonfire and bonfire.riscv)
assert(r) 

print()
print(string.format("Lua version: %s",_VERSION))

print(string.format("cpuid: %s",r.cpuid()))
--local board=pd.board()
--print(string.format("Board: %s",board))
local board="BONFIRE_ARTY"
if board=="BONFIRE_ARTY" then
  local SYSIO = 0x40000000 + 0x204
  print(string.format("Sys ID: %x",cpu.r32(SYSIO)))
end

