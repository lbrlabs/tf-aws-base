data "aws_iam_policy_document" "master-ec2" {
  statement {
    sid       = "EC2"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVolumes",
      "ec2:CreateVolume",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteVolume",
      "ec2:ModifyInstanceAttribute",
      "ec2:AttachVolume",
      "ec2:DetachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup",
      "ec2:RevokeSecurityGroupIngress",
    ]
  }
}

data "aws_iam_policy_document" "master-asg" {
  statement {
    sid       = "ASG"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:GetAsgForInstance",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
    ]
  }
}

data "aws_iam_policy_document" "master-elb" {
  statement {
    sid       = "ELV"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:AttachLoadBalancerToSubnets",
      "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancerPolicy",
      "elasticloadbalancing:CreateLoadBalancerListeners",
      "elasticloadbalancing:ConfigureHealthCheck",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteLoadBalancerListeners",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DetachLoadBalancerFromSubnets",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
      "ec2:DescribeVpcs",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancerPolicies",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:SetLoadBalancerPoliciesOfListener",
    ]
  }
}


module "master-role" {
    source     = "git::https://github.com/cloudposse/terraform-aws-iam-role.git?ref=master"

    enabled    = "true"
    namespace = "${var.namespace}"
    stage     = "${var.stage}"
    name      = "${var.name}"

    policy_description = "Kubernetes Master Policy"
    role_description   = "Role for Kubernetes masters"
    principals_arns = [ "arn:aws:iam::609316800003:instance/*" ]

    policy_documents = [
      "${data.aws_iam_policy_document.master-elb.json}",
      "${data.aws_iam_policy_document.master-asg.json}",
      "${data.aws_iam_policy_document.master-ec2.json}",
    ]
  }
