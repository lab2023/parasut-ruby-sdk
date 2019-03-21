require 'parasut_ruby_sdk'

PARASUT_CLIENT_ID     = ''
PARASUT_CLIENT_SECRET = ''
PARASUT_CALLBACK_URL  = 'urn:ietf:wg:oauth:2.0:oob'
PARASUT_USERNAME      = ''
PARASUT_USER_PASSWORD = ''
PARASUT_COMPANY_ID    = ''

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
puts account.all

# create
p = {
  data: {
    id: "",
    type: "contacts",
    attributes: {
      email: "user@email.com",
      name: "name surname",
      short_name: "",
      contact_type: "person",
      tax_number: "identity_number",
      tax_office: "",
      district: "",
      city: "",
      address: "address",
      phone: "phone",
      is_abroad: true,
      archived: false,
      account_type: "customer"
    },
    relationships: {}
  }
}

contact.create(p)

# Product
# -------------------------------------------------------------
product = ParasutRubySdk::REST::Product.new(config)
puts product.all

# SalesInvoice
# -------------------------------------------------------------
sales_invoice = ParasutRubySdk::REST::SalesInvoice.new(config)
puts sales_invoice.all
puts sales_invoice.get(SALES_INVOICE_ID)

# create
p = {
  data: {
    type: "sales_invoices",
    attributes: {
      item_type: "invoice",
      issue_date: "2019-03-20",

      description: "description",
      tax_office: "tax_office",
      tax_number: "tax_number",
      city: "city",
      district: "district",
      billing_address: "billing_address",
      billing_phone: "billing_phone",
      billing_fax: "billing_fax",
      due_date: "2019-03-20",
      invoice_id: 3,
      invoice_series: "0001",
    },
    relationships: {
      details: {
        data: [
          {
            type: "sales_invoice_details",
            attributes: {
              quantity: 1,
              unit_price: 99,
              vat_rate: 0,
              discount_type: "percentage",
              discount_value: 0,
              excise_duty_type: "percentage",
              excise_duty_value: 0,
              communications_tax_rate: 0,
              #description: "satir description"
            },
            relationships: {
              product: {
                data: {
                  id: "PRODUCT_ID",
                  type: "products"
                }
              }
            }
          }
        ]
      },
      contact: {
        data: {
          id: "CONTACT_ID",
          type: "contacts"
        }
      },
    }
  }
}

sales_invoice.create(p)

puts sales_invoice.get_e_invoice_inboxes("ID_have_einvoice")
{
  "data"=>[
    {
      "id"=>"ID",
      "type"=>"e_invoice_inboxes",
      "attributes"=>{
        "created_at"=>"2019-03-13T04:17:38.837Z",
        "updated_at"=>"2019-03-21T04:26:13.548Z",
        "vkn"=>"Identity number",
        "e_invoice_address"=>"urn:mail:defaultpk@example.com",
        "name"=>"Name",
        "inbox_type"=>"unknown",
        "address_registered_at"=>"2019-03-12T11:25:19.000Z",
        "registered_at"=>"2019-03-12T11:25:39.000Z"
      },
      "meta"=>{
        "created_at"=>"2019-03-13T04:17:38.837Z",
        "updated_at"=>"2019-03-21T04:26:13.548Z"
      }
    }
  ],
  "links"=>{}, "meta"=>{"current_page"=>1, "total_pages"=>1, "total_count"=>1, "per_page"=>15}
}

puts sales_invoice.get_e_invoice_inboxes("ID_have_not_einvoice")
{"data"=>[], "links"=>{}, "meta"=>{"current_page"=>1, "total_pages"=>0, "total_count"=>0, "per_page"=>15}}