module ParasutRubySdk
  module Util
    class RequestType
      GET = 'get'
      POST = 'post'
      PUT = 'put'
      DELETE = 'delete'
      PATCH = 'patch'
    end

    module SalesInvoice
      module ItemTypes
        INVOICE = 'invoice'
        ESTIMATE = 'estimate'
      end
      module PaymentStatus
        UNPAID = 'unpaid'
        OVERDUE = 'overdue'
        PARTIALLY_PAID = 'partially_paid'
        PAID = 'paid'
      end
    end

    module EInvoice
      module Scenario
        BASIC = 'basic'
        COMMERCIAL = 'commercial'
      end

      module ExciseDutyCode
        PETROL    = '0071'
        SODA      = '0073'
        DURABLE   = '0074'
        ALCOHOL   = '0075'
        TOBACCO   = '0076'
        SODA2     = '0077'
        MOTORIZED = '9077'
      end

      module InternetSale
        CREDIT_CARD = 'KREDIKARTI/BANKAKARTI'
        EFT         = 'EFT/HAVALE'
        AT_THE_DOOR = 'KAPIDAODEME'
        AGENT       = 'ODEMEARACISI'
        OTHER       = 'DIGER'
      end
    end

  end
end