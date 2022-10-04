function [team,geton_point,getoff_point] = getoff_information(Clustering_results,guest_information,Clustering_index)
    Clustering_number = size(find(Clustering_results == 0),1) - 1
    location0 = find(Clustering_results == 0)
    team = []
    geton_point = []
    getoff_point = []
    results = Clustering_results   %总的聚类效果
    for i = 1 : size(location0,2) - 1
        geton_information = results(1,(location0(1,i)+1):(location0(1,i+1)-1))
        getoff = []
        for j = 1 : size(geton_information,2)
           x =  guest_information(geton_information(1,j),4:6)
           getoff = [getoff;x]
        end
        [Clustering_results,center] = AP_algorithm(getoff,Clustering_index)
        location01 = find(Clustering_results == 0)
        nonlocation = find(Clustering_results ~= 0)
        for u = 1 : size(nonlocation,2)
            w = Clustering_results(1,nonlocation(1,u))
            Clustering_results(1,nonlocation(1,u)) = geton_information(1,w)
        end
        Clustering = Clustering_results
        for k = 1 : size(location01,2) - 1
           if location01(1,k+1) - location01(1,k) ~= 2
              number =  Clustering(1,(location01(1,k)+1):(location01(1,k+1)-1))
              geton = []
              for m = 1 : size(number,2)
                x = guest_information(number(1,m),1:3)
                geton = [geton;x]
              end
              [Clustering_results,center] = AP_algorithm(geton,Clustering_index)
              location010 = find(Clustering_results == 0)
              Cluster = Clustering_results
              for n = 1 : size(location010,2) - 1
                 if  location010(1,n+1) - location010(1,n) ~= 2
                    team_number =  number(1,1:(location010(1,n+1) - location010(1,n)-1))
                    guest_number_on = []
                    guest_number_off = []
                    for p = 1 : size(team_number,1)
                       rt1 = guest_information(team_number(1,p),1:2)
                       rt2 = guest_information(team_number(1,p),4:5)
                       guest_number_on = [guest_number_on;rt1]
                       guest_number_off = [guest_number_off;rt2]
                    end
                    geton_information(:,1:(location010(1,n+1) - location010(1,n)-1)) = []
                    team = [team 0 team_number]
                    geton_point = [geton_point;rt1]
                    getoff_point = [getoff_point;rt2]
                 else
                    team_number = [] 
                 end 
                 
              end
           end
        end
    end
    
end