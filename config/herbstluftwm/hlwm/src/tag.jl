struct Tag{L,R}
    name::L
    key::R
end

Tag(n::Int64) = Tag(n, n)

