function mister_robot(r::Robot)

    counter_steps = 1
    side = Ost

    while isborder(r, Nord) == true
        check(r, side, k)
        side = inverse(side)
        counter_steps+=1
    end
end

function check(r::Robot, side::HorizonSide, counter_steps::Int)

    for _ in 1:counter_steps
        move!(r, side)

        if isborder(r, Nord) == false
            break
        end
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))