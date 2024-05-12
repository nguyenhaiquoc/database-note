-- https://hainguyen.hashnode.dev/postgresql-serial-id-concurrent-inserts-behavior

-- Create a table with a SERIAL column as primary key
CREATE TABLE public.test_serial (
  id SERIAL PRIMARY KEY,
  reason VARCHAR(10) NOT NULL
);
-- End of script


-- Test concurrent inserts by running the following script in two separate sessions
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;  -- Use highest isolation level setting.
BEGIN TRANSACTION;

INSERT INTO test_serial (reason) VALUES ('Test 1');
SELECT * FROM test_serial WHERE reason  = 'Test 1'; -- Should display inserted id in console
-- SELECT pg_sleep(60); -- sleep 60 second to simulate a long running transaction
-- ROLLBACK;
COMMIT;
-- End of script

