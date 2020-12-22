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
  num score = 0;

  /**
   * Comparisons with scores higher than the threshold may be considered authenticated
   */
  num authenticationThreshold = 0;

  /**
   * Maximum possilbe score
   */
  num max = 0;

  String toString() {
    return 'score: $score, authenticationThreshold: $authenticationThreshold, max: $max';
  }

  FaceComparisonResult.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("score")) {
      score = json["score"];
    }
    if (json.containsKey("authenticationThreshold")) {
      authenticationThreshold = json["authenticationThreshold"];
    }
    if (json.containsKey("max")) {
      max = json["max"];
    }
  }
}
