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

## Set up your own queue and users

This demo uses an existing queue and users in Philip's AWS account, but here's
how to set up your own.  I include two sets of instructions: the simpler case
of just one user that can both write to and read from the queue, and the case of
two users, one for reading and one for writing.

### One user for reading and writing

1. Log in to the AWS console and go to its SQS section.
2. Create a new SQS queue.  Note its ARN.
3. Copy your new queue's ARN into the `QUEUE_ARN` constant of `queue.rb`.
4. Go to the IAM section of AWS console.
5. Create a new policy; use the Policy Generator.
    1. Effect: Allow
    2. AWS Service: AWS SQS
    3. Actions: All Actions (*)
    4. ARN: the ARN of your new queue (from step 2)
6. Create a new user; write down its access and secret keys, and set them in your environment variables.
7. Attach the policy from step 5 to the new user.

### A user for writing, a user for reading

1. Log in to the AWS console and go to its SQS section.
2. Create a new SQS queue.  Note its ARN.
3. Copy your new queue's ARN into the `QUEUE_ARN` constant of `queue.rb`.
4. Go to the IAM section of AWS console.
5. Create a new policy for _reader_ user; use the Policy Generator.
    1. Effect: Allow
    2. AWS Service: AWS SQS
    3. Actions: `ChangeMessageVisibility`, `ChangeMessageVisibilityBatch`, `DeleteMessage`,
        `DeleteMessageBatch`, `ReceiveMessage`.
    4. ARN: the ARN of your new queue (from step 2)
6. Create a new policy for _writer_ user; use the Policy Generator.
    1. Effect: Allow
    2. AWS Service: AWS SQS
    3. Actions: `PurgeQueue`, `SendMessage`, `SendMessageBatch`.
    4. ARN: the ARN of your new queue (from step 2)
6. Create a new _reader_ and _writer_ users; write down their access and secret keys.
7. To each user of your two new users, attach the correct policy.

Now you can run this program in _speaker_ or _listener_ mode after setting the
environment variables to the correct user's access and secret keys.

## References

* [AWS SDK for Ruby](https://aws.amazon.com/sdk-for-ruby/)
* [AWS SDK for Ruby - SQS client API](http://docs.aws.amazon.com/sdkforruby/api/Aws/SQS.html)
* [AWS SQS Pricing](https://aws.amazon.com/sqs/pricing/)
* [AWS Simple Monthly Calculator](http://calculator.s3.amazonaws.com/index.html)

