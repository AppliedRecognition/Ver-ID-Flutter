
/**
 * Diagnostic Information of the image
 */
class DiagnosticInfo {
  double maskScore;
  double brightness;
  double contrast;
  double sharpness;

  DiagnosticInfo(
      {this.maskScore, this.brightness, this.contrast, this.sharpness});

  DiagnosticInfo.fromJson(Map<String, dynamic> json) {
    maskScore = json['maskScore'];
    brightness = json['brightness'];
    contrast = json['contrast'];
    sharpness = json['sharpness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maskScore'] = this.maskScore;
    data['brightness'] = this.brightness;
    data['contrast'] = this.contrast;
    data['sharpness'] = this.sharpness;
    return data;
  }
}