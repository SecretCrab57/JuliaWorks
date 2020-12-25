function mister_robot(r::Robot)

    counter_steps = 1
    side = Nord

    while ismarker(r) == false

        for _ in 1:2
            check_mark(r, side, counter_steps)
            side = next(side)
        end

        counter_steps+=1
    end
end

function check_mark(r::Robot, side::HorizonSide, counter_steps::Int)

    for _ in 1:counter_steps
        movese!(r, side)

        if ismarker(r) == true
            break
        end
    end
end

next(side::HorizonSide) = HorizonSide(mod(Int(side) + 3, 4))