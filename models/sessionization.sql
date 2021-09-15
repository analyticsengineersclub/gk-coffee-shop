{{ config(
    materialized='table'
) }}

SELECT visitor_id,
        timestamp ,
        SUM(is_new_session) OVER (ORDER BY visitor_id, timestamp ) AS global_session_id,
        SUM(is_new_session) OVER (PARTITION BY visitor_id ORDER BY timestamp) AS user_session_id
FROM (
        SELECT *,
        TIMESTAMP_DIFF(timestamp, last_event, SECOND) as seconds_since_last_event,
        CASE WHEN TIMESTAMP_DIFF(timestamp, last_event, SECOND) >= (60 * 30)
        OR last_event IS NULL
        THEN 1 ELSE 0 END AS is_new_session
FROM (
SELECT *,
        LAG(timestamp,1) OVER
            (PARTITION BY visitor_id ORDER BY timestamp) AS last_event
FROM `aec-project-tutorial.dbt_gabrielle.user_stitching_sessions`
        ) last
) final