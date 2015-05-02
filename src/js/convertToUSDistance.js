// converts distance from meter to US measurement units. shows distance in ft if objects are less than a mile away, or miles if more than a mile away
//returns a object with distance and associated unit: { num: float, unit: unit}
function convertToUSDistance(num){
	//convert meters to ft
	var converted_ft = Math.round(num * 3.28084 * 100)/100;
	if (converted_ft > 1000){
		//convert to miles
		return {num: Math.round(converted_ft/5280*100)/100, unit: "mi"};
	}
	else{
		return {num:converted_ft, unit: "ft"};
	}
}

module.exports = convertToUSDistance;