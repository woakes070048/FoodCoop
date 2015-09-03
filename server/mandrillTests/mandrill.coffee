moment = require 'moment'
config = require './../config'
.Config
mandrill = require 'mandrill-api/mandrill'
mandrill_client = new mandrill.Mandrill config.mandrillCredentials.pass

console.log "Running mandrill test"

template_name = 'delivery-day-template'
template_content = []
message =
  # 'html': '<p>Example HTML content</p>'
  # 'text': 'Example text content'
  # 'subject': 'example subject'
  # 'from_email': 'message.from_email@example.com'
  # 'from_name': 'Example Name'
  'to': [ {
    'email': 'sean@maplekiwi.com'
    'name': 'Sean Stanley'
    'type': 'to'
  } ]
  'headers': 'Reply-To': 'message.reply@example.com'
  'important': false
  'track_opens': true
  'track_clicks': true
  'auto_text': true
  'merge_language': 'mailchimp'
  'global_merge_vars': [ {
    'name': 'COMPANY'
    'content': 'Northland Natural Food Co-op Ltd.'
  } ]
  'merge_vars': [ {
    'rcpt': 'sean@maplekiwi.com'
    'vars': [ {
      'FNAME': 'Sean'
    } ]
  } ]
  'tags': [ 'test-from-node' ]
  'google_analytics_domains': [ 'foodcoop.nz' ]
  'google_analytics_campaign': 'message.sean@foodcoop.nz'
  'metadata': 'website': 'foodcoop.nz'
  'recipient_metadata': [ {
    'rcpt': 'sean@maplekiwi.com'
    'values': 'user_id': 123456
  } ]
  # 'attachments': [ {
  #   'type': 'text/plain'
  #   'name': 'myfile.txt'
  #   'content': 'ZXhhbXBsZSBmaWxl'
  # } ]
  # 'images': [ {
  #   'type': 'image/png'
  #   'name': 'IMAGECID'
  #   'content': 'ZXhhbXBsZSBmaWxl'
  # } ]
async = false
ip_pool = 'Main Pool'
#send_at = 'example send_at'
mandrill_client.messages.sendTemplate {
  'template_name': template_name
  'template_content': template_content
  'message': message
  'async': async
  'ip_pool': ip_pool
#  'send_at': send_at
}, ((result) ->
  console.log result

  ###
  [{
          "email": "recipient.email@example.com",
          "status": "sent",
          "reject_reason": "hard-bounce",
          "_id": "abc123abc123abc123abc123abc123"
      }]
  ###

  return
), (e) ->
  # Mandrill returns the error as an object with name and message keys
  console.log 'A mandrill error occurred: ' + e.name + ' - ' + e.message
  # A mandrill error occurred: Unknown_Subaccount - No subaccount exists with the id 'customer-123'
  return

# ---
# generated by js2coffee 2.1.0