function mister_robot(r::Robot)

    vertical = moveses!(r,Sud)
    horizontal = moveses!(r,West)
    putmarker!(r)
    side = Ost

    while isborder(r,Nord) == false
        paint_row(r,side)
        side = inverse(side)
        movese!(r,Nord)
        putmarker!(r)
    end

    row(r,side)
    moves!(r,West)
    moves!(r,Sud)    
    movese_back(r,Nord,vertical)
    movese_back(r,Ost,horizontal)
end

function moveses!(r::Robot,side::HorizonSide)

    counter_steps = 0

    while isborder(r,side) == false
        movese!(r,side)
        counter_steps+=1
    end

    return counter_steps
end

function row(r::Robot, side::HorizonSide)

    while isborder(r,side) == false
        movese!(r,side)
        putmarker!(r)
    end
end

function movese_back(r::Robot, side::HorizonSide, counter_steps::Int)

    if (counter_steps<0) == true
        side = inverse(side)
        counter_steps* = -1
    end

    for _ in 1:counter_steps
        movese!(r,side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))