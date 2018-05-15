USE bankdb;

# Task 1

SELECT * FROM a_accounts
WHERE a_avail_balance < (
  SELECT min(a_avail_balance) FROM a_accounts
  INNER JOIN c_customers ON a_c_cust_nr = c_cust_nr
  WHERE EXISTS (
    SELECT i_fname, i_lname FROM i_individuals
    WHERE
	  i_fname = "Frank" AND
      i_lname = "Tucker" AND
      i_c_cust_nr = c_cust_nr
  )
);

# Task 2
