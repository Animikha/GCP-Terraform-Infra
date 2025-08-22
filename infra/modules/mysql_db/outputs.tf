# Outputs
output "mysql_private_ip" {
  value = google_sql_database_instance.mysql_instance.private_ip_address
}
 
output "mysql_connection_name" {
  value = google_sql_database_instance.mysql_instance.connection_name
}
 
output "mysql_instance_name" {
  value       = google_sql_database_instance.mysql_instance.name
  description = "Name of the Cloud SQL instance"
}