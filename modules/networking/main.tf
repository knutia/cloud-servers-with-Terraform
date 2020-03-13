resource "azurerm_resource_group" "resource_group" {
  name = var.environment
  location = var.location

  tags = {
    Name = "${var.environment}-rg"
    Environment = var.environment
    }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["${var.vpc_cidr}"]

  tags = {
    Name = "${var.environment}-vnet"
    Environment = var.environment
    }
}

// Public subnet
resource "azurerm_subnet" "PublicSubnet" {
  name                 = "PublicSubnet"
  address_prefix       = var.public_subnet_cidr
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  
  # tags = {
  #   Name = "${var.environment}-public-subnet"
  #   Environment = var.environment
  #   }
}
/*
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = true

  tags {
    Name        = "${var.environment}-public-subnet"
    Environment = "${var.environment}"
  }
}
*/


// Private subnet
resource "azurerm_subnet" "PrivateSubnet" {
  name                 = "PrivateSubnet"
  address_prefix       = var.private_subnet_cidr
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  # tags = {
  #   Name = "${var.environment}-private-subnet"
  #   Environment = var.environment
  #   }
}
/*
resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.private_subnet_cidr}"
  map_public_ip_on_launch = false
  availability_zone       = "${var.availability_zone}"

  tags {
    Name        = "${var.environment}-private-subnet"
    Environment = "${var.environment}"
  }
}
*/

/*
// Internet gateway for the public subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}


// Elastic IP for NAT
resource "aws_eip" "nat_eip" {
  vpc = true
}

// NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet.id}"
}
*/






/*
// Routing table for private subnet
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}-private-route-table"
    Environment = "${var.environment}"
  }
}

// Routing table for public subnet
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}-public-route-table"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

// Route table associations
resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  subnet_id       = "${aws_subnet.private_subnet.id}"
  route_table_id  = "${aws_route_table.private.id}"
}

// Default security group
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "bastion" {
  vpc_id      = "${aws_vpc.vpc.id}"
  name        = "${var.environment}-bastion-host"
  description = "Allow SSH to bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}-bastion-sg"
    Environment = "${var.environment}"
  }
}

resource "aws_instance" "bastion" {
  ami                         = "${lookup(var.bastion_ami, var.region)}"
  instance_type               = "t2.micro"
  key_name                    = "${var.key_name}"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  subnet_id                   = "${aws_subnet.public_subnet.id}"
  associate_public_ip_address = true

  tags {
    Name        = "${var.environment}-bastion"
    Environment = "${var.environment}"
  }
}
*/