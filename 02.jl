function lv2(r)

    r = Robot(; animate=true)
    vertical = moves!(r, Down)
    horizontal = moves!(r, Left)

    for dir in (Up, Right, Down, Left)
        putmarkers!(r, dir)
    end

    moves!(r, Up, verticalt)
    moves!(r, Right, horizontal)
end