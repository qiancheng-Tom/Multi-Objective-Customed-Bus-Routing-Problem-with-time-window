function [new_population1,new_population2] = crossover(MatingPool,bus1_capacity,....
    bus2_capacity,station_information,p,Pc)

    n = 2;
    bus_amount = 4
    A = 1 : size(MatingPool,1);
    random_num = A(randperm(numel(A),n));
    random_num = sort(random_num);
    record = random_num
if p < Pc    
    population1 = MatingPool(random_num(1,1),:)
    population2 = MatingPool(random_num(1,2),:)
    %% 
    parking1 = population1(1,1:bus_amount + bus_amount + 2)
    parking2 = population2(1,1:bus_amount + bus_amount + 2)
    
    changed1 = parking1
    for i = 1 : size(find(parking1 > 10),2)
        m = find(parking1 > 10);
        changed1(1,m(1,i)) = changed1(1,m(1,i)) - 10;
    end
    changed2 = parking2;
    for i = 1 : size(find(parking2 > 10),2)
        m = find(parking2 > 10);
        changed2(1,m(1,i)) = changed2(1,m(1,i)) - 10;
    end
    busnumber = size(find(changed1 ~= 0),2);
    p1 = [];
    for i = 1 : busnumber
       b = find(changed1 == i);
       part = changed1(1,1:b);
       number0 = size(find(part == 0),2);
       if number0 == 2
           p1 = [p1 1];
       elseif number0 == 3
           p1 = [p1 2];
       else
           p1 = [p1 3];
       end
    end
    
    p2 = [];
    for i = 1 : busnumber
       b = find(changed2 == i);
       part = changed2(1,1:b);
       number0 = size(find(part == 0),2);
       if number0 == 2
           p2 = [p2 1];
       elseif number0 == 3
           p2 = [p2 2];
       else
           p2 = [p2 3];
       end
    end
    pp1 = p1;pp2 = p2;
    for i = 1 : size(find(parking1 > 10),2)
        m = find(parking1 > 10);
        num = parking1(1,m(1,i)) - 10;
        pp1(1,num) = p1(1,num) + 10;
    end
    for i = 1 : size(find(parking2 > 10),2)
        m = find(parking2 > 10);
        num = parking2(1,m(1,i)) - 10;
        pp2(1,num) = p2(1,num) + 10;
    end
    
    pa1 = [pp1(1,1:2) pp2(1,3:4)];pa2 = [pp2(1,1:2) pp1(1,3:4)];
    fin1 = pa1;fin2 = pa2;
    for i = 1 : size(find(pa1 > 10),2)
       m = find(pa1 > 10);
       pa1(1,m) = pa1(1,m) - 10;
    end
    for i = 1 : size(find(pa2 > 10),2)
       m = find(pa2 > 10);
       pa2(1,m) = pa2(1,m) - 10;
    end
    
    location1 = find(pa1 == 1);location2 = find(pa1 == 2);location3 = find(pa1 == 3);
    new_population1 = [0 0 location1 0 location2 0 location3 0 0];
    location1 = find(pa2 == 1);location2 = find(pa2 == 2);location3 = find(pa2 == 3);
    new_population2 = [0 0 location1 0 location2 0 location3 0 0];
    
    m = find(fin1 > 10);
    for i = 1 : size(find(fin1 > 10),2)
       n = find(new_population1 == m(1,i));
       new_population1(1,n) = new_population1(1,n) + 10;
    end
    m = find(fin2 > 10);
    for i = 1 : size(find(fin2 > 10),2)
       n = find(new_population2 == m(1,i));
       new_population2(1,n) = new_population2(1,n) + 10;
    end
    %% ÉÏ³µµã
    population1(:,1:(bus_amount + bus_amount + 2)) = [];
    population2(:,1:(bus_amount + bus_amount + 2)) = [];
    on1 = population1(1,1:size(population1,2)/2)
    on2 = population2(1,1:size(population2,2)/2)
    origin1 = on1;origin2 = on2;
    
    ans = 1;
    timee = 0;
    while ans
        timee = timee + 1
        if timee > 100
            ans = 0
            oon1 = origin1;oon2 = origin2
            break
        end
        on1 = origin1;on2 = origin2;
        num1 = find(on1 == 0);on1(:,num1) = [];
        num2 = find(on2 == 0);on2(:,num2) = [];
        A = 1 : size(on1,2);
        random_num = A(randperm(numel(A),n));
        random_num = sort(random_num);
        for i = 1 : size(random_num,2)
            change1 = on1(1,random_num(1,i));
            change2 = on2(1,random_num(1,i));
            on1(1,random_num(1,i)) = change2;
            on2(1,random_num(1,i)) = change1;
        end
        del = [];add = [];
        for i = 1 : size(on1,2)
            time = find(on1 == i);
            if size(time,2) == 0
                add = [add i];
            elseif size(time,2) == 2
                del = [del i];
            end
        end
        for i = 1 : size(add,2)
            location = find(on1 == del(1,i));
            if rand > 0.5
                on1(1,location(1,1)) = add(1,i);
            else
                on1(1,location(1,2)) = add(1,i);
            end
        end
    
        del = [];add = [];
        for i = 1 : size(on2,2)
            time = find(on2 == i);
            if size(time,2) == 0
                add = [add i];
            elseif size(time,2) == 2
                del = [del i];
            end
        end
        for i = 1 : size(add,2)
            location = find(on2 == del(1,i));
            if rand > 0.5
                on2(1,location(1,1)) = add(1,i);
            else
                on2(1,location(1,2)) = add(1,i);
            end
        end
    
        for i = 1 : size(num1,2)
            onepart = on1(1,1:(num1(1,i)-1));
            twopart = on1(1,num1(1,i):size(on1,2));
            on1 = [onepart 0 twopart];
        end
        oon1 = on1; 
        on1(:,size(on1,2)) = [];
        on1 = [0 on1];
        ans = capacity_restriction(on1,bus1_capacity,bus2_capacity,station_information,fin1)
    
        if ans == 0
            for i = 1 : size(num2,2)
                onepart = on2(1,1:(num2(1,i)-1));
                twopart = on2(1,num2(1,i):size(on2,2));
                on2 = [onepart 0 twopart];
            end
            oon2 = on2;
            on2(:,size(on2,2)) = [];
            on2 = [0 on2];
            ans = capacity_restriction(on2,bus1_capacity,bus2_capacity,station_information,fin2);
        
        end
        
    end
    
    getoff1 = [];
    m = find(on1 == 0)
    for i = 1 : size(find(on1 == 0),2) - 1
        part = on1(:,m(1,i)+1:m(1,i+1)-1) + size(station_information,1)
        part = part(randperm(numel(part)))
        getoff1 = [getoff1 part 0]
    end
    getoff1 = [getoff1 0]
    
    getoff2 = [];
    m = find(on2 == 0)
    for i = 1 : size(find(on2 == 0),2) - 1
        part = on2(:,m(1,i)+1:m(1,i+1)-1) + size(station_information,1)
        part = part(randperm(numel(part)))
        getoff2 = [getoff2 part 0]
    end
    if timee > 100
       on2 = oon2
       on2 = [0 on2]
       on2(:,size(on2,2)) = []
       getoff2 = [];
       m = find(on2 == 0)
       for i = 1 : size(find(on2 == 0),2) - 1
           part = on2(:,m(1,i)+1:m(1,i+1)-1) + size(station_information,1)
           part = part(randperm(numel(part)))
           getoff2 = [getoff2 part 0]
       end
    end
    getoff2 = [getoff2 0];
    new_population1 = [new_population1 oon1 getoff1]
    new_population2 = [new_population2 oon2 getoff2]
    oon1 = [0 oon1];oon1(:,size(oon1,2)) = [];
    oon2 = [0 oon2];oon2(:,size(oon2,2)) = [];
    ans11 = capacity_restriction(oon1,bus1_capacity,bus2_capacity,station_information,fin1);
    ans12 = capacity_restriction(oon2,bus1_capacity,bus2_capacity,station_information,fin2);
else
    new_population1 = MatingPool(record(1,1),:);
    new_population2 = MatingPool(record(1,2),:);
end
end