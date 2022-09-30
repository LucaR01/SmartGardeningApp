
/// It represents a disease of a plant with its [name] and its [diseaseConfidence] retrieved after the run on the tflite model.
class PlantDisease {
  final String name;
  final double diseaseConfidence;

  PlantDisease({required this.name, required this.diseaseConfidence});
}