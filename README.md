# Docker Fake SQS

[![Docker Pulls](https://img.shields.io/docker/pulls/evenco/fake-sqs.svg)](https://hub.docker.com/r/evenco/sqs/)

Dockerized [Fake SQS](https://github.com/iain/fake_sqs).

## Running

Simply run the container:

```
docker run -it -p 4568:4568 evenco/fake-sqs
```

Or, from `docker-compose.yml`:

```yaml
services:
  sqs:
  image: evenco/fake-sqs
  ports:
    - 4568
```

## Configurations

The majority of configurations are set to sane defaults for use within Docker,
however, the following environment variables are available:

- `SERVER`: Server to use (`thin`, `mongrel` or `webrick`)
- `DATABASE`: Where to store the database (`:memory:`, `./path/to/database.yml`)

> __Note:__ The `SERVER` defaults to `thin`, as `webrick` attempts to do reverse
> dns lookups on every request which slows down the service drastically. There
> is a setting to override this within webrick, but sinatra does not allow
> server-specific setttings to be passed down.
