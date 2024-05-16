local function deep_copy(o, seen)
    seen = seen or {}
    if o == nil then return nil end
    if seen[o] then return seen[o] end
    
    local no
    if type(o) == 'table' then
        no = {}
        seen[o] = no
    
        for k, v in next, o, nil do
            no[deep_copy(k, seen)] = deep_copy(v, seen)
        end
        setmetatable(no, deep_copy(getmetatable(o), seen))
    else -- number, string, boolean, etc
        no = o
    end
    return no
end


local function copy_array(table) --> table
    -- Returns an identical copy of `table`.
    -- Only for array-like tables.

    new_table = {}
    for i=1, #table do
        new_table[i] = table[i]
    end
    return table
end


local function copy_dict(table) --> table
    -- Returns an identical copy of `table`.
    -- Only for dict-like tables.

    new_table = {}
    for k,v in pairs(table) do
        new_table[k] = v
    end
end


return {
    deep_copy = deep_copy,
    copy_array = copy_array,
    copy_dict = copy_dict,
}
