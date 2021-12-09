module Generators

export generate

struct GenTask
    task::Task
end

Base.iterate(gen::GenTask) = Base.iterate(gen, nothing)
function Base.iterate(gen::GenTask, _)
    result = yieldto(gen.task)
    istaskdone(gen.task) ? nothing : (result, nothing)
end

Base.IteratorSize(_::GenTask) = Base.SizeUnknown()

"""
    generate(func::Function)

Create a generator from func. Func receives a "yield" function as its argument. You can use
this function to produce values.

Here's an example of a recursive generator:

```jldoctest; output = false
flattened(list) = generate() do yield
    fl(el::Vector) = foreach(fl, el)
    fl(el) = yield(el)
    fl(list)
end

[flattened([1, [2, [3], 4], 5])...] == [1,2,3,4,5]

# output

true
```

"""
function generate(func::Function)
    cur = current_task()
    GenTask(Task(()-> begin
        func(result-> yieldto(cur, result))
        schedule(cur)
    end))
end

end
