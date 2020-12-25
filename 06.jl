function mister_robot(r::Robot)

    num = 0
    action = []

    while ((isborder(r, Sud)) && (isborder(r, West))) == false
        push!(action, moves!(r, West))
        push!(action, moves!(r, Sud))
        num+=2
    end

    side = Nord

    while isborder(r, Ost) == false

        while isborder(r, side) == false
            movese!(r, side)

            if isborder(r, Ost) == true
                break
            end
        end

        if isborder(r, Ost) == false
            movese!(r, Ost)
        end

        side = inverse(side)
    end

    while isborder(r, Ost) == true
        movese!(r, Sud)
    end

    side = Nord

    for _ in 1:4

        putmarker!(r)
        movese!(r, side)

        while isborder(r, next(side)) == true
            putmarker!(r)
            movese!(r, side)
        end

        side = next(side)
    end

    moves!(r, Sud)
    moves!(r, West)

    while (num>0) == true
        side = isodd(num) ? Ost : Nord

        for _ in 1:action[num]
            movese!(r, side)
        end

        num-=1
    end
end

function moves!(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) == false
        movese!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

next(side::HorizonSide) = HorizonSide(mod(Int(side) + 3, 4))