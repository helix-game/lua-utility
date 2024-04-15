function table.deepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == 'table' then
            v = DeepCopy(v)
        end
        copy[k] = v
    end
    return copy
end

--- @brief: Searches for a value in a table and returns it (or nil if not found), can also search recursively and will return the entire path as follows:
--- @param recursive boolean: Whether to search recursively in any child tables for the value
--- @return any: Returns the entire path of the found value, e.g if Supermarket.Corners.Food.Fruits[2] = 'Apples', then searching for 'Apples' will return { Supermarket, Corners, Food, Fruits, 2 }
function table.find(tableToSearch, value, recursive, path)
    path = path or {} -- Initialize path as an empty table if not provided

    for k, v in pairs(tableToSearch) do
        if type(v) == "table" and recursive then
            local newPath = {table.unpack(path)} -- Clone the current path
            table.insert(newPath, k) -- Append the current key to the path
            local result = table.find(v, value, true, newPath) -- Recursive call
            if result then
                return result -- Return the result if found in nested table
            end
        elseif v == value then
            table.insert(path, k) -- Append the current key to the path
            return path
            --[[ return #path > 1 and path or k -- If path length is only 1 (then the only element is the direct parent of the value), then return it only; no table. If the path is longer, return the entire path ]]
        end
    end

    return nil -- Return nil if value is not found
end

--- @brief: Filters a table based on a predicate, all values in the table are run through this predicate; the ones that apply stay
--- @param predicate function: The predicate/filtering function, e.g function(v) do return v <= 5 end - This will remove all values of the table greater than 5
function table.filter(tbl, predicate)
    local result = {}
    for k, v in pairs(tbl) do
        if predicate(v) then
            result[k] = v
        end
    end
    return result
end

--- @brief: Maps the values in the table through a mapper function
--- @param mapper function: The mapping function, e.g function(v) do v + 1 end - This will add 1 to all the values of the table (incase of a numeric table)
function table.map(tbl, mapper)
    local result = {}
    for k, v in pairs(tbl) do
        result[k] = mapper(v)
    end
    return result
end

--- @brief: Merges two or more tables (numeric/non-numeric)
function table.merge(...)
    local result = {}
    for _, tbl in ipairs({...}) do
        for k, v in pairs(tbl) do
            if type(k) == "number" then
                -- Handling numeric keys
                result[#result + 1] = v
            else
                -- Handling non-numeric keys
                if result[k] ~= nil then
                    -- Handle conflict
                    -- Here, we're choosing to overwrite existing values
                    result[k] = v
                else
                    result[k] = v
                end
            end
        end
    end
    return result
end

--- @brief: Deep merges two or more tables (by merging them like table.merge, and merging any tables in them with their corresponding ones in other tables)
function table.deepMerge(...)
    local result = {}
    for _, tbl in ipairs({...}) do
        for k, v in pairs(tbl) do
            if type(v) == "table" and type(result[k]) == "table" then
                result[k] = table.deepMerge(result[k], v)
            else
                if type(k) == "number" then
                    -- Handling numeric keys
                    result[#result + 1] = v
                else
                    -- Handling non-numeric keys
                    if result[k] ~= nil then
                        -- Handle conflict
                        -- Here, we're choosing to overwrite existing values
                        result[k] = v
                    else
                        result[k] = v
                    end
                end
            end
        end
    end
    return result
end

--- @brief: Reduces the function to a single value using a reducer func & initial value
--- @param reducer function: The reducer function, e.g function(accumulator, v) do accumulator + v end - This will get the sum of all values in the table
function table.reduce(tbl, reducer, initialValue)
    local accumulator = initialValue
    for _, v in pairs(tbl) do
        accumulator = reducer(accumulator, v)
    end
    return accumulator
end

--- @brief: Slices a section of a table & returns it
--- @param tbl table: The table to slice
--- @param start integer: (Optional) The start index of the slice (default is 1)
--- @param stop integer: (Optional) The stop index of the slice (default is the length of the table)
--- @param step integer: (Optional) The step size of the slice (default is 1)
--- @return table: A new table containing the sliced elements
function table.slice(tbl, start, stop, step)
    local sliced = {}
    local len = #tbl

    -- Handle negative indices
    start = start and (start > 0 and start or len + start + 1) or 1
    stop = stop and (stop > 0 and stop or len + stop + 1) or len

    step = step or 1

    for i = start, stop, step do
        table.insert(sliced, tbl[i])
    end

    return sliced
end

--- @brief: Gets the size of a dictionary
function table.size(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

--- @brief: Shuffles the contents of a table
function table.shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

--- @brief: Removes spaces from around a string
function string.trim(str)
    return str:gsub("^%s+", ""):gsub("%s+$", "")
end

--- @brief: Pads a string with a specified character to reach a desired length
-- If the string is already longer than the specified length, it is returned unchanged.
--- @param str string: The string to pad
--- @param length integer: The desired length of the padded string
--- @param char string: (Optional) The character used for padding (default is space)
function string.pad(str, length, char)
    char = char or " "
    return str .. string.rep(char, length - #str)
end

function string.capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function math.degreesToRadians(degrees)
    return degrees * math.pi / 180
end

function math.radiansToDegrees(radians)
    return radians * 180 / math.pi
end

function math.isPrime(n)
    if n <= 1 then return false end
    for i = 2, math.sqrt(n) do
        if n % i == 0 then return false end
    end
    return true
end

function math.factorial(n)
    if n == 0 then return 1 end
    return n * factorial(n - 1)
end

--- @brief: Translates a value to be normalized/scaled into another range
--- @param input integer: Value to be translated
--- @param minValue integer: Minimum value for the input entity
--- @param maxValue integer: Maximum value for the input entity
--- @param minOutput integer: Minimum value for output
--- @param maxOutput integer: Maxmimum value for output
--- @return integer: Translated value, e.g if input is 40, minValue is 20, MaxValue is 60: Then input is half-way (0.5), so if minOutput = 100, maxOutput = 200, output/return will be 150 (half-way, 0.5)
--- e.g x (input) = 20, Xmin = 0, Xmax = 40    :    x = Xmin ... 0.5 ... Xmax
--- Then if, Ymin = 100, Ymax = 200 : translated X = Ymin ... 0.5 ... Ymax : equals 150
function math.scaleValue(input, minValue, maxValue, minOutput, maxOutput)
    -- Calculate the ratio of the input value relative to the input range
    local inputRatio = (input - minValue) / (maxValue - minValue)

    -- Scale the ratio to fit within the output range
    local outputValue = minOutput + inputRatio * (maxOutput - minOutput)

    -- Return the scaled output value
    return outputValue
end