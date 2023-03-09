variable "vpc_id" {
    
}

variable "name" {

  
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

variable "subnets"{
  type = map
  default = {

   
    public_subnet={
        "name"="public_subnet"
        "availability_zone"="euc1-az1"
        "cidr-block"="10.0.11.0/24"

    }
   
     private_subnet_1={  
       "name"="private_subnet_1"
        "availability_zone"="euc1-az1"
        "cidr-block"="10.0.12.0/24"
     }
      private_subnet_2={   
      "name"="private_subnet_2"
      "availability_zone"="euc1-az2"
      "cidr-block"="10.0.13.0/24"

    }
  }
  }


