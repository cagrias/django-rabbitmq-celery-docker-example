# django-rabbitmq-celery-docker-example
A dockerized example pub/sub type message queue implementation in django by using rabbitmq and celery. Detailed explanation is published on the Medium story:

https://medium.com/p/20d349dc60b6


### Pub/Sub Role Definitions

**Publisher:** A separate RabbitMQ queue producer is declared and added to Celery's default producer_pool, which is pulled and used to publish new messages to that queue in a Celery task.

**Consumer:** A custom consumer class is defined and attached to Celery. The class is subscribed to the custom queue that is created/declared with the separate queue producer above. A handle_message callback function is defined in the custom consumer class so that every time a message is published to that particular queue, the consumer's callback is called, which consumes the message and sends an ack to RabbitMQ.


### Installation
`docker` and `docker-compose` are needed to be installed to run this project. These links can be followed to install both on Ubuntu:
- `docker`: https://docs.docker.com/install/linux/docker-ce/ubuntu/
- `docker-compose`: https://docs.docker.com/compose/install/

After installation, run:
```shell
docker-compose build
docker-compose up
```


### Usage
From a web-browser, Postman or an http-library in any language, send a GET request to `http://localhost:8080/api/publish`. The `publish` view will publish a custom JSON message to the queue, which will be followed by the subscription of the same message by the custom consumer class. A successful flow should print `Received message: {'hello': 'world'}` to docker-compose logs.
