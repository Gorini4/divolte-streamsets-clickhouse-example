CREATE TABLE IF NOT EXISTS clickstream_topic (
    firstInSession UInt8,
    timestamp UInt64,
    location String,
    partyId String,
    sessionId String,
    pageViewId String,
    eventType String,
    userAgentString String
) ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'clickstream',
    kafka_group_name = 'clickhouse',
    kafka_format = 'JSONEachRow';

CREATE TABLE clickstream (
    firstInSession UInt8,
    timestamp UInt64,
    location String,
    partyId String,
    sessionId String,
    pageViewId String,
    eventType String,
    userAgentString String
  ) ENGINE = ReplacingMergeTree()
ORDER BY (timestamp, pageViewId);

CREATE MATERIALIZED VIEW clickstream_consumer TO clickstream
    AS SELECT * FROM clickstream_topic;

SELECT * FROM clickstream;