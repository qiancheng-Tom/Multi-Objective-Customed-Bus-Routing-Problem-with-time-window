
function main()
%% load information
filename1 = 'guest.xlsx'
filename2 = 'parking.xlsx'
guest_information = table2array(readtable(filename1))
parking_information = table2array(readtable(filename2))

%% cluster the statistic  
set(0,'DefaultFigureVisible', 'off')
Clustering_index = -5;
x = guest_information(:,1:3);
[Clustering_results,center] = improved_AP_algorithm(x,Clustering_index);
[team,geton_point,getoff_point] = getoff_information(Clustering_results,guest_information,Clustering_index);
[station_information,~,~] = change_information(guest_information,team,geton_point,getoff_point);
%filename3 = 'station_information.xlsx'
%station_information = table2array(readtable(filename3))
station = station_information;
%% index
bus1_capacity = 25;
bus2_capacity = 15;
weight = 50;
bus_amount = 4;
population = 30;  % 种群的元素个数
speed = 7;
multiple_target = [];
Population = [];
Iterations = 30;
Pc = 0.8; %交叉率
Pm = 0.2; %变异率

%% 路径生成,4辆车的情况
switch bus_amount
    case 4
        %% 初始解集
        Initial_population = Population_formation(station_information,bus_amount,bus1_capacity,bus2_capacity,population)
        for i = 1 : population
            bus_route = Initial_population(i,:);
            [bus1,bus2,bus3,bus4] = decode(bus_route,station_information,parking_information);
            emission = canbon_emission(bus1,bus2,bus3,bus4,station_information,weight,speed,bus_route(1,1:10));
            Delay_time = delay(team,speed,guest_information,parking_information,bus1,bus2,bus3,bus4,station);
            company_cost = cost(bus1,bus2,bus3,bus4,guest_information,team,station_information,bus_route(1,1:10));
            multiple_target = [multiple_target;emission Delay_time company_cost]
        end
        FrontValue = NonDominateSort(multiple_target)
        CrowdDistance = CrowdDistances(multiple_target,FrontValue)
        Population = Initial_population
%% NSGA-II
for i = 1 : Iterations
    MatingPool = Mating(Population,FrontValue,CrowdDistance) 
    for j = 1 : Iterations/2
        p = rand
        [population1,population2] = crossover(MatingPool,....
                bus1_capacity,bus2_capacity,station_information,p,Pc)
        [new_population1,new_population2] = mutation(population1,population2,....
                bus1_capacity,bus2_capacity,station_information,p,Pm)
        Population = [Population;new_population1;new_population2]
    end
    for k = 1 : size(Population,1)/2
        bus_route = Population(k + Iterations,:);
        [bus1,bus2,bus3,bus4] = decode(bus_route,station_information,parking_information);
        emission = canbon_emission(bus1,bus2,bus3,bus4,station_information,weight,speed,bus_route(1,1:10));
        Delay_time = delay(team,speed,guest_information,parking_information,bus1,bus2,bus3,bus4,station);
        company_cost = cost(bus1,bus2,bus3,bus4,guest_information,team,station_information,bus_route(1,1:10));
        multiple_target = [multiple_target;emission Delay_time company_cost]
    end
    [FrontValue,MaxFront] = NonDominateSort(multiple_target)
    CrowdDistance = CrowdDistances(multiple_target,FrontValue)
    
end
    
end
end