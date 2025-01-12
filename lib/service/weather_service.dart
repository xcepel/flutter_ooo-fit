import 'package:flutter/material.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:weather/weather.dart';

class WeatherService {
  final WeatherFactory _weatherFactory;

  const WeatherService(this._weatherFactory);

  Future<Weather> getWeatherByCityName(String cityName) async {
    return await _weatherFactory.currentWeatherByCityName(cityName);
  }

  Image getWeatherIcon(Weather weather) {
    final Image weatherUnknownImage = Image.asset(
      "assets/icons/weather-unknown.png",
      width: 40,
      height: 40,
    );

    if (weather.weatherIcon == null) {
      return weatherUnknownImage;
    }

    final String weatherIconName = weather.weatherIcon!;
    final String url = 'http://openweathermap.org/img/wn/$weatherIconName.png';

    return Image.network(
      url,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return weatherUnknownImage;
      },
    );
  }

  TemperatureType getTemperatureTypeFromWeather(Weather weather) {
    return TemperatureType.fromCelsius(weather.temperature!.celsius!);
  }
}
