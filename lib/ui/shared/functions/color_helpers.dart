import 'dart:math';
import 'dart:ui';

class ColorHelpers {
  Color getRandomLightColor() {
    Random random = Random();
    // Generate random values for red, green, and blue components in the range [200, 255]
    int red = 80 + random.nextInt(56);
    int green = 80 + random.nextInt(56);
    int blue = 80 + random.nextInt(56);
    // Create a Color object with the generated RGB values
    return Color.fromARGB(255, red, green, blue);
  }
}
