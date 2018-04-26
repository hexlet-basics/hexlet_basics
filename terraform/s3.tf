resource "aws_s3_bucket" "hexlet-basics-static-site" {
  bucket = "code-basics.ru"
  acl    = "public-read"
  policy = "${file("files/static-site-policy.json")}"

  website {
    index_document = "index.html"
    /* error_document = "error.html" */

    /* routing_rules = <<EOF */
/* [{ */
    /* "Condition": { */
    /*     "KeyPrefixEquals": "docs/" */
    /* }, */
    /* "Redirect": { */
    /*     "ReplaceKeyPrefixWith": "documents/" */
    /* } */
/* }] */
/* EOF */
  }
}
