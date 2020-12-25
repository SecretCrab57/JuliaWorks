function mister_robot(r::Robot)

    side = Ost
    horizontal = moves!(r, West)
    vertical = moves!(r, Sud)
    change = 1

    while isborder(r, Nord) == false
        mark(r, abs(vertical), abs(horizontal), 1)

        while isborder(r, side) == false
            movese!(r, side)
            horizontal-=change
            mark(r, abs(vertical), abs(horizontal), 1)
        end

        movese!(r, Nord)
        side = inverse(side)
        vertical-=1
        change* = -1
    end

    mark(r, abs(vertical), abs(horizontal), 1)

    while isborder(r, side) == false
        movese!(r, side)
        horizontal-=change
        mark(r, abs(vertical), abs(horizontal), 1)
    end

    movese_back(r, Nord, vertical)
    movese_back(r, Ost, horizontal)
end

function moves!(r::Robot, side::HorizonSide)

    counter_steps = 0

    while isborder(r,side) == false
        movese!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

function mark(r::Robot, x_coord::Int, y_coord::Int, size::Int)

    if ((mod(x_coord, 2*size) in 0:size-1)&&(mod(y_coord, 2*size) in 0:size-1))
        putmarker!(r)
    end

    if ((mod(x_coord, 2*size) in size:2*size-1)&&(mod(y_coord, 2*size) in size:2*size-1))
        putmarker!(r)
    end
end
    
function movese_back(r::Robot, side::HorizonSide, counter_steps::Int)

    if (counter_steps < 0) == true
        side = inverse(side)
        counter_steps* = -1
    end

    for _ in 1:counter_steps
        movese!(r, side)
    end
end
    
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))