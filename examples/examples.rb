require 'parasut_ruby_sdk'

PARASUT_CLIENT_ID     = ''.freeze
PARASUT_CLIENT_SECRET = ''.freeze
PARASUT_CALLBACK_URL  = 'urn:ietf:wg:oauth:2.0:oob'.freeze
PARASUT_USERNAME      = ''.freeze
PARASUT_USER_PASSWORD = ''.freeze
PARASUT_COMPANY_ID    = ''.freeze

config = {
  client_id: PARASUT_CLIENT_ID,
  client_secret: PARASUT_CLIENT_SECRET,
  callback_url: PARASUT_CALLBACK_URL,
  username: PARASUT_USERNAME,
  password: PARASUT_USER_PASSWORD,
  company_id: PARASUT_COMPANY_ID,
  access_token: nil,
  refresh_token: nil
}

# Get access and refresh token
tokens = ParasutRubySdk::REST::BaseRequest.new(config).get_token
config['access_token'] = tokens.access_token
config['refresh_token'] = tokens.refresh_token

# Account
# -------------------------------------------------------------
account = ParasutRubySdk::REST::Account.new(config)
# Listing
puts account.all

# Contact
# -------------------------------------------------------------
contact = ParasutRubySdk::REST::Contact.new(config)
# Listing
puts contact.all
# Listing with filter
puts contact.all('filter[email]': 'user@email.com', 'page[size]': 1, 'page[number]': 1)
# Create Contact
params = {
  data: {
    id: '',
    type: 'contacts',
    attributes: {
      email: 'user@email.com',
      name: 'name surname',
      short_name: '',
      contact_type: 'person',
      tax_number: 'identity_number',
      tax_office: '',
      district: '',
      city: '',
      address: 'address',
      phone: 'phone',
      is_abroad: true,
      archived: false,
      account_type: 'customer'
    },
    relationships: {}
  }
}
puts contact.create(params)

# Product
# -------------------------------------------------------------
product = ParasutRubySdk::REST::Product.new(config)
# Listing
puts product.all
# Listing with filter
puts product.all('filter[name]': 'pro', 'page[size]': 1, 'page[number]': 1)

# SalesInvoice
# -------------------------------------------------------------
sales_invoice = ParasutRubySdk::REST::SalesInvoice.new(config)
SALES_INVOICE_ID = 'your_sales_invoice_id'
# Listing
puts sales_invoice.all
# Listing with filter
puts sales_invoice.all('page[size]': 1, 'page[number]': 1)
# Get sales invoice
puts sales_invoice.get(SALES_INVOICE_ID)
# Get specific invoice with active_e_document
puts sales_invoice.get(SALES_INVOICE_ID, include: 'active_e_document')
# Get e_invoice_inboxes
puts sales_invoice.get_e_invoice_inboxes
# Get e_invoice_inboxes with filter
puts sales_invoice.get_e_invoice_inboxes('filter[vkn]': 'ID_have_einvoice')
# Get e-document/archive
puts sales_invoice.get_e_archive(SALES_INVOICE_ID)
# Get PDF link
puts sales_invoice.get_e_archive_pdf(SALES_INVOICE_ID)

# Create a sales invoice
params = {
  data: {
    type: 'sales_invoices',
    attributes: {
      item_type: 'invoice',
      issue_date: '2019-03-20',

      description: 'description',
      tax_office: 'tax_office',
      tax_number: 'tax_number',
      city: 'city',
      district: 'district',
      billing_address: 'billing_address',
      billing_phone: 'billing_phone',
      billing_fax: 'billing_fax',
      due_date: '2019-03-20',
      invoice_id: 3,
      invoice_series: '0001'
    },
    relationships: {
      details: {
        data: [
          {
            type: 'sales_invoice_details',
            attributes: {
              quantity: 1,
              unit_price: 99,
              vat_rate: 0,
              discount_type: 'percentage',
              discount_value: 0,
              excise_duty_type: 'percentage',
              excise_duty_value: 0,
              communications_tax_rate: 0,
              description: 'description'
            },
            relationships: {
              product: {
                data: {
                  id: 'PRODUCT_ID',
                  type: 'products'
                }
              }
            }
          }
        ]
      },
      contact: {
        data: {
          id: 'CONTACT_ID',
          type: 'contacts'
        }
      }
    }
  }
}
puts sales_invoice.create(params)

# Create a e-Archive
params = {
  data: {    
    type: "e_archives",
    attributes: {     
      vat_exemption_reason_code: "VAT_EXEMPTION_REASON_CODE",
      vat_exemption_reason: "VAT_EXEMPTION_REASON",
      internet_sale: {
        url: "https://example.com/",
        payment_type: "KREDIKARTI/BANKAKARTI",
        payment_platform: "Akbank 3d_pay_hosting",
        payment_date: "2019-03-24"
      },
      shipment: {}
    },
    relationships: {
      sales_invoice: {
        data: {
          id: "SALES_INVOICE_ID",
          type: "sales_invoices"
        }
      }
    }
  }
}
puts sales_invoice.create_e_archive(params)

# Get e-document status
h = sales_invoice.get_e_document_status("TRACKABLE_JOBS_ID")
puts h["data"]["attributes"]["status"] == "done"

# Get e-archive
puts sales_invoice.get(SALES_INVOICE_ID, {'include': 'active_e_document'})

# Get PDF link
h = sales_invoice.get_e_archive_pdf(SALES_INVOICE_ID)
puts h["data"]["attributes"]["url"]
