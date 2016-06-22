## **API Beeline Inspector**

Program interface to collect info about beeline abonent.

#### **Error handling**
Status code values:

- 200 - Succes. But some requested data still may be missing. In this case repeat request later
- 400 - Missing required parameters
- 401 - Cannot authenticate with the provided credentials
- 5xx - Unexpected server errors

If there is expected error during request, response body will include error description:
```
{ "message":"Cannot authenticate with the provided credentials" }
```

### **Collect abonents data request**

```
GET /api/abonent/data
```

#### **Required parameters**

- phone_number - abonent's phone number in 11 digit format (91112223344)
- password - abonent's personal cabinet password (12345)

#### **Optional parameters**
- end_date - the date till detalization will be ordered dd.mm.yyyy (01.10.2015)
- start_date - the date from detalization will be ordered dd.mm.yyyy (01.10.2015)
- additinal_date - the date till additional detalization will be ordered dd.mm.yyyy (01.10.2015)
- balance - is it required to collect balance (it will be collected only with 'true' value)
- current_plan - is it required to collect current plan (it will be collected only with 'true' value)
- services - is it required to collect services (it will be collected only with 'true' value)
- detail - is it required to collect detailization (it will be collected only with 'true' value)

#### **Example**

```
http --timeout=600 --pretty=all --verbose 'localhost:9393/api/abonent/data?phone_number=960*******&*****=zaqwsx&order_id=1&start_date=2016-01-01&end_date=2016-01-31&additional_date=2016-02-15&additional_detail=true&balance=true&detail=true&bill=true&current_plan=true&services=true'

GET /api/abonent/data?phone_number=960*******&password=*****&order_id=1&start_date=2016-01-01&end_date=2016-01-31&additional_date=2016-02-15&additional_detail=true&balance=true&detail=true&bill=true&current_plan=true&services=true HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Host: localhost:9394
User-Agent: HTTPie/0.9.3



HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 592077
Content-Type: application/json
Server: thin
X-Content-Type-Options: nosniff

{
    "message": {
        "additional_detail": "JVBERi0xLjQKJeLjz9MKMyAwIG9iago8PC9Db2xvclNwYWNlWy9DYWxSR0I8\nPC9HYW1tYVsyLjIyIDIuMjIgMi4yMl0vV2hpdGVQb2ludF7mPdQI5U\nnKML9NA6ySNqzAD2VAxLa+Jbd9ACVQNQR7qsSBXNjaliBjfSxsatlIGN78bV\nbQxjY/eJpZRjjHT0YK\n",
        "balance": 99.6842,
        "current_plan": {
            "name": "Go!",
            "payment_period": null,
            "subscription_payment": 0.0
        },
        "detail": "JVBERi0xLjQKJeLjz9MKMyAwIG9iago8PC9Db2xvclNwYWNlWy9DYWxSR0I8\nPC9HYW1tYVsyLjIyIDIuMjIgMi4yMl0vV2hpdGVQb2ludFswLjk1MDQzIjEzODIwNz48MTQ1NDNkOTFiMjBiNDNiMDhlYjVmNGYz\nNzNhYmIxYmI+XS9Sb290IDYxIDAgUi9TaXplIDYzPj4Kc3RhcnR4cmVmCjIx\nNTA0OQolJUVPRgo=\n",
        "payment_type": "prepaid",
        "services": [
            {
                "name": "Автопродление скорости",
                "payment_period": null,
                "removable": "Y",
                "subscription_payment": null
            },
            {
                "name": "Доступ в интернет и MMS",
                "payment_period": null,
                "removable": "N",
                "subscription_payment": 0.0
            },
            {
                "name": "Интернет-уведомление в роуминге",
                "payment_period": "dayly",
                "removable": "Y",
                "subscription_payment": 0.0
            },
            {
                "name": "Есть контакт",
                "payment_period": "dayly",
                "removable": "Y",
                "subscription_payment": 0.0
            },
            {
                "name": "Определитель номера",
                "payment_period": "dayly",
                "removable": "Y",
                "subscription_payment": 0.0
            },
            {
                "name": "Моя страна архив",
                "payment_period": "dayly",
                "removable": "Y",
                "subscription_payment": 0.0
            },
            {
                "name": "Самый выгодный роуминг",
                "payment_period": "dayly",
                "removable": "N",
                "subscription_payment": 0.0
            },
            {
                "name": "Хайвей 5 МБ",
                "payment_period": null,
                "removable": "Y",
                "subscription_payment": 0.0
            }
        ]
    }
}```
