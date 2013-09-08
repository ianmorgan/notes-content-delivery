module ElasticSearchIntegration 
  
  def server 
    @server ||= Stretcher::Server.new('http://localhost:9200')
  end

  def all_slugs_for_topic(topic)
    # see http://www.elasticsearch.org/guide/reference/query-dsl/query-string-query/ for syntax
    q = { query_string: { 
              query: topic,
              default_field: "topic",
              lowercase_expanded_terms: false,
              allow_leading_wildcard: false 
    }}
    
    results = server.index(:directory).msearch([{query: q}])[0][:results]    
    results.collect {|result| result["slug"]}
  end

end