# SQS demo for Ada Developers Academy

This program supports two modes: *speaker* and *listener*.

## Setup

Set AWS environment variables:

```
export AWS_REGION=us-west-2
export AWS_ACCESS_KEY_ID=<get from Philip>
export AWS_SECRET_ACCESS_KEY=<get from Philip>
```

Install dependencies: `bundle`

## Run as speaker

```
ruby queue.rb speaker
```

## Run as listener

```
ruby queue.rb listener
```

## Cost

The only AWS technology in use here is Simple Queue Service (SQS).
There are two factors to consider: the number of messages, and amount of data
entering and leaving AWS.

Assuming one message every second, 24x7, that's up to 2,678,400 messages per month.
Further, assume each message is 500 bytes.

The first 1M messages per month are free, then 50¢ per 1M.  For the quantity
of messages, our cost is about 84¢.

For data transfer, we estimate about 1.34 GB.  Data transfer _in_ is free, and 
_out_ is 9¢ per gigabyte after the first gigabyte.  Thus, that's about 4¢ for
data transfer.

In total, we estimate we'd pay 88¢ per month for our estimated AWS usage.

## References

* [AWS SDK for Ruby](https://aws.amazon.com/sdk-for-ruby/)
* [AWS SDK for Ruby - SQS client API](http://docs.aws.amazon.com/sdkforruby/api/Aws/SQS.html)
* [AWS SQS Pricing](https://aws.amazon.com/sqs/pricing/)
* [AWS Simple Monthly Calculator](http://calculator.s3.amazonaws.com/index.html)

