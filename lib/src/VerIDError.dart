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
