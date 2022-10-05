module hlwm
using FilePathsBase
export main

include("cmd.jl")
include("bootstrap.jl") # bootstrap
include("tag.jl")
include("keybind.jl")
include("config/keybinds.jl")


function main()
    set_binds()
end


end # module
