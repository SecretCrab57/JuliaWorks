function mister_robot(r::Robot)

    side = Ost
    vertical = mov!(r, Sud)
    horizontal = mov!(r, Ost)
    count = mov!(r, West)
    horizontal = count-horizontal

    while count > 0
        putmarker!(r)

        for _ in 1:count
            move!(r, side)
            putmarker!(r)
        end

        if isborder(r, West) == false
            move!(r, West)
        end

        if isborder(r, Nord) == false
            move!(r, Nord)
            vertical-=1
        else
            break
        end

        side = inverse(side)
        count-=1
    end

    putmarker!(r)
    mov!(r, West)
    move_back(r, Nord, vertical)
    move_back(r, Ost, horizontal)
end

function mov!(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) == false
        move!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

function move_back(r::Robot, side::HorizonSide, counter_steps::Int)

    if (counter_steps<0) == true
        side = inverse(side)
        counter_steps*=-1
    end

    for _ in 1:counter_steps
        move!(r, side)
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side) + 2, 4))