FROM rabbitmq:3.6.1-management

RUN mkdir -p /usr/lib/rabbitmq/lib/rabbitmq_server-3.5.6/plugins
ADD http://www.rabbitmq.com/community-plugins/v3.6.x/rabbitmq_delayed_message_exchange-0.0.1.ez /usr/lib/rabbitmq/lib/rabbitmq_server-3.6.1/plugins/rabbitmq_delayed_message_exchange.ez

RUN \
 chown -R rabbitmq /usr/lib/rabbitmq/lib/rabbitmq_server-3.6.1/plugins && \
 rabbitmq-plugins enable rabbitmq_delayed_message_exchange --offline

EXPOSE 5672 4369 25672 15672
