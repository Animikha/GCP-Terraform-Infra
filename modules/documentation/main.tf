resource "local_file" "terraform_documentation" {
    content = var.doc_content
    filename = "${path.root}/../terraform_documentation.txt" 
}