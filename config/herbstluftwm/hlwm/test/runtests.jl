using Test

using hlwm

@testset "command creation" begin
    @test cmd("ls") == `ls`
    @test cmd("herbsctlient layout") == `herbsctlient layout`
    @test cmd("herbsctlient keybind Mod-x spawn hamburger") == `herbsctlient keybind Mod-x spawn hamburger`
end

@testset "keybinds" begin


end
