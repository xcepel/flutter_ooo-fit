import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ooo_fit/ioc/ioc_container.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/service/weather_service.dart';
import 'package:ooo_fit/widget/common/loading_future_builder.dart';
import 'package:weather/weather.dart';

class HomepageDailyInfo extends StatelessWidget {
  static const String dateFormat = "EEEE, MMM d";
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

        final String formattedDate = _getFormattedDateNow();
        final String formattedTemperature =
            "${temp.celsius!.toStringAsFixed(1)}°C";

        final TemperatureType temperatureType =
            WeatherService.getTemperatureTypeFromWeather(weather);
        final Icon temperatureTypeIcon = temperatureType.icon;

        return Column(
          children: [
            Text("Brno"),
            Text(formattedDate),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                weatherIcon,
                SizedBox(width: 8),
                temperatureTypeIcon,
                Text(formattedTemperature, style: TextStyle(fontSize: 30)),
              ],
            ),
          ],
        );
      },
    );
  }

  String _getFormattedDateNow() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat(dateFormat);
    final String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
