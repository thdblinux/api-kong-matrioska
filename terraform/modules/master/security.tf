resource "aws_security_group" "cluster_master_sg" {
    name = format("%s-master-sg", var.cluster_name)
    vpc_id = var.cluster_vpc.id

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = format("%s-master-sg", var.cluster_name)
    }
}

resource "aws_security_group_rule" "cluster_ingress_https" {
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.cluster_master_sg.id
    type              = "ingress"
}

resource "aws_security_group_rule" "cluster_ingress_http" {
    from_port         = 3000
    to_port           = 3000
    protocol          = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.cluster_master_sg.id
    type              = "ingress"
}

resource "aws_security_group_rule" "cluster_ingress_ssh" {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.cluster_master_sg.id
    type              = "ingress"
}

resource "aws_security_group_rule" "cluster_ingress_http_port" {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.cluster_master_sg.id
    type              = "ingress"
}
