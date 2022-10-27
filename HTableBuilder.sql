CREATE SCHEMA IF NOT EXISTS `hBase`;

CREATE TABLE IF NOT EXISTS hBase.part(
	p_partkey varchar(255) NOT NULL,
    p_name varchar(55) NOT NULL,
    p_mfgr char(25) NOT NULL,
    p_brand char(10) NOT NULL,
    p_type varchar(25) NOT NULL,
    p_size INT NOT NULL,
    p_container char(10) NOT NULL,
    p_retailprice decimal(10,0) NOT NULL,
    p_comment varchar(23),
    PRIMARY KEY (p_partkey)
);

CREATE TABLE IF NOT EXISTS hBase.region(
	r_regionkey varchar(255) NOT NULL,
    r_name char(25) NOT NULL,
    r_comment varchar(152) NOT NULL,
    PRIMARY KEY (r_regionkey)
);

CREATE TABLE IF NOT EXISTS hBase.nation(
	n_nationkey varchar(255) NOT NULL,
    n_name char(25) NOT NULL,
    n_regionkey varchar(255) NOT NULL,
    n_comment varchar(152) NOT NULL,
    
    FOREIGN KEY (n_regionkey)
        REFERENCES hBase.region (r_regionkey),
    PRIMARY KEY (n_nationkey)
);

CREATE TABLE IF NOT EXISTS hBase.customer(
	c_custkey varchar(255) NOT NULL,
    c_name char(25) NOT NULL,
    c_address varchar(40) NOT NULL,
    c_nationkey varchar(255) NOT NULL,
    c_phone char(15) NOT NULL,
    c_acctbal decimal(10,0) NOT NULL,
    c_mktsegment char(10) NOT NULL,
    c_comment varchar(152) NOT NULL,
    
    PRIMARY KEY (c_custkey)
);

CREATE TABLE IF NOT EXISTS hBase.supplier(
	s_suppkey varchar(255) NOT NULL,
    s_name char(25) NOT NULL,
    s_address varchar(40) NOT NULL,
    s_nationkey varchar(255) NOT NULL,
    s_phone char(15) NOT NULL,
    s_acctbal decimal(10,0) NOT NULL,
    s_comment varchar(101) NOT NULL,
    FOREIGN KEY (s_nationkey)
        REFERENCES hBase.nation (n_nationkey),
    PRIMARY KEY (s_suppkey)
);

CREATE TABLE IF NOT EXISTS hBase.partsupp(
	ps_partkey varchar(255) NOT NULL,
    ps_suppkey varchar(255) NOT NULL,
    ps_availqty INT NOT NULL,
    ps_supplycost decimal(10,0) NOT NULL,
    ps_comment varchar(101) NOT NULL,
    FOREIGN KEY (ps_partkey)
        REFERENCES hBase.part (p_partkey),
    FOREIGN KEY (ps_suppkey)
        REFERENCES hBase.supplier (s_suppkey),   
    PRIMARY KEY (ps_partkey,ps_suppkey)
);

CREATE TABLE IF NOT EXISTS hBase.orders(
	o_orderkey varchar(255) NOT NULL,
    o_custkey varchar(255) NOT NULL,
    o_orderstatus char(1) NOT NULL,
    o_totalprice DECIMAL(10,0) NOT NULL,
    o_orderdate DATE NOT NULL,
    o_orderpriority char(15) NOT NULL,
    o_clerk char(15) NOT NULL,
    o_shippriority int NOT NULL,
    o_comment varchar(79) NOT NULl,
    FOREIGN KEY (o_custkey)
        REFERENCES hBase.customer (c_custkey),
    PRIMARY KEY (o_orderkey)
);

CREATE TABLE IF NOT EXISTS hBase.lineitem(
	l_orderkey varchar(255) NOT NULL,
    l_partkey varchar(255) NOT NULL,
    l_supplykey varchar(255) NOT NULL,
    l_linenumber int NOT NULL,
    l_quantity DECIMAL(10,0) NOT NULL,
    l_extendedprice DECIMAL(10,0) NOT NULL,
    l_discount DECIMAL(10,0) NOT NULL,
    l_tax DECIMAL(10,0) NOT NULL,
    l_returnflag char(1) NOT NULl,
    l_linestatus char(1) NOT NULl,
    l_shipdate DATE NOT NULl,
    l_commitdate DATE NOT NULl,
    l_receiptdate DATE NOT NULl,
    l_shipinstruct char(25) NOT NULl,
    l_shipmode char(10) NOT NULl,
    l_comment varchar(40) NOT NULl,
    FOREIGN KEY (l_orderkey)
        REFERENCES hBase.orders (o_orderkey),
    FOREIGN KEY (l_partkey)
        REFERENCES hBase.part (p_partkey),
    FOREIGN KEY (l_supplykey)
        REFERENCES hBase.supplier (s_suppkey), 
    PRIMARY KEY (l_orderkey,l_linenumber)
);