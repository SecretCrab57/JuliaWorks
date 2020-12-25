function mister_robot(r::Robot)

    num = 0
    action = []

    while ((isborder(r, Sud)) && (isborder(r, West))) == false
        push!(action, moves!(r, West))
        push!(action, moves!(r, Sud))
        num+=2
    end

    putmarker!(r)

    while !isborder(r, Ost)
        movese!(r, Ost)
        putmarker!(r)
    end

    count_mark = moves!(r, West)

    while !isborder(r, Nord) && count_mark > 0
        marks = count_mark
        movese!(r, Nord)

        while marks > 0
            putmarker!(r)
            marks-=movese_around(r, Ost)
        end

        movese_around_back(r, West)
        count_mark-=1
    end

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

function movese_around_back(r::Robot, side::HorizonSide)

    change = 1

    while change! = 0
        change = movese_around(r, side)
    end
end

next(side::HorizonSide) = (HorizonSide(mod(Int(side) + 1, 4)))
inverse(side::HorizonSide) = (HorizonSide(mod(Int(side) + 2, 4)))