module ParasutRubySdk
  module REST
    class SalesInvoice < BaseRequest

      def initialize(*args)
        super(*args)
        @resource = 'sales_invoices'
      end

      def all( params = {} )
        prepare_request( Util::RequestType::GET, @resource, params)
      end

      def get( id )
        prepare_request( Util::RequestType::GET, "#{@resource}/#{id}")
      end

      def create( params )
        prepare_request( Util::RequestType::POST, @resource, params)
      end

      def update( id, params )
        prepare_request( Util::RequestType::PUT, "#{@resource}/#{id}", params)
      end

      def delete( id )
        prepare_request( Util::RequestType::DELETE, "#{@resource}/#{id}")
      end

      def convert_to_invoice( id )
        prepare_request( Util::RequestType::POST, "#{@resource}/#{id}/convert_to_invoice")
      end

      def create_payments ( id, params)
        prepare_request( Util::RequestType::POST, "#{@resource}/#{id}/payments", params)
      end

      def get_e_document_type( id )
        prepare_request( Util::RequestType::GET, "#{@resource}/#{id}/e_document_type")
      end

      def create_e_invoice( id, params )
        prepare_request( Util::RequestType::POST, "#{@resource}/#{id}/e_invoice", params)
      end

      def create_e_archive( id, params )
        prepare_request( Util::RequestType::POST, "#{@resource}/#{id}/e_archive", params)
      end

      def get_e_document_status( id )
        prepare_request( Util::RequestType::GET, "#{@resource}/#{id}/e_document_status")
      end

    end
  end
end