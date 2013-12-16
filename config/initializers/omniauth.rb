Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'aed6b261c25bec13a55e', '01e8ca82ba9e7eb77fa3250ddbcf572c4d2051be', {:client_options => {:ssl => {:verify => false}}}
end