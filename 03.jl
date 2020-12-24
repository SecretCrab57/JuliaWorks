function mister_robot(r::Robot)

    vertical = moves!(r,Sud)
    horizontal = moves!(r,West)
    putmarker!(r)
    side = Ost

    while isborder(r,Nord) == false
        paint_row(r,side)
        side = inverse(side)
        move!(r,Nord)
        putmarker!(r)
    end

    row(r,side)
    mov!(r,West)
    mov!(r,Sud)    
    move_back(r,Nord,vertical)
    move_back(r,Ost,horizontal)
end

function moves!(r::Robot,side::HorizonSide)

    counter_steps = 0

    while isborder(r,side) == false
        move!(r,side)
        counter_steps+=1
    end

    return counter_steps
end

function row(r::Robot, side::HorizonSide)

    while isborder(r,side) == false
        move!(r,side)
        putmarker!(r)
    end
end

function move_back(r::Robot, side::HorizonSide, counter_steps::Int)

    if (counter_steps<0) == true
        side = inverse(side)
        counter_steps* = -1
    end

    for _ in 1:counter_steps
        move!(r,side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))