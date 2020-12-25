X_COORD = 0
Y_COORD = 0
SIZE = 0 

function mister_robot(r::Robot, n::Int)

    global SIZE, Y_COORD, X_COORD
    SIZE = n
    vertical = moves!(r, Sud)
    horizontal = moves!(r, West)
    marking(r)
    movese_back(r, Sud, Y_COORD-vertical)
    movese_back(r, West, X_COORD-horizontal)
end

function marking(r::Robot)

    mark_row(r, Ost)
    side = West

    while isborder(r, Nord) == false
        movese_to_side(r, Nord)
        mark_row(r, side)
        side = inverse(side)
    end
end

function mark_row(r::Robot, side::HorizonSide)

    mark(r, X_COORD, Y_COORD, SIZE)

    while isborder(r, side) == false
        movese_to_side(r, side)
        mark(r, X_COORD, Y_COORD, SIZE)
    end
end
        
function mark(r::Robot, x_coord::Int, y_coord::Int, size::Int)

    if ((mod(x_coord, 2*size) in 0:size-1) && (mod(y_coord, 2*size) in 0:size-1))
        putmarker!(r)
    end

    if ((mod(x_coord, 2*size) in size:2*size-1) && (mod(y_coord, 2*size) in size:2*size-1))
        putmarker!(r)
    end
end

function movese_to_side(r::Robot, side::HorizonSide)

    global X_COORD, Y_COORD

    if side == Nord
        Y_COORD+=1
    elseif side == Sud
        Y_COORD-=1
    elseif side == Ost
        X_COORD+=1
    elseif side == West
        X_COORD-=1
    end

    movese!(r, side)
end

function moves!(r::Robot,side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) == false
        movese!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

function movese_back(r::Robot, side::HorizonSide, counter_steps::Int)

    if (counter_steps < 0) == true
        side = inverse(side)
        counter_steps*=-1
    end

    for _ in 1:counter_steps
        movese!(r, side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))