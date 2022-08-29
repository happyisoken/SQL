Use sales;

Create table Companies
(
company_id varchar(255),
company_name varchar(255),
headquarters_phone_number int(12)
);

DROP TABLE Companies;
USE Sales;

Create table Companies
(
company_id varchar(255),
company_name varchar(255),
headquarters_phone_number varchar(255)
);

ALTER Table Companies
ADD UNIQUE KEY (headquarters_phone_number);

ALTER TABLE Companies
CHANGE COLUMN company_name company_name VARCHAR(255) DEFAULT 0;

ALTER TABLE Companies
MODIFY Headquarters_phone_number VARCHAR(255) NULL;

ALTER TABLE Companies
MODIFY Company_ID VARCHAR(255) NOT NULL;

SELECT * from Companies


