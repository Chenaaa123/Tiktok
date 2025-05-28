import { List } from "@kit.ArkTS"

export class HistoryResponse {
  public location: Location
  public forecast: Forecast

  constructor(location: Location, forecast: Forecast) {
    this.location = location
    this.forecast = forecast
  }
}

export class Location {
  public name: string
  public region: string
  public country: string

  constructor(name: string, region: string, country: string) {
    this.name = name;
    this.region = region
    this.country = country
  }
}

export class Forecast {
  public forecastday: List<ForecastDay>

  constructor(forecastday: List<ForecastDay>) {
    this.forecastday = forecastday;
  }
}

export class ForecastDay {
  public date: string
  public day: Day

  constructor(date: string, day: Day) {
    this.date = date
    this.day = day
  }
}

export class Day {
  public avgtemp_c: number
  public condition: Condition

  constructor(avgtemp_c: number, condition: Condition) {
    this.avgtemp_c = avgtemp_c
    this.condition = condition
  }
}

export class Condition {
  public text: string
  public icon: string

  constructor(text: string, icon: string) {
    this.text = text
    this.icon = icon
  }
}