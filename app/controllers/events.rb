Jmetrics::App.controllers :events do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  before do
    authenticate
  end

  post :index, provides: :json do
    event_data = JSON.parse( @body ) 
    if event_data.is_a?(Array)
      events = []
      event_data.each do |e|
        e[:application] = @application
        events << Event.create(e)
      end
      events.to_json
    else
      event_data[:application] = @application
      Event.create(event_data)
    end
  end

end
