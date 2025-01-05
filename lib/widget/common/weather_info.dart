import 'package:flutter/material.dart';
import 'package:ooo_fit/ioc/ioc_container.dart';
import 'package:ooo_fit/service/weather_service.dart';
import 'package:ooo_fit/widget/common/loading_future_builder.dart';
import 'package:weather/weather.dart';

class HomepageDailyInfo extends StatelessWidget {
  final WeatherService _weatherService = get<WeatherService>();

  HomepageDailyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingFutureBuilder(
      // TODO: store and get city name from settings
      future: _weatherService.getWeatherByCityName('Brno'),
      builder: (context, weather) {
        final Temperature temp = weather.temperature!;
        final Image weatherIcon = _weatherService.getWeatherIcon(weather);

        final String formattedTemperature =
            "${temp.celsius!.toStringAsFixed(1)}°C";

        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                weatherIcon,
                SizedBox(width: 6),
                //temperatureTypeIcon,
                Text(formattedTemperature,
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
          ],
        );
      },
    );
  }
}
