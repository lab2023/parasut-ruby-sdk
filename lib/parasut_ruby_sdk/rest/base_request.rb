module ParasutRubySdk
  module REST
    class BaseRequest
      attr_accessor :config
      HTTP_HEADERS = {
          'Accept'          => 'application/json',
          'Accept-Charset'  => 'utf-8',
          'User-Agent'      => "parasut_ruby_sdk/#{ParasutRubySdk::VERSION}" " (#{RUBY_ENGINE}/#{RUBY_PLATFORM}" " #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL})"
      }

      def initialize(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        args.select! {|arg| !arg.nil?}
        self.config = ParasutRubySdk::Util::Configuration.new options
        @refresh_try = 0
        raise ArgumentError, 'Auth token or user credentials are required' if (self.config.client_id.nil? || self.config.client_secret.nil? || self.config.username.nil? || self.config.password.nil?)
        set_up_connection
        get_token_from_api if self.config.access_token.nil?
      end

      def refresh_expired_token
        refresh_token
      end

      def get_token
        get_token_from_api
      end

      protected
        ##
        # Set up and cache a Net::HTTP object to use when making requests.
        def set_up_connection # :doc:
          uri                = URI.parse(self.config.host)
          @http              = Net::HTTP.new(uri.host, uri.port, p_user = self.config.proxy_user, p_pass =  self.config.proxy_pass)
          @http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
          @http.use_ssl      = self.config.use_ssl
          if self.config.ssl_verify_peer
            @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
            @http.ca_file     = self.config.ssl_ca_file
          else
            @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          end
          @http.open_timeout = self.config.timeout
          @http.read_timeout = self.config.timeout
        end

        ##
        # Send an HTTP request using the cached <tt>@http</tt> object and
        # return the JSON response body parsed into a hash. Also save the raw
        # Net::HTTP::Request and Net::HTTP::Response objects as
        # <tt>@last_request</tt> and <tt>@last_response</tt> to allow for
        # inspection later.
        def connect_and_send(request, is_file = false ) # :doc:
          @last_request = request
          retries_left = self.config.retry_limit
          begin
            response = @http.request request
            @last_response = response
            if response.kind_of? Net::HTTPServerError
              # raise ParasutRubySdk::REST::ServerError
              return response
            end
          rescue
            raise if request.class == Net::HTTP::Post
            if retries_left > 0 then retries_left -= 1; retry else raise end
          end
          if response.body and !response.body.empty?
            if is_file
              object = response.body
            else
              object = JSON.parse(response.body)
            end
          elsif response.kind_of? Net::HTTPBadRequest
            object = { message: 'Bad request', code: 400 }
          end

          if response.kind_of? Net::HTTPClientError
            # if response.kind_of? Net::HTTPUnauthorized
            #   object = response
            # else
            #   object = response
            #   # raise ParasutRubySdk::REST::RequestError.new response.message, response.code
            # end
            object = response
          end
          object
        end

        ##
        # Prepare http request
        def prepare_request(method, path, params = {})
          uri                     = uri_parse(params, path)
          uri.query               = URI.encode_www_form(params) if ['get', 'delete'].include?(method)
          method_class            = Net::HTTP.const_get method.to_s.capitalize
          headers                 = HTTP_HEADERS.clone
          headers['Content-Type'] = 'application/json' if ['post', 'put'].include?(method)
          request                 = method_class.new(uri.to_s, headers)
          request.body            = params.to_json if ['post', 'put'].include?(method)
          connect_and_send(request)
        end

        ##
        # URI parse for params
        def uri_parse(params = {}, path)
          root_path = params.delete(:root_path)
          if root_path
            request_path = "#{self.config.host}/#{path}"
          else
            request_path = "#{self.config.host}/v1/#{self.config.company_id}/#{path}"
            params[:access_token] = self.config.access_token
          end
          URI.parse(request_path)
        end

        def get_token_from_api
          params = {
              client_id: self.config.client_id,
              client_secret: self.config.client_secret,
              grant_type: 'password',
              redirect_uri: self.config.callback_url,
              username: self.config.username,
              password: self.config.password,
              root_path: true
          }
          credentials = prepare_request(Util::RequestType::POST, 'oauth/token', params)
          set_credentials(credentials)
          @refresh_try = 0
          self.config
        end

        def set_credentials(credentials)
          conf = self.config.clone
          conf.access_token = credentials['access_token']
          conf.refresh_token = credentials['refresh_token']
          self.config = conf
          self.config
        end

        def refresh_token
          params = {
              client_id: self.config.client_id,
              client_secret: self.config.client_secret,
              grant_type: 'refresh_token',
              refresh_token: self.config.refresh_token,
              root_path: true
          }
          credentials = prepare_request(Util::RequestType::POST, 'oauth/token', params)
          set_credentials(credentials)
          @refresh_try = 0
          self.config
        end
    end
  end
end