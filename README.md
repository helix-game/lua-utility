# Lua Utility Functions

Compilation of useful utility functions in Lua, so far for the table, string & math libraries

## Table Functions

- `table.deepCopy(...)`: Creates a deep copy of a table, along with nested structures recursively
- `table.find(tableToSearch, value, recursive, path)`: Searches for a value in a table, optionally recursively, and returns its path if found
- `table.deepMerge(...)`: Deep merges two or more tables, merging nested tables recursively
- `table.filter(tbl, predicate)`: Filters a table based on a predicate function
- `table.map(tbl, mapper)`: Maps the values in a table through a mapper function
- `table.merge(...)`: Merges two or more tables, handling conflicts based on key types
- `table.reduce(tbl, reducer, initialValue)`: Reduces a table to a single value using a reducer function
- `table.slice(tbl, start, stop, step)`: Slices a section of a table and returns it
- `table.size(tbl)`: Gets the size of a dictionary (number of key-value pairs)
- `table.shuffle(tbl)`: Shuffles the contents of a table

## String Functions

- `string.trim(str)`: Removes spaces from around a string
- `string.pad(str, length, char)`: Pads a string with a specified character to reach a desired length
- `string.capitalize(str)`: Capitalizes the first letter of a string

## Math Functions

- `math.degreesToRadians(degrees)`: Converts degrees to radians
- `math.radiansToDegrees(radians)`: Converts radians to degrees
- `math.isPrime(n)`: Checks if a number is prime
- `math.factorial(n)`: Calculates the factorial of a non-negative integer
- `math.scaleValue(input, minValue, maxValue, minOutput, maxOutput)`: Translates a value to be normalized/scaled into another range

Each function is documented with a brief description and usage examples in the source code for easy reference
