import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherz/bloc/weather_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchEditingControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        excludeHeaderSemantics: true,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search city',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  BlocProvider.of<WeatherBloc>(context).add(FetchWeatherByCity(cityNme: value));
                }
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(4, -.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-4, -.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF673AB7),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xffffab40),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherSuccess) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              "📍 ${state.weather.areaName}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Good Morning",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            getWeather(state.weather.weatherConditionCode!),
                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius?.round()}°C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                state.weather.weatherMain!.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                DateFormat('EEEE dd . ').add_jm().format(state.weather.date!),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 5,
                                  children: [
                                    Image.asset(
                                      "assets/11.png",
                                      scale: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 3,
                                      children: [
                                        const Text(
                                          "Sunrise",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('').add_jm().format(state.weather.sunrise!),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    Image.asset(
                                      "assets/12.png",
                                      scale: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 3,
                                      children: [
                                        const Text(
                                          "Sunrise",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('').add_jm().format(state.weather.sunset!),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 5,
                                  children: [
                                    Image.asset(
                                      "assets/13.png",
                                      scale: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 3,
                                      children: [
                                        const Text(
                                          "Temp. Max",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '${state.weather.tempMax!.celsius?.round()}°C',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    Image.asset(
                                      "assets/14.png",
                                      scale: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 3,
                                      children: [
                                        const Text(
                                          "Temp. Min",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '${state.weather.tempMin!.celsius?.round()}°C',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget getWeather(int code) {
  switch (code) {
    case >= 200 && < 300:
      return Image.asset('assets/1.png');
    case >= 300 && < 400:
      return Image.asset('assets/2.png');
    case >= 500 && < 600:
      return Image.asset('assets/3.png');
    case >= 600 && < 700:
      return Image.asset('assets/4.png');
    case >= 700 && < 800:
      return Image.asset('assets/5.png');
    case 800:
      return Image.asset('assets/6.png');
    case > 800 && < 804:
      return Image.asset('assets/7.png');
    default:
      return Image.asset('assets/7.png');
  }
}
