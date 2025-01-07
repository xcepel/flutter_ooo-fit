import 'package:flutter/material.dart';
import 'package:ooo_fit/ioc/ioc_container.dart';
import 'package:ooo_fit/service/weather_service.dart';
import 'package:ooo_fit/widget/weather/change_city_dialog.dart';
import 'package:weather/weather.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherService _weatherService = get<WeatherService>();

  WeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // TODO: store and get city name from user settings
      future: _weatherService.getWeatherByCityName('Brno'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return showCustomDialog(
            context,
            Image.asset(
              "assets/icons/weather-unknown.png",
              width: 40,
              height: 40,
              color: Colors.white,
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final Weather? weather = snapshot.data;

        final Temperature temp = weather!.temperature!;
        final Image weatherIcon = _weatherService.getWeatherIcon(weather);

        final String formattedTemperature =
            "${temp.celsius!.toStringAsFixed(1)}°C";

        return showCustomDialog(
          context,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              weatherIcon,
              SizedBox(width: 6),
              Text(formattedTemperature,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
        );
      },
    );
  }

  Widget showCustomDialog(BuildContext context, Widget weather_data) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => ChangeCityDialog(),
      ),
      child: weather_data,
    );
  }
}
