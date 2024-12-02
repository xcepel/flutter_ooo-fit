import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:ooo_fit/model/temperature_type.dart';

class WeatherService {
  final WeatherFactory _weatherFactory;

  const WeatherService(this._weatherFactory);

  Future<Weather> getWeatherByCityName(String cityName) async {
    return await _weatherFactory.currentWeatherByCityName(cityName);
  }

  Image getWeatherIcon(Weather weather) {
    //TODO: null handling
    final String weatherIconName = weather.weatherIcon!;
    return Image.network(
        'http://openweathermap.org/img/wn/$weatherIconName.png');
  }

  static TemperatureType getTemperatureTypeFromWeather(Weather weather) {
    return TemperatureType.fromCelsius(weather.temperature!.celsius!);
  }
}
