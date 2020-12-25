function mister_robot(r::Robot)

    num = 0
    action = []

    while ((isborder(r, Sud)) && (isborder(r, West))) == false
        push!(action, moves!(r, West))
        push!(action, moves!(r, Sud))
        num+=2
    end

    side = Nord

    for _ in 1:4
        moves!(r, side)
        putmarker!(r)
        side = next(side)
    end

    while (num > 0) == true
        side = isodd(num) ? Ost : Nord

        for _ in 1:action[num]
            movese!(r, side)
        end

        num-=1
    end
end

function moves!(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r,side) == false
        movese!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

next(side::HorizonSide) = HorizonSide(mod(Int(side) + 3, 4))