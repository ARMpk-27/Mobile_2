class User {
  final int? id;
  final String username;
  final String email;
  final String pwd;
  final double weight;
  final double height;
  final double bmi;
  final String bmiType;
  final double normalWeight;
  final double weightToAdjust;
  final String adviceText;
  final String bmiImage;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.pwd,
    required this.weight,
    required this.height,
  })  : bmi = calculateBmi(weight, height),
        bmiType = determineBmiType(calculateBmi(weight, height)),
        normalWeight = calculateNormalWeight(weight, height),
        weightToAdjust = calculateWeightToAdjust(weight, height),
        adviceText = buildAdviceText(weight, height),
        bmiImage = bmiImagePath(calculateBmi(weight, height));

  static double calculateBmi(double weight, double height) {
    final h = height / 100;
    return weight / (h * h);
  }

  static String determineBmiType(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi <= 24.9) return 'Normal';
    if (bmi <= 29.9) return 'Overweight';
    return 'Obese';
  }

  static double calculateNormalWeight(double weight, double height) {
    final h = height / 100;
    final bmi = calculateBmi(weight, height);
    if (bmi < 18.5) return 18.5 * h * h;
    if (bmi > 24.9) return 24.9 * h * h;
    return weight;
    }

  static double calculateWeightToAdjust(double weight, double height) {
    return (calculateNormalWeight(weight, height) - weight).abs();
  }

  static String buildAdviceText(double weight, double height) {
    final bmi = calculateBmi(weight, height);
    final diff = calculateWeightToAdjust(weight, height).toStringAsFixed(1);
    if (bmi < 18.5) return 'ต้องเพิ่มน้ำหนัก $diff กก. เพื่ออยู่ในเกณฑ์ Normal';
    if (bmi > 24.9) return 'ต้องลดน้ำหนัก $diff กก. เพื่ออยู่ในเกณฑ์ Normal';
    return 'น้ำหนักอยู่ในเกณฑ์ Normal';
  }

  static String bmiImagePath(double bmi) {
    if (bmi < 18.5) return 'assets/images/bmi-1.png';
    if (bmi <= 22.9) return 'assets/images/bmi-2.png';
    if (bmi <= 24.9) return 'assets/images/bmi-3.png';
    if (bmi <= 29.9) return 'assets/images/bmi-4.png';
    return 'assets/images/bmi-5.png';
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'email': email,
        'pwd': pwd,
        'weight': weight,
        'height': height,
        'bmi': bmi,
        'bmi_type': bmiType,
        'normal_weight': normalWeight,
        'weight_to_adjust': weightToAdjust,
        'advice_text': adviceText,
        'bmi_image': bmiImage,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'] as String,
      email: map['email'] as String,
      pwd: map['pwd'] as String,
      weight: (map['weight'] as num).toDouble(),
      height: (map['height'] as num).toDouble(),
    );
  }
}
