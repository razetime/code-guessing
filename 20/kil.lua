getmetatable('').__index = function(str,i) return string.sub(str,i,i) end

function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end

a,b,c=io.read("*l","*l","*l")
d={a,b,c}
e={
  {{1,1},{1,2},{1,3}},
  {{2,1},{2,2},{2,3}},
  {{3,1},{3,2},{3,3}},
  {{1,1},{2,1},{3,1}},
  {{1,2},{2,2},{3,2}},
  {{1,3},{2,3},{3,3}},
  {{1,1},{2,2},{3,3}},
  {{1,3},{2,2},{3,1}}
}

--print_r(d)
ps={1,1}
for i,v in pairs(e) do
  c=0
  b=false
  for j,w in pairs(v) do
    ch=d[w[1]][w[2]]
    if ch=='o' then
      c=c+1
    elseif ch=='.' then
      --print
      ps=w
    end
  end
  if c==2 then
    break
  end
end
print(ps[1],ps[2])
for i,v in pairs(d) do
  for j=1,#v do
    --print(i==ps[0],j==ps[1])
    if i==ps[1] and j==ps[2] then
      io.write('x')
    else
      io.write(d[i][j])
    end
  end
  print("")
end
