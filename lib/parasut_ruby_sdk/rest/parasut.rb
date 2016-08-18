module ParasutRubySdk
  module REST
    class Parasut < BaseRequest

      def initialize(*args)
        super(*args)
        @args = args.first
      end

      def accounts
        ParasutRubySdk::REST::Account.new(@args)
      end

      def contacts
        ParasutRubySdk::REST::Contact.new(@args)
      end

      def categories
        ParasutRubySdk::REST::Category.new(@args)
      end

      def products
        ParasutRubySdk::REST::Product.new(@args)
      end

      def sales_invoices
        ParasutRubySdk::REST::SalesInvoice.new(@args)
      end

    end
  end
end