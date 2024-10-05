package com.example.opentelemetrytomcat;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

@Service
public class KafkaConsumer {

    @KafkaListener(topics = "server1.dbo.account", groupId = "my-group")
    public void listenAccount(@Payload String message) {
        System.out.println("ACCOUNT MESSAGE: " + message);
    }

    @KafkaListener(topics = "server1.dbo.client", groupId = "my-group")
    public void listenClient(@Payload String message) {
        System.out.println("CLIENT MESSAGE: " + message);
    }
}