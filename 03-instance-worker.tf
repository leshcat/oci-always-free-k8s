resource "oci_core_instance" "worker-arm" {
  compartment_id      = oci_identity_compartment.tf-compartment.id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

  display_name = "worker-arm"

  shape = "VM.Standard.A1.Flex"
  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }
  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu_arm.images[0].id
  }

  create_vnic_details {
    assign_public_ip = false
    subnet_id        = oci_core_subnet.vcn-public-subnet.id
  }

  metadata = {
    ssh_authorized_keys = file(var.leader-ssh-key-pub)
  }
}

# Retrieve ID for the image
resource "oci_core_instance" "worker" {
  compartment_id      = oci_identity_compartment.tf-compartment.id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

  display_name = "worker"

  shape = "VM.Standard.E2.1.Micro"
  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }
  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images[0].id
  }

  create_vnic_details {
    assign_public_ip = false
    subnet_id        = oci_core_subnet.vcn-public-subnet.id
  }

  metadata = {
    ssh_authorized_keys = file(var.leader-ssh-key-pub)
  }
}
