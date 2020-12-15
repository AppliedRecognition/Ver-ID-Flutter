/**
 * Face recognition template
 */
class FaceTemplate {
  FaceTemplate({String data, int version}) {
    if (data != null) {
      this.data = data;
    }
    if (version != null) {
      this.version = version;
    }
  }
  /**
   * Data used for face recognition
   */
  String data = '';
  /**
   * Template version
   */
  int version = 0;

  FaceTemplate.fromJson(Map<String, dynamic> json) {
    this.data = json["data"];
    this.version = json["version"];
  }
}
