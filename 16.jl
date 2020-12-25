function mister_robot(r::Robot)

    num = 0
    action = []

    while ((isborder(r,Sud)) && (isborder(r, West))) == false
        push!(action, moves!(r, West))
        push!(action, moves!(r, Sud))
        num+=2
    end

    putmarker!(r)

    while !isborder(r, Ost)
        movese!(r, Ost)
        putmarker!(r)
    end

    side = West

    while !isborder(r, Nord)
        change = 1
        movese!(r, Nord)
        putmarker!(r)

        while change!=0
            change = movese_around(r, side)
            putmarker!(r)
        end

        side = inverse(side)
    end

    moves!(r, West)
    moves!(r, Sud)

    while (num > 0) == true
        side = isodd(num) ? Ost : Nord

        for _ in 1:action[num]
            movese!(r, side)
        end

        num-=1
    end
end

function movese_around(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) &&! isborder(r, next(side))
        movese!(r, next(side))
        counter_steps+=1
    end

    change = 0

    if !isborder(r, side)
        movese!(r, side)
        change+=1
    end

    if counter_steps !=0

        while isborder(r, inverse(next(side)))
            movese!(r, side)
            change+=1
        end

        for _ in 1:counter_steps
            movese!(r, inverse(next(side)))
        end
    end

    return change
end

function moves!(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) == false
        movese!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

next(side::HorizonSide)=(HorizonSide(mod(Int(side) + 1, 4)))
inverse(side::HorizonSide)=(HorizonSide(mod(Int(side) + 2, 4)))