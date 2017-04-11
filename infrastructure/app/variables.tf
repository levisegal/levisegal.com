/* shared variables, symlinked to each env */

/*
Your aws secret key and access key should be in your env variables
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
*/

/* Provider Conf */
variable "region" {
  default = "us-west-2"
}

provider "aws" {
  region = "${var.region}"
}
