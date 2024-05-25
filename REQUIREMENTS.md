# API Requirements

Using the CSV `/backend/spec/fixtures/transactional-sample.csv` with hypothetical transactional data,
imagine that you are trying to understand if there is any kind of suspicious behavior.

1. Analyze the data provided and present your conclusions (consider that all transactions are made using a mobile device).
2. In addition to the spreadsheet data, what other data would you look at to try to find patterns of possible frauds? 

## Solve the problem

*Stop credit card fraud: Implement the concept of a simple anti-fraud.*

An Anti-fraud works by receiving information about a transaction and inferring whether it is a fraudulent transaction or not before authorizing it. 
We work mostly with Ruby and Python, but you can use any programming language that you want. 

Please use the data provided on challenge 2 to test your solution. Consider that transactions with the flag ```has_cbk = true``` are transactions with fraud chargebacks.

Your Anti-fraud must have at least:

- 1 endpoint that receives transaction data and returns a recommendation to “approve/deny” the transaction.

Example payload:
```json
{
  "transaction_id" : 2342357,
  "merchant_id" : 29744,
  "user_id" : 97051,
  "card_number" : "434505******9116",
  "transaction_date" : "2019-11-31T23:16:32.812632",
  "transaction_amount" : 373,
  "device_id" : 285475
}
```

Example response:

```json
{ 
  "transaction_id" : 2342357,
  "recommendation" : "approve"
}
```

You are free to determine the methods to approve/deny the transactions, but a few ways to do it are:

- rule-based  - you define which cases get approved/denied based on predefined rules;
- score-base  - you create a method/model (you could use machine learning models here if you want)  to determine the risk-- score of a transaction and make your decision based on it; 
- a combination of both;
 
Things to watch for:
- Latency
- Security
- Architecture
- Coding style

### Additional Requirements

- Reject transaction if user is trying too many transactions in a row;
- Reject transactions above a certain amount in a given period;
- Reject transaction if a user had a chargeback before (note that this information does not comes on the payload. The chargeback data is received **days after the transaction was approved**)