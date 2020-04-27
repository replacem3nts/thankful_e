
    require 'twilio-ruby'

    account_sid = 'AC1c3b8f2e4f137406352b303bbe030856'
    auth_token = '8335ebb707358e1f396b98ca9cdc1139'
    client = Twilio::REST::Client.new(account_sid, auth_token)
    
    from = '+13202284265' # Your Twilio number
    to = '+12033130513' # Your mobile phone number
    
    client.messages.create(
        from: from,
        to: to,
        body: "Hey friend!"
        )