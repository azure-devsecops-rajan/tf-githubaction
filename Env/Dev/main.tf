module "rg" {
  source = "github.com/mdkadir360/Terraform-env-gitops.git//1-RG"
  rgs    = var.rg
}