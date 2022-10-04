function fuel = emission_model(distance,weight,speed,guest_number,ans)
    
    Fuel_air_mass_ratio = 1;
    Fuel_calorific_value = 44;
    Conversion_factor = 737;
    
    Engine_friction_factor = 0.2;
    engine_speed = 3000;
    Engine_displacement = 8;
    
    Vehicle_transmission_efficiency = 0.95;
    Diesel_engine_efficiency = 0.4;
    Air_drag_coefficient = 0.7;
    Air_density = 1.29;
    
    Road_inclination_angle = 0;
    gravity = 9.81;
    Rolling_resistance_coefficient = 0.01;
    acceleration = 0;
    if ans == 1
        Vehicle_weight = 12000;
        engine_speed = 3000;
    else
        Vehicle_weight = 8000;
        engine_speed = 2000;
    end
    guest_weight = guest_number * weight;
    
    fuel_consumption = (Fuel_air_mass_ratio/(Fuel_calorific_value * Conversion_factor))....
        *(Engine_friction_factor*engine_speed*Engine_displacement*distance/speed + ....
        (1/1000)*Vehicle_transmission_efficiency*Diesel_engine_efficiency*distance*(speed)^2 + ....
        (1/1000)*Vehicle_transmission_efficiency*Diesel_engine_efficiency * ....
        (gravity*Rolling_resistance_coefficient + acceleration) * (Vehicle_weight + guest_weight) *....
        distance)
    
    fuel = (distance/speed)*fuel_consumption
    
end