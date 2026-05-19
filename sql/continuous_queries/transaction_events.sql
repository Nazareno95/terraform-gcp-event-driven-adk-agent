EXPORT DATA
OPTIONS (
  uri = 'https://pubsub.googleapis.com/projects/${PROJECT_ID}/topics/${TOPIC_NAME}',
  format = 'CLOUD_PUBSUB'
)
AS
SELECT
  TO_JSON_STRING(STRUCT(
    transaction_id,
    customer_id,
    amount,
    country,
    event_timestamp
  )) AS message
FROM `${PROJECT_ID}.${DATASET_ID}.transactions`
WHERE amount >= 1000;