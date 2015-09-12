# SQS demo for Ada Developers Academy

This program supports two modes: *speaker* and *listener*.

## Setup

Get the AWS access and secret keys from Philip.

Set AWS environment variables:

```
export AWS_REGION=us-west-2
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
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
