-- Simple helpers to make interactive work more convenient

_ = {

   p = print
  
}


  function _.px(...)
    for i,v in ipairs{...} do
      io.write(string.format("%X  ",v))
    end
    io.write("\n")
  end    
  
  
  
  function _.pt(t)
    for k,v in pairs(t) do print(k,v) end
  end
  
  
  function _.always(f,timeout,...)
  local t,delta
  
    t=tmr.read()
    repeat
      f(...)
      delta=tmr.getdiffnow(nil,t)
    until (timeout~=nil and delta>=timeout) or uart.getchar(0,uart.NO_TIMEOUT)~=""
  end     
      
  
