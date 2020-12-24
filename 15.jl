function mister_robot(r::Robot)

    num = 0
    action = []

    while ((isborder(r, Sud)) && (isborder(r, West))) == false
        push!(action, mov!(r, West))
        push!(action, mov!(r, Sud))
        num+=2
    end

    side = Nord

    for _ in 1:4

        while !isborder(r, side)
            putmarker!(r)
            move!(r, side)
        end

        side = inverse(next(side))
    end

    while (num > 0) == true
        side = isodd(num) ? Ost : Nord

        for _ in 1:action[num]
            move!(r, side)
        end

        num-=1
    end
end

function mov!(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) == false
        move!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

next(side::HorizonSide) = (HorizonSide(mod(Int(side) + 1, 4)))
inverse(side::HorizonSide) = (HorizonSide(mod(Int(side) + 2, 4)))