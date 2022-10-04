function Initial_population = Population_formation(station_information,bus_amount,bus1_capacity,bus2_capacity,Iterations)
    Initial_population = []
    for i = 1 :Iterations 
        bus_route = CB_route(station_information,bus_amount,bus1_capacity,bus2_capacity)
        Initial_population = [Initial_population;bus_route]
    end
end