import 'package:broker_app/content_models/broker_model_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Broker', () {
    test('should create Broker instance with correct properties', () {
      // Arrange
      const name = 'Test Broker';
      const logo = 'TB';
      final color = Colors.blue;

      // Act
      final broker = Broker(name: name, logo: logo, color: color);

      // Assert
      expect(broker.name, name);
      expect(broker.logo, logo);
      expect(broker.color, color);
    });
  });
}
