function[bus1,bus2,bus3,bus4] = decode(bus_route,station_information,parking_information)
    bus_route
    parking = bus_route(1,1:10)
    location00 = find(parking == 0)
    location1 = find(parking == 1)
    location2 = find(parking == 2)
    location3 = find(parking == 3)
    location4 = find(parking == 4)
    
    geton = bus_route(1,11:30)
    location0 = find(geton == 0)
    bus1_geton = geton(1,1:location0(1,1)-1)
    bus2_geton = geton(1,location0(1,1)+1:location0(1,2)-1)
    bus3_geton = geton(1,location0(1,2)+1:location0(1,3)-1)
    bus4_geton = geton(1,location0(1,3)+1:location0(1,4)-1)
    
    getoff = bus_route(31:50)
    location0 = find(getoff == 0)
    bus1_getoff = getoff(1,1:location0(1,1)-1)
    bus2_getoff = getoff(1,location0(1,1)+1:location0(1,2)-1)
    bus3_getoff = getoff(1,location0(1,2)+1:location0(1,3)-1)
    bus4_getoff = getoff(1,location0(1,3)+1:location0(1,4)-1)
    %% 
    ans = 0;parking_information
    for i = 1 : size(location00,2)
        if location1 > location00(1,i)
            ans = ans + 1
        end
    end
    if ans == 2
       bus1_start = parking_information(1,:)
    elseif ans == 3
       bus1_start = parking_information(2,:)
    else
       bus1_start = parking_information(3,:)
    end
    %%
    ans = 0
    for i = 1 : size(location00,2)
        if location2 > location00(1,i)
            ans = ans + 1
        end
    end
    if ans == 2
       bus2_start = parking_information(1,:)
    elseif ans == 3
       bus2_start = parking_information(2,:)
    else
       bus2_start = parking_information(3,:)
    end
    %%
    ans = 0
    for i = 1 : size(location00,2)
        if location3 > location00(1,i)
            ans = ans + 1
        end
    end
    if ans == 2
       bus3_start = parking_information(1,:)
    elseif ans == 3
       bus3_start = parking_information(2,:)
    else
       bus3_start = parking_information(3,:)
    end
    %%
    ans = 0
    for i = 1 : size(location00,2)
        if location4 > location00(1,i)
            ans = ans + 1
        end
    end
    if ans == 2
       bus4_start = parking_information(1,:)
    elseif ans == 3
       bus4_start = parking_information(2,:)
    else
       bus4_start = parking_information(3,:)
    end
    
    %%
    bus1_geton_location = []
    for i = 1 : size(bus1_geton,2)
       location = station_information(bus1_geton(1,i),2:3)
       bus1_geton_location = [bus1_geton_location;location]
    end
    bus1_getoff_location = []
    for i = 1 : size(bus1_getoff,2)
       location = station_information(bus1_getoff(1,i) - size(station_information,1),6:7)
       bus1_getoff_location = [bus1_getoff_location;location]
    end
    bus1 = [bus1_start;bus1_geton_location;bus1_getoff_location]
    
    bus2_geton_location = [];
    for i = 1 : size(bus2_geton,2)
       location = station_information(bus2_geton(1,i),2:3);
       bus2_geton_location = [bus2_geton_location;location];
    end
    bus2_getoff_location = [];
    for i = 1 : size(bus2_getoff,2)
       location = station_information(bus2_getoff(1,i) - size(station_information,1),6:7);
       bus2_getoff_location = [bus2_getoff_location;location];
    end
    bus2 = [bus2_start;bus2_geton_location;bus2_getoff_location]
    
    bus3_geton_location = [];
    for i = 1 : size(bus3_geton,2)
       location = station_information(bus3_geton(1,i),2:3);
       bus3_geton_location = [bus3_geton_location;location];
    end
    bus3_getoff_location = [];
    for i = 1 : size(bus3_getoff,2);
       location = station_information(bus3_getoff(1,i) - size(station_information,1),6:7);
       bus3_getoff_location = [bus3_getoff_location;location];
    end
    bus3 = [bus3_start;bus3_geton_location;bus3_getoff_location]
    
    bus4_geton_location = [];
    for i = 1 : size(bus4_geton,2)
       location = station_information(bus4_geton(1,i),2:3);
       bus4_geton_location = [bus4_geton_location;location];
    end
    bus4_getoff_location = [];
    for i = 1 : size(bus4_getoff,2)
       location = station_information(bus4_getoff(1,i) - size(station_information,1),6:7);
       bus4_getoff_location = [bus4_getoff_location;location];
    end
    bus4 = [bus4_start;bus4_geton_location;bus4_getoff_location]
    
    
end