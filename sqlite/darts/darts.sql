-- Schema: CREATE TABLE "darts" ("x" REAL, "y" REAL, score INTEGER);
-- Task: update the darts table and set the score based on the x and y values.

UPDATE darts
  SET score = CASE 
  WHEN x * x + y * y <= 100 THEN 1
  WHEN x * x + y * y <=  25 THEN 5
  WHEN x * x + y * y <=   1 THEN 10
  ELSE 0
END;

UPDATE darts
  SET score = 1
  WHERE x * x + y * y <= 100;

UPDATE darts
  SET score = 5
  WHERE x * x + y * y <= 25;

UPDATE darts
  SET score = 10
  WHERE x * x + y * y <= 1;

