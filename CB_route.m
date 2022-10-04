function bus_route = CB_route(station_information,bus_amount,bus1_capacity,bus2_capacity)
    total_guest = sum(station_information(:,size(station_information,2)))
    
    parking_number = [1:bus_amount]
    geton_number = [1:size(station_information,1)]
    getoff_number = [(size(station_information,1) + 1) : (2 * size(station_information,1))]
    
    an = 1
    %% 给车辆分配站点
    while an
    pool = [1 2 3 11 12 13];
    bus_arrange = []
    for i = 1 : bus_amount
        number = size(pool,2)
        n = 1;
        random_num = pool(randperm(numel(pool),n));
        random_num = sort(random_num);
        pool(:,pool == random_num) = [];
        bus_arrange = [bus_arrange random_num];
    end
    
    first_bus = [];
    second_bus = [];
    third_bus = [];
    forth_bus = [];
    for i = 1 : size(geton_number,2)   %这里考虑的是4辆车的情况
       p = rand;
       if p < 1/4
           number = geton_number(1,i);
           first_bus = [first_bus number];
       elseif (1/4 <= p) && (p < 1/2)
           number = geton_number(1,i);
           second_bus = [second_bus number];
       elseif (1/2 <= p) && (p < 3/4)
           number = geton_number(1,i);
           third_bus = [third_bus number];
       else
           number = geton_number(1,i);
           forth_bus = [forth_bus number] ;          
       end
    end
    bus = [0 first_bus 0 second_bus 0 third_bus 0 forth_bus 0];
    an = capacity_restriction(bus,bus1_capacity,bus2_capacity,station_information,bus_arrange);
    for i = 1 :size(bus,2) - 1
       if bus(1,i+1) - bus(1,i) == 0
          an = 1 ;
       end
    end
    
    if an == 0
        getoff = first_bus + size(station_information,1);
        getoff = getoff(randperm(length(getoff)));
        first_bus = [first_bus getoff];
        
        getoff = second_bus + size(station_information,1);
        getoff = getoff(randperm(length(getoff)));
        second_bus = [second_bus getoff];
    
        getoff = third_bus + size(station_information,1);
        getoff = getoff(randperm(length(getoff)));
        third_bus = [third_bus getoff];
    
        getoff = forth_bus + size(station_information,1);
        getoff = getoff(randperm(length(getoff)));
        forth_bus = [forth_bus getoff];
    end
    end
    
    
    %% 给车辆分配停车场，默认是3个
    first_parking = []
    second_parking = []
    third_parking = []
    bus_arrange
    for i = 1 : size(bus_arrange,2)   %这里考虑的是4辆车的情况
        num = bus_arrange(1,i)
        if num == 1
            first_parking = [first_parking i];
        elseif num == 11
            first_parking = [first_parking i+10];
        elseif num == 2
            second_parking = [second_parking i];
        elseif num == 12
            second_parking = [second_parking i+10];
        elseif num == 3
            third_parking = [third_parking i];
        elseif num == 13
            third_parking = [third_parking i+10];
        end
    end
    
    number = size(first_bus,2)
    first_on = [first_bus(1,1:number/2)];first_off = [first_bus(1,number/2 + 1 :number)];
    number = size(second_bus,2)
    second_on = [second_bus(1,1:number/2)];second_off = [second_bus(1,number/2 + 1 :number)];
    number = size(third_bus,2)
    third_on = [third_bus(1,1:number/2)];third_off = [third_bus(1,number/2 + 1 :number)];
    number = size(forth_bus,2)
    forth_on = [forth_bus(1,1:number/2)];forth_off = [forth_bus(1,number/2 + 1 :number)];
    bus_route = [0 0 first_parking 0 second_parking 0 third_parking 0 0 ....
    first_on 0 second_on 0 third_on 0 forth_on 0 0....
    first_off 0 second_off 0 third_off 0 forth_off 0 0];
end