class VerIDError {
  /**
   *
   */
  String domain = "";

  /**
   *
   */
  num code = 0;

  /**
   *
   */
  String description = "";

  String toString() {
    return 'domain: ${this.domain}, code: ${this.code}, description: ${this.description}';
  }
  /**
   * Factory method to create from JSON string
   */
  VerIDError.fromJson(Map<String, dynamic> json) {
    this.domain = json["domain"];
    this.code = json["code"];
    this.description = json["description"];
  }

  VerIDError([String pdomain, num pcode, String pdescription]) {
    if (pdomain != null) {
      this.domain = pdomain;
    }

    if (pcode != null) {
      this.code = pcode;
    }

    if (pdescription != null) {
      this.description = pdescription;
    }
  }
}
