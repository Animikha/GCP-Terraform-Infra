resource "google_compute_instance" "vm" {
  for_each = var.vm_instances
  name = each.key
  # Set the count or number of vms to be created
  # count = 2 
  # # Sets the vm instance name according to the count (index starting from 0)
  # name         = "${var.instance_name}-${count.index}" 
  machine_type = each.value.machine_type
  zone         = each.value.zone

  boot_disk {
    initialize_params {
      image = var.source_image
      size  = var.disk_size
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {} # Enables external IP
  }

#   metadata = {
#     ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
#   }
  //metadata_startup_script = file("${path.module}/scripts/install-nginx.sh")
  tags = var.tags

#   metadata_startup_script = <<-EOT
#     #!/bin/bash
#     apt-get update -y
#     apt-get install -y mysql-client

#     # Retry loop function for MySQL connection
#     cat <<'EOF' >> /home/$${USER:-$(whoami)}/.bashrc

#     echo "Attempting to connect to MySQL..."
#     for i in {1..5}; do
#       mysql -h ${var.db_host} -u ${var.db_user} -p${var.db_password} -e "SELECT 1;" >/dev/null 2>&1
#       if [ $? -eq 0 ]; then
#         echo "Connected! Launching MySQL CLI..."
#         mysql -h ${var.db_host} -u ${var.db_user} -p${var.db_password}
#         break
#       else
#         echo "Attempt $i failed... retrying in 5 seconds"
#         sleep 5
#       fi
#     done
#     EOF
# EOT

metadata = {
    startup-script = <<EOF
       #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y default-mysql-client

    echo "Starting MySQL connection test..." | tee -a /var/log/mysql-startup.log
    sudo touch /var/log/msqlogin.txt
    sudo chmod 777 /var/log/msqlogin.txt

    # Capture current user dynamically
    USER_NAME=$(getent passwd | awk -F: '$3 >= 1000 && $3 < 65534 {user=$1} END {print user}')

    echo "User detected 1: $USER_NAME" | tee -a /var/log/msqlogin.txt

    # Attempt MySQL connection retry logic
    for i in {1..5}; do
      echo "Attempt $i: Connecting to MySQL at ${var.db_host}..." | tee -a /var/log/mysql-startup.log
      mysql -h "${var.db_host}" -u "${var.db_user}" -p"${var.db_password}" -e "SHOW DATABASES;" >> /var/log/mysql-startup.log 2>&1

      if [ $? -eq 0 ]; then
        echo "✅ MySQL connection successful!" | tee -a /var/log/mysql-startup.log
        echo "Final detected user: $USER_NAME" | tee -a /var/log/msqlogin.txt
        USER_NAME=$(getent passwd | awk -F: '$3 >= 1000 && $3 < 65534 {user=$1} END {print user}')
        echo "User detected 2: $USER_NAME" | tee -a /var/log/msqlogin.txt
        break
      else
        echo "❌ MySQL connection failed. Retrying in 10s..." | tee -a /var/log/mysql-startup.log
        sleep 10
      fi
    done

    for i in {1..5}; do
      mysql -h "${var.db_host}" -u "${var.db_user}" -p"${var.db_password}" -e "SHOW DATABASES;" >> /var/log/mysql-startup.log 2>&1
      if [ $? -eq 0 ]; then
        USER_NAME=$(getent passwd | awk -F: '$3 >= 1000 && $3 < 65534 {user=$1} END {print user}')
        echo "User detected 3: $USER_NAME" | tee -a /var/log/msqlogin.txt
        if ! grep -q 'mysql -h "${var.db_host}" -u "${var.db_user}" -p' /home/$USER_NAME/.bashrc; then
        echo "alias mysqlconnect='mysql -h \"${var.db_host}\" -u \"${var.db_user}\" -p'" >> /home/$USER_NAME/.bashrc
        echo 'mysql -h "${var.db_host}" -u "${var.db_user}" -p' >> /home/$USER_NAME/.bashrc
        fi
        break
      else
        sleep 10
      fi
    done
    EOF
  }

}
