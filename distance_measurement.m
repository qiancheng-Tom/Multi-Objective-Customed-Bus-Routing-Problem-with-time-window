function distance = distance_measurement(bus1,bus2)
    distance = (((bus1(1,1) - bus2(1,1))^2) + ((bus1(1,2) - bus2(1,2))^2))^(1/2);     
end