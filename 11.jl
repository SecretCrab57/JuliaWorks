function mister_robot(r::Robot)

    num = 0
    action = []

    while ((isborder(r, Sud)) && (isborder(r, West))) == false
        push!(action, mov!(r, West))
        push!(action, mov!(r, Sud))
        num+=2
    end

    vertical = 0
    horizontal = 0

    for i in 1:num

        if isodd(i) == true
            horizontal+=action[i]
        else
            vertical+=action[i]
        end
    end

    side = Nord

    for _ in 1:2
        vertical = mark_o(r, side, vertical)
        side = next(side)
        horizontal = mark_o(r, side, horizontal)
        side = next(side)
    end

    while (num > 0) == true
        side = isodd(num) ? Ost : Nord
        move_steps(r, side, action[num])
        num-=1
    end
end

function mov!(r::Robot,side::HorizonSide)

    counter_steps = 0

    while isborder(r, side) == false
        move!(r, side)
        counter_steps+=1
    end

    return counter_steps
end

function mark_o(r::Robot, side::HorizonSide, counter_steps::Int)

    move_steps(r, side, counter_steps)
    putmarker!(r)
    counter_steps = mov!(r, side)
    return counter_steps
end

function move_steps(r::Robot, side::HorizonSide, counter_steps::Int)

    for _ in 1:counter_steps
        move!(r, side)
    end
end

next(side::HorizonSide) = HorizonSide(mod(Int(side) + 3, 4))
