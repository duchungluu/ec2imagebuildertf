resource "aws_imagebuilder_image_pipeline" "this" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.this.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn
  name                             = "amazon-windows-for-jenkins"
  status                           = "ENABLED"
  description                      = "Windows Jenkins slave with nuget and Java"

  schedule {
    schedule_expression                = "cron(0 9 ? * sun)"
    pipeline_execution_start_condition = "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE"
  }

  # Test the image after build
  image_tests_configuration {
    image_tests_enabled = true
    timeout_minutes     = 60
  }


  /***
  tags                           = merge(var.default_tags)
  distribution_configuration_arn = aws_imagebuilder_distribution_configuration.windowsjenkins.arn

  #lifecycle { create_before_destroy = true }
  depends_on = [
    aws_imagebuilder_component.jenkins,
    aws_imagebuilder_image_recipe.jenkins,
    aws_imagebuilder_distribution_configuration.jenkins
  ]
}

resource "aws_imagebuilder_distribution_configuration" "jenkins" {
  name = "jenkins-ami-distribution"

  distribution {
    ami_distribution_configuration {

      ami_tags = {
        Hardening     = "CIS-standard"
        Author        = "Platform Enablement"
        Service       = "Jenkins"
        Name          = "Jenkins AZL2 ${local.jenkins_recipe_version}"
        RecipeVersion = local.jenkins_recipe_version
      }

      name = replace(
        "amazon-linux-2-jenkins-x86 v${local.jenkins_recipe_version} {{ imagebuilder:buildDate }}",
        ".", "-"
      )

      launch_permission {
        organization_arns = [local.organization_arn]
      }
    }
    region = var.aws_region
  }


***/

}
