data "aws_ssm_parameter" "recommended_linux_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}