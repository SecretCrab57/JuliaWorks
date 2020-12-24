function mister_robot(r::Robot)

    num = 0
    action = []

    while ((isborder(r, Sud)) && (isborder(r, West))) == false
        push!(action, mov!(r, West))
        push!(action, mov!(r, Sud))
        num+=2
    end

    putmarker!(r)

    while !isborder(r, Ost)
        move!(r, Ost)
        putmarker!(r)
    end

    count_mark = mov!(r, West)

    while !isborder(r, Nord) && count_mark > 0
        marks = count_mark
        move!(r, Nord)

        while marks > 0
            putmarker!(r)
            marks-=move_around(r, Ost)
        end

        move_around_back(r, West)
        count_mark-=1
    end

    mov!(r, Sud)

    while (num > 0) == true
        side = isodd(num) ? Ost : Nord

        for _ in 1:action[num]
            move!(r, side)
        end

        num-=1
    end
end

function move_around(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) &&! isborder(r, next(side))
        move!(r, next(side))
        counter_steps+=1
    end

    change = 0

    if !isborder(r, side)
        move!(r, side)
        change+=1
    end

    if counter_steps !=0

        while isborder(r, inverse(next(side)))
            move!(r, side)
            change+=1
        end

        for _ in 1:counter_steps
            move!(r, inverse(next(side)))
        end
    end

    return change
end

function mov!(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) == false
        move!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

function move_around_back(r::Robot, side::HorizonSide)

    change = 1

    while change! = 0
        change = move_around(r, side)
    end
end

next(side::HorizonSide) = (HorizonSide(mod(Int(side) + 1, 4)))
inverse(side::HorizonSide) = (HorizonSide(mod(Int(side) + 2, 4)))