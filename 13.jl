function mister_robot(r::Robot)

    side = Nord

    for _ in 1:4

        while (isborder(r, side) || isborder(r, next(side))) == false
            movese!(r, side)
            movese!(r, next(side))
            putmarker!(r)
        end

        side = inverse(side)

        while ismarker(r)
            movese!(r, side)
            movese!(r, next(side))
        end

        side = inverse(next(side))
    end

    putmarker!(r)
end

next(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))