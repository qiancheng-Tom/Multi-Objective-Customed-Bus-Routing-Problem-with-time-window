function emission = canbon_emission(bus1,bus2,bus3,bus4,station_information,weight,speed,route)
    bus1
    bus2
    bus3
    bus4
    geton_station = station_information(:,2:3)
    getoff_station = station_information(:,6:7)
    %%
    bus1_guest = [0]
    bus1_get = bus1
    bus1_get(1,:) = []
    h = size(bus1_get,1)
    bus1_geton = bus1_get(1:h/2,:);bus1_getoff = bus1_get(((h/2)+1):h,:)
    number = 0
    for i = 1 : size(bus1_geton,1)
        [~,ind]=ismember(bus1_geton(i,:),geton_station,'rows');
        guest = station_information(ind,4);
        number = number + guest;
        bus1_guest = [bus1_guest;number];
    end
    
    for i = 1 : size(bus1_getoff,1) 
        [~,ind]=ismember(bus1_getoff(i,:),getoff_station,'rows');
        guest = station_information(ind,4);
        number = number - guest;
        bus1_guest = [bus1_guest;number]
    end
    %%
    bus2_guest = [0];
    bus2_get = bus2;
    bus2_get(1,:) = [];
    h = size(bus2_get,1);
    bus2_geton = bus2_get(1:h/2,:);bus2_getoff = bus2_get(((h/2)+1):h,:);
    number = 0;
    for i = 1 : size(bus2_geton,1) 
        [~,ind]=ismember(bus2_geton(i,:),geton_station,'rows');
        guest = station_information(ind,4);
        number = number + guest;
        bus2_guest = [bus2_guest;number];
    end
    
    for i = 1 : size(bus2_getoff,1) 
        [~,ind]=ismember(bus2_getoff(i,:),getoff_station,'rows');
        guest = station_information(ind,4);
        number = number - guest;
        bus2_guest = [bus2_guest;number]
    end
    %%
    bus3_guest = [0];
    bus3_get = bus3;
    bus3_get(1,:) = [];
    h = size(bus3_get,1);
    bus3_geton = bus3_get(1:h/2,:);bus3_getoff = bus3_get(((h/2)+1):h,:);
    number = 0;
    for i = 1 : size(bus3_geton,1) 
        [~,ind]=ismember(bus3_geton(i,:),geton_station,'rows');
        guest = station_information(ind,4);
        number = number + guest;
        bus3_guest = [bus3_guest;number];
    end
    
    for i = 1 : size(bus3_getoff,1) 
        [~,ind]=ismember(bus3_getoff(i,:),getoff_station,'rows');
        guest = station_information(ind,4);
        number = number - guest;
        bus3_guest = [bus3_guest;number];
    end
    %%
    bus4_guest = [0];
    bus4_get = bus4;
    bus4_get(1,:) = [];
    h = size(bus4_get,1);
    bus4_geton = bus4_get(1:h/2,:);bus4_getoff = bus4_get(((h/2)+1):h,:);
    number = 0;
    for i = 1 : size(bus4_geton,1) 
        [~,ind]=ismember(bus4_geton(i,:),geton_station,'rows');
        guest = station_information(ind,4);
        number = number + guest;
        bus4_guest = [bus4_guest;number];
    end
    
    for i = 1 : size(bus4_getoff,1) 
        [~,ind]=ismember(bus4_getoff(i,:),getoff_station,'rows');
        guest = station_information(ind,4);
        number = number - guest;
        bus4_guest = [bus4_guest;number];
    end
    
    %%
    bus1_fuel = 0;
    bus1 = [bus1;bus1(1,:)];
    route(:,find(route == 0)) = [];
    k = find(route == 1);
    if size(k,2) > 0
        ans = 1;
    else
        ans = 0;
    end
    for i = 1 : size(bus1,1) - 1
        distance = (((bus1(i+1,1) - bus1(i,1))^2) + ((bus1(i+1,2) - bus1(i,2))^2))^(1/2)
        fuel_consumption = emission_model(distance,weight,speed,bus1_guest(i,1),ans)
        bus1_fuel = bus1_fuel + fuel_consumption
    end
    
    bus2_fuel = 0;
    bus2 = [bus2;bus2(1,:)];
    route(:,find(route == 0)) = [];
    k = find(route == 2);
    if size(k,2) > 0
        ans = 1;
    else
        ans = 0;
    end
    for i = 1 : size(bus2,1) - 1
        distance = (((bus2(i+1,1) - bus2(i,1))^2) + ((bus2(i+1,2) - bus2(i,2))^2))^(1/2);
        fuel_consumption = emission_model(distance,weight,speed,bus2_guest(i,1),ans);
        bus2_fuel = bus2_fuel + fuel_consumption;
    end
    
    bus3_fuel = 0;
    bus3 = [bus3;bus3(1,:)];
    route(:,find(route == 0)) = [];
    k = find(route == 3);
    if size(k,2) > 0
        ans = 1;
    else
        ans = 0;
    end
    for i = 1 : size(bus3,1) - 1
        distance = (((bus3(i+1,1) - bus3(i,1))^2) + ((bus3(i+1,2) - bus3(i,2))^2))^(1/2);
        fuel_consumption = emission_model(distance,weight,speed,bus3_guest(i,1),ans);
        bus3_fuel = bus3_fuel + fuel_consumption;
    end
    
    bus4_fuel = 0;
    bus4 = [bus4;bus4(1,:)];
    route(:,find(route == 0)) = [];
    k = find(route == 4);
    if size(k,2) > 0
        ans = 1;
    else
        ans = 0;
    end
    for i = 1 : size(bus4,1) - 1
        distance = (((bus4(i+1,1) - bus4(i,1))^2) + ((bus4(i+1,2) - bus4(i,2))^2))^(1/2);
        fuel_consumption = emission_model(distance,weight,speed,bus4_guest(i,1),ans);
        bus4_fuel = bus4_fuel + fuel_consumption;
    end
    
    fuel = bus1_fuel + bus2_fuel + bus3_fuel + bus4_fuel;
    emission = fuel * 0.85 * 42705 * 0.0638152;
end