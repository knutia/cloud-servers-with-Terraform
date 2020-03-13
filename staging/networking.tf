module "networking" {
  source              = "../modules/networking"
  environment         = "${var.environment}"
  vpc_cidr            = "${var.vpc_cidr}"
  location            = "${var.location}"
  public_subnet_cidr  = "${var.public_subnet_cidr}"
  private_subnet_cidr = "${var.private_subnet_cidr}"
  #   key_name            = "${var.key_name}"
}