
local M={}

function M.disk_bench(s,fname)
local t=os.clock()
local f=io.open(fname,"w")

  assert(f)
  print(string.format("Testing with %d bytes",#s))
  f:write(s)
  f:close(s)
  local diff=os.clock()-t
  print(string.format("Write time : %.3f ms, %.0f Bytes/sec ",diff*1000,#s/diff))
  t=os.clock()
  f=io.open(fname,"r")
  local sres=f:read("*a")
  f:close()
  diff=os.clock()-t
  print(string.format("%d bytes read back",#sres))
  print(string.format("Read time : %.3f ms, %.0f Bytes/sec ",diff*1000,#sres/diff))
  return sres
end

return M

