CREATE TABLE FactBilling
(
    rowid integer NOT NULL,
    customerid integer NOT NULL,
    monthid integer NOT NULL,
    billedamount integer NOT NULL,
    PRIMARY KEY (rowid)
);

CREATE TABLE DimMonth
(
    monthid integer NOT NULL,
    year integer NOT NULL,
    month integer NOT NULL,
    monthname char NOT NULL,
    quarter integer NOT NULL,
    quartername char NOT NULL,
    PRIMARY KEY (monthid)
);

CREATE TABLE DimCustomer
(
    customerid integer NOT NULL,
    category char NOT NULL,
    country char NOT NULL,
    industry char NOT NULL,
    PRIMARY KEY (customerid)
);

ALTER TABLE FactBilling
    ADD 
    FOREIGN KEY (customerid) REFERENCES DimCustomer (customerid) ON DELETE CASCADE;

ALTER TABLE FactBilling
    ADD FOREIGN KEY (monthid)
    REFERENCES DimMonth (monthid) ON DELETE CASCADE;
