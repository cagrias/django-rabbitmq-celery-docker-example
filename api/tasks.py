from __future__ import absolute_import, unicode_literals

from celery import shared_task
from mypubsub.celery import app


@shared_task
def publish_message(message):
    with app.producer_pool.acquire(block=True) as producer:
        producer.publish(
            message,
            exchange='myexchange',
            routing_key='mykey',
        )
