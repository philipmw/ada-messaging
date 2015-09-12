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
