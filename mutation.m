function[new_population1,new_population2] = mutation(population1,population2,....
    bus1_capacity,bus2_capacity,station_information,p,Pm)
%%
    population1
    fin1 = population1(:,1:10);
    location0 = find(fin1 == 0);
    fin1(:,location0) = [];
    parking1 = population1(:,1:10);parking2 = population2(:,1:10);
    initial_population1 = population1;
    initial_population2 = population2;
    population1(:,1:10) = [];population2(:,1:10) = [];
    if p < Pm
        on1 = population1(:,1:size(population1,2)/2);
        on1 = [0 on1];on1(:,size(on1,2)) = [];
        ans11 = capacity_restriction(on1,bus1_capacity,bus2_capacity,station_information,fin1);
        ans = 1;ans1 = 1;
        while ans
            on1
            ans1 = 1;
            while ans1
                n = 2;
                A = 1 : size(on1,2);
                random_num = A(randperm(numel(A),n));
                random_num = sort(random_num);
                if on1(1,random_num(1,1)) == 0 || on1(1,random_num(1,2)) == 0
                    ans1 = 1;
                else
                    ans1 = 0;
                end
            end
            temp = on1(1,random_num(1,1));
            on1(1,random_num(1,1)) = on1(1,random_num(1,2));
            on1(1,random_num(1,2)) = temp;
            ans = capacity_restriction(on1,bus1_capacity,bus2_capacity,station_information,fin1);
        end
        off1 = [];
        m = find(on1 == 0);
        for i = 1 : size(find(on1 == 0),2) - 1
            part = on1(:,m(1,i)+1:m(1,i+1)-1) + size(station_information,1);
            part = part(randperm(numel(part)));
            off1 = [off1 part 0];
        end
        off1 = [off1 0];
        on1(:,1) = [];on1 = [on1 0];
        new_population1 = [parking1 on1 off1]
        %%
        population2
        fin1 = population2(:,1:10);
        location0 = find(fin1 == 0);
        fin1(:,location0) = [];
        on2 = population2(:,1:size(population2,2)/2);
        on2 = [0 on2];on2(:,size(on2,2)) = [];
        ans11 = capacity_restriction(on2,bus1_capacity,bus2_capacity,station_information,fin1);
        ans = 1;ans1 = 1;
        while ans
            on2
            ans1 = 1;
            while ans1
                n = 2;
                A = 1 : size(on2,2);
                random_num = A(randperm(numel(A),n));
                random_num = sort(random_num);
                if on2(1,random_num(1,1)) == 0 || on2(1,random_num(1,2)) == 0
                    ans1 = 1;
                else
                    ans1 = 0;
                end
            end
            temp = on2(1,random_num(1,1));
            on2(1,random_num(1,1)) = on2(1,random_num(1,2));
            on2(1,random_num(1,2)) = temp;
            ans = capacity_restriction(on2,bus1_capacity,bus2_capacity,station_information,fin1);
        end
        on2
        off2 = []
        m = find(on2 == 0)
        for i = 1 : size(find(on2 == 0),2) - 1
            part = on2(:,m(1,i)+1:m(1,i+1)-1) + size(station_information,1)
            part = part(randperm(numel(part)))
            off2 = [off2 part 0]
        end
        off2 = [off2 0]
        on2(:,1) = [];on2 = [on2 0];
        new_population2 = [parking2 on2 off2]
    else
        new_population1 = initial_population1
        new_population2 = initial_population2
    end
end