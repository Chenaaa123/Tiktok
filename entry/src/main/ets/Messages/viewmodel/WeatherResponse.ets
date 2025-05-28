/**
 * {
     "location": {
       "name": "Jingdezhen",
       "region": "Jiangxi",
       "country": "China"
     },
     "current": {
         "temp_c": 24.5,
         "condition": {
             "text": "Sunny",
             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
         }
     }
 }
 */

export interface Condition {
  text: string
  icon: string
}

export interface Current {
  temp_c: number
  condition: Condition

}

export interface Location {
  name: string
  region: string
  country: string


}

export interface WeatherResponse {
  location: Location
  current: Current
}