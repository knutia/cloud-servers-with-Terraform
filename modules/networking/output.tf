output "vnet_id" {
  value = "${azurerm_virtual_network.vnet.id}"
}

output "public_subnet_id" {
  value = "${azurerm_subnet.PublicSubnet.id}"
}

output "private_subnet_id" {
  value = "${azurerm_subnet.PrivateSubnet.id}"
}

/*
output "default_sg_id" {
  value = "${aws_security_group.default.id}"
} */