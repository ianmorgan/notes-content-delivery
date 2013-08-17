module AWSIntegration

  aws_credentials = YAML::load( File.open( ENV['HOME'] + '/.notes-content-delivery/aws/credentials.yaml' ) )
   #puts aws_credentials.class
   #puts aws_credentials["access_key_id"]

   s3 = AWS::S3.new(
  :access_key_id => aws_credentials["access_key_id"],
  :secret_access_key => aws_credentials['secret_access_key'])
  
  
  # TODO - should be able to figure this out dynamically 
  @@buckets = Hash.new 
  @@buckets['design'] = s3.buckets['notes-storage-design'] 
  @@buckets['functional-programming'] = s3.buckets['notes-storage-functional-programming'] 
  @@buckets['html'] = s3.buckets['notes-storage-html'] 
  @@buckets['java'] = s3.buckets['notes-storage-java'] 
  @@buckets['ruby'] = s3.buckets['notes-storage-ruby']
  @@buckets['scala'] = s3.buckets['notes-storage-scala'] 
  @@buckets['unix'] = s3.buckets['notes-storage-unix'] 
 

  def retrieve_by_key(topic, key)
    result = nil
    puts topic
    puts key
    #puts(Benchmark.measure do 
      obj = @@buckets[topic].objects[key]
      puts obj
      result = obj.read
    #end)
    result
  end

end