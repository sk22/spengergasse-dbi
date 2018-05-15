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

SELECT * FROM c_customers
WHERE (
  SELECT count(a_account_nr) FROM a_accounts
  WHERE a_c_cust_nr = c_cust_nr
) = 2;
