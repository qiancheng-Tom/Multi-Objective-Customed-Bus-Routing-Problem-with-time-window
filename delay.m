function Delay_time = delay(team,speed,guest_information,parking_information,bus1,bus2,bus3,bus4,station_information)
    moment = 0;
    team = [team 0];
    location0 = find(team == 0);
    station_on = station_information(:,2:3);
    station_off = station_information(:,6:7);
    Delay_time = 0;
    
    %% 
    bus1;
    bus1_moment = [];
    for i = 1 : (size(bus1,1)-1)/2
       distance = distance_measurement(bus1(i,:),bus1(i+1,:));
       time = (distance/speed/3.6)*60;
       moment = moment + time;
       bus_station = bus1(i+1,:);
       [~,ind]=ismember(bus_station,station_on,'rows');
       if ind <= size(station_on,1) - size(find(team == 0),2) + 1
           [~,iind]=ismember(bus_station,guest_information(:,1:2),'rows');
           guest = iind;
       else
           guest = team(1,location0(1,(ind - size(station_on,1) + size(find(team == 0),2) - 1))+1:location0(1,(ind - size(station_on,1) + size(find(team == 0),2)))-1);
       end
       
       [delay_time,interval] = guest_delay_on(guest,guest_information,moment);
       Delay_time = Delay_time + delay_time;
       if moment < interval
           moment = interval;
       end
       bus1_moment = [bus1_moment;moment];
    end
    
    for i = (size(bus1,1)+1)/2 : size(bus1,1)-1
       distance = distance_measurement(bus1(i,:),bus1(i+1,:));
       time = (distance/speed/3.6)*60;
       moment = moment + time;
       bus_station = bus1(i+1,:);
       [~,ind]=ismember(bus_station,station_off,'rows');
       if ind <= size(station_off,1) - size(find(team == 0),2) + 1
           [~,iind]=ismember(bus_station,guest_information(:,4:5),'rows');
           guest = iind;
       else
           guest = team(1,location0(1,(ind - size(station_off,1) + size(find(team == 0),2) - 1))+1:location0(1,(ind - size(station_on,1) + size(find(team == 0),2)))-1);
       end
       
       [delay_time,interval] = guest_delay_off(guest,guest_information,moment);
       Delay_time = Delay_time + delay_time;
       if moment < interval
           moment = interval;
       end
       bus1_moment = [bus1_moment;moment];
    end
    
    %%
    bus2;
    moment = 0;
    bus2_moment = [];
    for i = 1 : (size(bus2,1)-1)/2
       distance = distance_measurement(bus2(i,:),bus2(i+1,:));
       time = (distance/speed/3.6)*60;
       moment = moment + time;
       bus_station = bus2(i+1,:);
       [~,ind]=ismember(bus_station,station_on,'rows');
       if ind <= size(station_on,1) - size(find(team == 0),2) + 1
           [~,iind]=ismember(bus_station,guest_information(:,1:2),'rows');
           guest = iind;
       else
           guest = team(1,location0(1,(ind - size(station_on,1) + size(find(team == 0),2) - 1))+1:location0(1,(ind - size(station_on,1) + size(find(team == 0),2)))-1);
       end
       
       [delay_time,interval] = guest_delay_on(guest,guest_information,moment);
       Delay_time = Delay_time + delay_time;
       if moment < interval
           moment = interval;
       end
       bus2_moment = [bus2_moment;moment] ;
    end
    
    for i = (size(bus2,1)+1)/2 : size(bus2,1)-1
       distance = distance_measurement(bus2(i,:),bus2(i+1,:));
       time = (distance/speed/3.6)*60;
       moment = moment + time;
       bus_station = bus2(i+1,:);
       [~,ind]=ismember(bus_station,station_off,'rows');
       if ind <= size(station_off,1) - size(find(team == 0),2) + 1
           [~,iind]=ismember(bus_station,guest_information(:,4:5),'rows');
           guest = iind;
       else
           guest = team(1,location0(1,(ind - size(station_off,1) + size(find(team == 0),2) - 1))+1:location0(1,(ind - size(station_on,1) + size(find(team == 0),2)))-1);
       end
       
       [delay_time,interval] = guest_delay_off(guest,guest_information,moment);
       Delay_time = Delay_time + delay_time;
       if moment < interval
           moment = interval;
       end
       bus2_moment = [bus2_moment;moment];
    end
    
    %%
    bus3;
    moment = 0;
    bus3_moment = [];
    for i = 1 : (size(bus3,1)-1)/2
       distance = distance_measurement(bus3(i,:),bus3(i+1,:));
       time = (distance/speed/3.6)*60;
       moment = moment + time;
       bus_station = bus3(i+1,:);
       [~,ind]=ismember(bus_station,station_on,'rows');
       if ind <= size(station_on,1) - size(find(team == 0),2) + 1
           [~,iind]=ismember(bus_station,guest_information(:,1:2),'rows');
           guest = iind;
       else
           guest = team(1,location0(1,(ind - size(station_on,1) + size(find(team == 0),2) - 1))+1:location0(1,(ind - size(station_on,1) + size(find(team == 0),2)))-1)
       end
       
       [delay_time,interval] = guest_delay_on(guest,guest_information,moment);
       Delay_time = Delay_time + delay_time;
       if moment < interval
           moment = interval;
       end
       bus3_moment = [bus3_moment;moment];
    end
    
    for i = (size(bus3,1)+1)/2 : size(bus3,1)-1
       distance = distance_measurement(bus3(i,:),bus3(i+1,:));
       time = (distance/speed/3.6)*60;
       moment = moment + time;
       bus_station = bus3(i+1,:);
       [~,ind]=ismember(bus_station,station_off,'rows');
       if ind <= size(station_off,1) - size(find(team == 0),2) + 1
           [~,iind]=ismember(bus_station,guest_information(:,4:5),'rows');
           guest = iind;
       else
           guest = team(1,location0(1,(ind - size(station_off,1) + size(find(team == 0),2) - 1))+1:location0(1,(ind - size(station_on,1) + size(find(team == 0),2)))-1)
       end
       
       [delay_time,interval] = guest_delay_off(guest,guest_information,moment);
       Delay_time = Delay_time + delay_time;
       if moment < interval
           moment = interval;
       end
       bus3_moment = [bus3_moment;moment];
    end
    
    %%
    bus4;
    moment = 0;
    bus4_moment = [];
    for i = 1 : (size(bus4,1)-1)/2
       distance = distance_measurement(bus4(i,:),bus4(i+1,:));
       time = (distance/speed/3.6)*60;
       moment = moment + time;
       bus_station = bus4(i+1,:);
       [~,ind]=ismember(bus_station,station_on,'rows');
       if ind <= size(station_on,1) - size(find(team == 0),2) + 1
           [~,iind]=ismember(bus_station,guest_information(:,1:2),'rows');
           guest = iind;
       else
           guest = team(1,location0(1,(ind - size(station_on,1) + size(find(team == 0),2) - 1))+1:location0(1,(ind - size(station_on,1) + size(find(team == 0),2)))-1)
       end
       
       [delay_time,interval] = guest_delay_on(guest,guest_information,moment);
       Delay_time = Delay_time + delay_time;
       if moment < interval
           moment = interval;
       end
       bus4_moment = [bus4_moment;moment] ;
    end
    
    for i = (size(bus4,1)+1)/2 : size(bus4,1)-1
       distance = distance_measurement(bus4(i,:),bus4(i+1,:));
       time = (distance/speed/3.6)*60;
       moment = moment + time;
       bus_station = bus4(i+1,:);
       [~,ind]=ismember(bus_station,station_off,'rows');
       if ind <= size(station_off,1) - size(find(team == 0),2) + 1;
           [~,iind]=ismember(bus_station,guest_information(:,4:5),'rows');
           guest = iind;
       else
           guest = team(1,location0(1,(ind - size(station_off,1) + size(find(team == 0),2) - 1))+1:location0(1,(ind - size(station_on,1) + size(find(team == 0),2)))-1);
       end
       
       [delay_time,interval] = guest_delay_off(guest,guest_information,moment);
       Delay_time = Delay_time + delay_time;
       if moment < interval
           moment = interval;
       end
       bus4_moment = [bus4_moment;moment];
    end
end