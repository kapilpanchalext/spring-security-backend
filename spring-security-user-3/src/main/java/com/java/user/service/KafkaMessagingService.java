package com.java.user.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import org.apache.kafka.clients.admin.AdminClient;
import org.apache.kafka.clients.admin.NewTopic;
import org.apache.kafka.common.config.TopicConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaAdmin;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.SendResult;
import org.springframework.stereotype.Service;

@Service
public class KafkaMessagingService {

	@Autowired
	KafkaAdmin kafkaAdmin;

	@Autowired
	private KafkaTemplate<Integer, Object> kafkaTemplate;

	private void createNewTopic(String topicName) throws ExecutionException, InterruptedException {

		Map<String, String> topicConfig = new HashMap<>();
		topicConfig.put(TopicConfig.RETENTION_MS_CONFIG, String.valueOf(24 * 60 * 60 * 1000)); // 24 hours retention

		NewTopic newTopic = new NewTopic(topicName, 1, (short) 1).configs(topicConfig);

		try (AdminClient adminClient = AdminClient.create(kafkaAdmin.getConfigurationProperties())) {
			// Blocking call to make sure topic is created
			adminClient.createTopics(Collections.singletonList(newTopic)).all().get();
		}
	}

	public CompletableFuture<SendResult<Integer, Object>> publishMessage(String eventMessage, int key) {
        return kafkaTemplate.send("login-events", key, eventMessage);
    }
}
