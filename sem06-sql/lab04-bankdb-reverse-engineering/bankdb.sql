drop database if exists bankdb1;
create database if not exists bankdb1;
use bankdb1;


/* begin table creation */

create table d_departments
 (d_dept_nr smallint unsigned not null auto_increment,
  d_name varchar(20) not null,
  constraint pk_department primary key (d_dept_nr)
 );

create table b_branches
 (b_branch_nr smallint unsigned not null auto_increment,
  b_name varchar(20) not null,
  b_address varchar(30),
  b_city varchar(20),
  b_state varchar(2),
  b_zip varchar(12),
  constraint pk_branch primary key (b_branch_nr)
 );

create table e_employees
 (e_emp_nr smallint unsigned not null auto_increment,
  e_fname varchar(20) not null,
  e_lname varchar(20) not null,
  e_start_date date not null,
  e_end_date date,
  e_superior_emp_id smallint unsigned,
  e_d_dept_nr smallint unsigned,
  e_title varchar(20),
  e_b_assigned_branch_id smallint unsigned,
  constraint fk_e_emp_nr 
    foreign key (e_superior_emp_id) references e_employees (e_emp_nr),
  constraint fk_dept_id
    foreign key (e_d_dept_nr) references d_departments (d_dept_nr),
  constraint fk_e_branch_id
    foreign key (e_b_assigned_branch_id) references b_branches (b_branch_nr),
  constraint pk_employee primary key (e_emp_nr)
 );

create table pt_product_types
 (pt_product_type_id varchar(10) not null,
  pt_name varchar(50) not null,
  constraint pk_product_type primary key (pt_product_type_id)
 );

create table p_products
 (p_product_id varchar(10) not null,
  p_name varchar(50) not null,
  p_pt_product_type_id varchar(10) not null,
  p_date_offered date,
  p_date_retired date,
  constraint fk_product_type_cd foreign key (p_pt_product_type_id) 
    references pt_product_types (pt_product_type_id),
  constraint pk_product primary key (p_product_id)
 );

create table c_customers
 (c_cust_nr integer unsigned not null auto_increment,
  c_fed_id varchar(12) not null,
  c_cust_type_cd enum('I','B') not null,
  c_address varchar(30),
  c_city varchar(20),
  c_state varchar(20),
  c_postal_code varchar(10),
  constraint pk_customer primary key (c_cust_nr)
 );

create table i_individuals
 (i_c_cust_nr integer unsigned not null,
  i_fname varchar(30) not null,
  i_lname varchar(30) not null,
  i_birth_date date,
  constraint fk_i_cust_id foreign key (i_c_cust_nr)
    references c_customers (c_cust_nr),
  constraint pk_individual primary key (i_c_cust_nr)
 );

create table bu_businesses
 (bu_c_cust_nr integer unsigned not null,
  bu_name varchar(40) not null,
  bu_state_id varchar(10) not null,
  bu_incorp_date date,
  constraint fk_b_cust_id foreign key (bu_c_cust_nr)
    references c_customers (c_cust_nr),
  constraint pk_business primary key (bu_c_cust_nr)
 );

create table o_officers
 (o_officer_nr smallint unsigned not null auto_increment,
  o_bu_c_cust_nr integer unsigned not null,
  o_fname varchar(30) not null,
  o_lname varchar(30) not null,
  o_title varchar(20),
  o_start_date date not null,
  o_end_date date,
  constraint fk_o_cust_id foreign key (o_bu_c_cust_nr)
    references bu_businesses (bu_c_cust_nr),
  constraint pk_officer primary key (o_officer_nr)
 );

create table a_accounts
 (a_account_nr integer unsigned not null auto_increment,
  a_p_product_id varchar(10) not null,
  a_c_cust_nr integer unsigned not null,
  a_open_date date not null,
  a_close_date date,
  a_last_activity_date date,
  a_status enum('ACTIVE','CLOSED','FROZEN'),
  a_b_open_branch_id smallint unsigned,
  a_e_open_emp_id smallint unsigned,
  a_avail_balance float(10,2),
  a_pending_balance float(10,2),
  constraint fk_product_cd foreign key (a_p_product_id)
    references p_products (p_product_id),
  constraint fk_a_cust_id foreign key (a_c_cust_nr)
    references c_customers (c_cust_nr),
  constraint fk_a_branch_id foreign key (a_b_open_branch_id)
    references b_branches (b_branch_nr),
  constraint fk_a_emp_id foreign key (a_e_open_emp_id)
    references e_employees (e_emp_nr),
  constraint pk_account primary key (a_account_nr)
 );

create table t_transactions
 (t_txn_nr integer unsigned not null auto_increment,
  t_txn_date datetime not null,
  t_a_account_nr integer unsigned not null,
  t_txn_type_cd enum('DBT','CDT'),
  t_amount double(10,2) not null,
  t_e_teller_emp_id smallint unsigned,
  t_b_execution_branch_id smallint unsigned,
  t_funds_avail_date datetime,
  constraint fk_t_account_id foreign key (t_a_account_nr)
    references a_accounts (a_account_nr),
  constraint fk_teller_emp_id foreign key (t_e_teller_emp_id)
    references e_employees (e_emp_nr),
  constraint fk_exec_branch_id foreign key (t_b_execution_branch_id)
    references b_branches (b_branch_nr),
  constraint pk_transaction primary key (t_txn_nr)
 );

/* end table creation */

/* begin data population */

/* department data */
insert into d_departments 
 (d_dept_nr, d_name)
values 
(null, 'Operations'),
(null, 'Loans'),
(null, 'Administration');

/* branch data */
insert into b_branches 
 (b_branch_nr, b_name, b_address, b_city, b_state, b_zip)
values 
(null, 'Headquarters', '3882 Main St.', 'Waltham', 'MA', '02451'),
(null, 'Woburn Branch', '422 Maple St.', 'Woburn', 'MA', '01801'),
(null, 'Quincy Branch', '125 Presidential Way', 'Quincy', 'MA', '02169'),
(null, 'So. NH Branch', '378 Maynard Ln.', 'Salem', 'NH', '03079');

/* employee data */
insert into e_employees 
 (e_emp_nr, e_fname, e_lname, e_start_date, 
  e_d_dept_nr, e_title, e_b_assigned_branch_id)
values 
(null, 'Michael', 'Smith', '2005-06-22', 
  (select d_dept_nr from d_departments where d_name = 'Administration'), 
  'President', 
  (select b_branch_nr from b_branches where b_name = 'Headquarters')),
(null, 'Susan', 'Barker', '2006-09-12', 
  (select d_dept_nr from d_departments where d_name = 'Administration'), 
  'Vice President', 
  (select b_branch_nr from b_branches where b_name = 'Headquarters')),
(null, 'Robert', 'Tyler', '2005-02-09',
  (select d_dept_nr from d_departments where d_name = 'Administration'), 
  'Treasurer', 
  (select b_branch_nr from b_branches where b_name = 'Headquarters')),
(null, 'Susan', 'Hawthorne', '2006-04-24', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Operations Manager', 
  (select b_branch_nr from b_branches where b_name = 'Headquarters')),
(null, 'John', 'Gooding', '2007-11-14', 
  (select d_dept_nr from d_departments where d_name = 'Loans'), 
  'Loan Manager', 
  (select b_branch_nr from b_branches where b_name = 'Headquarters')),
(null, 'Helen', 'Fleming', '2008-03-17', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Head Teller', 
  (select b_branch_nr from b_branches where b_name = 'Headquarters')),
(null, 'Chris', 'Tucker', '2008-09-15', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Teller', 
  (select b_branch_nr from b_branches where b_name = 'Headquarters')),
(null, 'Sarah', 'Parker', '2006-12-02', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Teller', 
  (select b_branch_nr from b_branches where b_name = 'Headquarters')),
(null, 'Jane', 'Grossman', '2006-05-03', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Teller', 
  (select b_branch_nr from b_branches where b_name = 'Headquarters')),
(null, 'Paula', 'Roberts', '2006-07-27', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Head Teller', 
  (select b_branch_nr from b_branches where b_name = 'Woburn Branch')),
(null, 'Thomas', 'Ziegler', '2004-10-23', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Teller', 
  (select b_branch_nr from b_branches where b_name = 'Woburn Branch')),
(null, 'Samantha', 'Jameson', '2007-01-08', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Teller', 
  (select b_branch_nr from b_branches where b_name = 'Woburn Branch')),
(null, 'John', 'Blake', '2004-05-11', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Head Teller', 
  (select b_branch_nr from b_branches where b_name = 'Quincy Branch')),
(null, 'Cindy', 'Mason', '2006-08-09', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Teller', 
  (select b_branch_nr from b_branches where b_name = 'Quincy Branch')),
(null, 'Frank', 'Portman', '2007-04-01', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Teller', 
  (select b_branch_nr from b_branches where b_name = 'Quincy Branch')),
(null, 'Theresa', 'Markham', '2005-03-15', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Head Teller', 
  (select b_branch_nr from b_branches where b_name = 'So. NH Branch')),
(null, 'Beth', 'Fowler', '2006-06-29', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Teller', 
  (select b_branch_nr from b_branches where b_name = 'So. NH Branch')),
(null, 'Rick', 'Tulman', '2006-12-12', 
  (select d_dept_nr from d_departments where d_name = 'Operations'), 
  'Teller', 
  (select b_branch_nr from b_branches where b_name = 'So. NH Branch'));

/* create data for self-referencing foreign key 'superior_emp_id' */
create temporary table emp_tmp as
select e_emp_nr, e_fname, e_lname from e_employees;

update e_employees set e_superior_emp_id =
 (select e_emp_nr from emp_tmp where e_lname = 'Smith' and e_fname = 'Michael')
where ((e_lname = 'Barker' and e_fname = 'Susan')
  or (e_lname = 'Tyler' and e_fname = 'Robert'));

update e_employees set e_superior_emp_id =
 (select e_emp_nr from emp_tmp where e_lname = 'Tyler' and e_fname = 'Robert')
where e_lname = 'Hawthorne' and e_fname = 'Susan';

update e_employees set e_superior_emp_id =
 (select e_emp_nr from emp_tmp where e_lname = 'Hawthorne' and e_fname = 'Susan')
where ((e_lname = 'Gooding' and e_fname = 'John')
  or (e_lname = 'Fleming' and e_fname = 'Helen')
  or (e_lname = 'Roberts' and e_fname = 'Paula') 
  or (e_lname = 'Blake' and e_fname = 'John') 
  or (e_lname = 'Markham' and e_fname = 'Theresa')); 

update e_employees set e_superior_emp_id =
 (select e_emp_nr from emp_tmp where e_lname = 'Fleming' and e_fname = 'Helen')
where ((e_lname = 'Tucker' and e_fname = 'Chris') 
  or (e_lname = 'Parker' and e_fname = 'Sarah') 
  or (e_lname = 'Grossman' and e_fname = 'Jane'));  

update e_employees set e_superior_emp_id =
 (select e_emp_nr from emp_tmp where e_lname = 'Roberts' and e_fname = 'Paula')
where ((e_lname = 'Ziegler' and e_fname = 'Thomas')  
  or (e_lname = 'Jameson' and e_fname = 'Samantha'));   

update e_employees set e_superior_emp_id =
 (select e_emp_nr from emp_tmp where e_lname = 'Blake' and e_fname = 'John')
where ((e_lname = 'Mason' and e_fname = 'Cindy')   
  or (e_lname = 'Portman' and e_fname = 'Frank'));    

update e_employees set e_superior_emp_id =
 (select e_emp_nr from emp_tmp where e_lname = 'Markham' and e_fname = 'Theresa')
where ((e_lname = 'Fowler' and e_fname = 'Beth')   
  or (e_lname = 'Tulman' and e_fname = 'Rick'));    

drop table emp_tmp;

/* recreate employee self-referencing foreign key */
alter table e_employees drop foreign key fk_e_emp_nr;
alter table e_employees add constraint fk_e_emp_nr
foreign key (e_superior_emp_id) references e_employees (e_emp_nr);

/* product type data */
insert into pt_product_types 
 (pt_product_type_id, pt_name)
values 
('ACCOUNT','Customer Accounts'),
('LOAN','Individual and Business Loans'),
('INSURANCE','Insurance Offerings');

/* product data */
insert into p_products 
 (p_product_id, p_name, p_pt_product_type_id, p_date_offered)
values 
('CHK','checking account','ACCOUNT','2004-01-01'),
('SAV','savings account','ACCOUNT','2004-01-01'),
('MM','money market account','ACCOUNT','2004-01-01'),
('CD','certificate of deposit','ACCOUNT','2004-01-01'),
('MRT','home mortgage','LOAN','2004-01-01'),
('AUT','auto loan','LOAN','2004-01-01'),
('BUS','business line of credit','LOAN','2004-01-01'),
('SBL','small business loan','LOAN','2004-01-01');

/* residential customer data */
insert into c_customers 
 (c_cust_nr, c_fed_id, c_cust_type_cd,
  c_address, c_city, c_state, c_postal_code)
values 
(null, '111-11-1111', 'I', '47 Mockingbird Ln', 'Lynnfield', 'MA', '01940'),
(null, '222-22-2222', 'I', '372 Clearwater Blvd', 'Woburn', 'MA', '01801'),
(null, '333-33-3333', 'I', '18 Jessup Rd', 'Quincy', 'MA', '02169'),
(null, '444-44-4444', 'I', '12 Buchanan Ln', 'Waltham', 'MA', '02451'),
(null, '555-55-5555', 'I', '2341 Main St', 'Salem', 'NH', '03079'),
(null, '666-66-6666', 'I', '12 Blaylock Ln', 'Waltham', 'MA', '02451'),
(null, '777-77-7777', 'I', '29 Admiral Ln', 'Wilmington', 'MA', '01887'),
(null, '888-88-8888', 'I', '472 Freedom Rd', 'Salem', 'NH', '03079'),
(null, '999-99-9999', 'I', '29 Maple St', 'Newton', 'MA', '02458'),
(null, '04-1111111', 'B', '7 Industrial Way', 'Salem', 'NH', '03079'),
(null, '04-2222222', 'B', '287A Corporate Ave', 'Wilmington', 'MA', '01887'),
(null, '04-3333333', 'B', '789 Main St', 'Salem', 'NH', '03079'),
(null, '04-4444444', 'B', '4772 Presidential Way', 'Quincy', 'MA', '02169');

insert into i_individuals 
 (i_c_cust_nr, i_fname, i_lname, i_birth_date)
select c_cust_nr, 'James', 'Hadley', '1977-04-22' 
from c_customers
where c_fed_id = '111-11-1111'
union all
select c_cust_nr, 'Susan', 'Tingley', '1973-08-15' 
from c_customers
where c_fed_id = '222-22-2222'
union all
select c_cust_nr, 'Frank', 'Tucker', '1963-02-06' 
from c_customers
where c_fed_id = '333-33-3333'
union all
select c_cust_nr, 'John', 'Hayward', '1971-12-22' 
from c_customers
where c_fed_id = '444-44-4444'
union all
select c_cust_nr, 'Charles', 'Frasier', '1976-08-25' 
from c_customers
where c_fed_id = '555-55-5555'
union all
select c_cust_nr, 'John', 'Spencer', '1967-09-14' 
from c_customers
where c_fed_id = '666-66-6666'
union all
select c_cust_nr, 'Margaret', 'Young', '1951-03-19' 
from c_customers
where c_fed_id = '777-77-7777'
union all
select c_cust_nr, 'George', 'Blake', '1982-07-01' 
from c_customers
where c_fed_id = '888-88-8888'
union all
select c_cust_nr, 'Richard', 'Farley', '1973-06-16' 
from c_customers
where c_fed_id = '999-99-9999';

/* corporate customer data */
insert into bu_businesses 
 (bu_c_cust_nr, bu_name, bu_state_id, bu_incorp_date)
select c_cust_nr, 'Chilton Engineering', '12-345-678', '1995-05-01' 
from c_customers
where c_fed_id = '04-1111111'
union all
select c_cust_nr, 'Northeast Cooling Inc.', '23-456-789', '2001-01-01' 
from c_customers
where c_fed_id = '04-2222222'
union all
select c_cust_nr, 'Superior Auto Body', '34-567-890', '2002-06-30' 
from c_customers
where c_fed_id = '04-3333333'
union all
select c_cust_nr, 'AAA Insurance Inc.', '45-678-901', '1999-05-01' from c_customers
where c_fed_id = '04-4444444';


insert into o_officers 
 (o_officer_nr, o_bu_c_cust_nr, o_fname, o_lname, o_title, o_start_date)
select null, c_cust_nr, 'John', 'Chilton', 'President', '1995-05-01'
from c_customers
where c_fed_id = '04-1111111'
union all
select null, c_cust_nr, 'Paul', 'Hardy', 'President', '2001-01-01'
from c_customers
where c_fed_id = '04-2222222'
union all
select null, c_cust_nr, 'Carl', 'Lutz', 'President', '2002-06-30'
from c_customers
where c_fed_id = '04-3333333'
union all
select null, c_cust_nr, 'Stanley', 'Cheswick', 'President', '1999-05-01'
from c_customers
where c_fed_id = '04-4444444';

/* residential account data */
insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,  a_last_activity_date, a_status, a_b_open_branch_id,  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE', e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Woburn' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2000-01-15' open_date, '2005-01-04' last_date,
    1057.75 avail, 1057.75 pend union all
  select 'SAV' prod_cd, '2000-01-15' open_date, '2004-12-19' last_date,
    500.00 avail, 500.00 pend union all
  select 'CD' prod_cd, '2004-06-30' open_date, '2004-06-30' last_date,
    3000.00 avail, 3000.00 pend) a
where c.c_fed_id = '111-11-1111';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Woburn' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2001-03-12' open_date, '2004-12-27' last_date,
    2258.02 avail, 2258.02 pend union all
  select 'SAV' prod_cd, '2001-03-12' open_date, '2004-12-11' last_date,
    200.00 avail, 200.00 pend) a
where c.c_fed_id = '222-22-2222';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Quincy' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2002-11-23' open_date, '2004-11-30' last_date,
    1057.75 avail, 1057.75 pend union all
  select 'MM' prod_cd, '2002-12-15' open_date, '2004-12-05' last_date,
    2212.50 avail, 2212.50 pend) a
where c.c_fed_id = '333-33-3333';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2003-09-12' open_date, '2005-01-03' last_date,
    534.12 avail, 534.12 pend union all
  select 'SAV' prod_cd, '2000-01-15' open_date, '2004-10-24' last_date,
    767.77 avail, 767.77 pend union all
  select 'MM' prod_cd, '2004-09-30' open_date, '2004-11-11' last_date,
    5487.09 avail, 5487.09 pend) a
where c.c_fed_id = '444-44-4444';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2004-01-27' open_date, '2005-01-05' last_date,
    2237.97 avail, 2897.97 pend) a
where c.c_fed_id = '555-55-5555';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2002-08-24' open_date, '2004-11-29' last_date,
    122.37 avail, 122.37 pend union all
  select 'CD' prod_cd, '2004-12-28' open_date, '2004-12-28' last_date,
    10000.00 avail, 10000.00 pend) a
where c.c_fed_id = '666-66-6666';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Woburn' limit 1) e
  cross join
 (select 'CD' prod_cd, '2004-01-12' open_date, '2004-01-12' last_date,
    5000.00 avail, 5000.00 pend) a
where c.c_fed_id = '777-77-7777';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2001-05-23' open_date, '2005-01-03' last_date,
    3487.19 avail, 3487.19 pend union all
  select 'SAV' prod_cd, '2001-05-23' open_date, '2004-10-12' last_date,
    387.99 avail, 387.99 pend) a
where c.c_fed_id = '888-88-8888';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2003-07-30' open_date, '2004-12-15' last_date,
    125.67 avail, 125.67 pend union all
  select 'MM' prod_cd, '2004-10-28' open_date, '2004-10-28' last_date,
    9345.55 avail, 9845.55 pend union all
  select 'CD' prod_cd, '2004-06-30' open_date, '2004-06-30' last_date,
    1500.00 avail, 1500.00 pend) a
where c.c_fed_id = '999-99-9999';

/* corporate account data */
insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2002-09-30' open_date, '2004-12-15' last_date,
    23575.12 avail, 23575.12 pend union all
  select 'BUS' prod_cd, '2002-10-01' open_date, '2004-08-28' last_date,
    0 avail, 0 pend) a
where c.c_fed_id = '04-1111111';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Woburn' limit 1) e
  cross join
 (select 'BUS' prod_cd, '2004-03-22' open_date, '2004-11-14' last_date,
    9345.55 avail, 9345.55 pend) a
where c.c_fed_id = '04-2222222';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, '2003-07-30' open_date, '2004-12-15' last_date,
    38552.05 avail, 38552.05 pend) a
where c.c_fed_id = '04-3333333';

insert into a_accounts (a_account_nr, a_p_product_id, a_c_cust_nr, a_open_date,
  a_last_activity_date, a_status, a_b_open_branch_id,
  a_e_open_emp_id, a_avail_balance, a_pending_balance)
select null, a.prod_cd, c.c_cust_nr, a.open_date, a.last_date, 'ACTIVE',
  e.b_branch_nr, e.e_emp_nr, a.avail, a.pend
from c_customers c cross join 
 (select b.b_branch_nr, e.e_emp_nr 
  from b_branches b inner join e_employees e on e.e_b_assigned_branch_id = b.b_branch_nr
  where b.b_city = 'Quincy' limit 1) e
  cross join
 (select 'SBL' prod_cd, '2004-02-22' open_date, '2004-12-17' last_date,
    50000.00 avail, 50000.00 pend) a
where c.c_fed_id = '04-4444444';

/* put $100 in all checking/savings accounts on Jan 5th, 2008 */
insert into t_transactions (t_txn_nr, t_txn_date, t_a_account_nr, t_txn_type_cd,
  t_amount, t_funds_avail_date)
select null, '2008-01-05', a.a_account_nr, 'DBT', 100, '2008-01-05'
from a_accounts a
where a.a_p_product_id IN ('CHK','SAV','CD','MM');

/* end data population */