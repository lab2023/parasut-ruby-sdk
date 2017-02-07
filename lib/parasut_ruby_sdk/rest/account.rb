module ParasutRubySdk
  module REST
    class Account < BaseRequest

      def initialize(*args)
        super(*args)
        @resource = 'accounts'
      end

      def all( params = {} )
        prepare_request( Util::RequestType::GET, @resource, params)
      end

      def get( id, params = {} )
        prepare_request( Util::RequestType::GET, "#{@resource}/#{id}", params)
      end

      def get_transactions( id )
        prepare_request( Util::RequestType::GET, "#{@resource}/#{id}/transactions", params)
      end

    end
  end
end