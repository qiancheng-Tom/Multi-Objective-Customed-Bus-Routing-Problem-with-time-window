function ans = capacity_restriction(bus,bus1_capacity,bus2_capacity,station_information,bus_arrange)
    location0 = find(bus == 0)
    for i = 1 : size(location0,2)-1
        if bus_arrange(1,i) < 10
            geton_number = bus((location0(1,i)+1) : (location0(1,i+1)-1))
            guest = 0
            for j = 1 : size(geton_number,2)
                guest_number = station_information(geton_number(1,j),4)
                guest = guest + guest_number
            end
            if guest > bus1_capacity
                ans = 1
                break
            else
                ans = 0
            end
        elseif  bus_arrange(1,i) > 10
            geton_number = bus((location0(1,i)+1) : (location0(1,i+1)-1))
            guest = 0
            for j = 1 : size(geton_number,2)
                guest_number = station_information(geton_number(1,j),4)
                guest = guest + guest_number
            end
            if guest > bus2_capacity
                ans = 1
                break
            else
                ans = 0
            end
        end
    end
end