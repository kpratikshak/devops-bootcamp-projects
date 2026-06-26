create a variable of type list(string) for bucket names 
Use count to iterate throught the bucket names. Reference bucket names using count.index 
Run terraform plan to see the resources. 

variable.tf 
variable "buckets" {
    description = "values for  S3 buckets"
    type = list(string)
    default = [ "bucket-one-uiefieue" , bucket-two]
}
  
Understanding for_each

Create a variable of type set for bucket names. 
Use for_each to iterate through the bucket names.
Reference bucket names using each.value
  
variable "buckets_set" {
  description = "variables"
  type = list(string)
  default = [ "bucket-one-12456" ,  ]
}


main.tf 
resource {
    count =  S3
    bucket = var.bucket[count.index]
}

 Please complete task  S3 when you visit this space again.....


