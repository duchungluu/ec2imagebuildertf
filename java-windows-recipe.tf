resource "aws_imagebuilder_image" "this" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.this.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.this.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn

}
# Recipe for configuration on EC2  Windows image
resource "aws_imagebuilder_image_recipe" "this" {

  block_device_mapping {
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = true
      volume_size           = "30"
      volume_type           = "gp3"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.installpreq.arn
  }



  name              = "windows-server-2019-english-core-base-x86"
  parent_image      = "arn:aws:imagebuilder:eu-central-1:aws:image/windows-server-2019-english-core-base-x86/x.x.x"
  version           = "1.0.0" # Has to be updated when the component is changed
  working_directory = "C:/"


  lifecycle { create_before_destroy = true }
}

resource "aws_imagebuilder_component" "installpreq" {
  data     = file("${path.module}/javanuget.yml")
  name     = "example"
  platform = "Windows"
  version  = "1.0.0"
}

