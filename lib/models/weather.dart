class WeatherModel {
  const WeatherModel({
    this.condition = WeatherCondition.sunny,
  });

  final WeatherCondition condition;
}

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
}
