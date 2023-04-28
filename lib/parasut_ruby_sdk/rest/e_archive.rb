module ParasutRubySdk
  module REST
    class EArchive < BaseRequest
      def initialize(*args)
        super(*args)
        @resource = 'e_archives'
      end

      def get(id)
        prepare_request(Util::RequestType::GET, "#{@resource}/#{id}")
      end

      def create(params)
        prepare_request(Util::RequestType::POST, @resource, params)
      end

      def show_pdf(id)
        prepare_request(Util::RequestType::GET, "#{@resource}/#{id}/pdf")
      end
    end
  end
end
