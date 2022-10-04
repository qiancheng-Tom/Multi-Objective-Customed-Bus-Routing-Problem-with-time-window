function company_cost = cost(bus1,bus2,bus3,bus4,guest_information,team,station_information,route)
    c1 = 15;
    c2 = 2.4;
    c3 = 12;
    c4 = 1.8;
    team = [team 0];
    guest_distance = [];
    for i = 1 : size(guest_information,1)
       [~,ind]=ismember(guest_information(i,1:2),station_information(:,2:3),'rows');
       if ind ~= 0
          [~,ind1]=ismember(guest_information(i,1:2),bus1,'rows');
          [~,ind2]=ismember(guest_information(i,1:2),bus2,'rows');
          [~,ind3]=ismember(guest_information(i,1:2),bus3,'rows');
          [~,ind4]=ismember(guest_information(i,1:2),bus4,'rows');
          if ind1 ~= 0
              [~,ind11]=ismember(guest_information(i,4:5),bus1,'rows');
              distance = 0;
              for j = ind1 : ind11 - 1
                  dis = distance_measurement(bus1(j,:),bus1(j+1,:));
                  distance = distance + dis;
              end
          end
          if ind2 ~= 0
              [~,ind21]=ismember(guest_information(i,4:5),bus2,'rows');
              distance = 0;
              for j = ind2 : ind21 - 1
                  dis = distance_measurement(bus2(j,:),bus2(j+1,:));
                  distance = distance + dis;
              end
          end
          if ind3 ~= 0
              [~,ind31]=ismember(guest_information(i,4:5),bus3,'rows');
              distance = 0;
              for j = ind3 : ind31 - 1
                  dis = distance_measurement(bus3(j,:),bus3(j+1,:));
                  distance = distance + dis;
              end
          end
          if ind4 ~= 0
              [~,ind41]=ismember(guest_information(i,4:5),bus4,'rows');
              distance = 0;
              for j = ind4 : ind41 - 1 
                  dis = distance_measurement(bus4(j,:),bus4(j+1,:));
                  distance = distance + dis;
              end
          end
          
          
       elseif ind == 0
           location0 = find(team == 0);
           for j = 1 : size(find(team == 0),2)-1
               w = team(1,location0(1,j)+1:location0(1,j+1)-1);
               if find(w == i) > 0
                   station_number = size(station_information,1)-size(find(team == 0),2) + 1 + j;
                   start = station_information(station_number,2:3);
                   stop = station_information(station_number,6:7);
               end
           end
           [~,ind1]=ismember(start,bus1,'rows');
           [~,ind2]=ismember(start,bus2,'rows');
           [~,ind3]=ismember(start,bus3,'rows');
           [~,ind4]=ismember(start,bus4,'rows');
           if ind1 ~= 0
              [~,ind11]=ismember(stop,bus1,'rows');
              distance = 0;
              for j = ind1 : ind11 - 1
                  dis = distance_measurement(bus1(j,:),bus1(j+1,:));
                  distance = distance + dis;
              end
          end
          if ind2 ~= 0
              [~,ind21]=ismember(stop,bus2,'rows');
              distance = 0;
              for j = ind2 : ind21 - 1
                  dis = distance_measurement(bus2(j,:),bus2(j+1,:));
                  distance = distance + dis;
              end
          end
          if ind3 ~= 0
              [~,ind31]=ismember(stop,bus3,'rows');
              distance = 0;
              for j = ind3 : ind31 - 1
                  dis = distance_measurement(bus3(j,:),bus3(j+1,:));
                  distance = distance + dis;
              end
          end
          if ind4 ~= 0
              [~,ind41]=ismember(stop,bus4,'rows');
              distance = 0;
              for j = ind4 : ind41 - 1 
                  dis = distance_measurement(bus4(j,:),bus4(j+1,:));
                  distance = distance + dis;;
              end
          end
       end
       guest_distance = [guest_distance;distance];
    end
    
    income = 0;
    for i = 1 : size(guest_distance,1)
        if guest_distance(i,1) > 15
            guest_price = 2 + (guest_distance(i,1) - 15)*0.4;
            income = income + guest_price;
        end
    end
    
    bus1 = [bus1;bus1(1,:)];
    distance_bus1 = 0;
    route(:,find(route == 0)) = [];
    k = find(route == 1);
    if size(k,2) > 0
        ans = 1;
    else
        ans = 0;
    end
    for i = 1 : size(bus1,1) - 1
       distance = distance_measurement(bus1(i,:),bus1(i+1,:));
       distance_bus1 = distance_bus1 + distance;
    end
    if ans == 1
        bus1_fee = c1 + c2 * distance_bus1;
    else
        bus1_fee = c3 + c4 * distance_bus1;
    end
    
    bus2 = [bus2;bus2(1,:)];
    distance_bus2 = 0;
    route(:,find(route == 0)) = [];
    k = find(route == 2);
    if size(k,2) > 0
        ans = 1;
    else
        ans = 0;
    end
    for i = 1 : size(bus2,1) - 1
       distance = distance_measurement(bus2(i,:),bus2(i+1,:));
       distance_bus2 = distance_bus2 + distance;
    end
    if ans == 1
        bus2_fee = c1 + c2 * distance_bus2;
    else
        bus2_fee = c3 + c4 * distance_bus2;
    end
    
    bus3 = [bus3;bus3(1,:)];
    distance_bus3 = 0;
    route(:,find(route == 0)) = [];
    k = find(route == 3);
    if size(k,2) > 0
        ans = 1;
    else
        ans = 0;
    end
    for i = 1 : size(bus3,1) - 1
       distance = distance_measurement(bus3(i,:),bus3(i+1,:));
       distance_bus3 = distance_bus3 + distance;
    end
    if ans == 1
        bus3_fee = c1 + c2 * distance_bus3;
    else
        bus3_fee = c3 + c4 * distance_bus3;
    end
    
    bus4 = [bus4;bus4(1,:)];
    distance_bus4 = 0;
    route(:,find(route == 0)) = [];
    k = find(route == 4);
    if size(k,2) > 0
        ans = 1;
    else
        ans = 0;
    end
    for i = 1 : size(bus4,1) - 1
       distance = distance_measurement(bus4(i,:),bus4(i+1,:));
       distance_bus4 = distance_bus4 + distance;
    end
    if ans == 1
        bus4_fee = c1 + c2 * distance_bus4;
    else
        bus4_fee = c3 + c4 * distance_bus4;
    end
    company_cost = bus1_fee + bus2_fee + bus3_fee + bus4_fee - income;
end