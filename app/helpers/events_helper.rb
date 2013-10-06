# Helper methods defined here can be accessed in any controller or view in the application

Jmetrics::App.helpers do
  # def simple_helper_method
  #  ...
  # end

  def request_headers
    env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
  end  

  def application_id
    request_headers['application_id']
  end

  def auth_checksum
    env['HTTP_X_AUTHCHECKSUM']
  end

  def authenticate
    halt 401, "No applicatiod id of checksum" if application_id.nil? or auth_checksum.nil?
    @body = request.body.read
    logger.debug @body.inspect
    @application = Application.find(application_id)
    my_digest = (Digest::SHA1.new.hexdigest(@application.key+@body))
    logger.debug auth_checksum
    logger.debug my_digest
    halt 401 unless (auth_checksum == my_digest) 
  end
end
