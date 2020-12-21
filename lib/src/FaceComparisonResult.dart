class FaceComparisonResult {
  FaceComparisonResult({int score, int authenticationThreshold, int max}) {
    if (score != null) {
      this.score = score;
    }
    if (authenticationThreshold != null) {
      this.authenticationThreshold = authenticationThreshold;
    }
    if (max != null) {
      this.max = max;
    }
  }
  /**
   * The result score
   */
  int score = 0;

  /**
   * Comparisons with scores higher than the threshold may be considered authenticated
   */
  int authenticationThreshold = 0;

  /**
   * Maximum possilbe score
   */
  int max = 0;

  FaceComparisonResult.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("score")) {
      score = int.parse(json["score"]);
    }
    if (json.containsKey("authenticationThreshold")) {
      authenticationThreshold = int.parse(json["authenticationThreshold"]);
    }
    if (json.containsKey("max")) {
      max = int.parse(json["max"]);
    }
  }
}
