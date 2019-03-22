module ParasutRubySdk
  module REST
    class Category < BaseRequest
      def initialize(*args)
        super(*args)
        @resource = 'item_categories'
      end

      def all(params = {})
        prepare_request(Util::RequestType::GET, @resource, params)
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
