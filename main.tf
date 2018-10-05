provider "kubernetes" {
  host                   = "${var.kubernetes_ip}"
  config_context_cluster = "mycluster.icp"
  token                  = "${var.k8s_token}"
  insecure               = "true"
}

output "port" {
  value = "${kubernetes_service.jenkins.spec.0.port.0.node_port}"
}

resource "kubernetes_service" "jenkins-config" {
  metadata {
    name = "jenkins-config"
  }

  spec {
    selector {
      app = "${kubernetes_pod.jenkinsConfig.metadata.0.labels.app}"
    }

    port {
      port        = 8000
      target_port = 8000

      # node_port   = 30001
    }

    type = "NodePort"
  }
}

resource "kubernetes_pod" "jenkins-config" {
  metadata {
    name = "${var.pod_name}"

    labels {
      app = "jenkins-config"
    }
  }

  spec {
    container {
      image = "mpachich/jenkins-config:1"
      name  = "example"

      # env = {
      #   name  = "CASC_JENKINS_CONFIG"
      #   value = "http://github.com/mpachich/Kubernetes_template/blob/master/config.yaml"
      # }

      port {
        container_port = 80
      }
    }
  }
}
