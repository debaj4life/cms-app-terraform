region        = "eu-west-2"
instance_type = "t3.medium"
ami_id        = "ami-0acc77abdfc7ed5a6"
environment   = "qa"
vpc_id        = "vpc-071a935c677dbb90c"
key_name      = "tutorial-key"
desired_capacity = 1
max_size = 1
min_size = 1
subnets = ["subnet-0ac8b28d64573460b", "subnet-08b711d075f9a142a", "subnet-0a66a5cfe19424c28"]