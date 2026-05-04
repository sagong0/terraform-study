variable "instance_type" {
    type = map
    default = {
        "example1" = "t2.micro"
        "example2" = "t3.large"
    }
}