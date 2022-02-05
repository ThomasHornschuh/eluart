print()
m=require "mmc_bench"
local s=string.rep("#",10^6)
m.disk_bench(s,"/sd/bench.txt")
m.disk_bench(s,"/ram/bench.txt")

