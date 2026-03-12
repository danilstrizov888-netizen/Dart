import 'dart:math';

abstract class Shape {
  Shape();
  double area();
  factory Shape.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    switch (type) {
      case 'circle':
        final radius = json['radius'];
        if (radius is! num) throw ArgumentError('radius must be a number');
        return Circle(radius.toDouble());
      case 'rectangle':
        final width = json['width'];
        final height = json['height'];
        if (width is! num) throw ArgumentError('width must be a number');
        if (height is! num) throw ArgumentError('height must be a number');
        return Rectangle(width.toDouble(), height.toDouble());
      default:
        throw ArgumentError('Unknown shape type: $type');
    }
  }
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius) : super() {
    if (radius <= 0) throw ArgumentError('Radius must be positive');
  }
  @override
  double area() => pi * radius * radius;
  @override
  String toString() => 'Circle(radius: $radius)';
}

class Rectangle extends Shape {
  final double width;
  final double height;
  Rectangle(this.width, this.height) : super() {
    if (width <= 0 || height <= 0) {
      throw ArgumentError('Width and height must be positive');
    }
  }
  @override
  double area() => width * height;
  @override
  String toString() => 'Rectangle(width: $width, height: $height)';
}

void main() {
  try {
    final circle = Shape.fromJson({'type': 'circle', 'radius': 5});
    final rect = Shape.fromJson({'type': 'rectangle', 'width': 4, 'height': 6});
    print(circle);
    print('Area: ${circle.area()}');
    print(rect);
    print('Area: ${rect.area()}');
  } catch (e) {
    print('Error: $e');
  }
}
