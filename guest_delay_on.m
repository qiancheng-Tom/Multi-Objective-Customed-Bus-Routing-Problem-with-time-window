function [delay,interval_1] = guest_delay_on(guest,guest_information,moment)
early = 1.5
late = 2
    for i = 1 : size(guest,2)
        interval_1 = guest_information(guest(1,i),7)
        interval_2 = guest_information(guest(1,i),8)
        if moment < interval_1
            delay_time = interval_1 - moment
            delay = early * delay_time
        elseif moment > interval_2
            delay_time = moment - interval_2
            delay = late * delay_time
        else
            delay = 0
    end
end