function mister_robot(r::Robot)

    for side in (DirectionsOfMovement(i) for i=0:3)
        putmarkers!(r,side)
        move_by_markers(r, inverse(side))
    end

    putmarker!(r)
end