module ParasutRubySdk
  module REST
    class Product < BaseRequest
      def initialize(*args)
        super(*args)
        @resource = 'products'
      end

      def all(params = {})
        prepare_request(Util::RequestType::GET, @resource, params)
      end

      def get(id)
        prepare_request(Util::RequestType::GET, "#{@resource}/#{id}")
      end

      def create(params)
        prepare_request(Util::RequestType::POST, @resource, params)
      end

      def update(id, params)
        prepare_request(Util::RequestType::PUT, "#{@resource}/#{id}", params)
      end

      def delete(id)
        prepare_request(Util::RequestType::DELETE, "#{@resource}/#{id}")
      end
    end
  end
end
