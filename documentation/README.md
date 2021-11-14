# Transaction API

### Assumptions

* To sign_up on this API, there is outside service to sign_up.
* Update the account to convert it to verified should be by admin.
* All transactions will be through one currenct `AED`.

### How to install the transactions api on the server.

- Clone the api on the server or localhost.
- Make sure you installed rvm, then create `.ruby-gemset` on the folder, and type the gemset name.
- After creating the gemset, install the bundler by `gem install bundler`.
- Install all required gems by command: `bundle install`.
- Create new Database by command: `rake db:create`.
- Migrate all other indexing to DB: `rake db:migrate`.
- Create seeds in DB: `rake db:seed`.
- Start the server by: `rails s`.

### Use the API, and sample of responses

* In this service, user account should be exist in the DB by registration service.

* Only available in this service login api action to receive `auth_token`.

* Login by sending POST request using **Basic Auth** request to `/accounts/sign_in`, the response will be as the following:
```
{
    "id": 4,
    "auth_token": "M4YU6phQYBJnpjqCcX1H"
}
```

* Create transaction between your account and others, body request should be as the following:
- Get Receiver by Email:
```
{"transaction": {"receiver": {"email": "hassan_pay@mailinator.com"}, "amount": 10.0}}
```
- Get Receiver by phone_number:
```
{"transaction": {"receiver": {"phone_number": "+97152525252"}, "amount": 10.0}}
```
- Get Receiver by ID:
```
{"transaction": {"receiver_id": 5, "amount": 10.0}}
```

* Response of success transaction will be as the following:
```
{
    "id": 4,
    "amount": "10.0",
    "currency": "AED",
    "created_at": "2021-11-14T16:51:35.492Z",
    "sender": {
        "id": 4,
        "email": "mohamed_pay@mailinator.com",
        "first_name": "Mohamed",
        "last_name": "Mohamed",
        "phone_number": "+9715252525252"
    },
    "receiver": {
        "id": 6,
        "email": "hassan_pay@mailinator.com",
        "first_name": "Hassan",
        "last_name": "Hassan",
        "phone_number": "+9715454545454"
    }
}
```

* Get all transactions related to your account, there are three requests:
- `/transactions`
- `/transactions/sent_transactions`
- `/transactions/received_transactions`

* Error in create transaction will be as the following:
- Not verified account for sender or receiver.
- Amount is greater than sender balance, or negative, or not a number.
- Sender account is the same of receiver account.

### Scale Features:

1. Limit result of transactions by using pagination, [will_paginate gem](https://github.com/mislav/will_paginate) can be installed to limit the results.

2. Adding filter on transactions request by date range using `ransack gem`.

3. Handling different currency through using `Money gem`. 

### Run test cases

run command: `bundle exec rspec`, all test cases are passed.
