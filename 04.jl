function mister_robot(r::Robot)

    side = Ost
    vertical = moves!(r, Sud)
    horizontal = moves!(r, Ost)
    count = moves!(r, West)
    horizontal = count-horizontal

    while count > 0
        putmarker!(r)

        for _ in 1:count
            movese!(r, side)
            putmarker!(r)
        end

        if isborder(r, West) == false
            movese!(r, West)
        end

        if isborder(r, Nord) == false
            movese!(r, Nord)
            vertical-=1
        else
            break
        end

        side = inverse(side)
        count-=1
    end

    putmarker!(r)
    moves!(r, West)
    movese_back(r, Nord, vertical)
    movese_back(r, Ost, horizontal)
end

function moves!(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) == false
        movese!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

function movese_back(r::Robot, side::HorizonSide, counter_steps::Int)

    if (counter_steps<0) == true
        side = inverse(side)
        counter_steps*=-1
    end

    for _ in 1:counter_steps
        movese!(r, side)
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side) + 2, 4))