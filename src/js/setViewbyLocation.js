//Calculates distance in meters from user_location to default_location. Returns user_location if distance is within threshoold. else returns default_location.
//user_location and default_location need to be leaflet objects. threshold is integer
function setViewbyLocation(threshold, user_location, default_location){
   var distance_to_default = default_location.distanceTo(user_location)
   if (distance_to_default <= threshold){
        return user_location;
    }
    else{
        return default_location;
    }
}

module.exports = setViewbyLocation;