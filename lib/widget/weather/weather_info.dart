import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/service/user_data_service.dart';
import 'package:ooo_fit/service/weather_service.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:weather/weather.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherService _weatherService = GetIt.instance<WeatherService>();
  final UserDataService _userDataService = GetIt.instance<UserDataService>();

  WeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder(
        stream: _userDataService.getCurrentUsersDataStream(),
        builder: (context, userData) {
          String? cityName = userData!.city;

          return FutureBuilder(
            future: _weatherService.getWeatherByCityName(cityName ?? ''),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Image.asset(
                  "assets/icons/weather-unknown.png",
                  width: 40,
                  height: 40,
                  color: Colors.white,
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

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  weatherIcon,
                  SizedBox(width: 6),
                  Text(formattedTemperature,
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              );
            },
          );
        });
  }
}
