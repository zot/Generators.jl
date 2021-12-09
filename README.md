
<a id='Generators'></a>

<a id='Generators-1'></a>

# Generators


Very lightweight, task-based generators.


<a id='Generators.jl-Documentation'></a>

<a id='Generators.jl-Documentation-1'></a>

# Generators.jl Documentation

<a id='Generators.generate-Tuple{Function}' href='#Generators.generate-Tuple{Function}'>#</a>
**`Generators.generate`** &mdash; *Method*.



```julia
generate(func::Function)
```

Create a generator from func. Func receives a "yield" function as its argument. You can use this function to produce values.

Here's an example of a recursive generator:

```julia
flattened(list) = generate() do yield
    fl(el::Vector) = foreach(fl, el)
    fl(el) = yield(el)
    fl(list)
end

[flattened([1, [2, [3], 4], 5])...] == [1,2,3,4,5]
```

