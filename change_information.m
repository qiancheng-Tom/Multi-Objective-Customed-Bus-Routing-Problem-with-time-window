function [station,geton_point,getoff_point] = change_information(guest_information,team,geton_point,getoff_point)
    original_team = team
    team = [team 0]
    location0 = find(team == 0)
    station = guest_information(:,1:6)
    station_number = station
    for i = 1 : size(location0,2) - 1
       guest_number = team(1,(location0(1,i)+1):(location0(1,i+1)-1))
       amount = 0
       guest_number_information = []
       for j = 1 : size(guest_number,2)
           information = guest_information(guest_number(1,j),:)
           guest_number_information = [guest_number_information;information]
           guest = guest_information(guest_number(1,j),3)
           amount = amount + guest
       end
       new_guest_information = [geton_point(i,:) amount getoff_point(i,:) amount]
       station = [station;new_guest_information]
    end
    
    for i = 1 :size(location0,2)
       location = find(team == 0)
       team(location(1,1)) = []
    end
    
    for i = 1:size(team,2)
       delete_guest = guest_information(team(1,i),1:6) 
       [~,ind]=ismember(delete_guest,station,'rows')
       if ind ~= 0
           station(ind,:) = []
       end
    end
    geton = [];getoff = []
    
    for i = 1 : (size(guest_information,1) - size(team,2))
        [~,ind]=ismember(station(i,:),station_number,'rows')
        on = station_number(ind,1:2)
        off = station_number(ind,4:5)
        geton = [geton;on]
        getoff = [getoff;off]
    end
    
    geton_point = [geton;geton_point]
    geton_point = [geton_point station(:,3)]
    getoff_point = [getoff;getoff_point]
    getoff_point = [getoff_point station(:,6)]
    
    line = size(station,1)
    Array1 = (1:line)'
    geton_point = [Array1 geton_point]
    Array2 = ((line + 1): 2 * line)'
    getoff_point = [Array2 getoff_point]
    station = [geton_point getoff_point]
end