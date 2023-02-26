CREATE TABLE IF NOT EXISTS companies (
                                         id INT AUTO_INCREMENT PRIMARY KEY,
                                         name VARCHAR(255) NOT NULL,
                                         country VARCHAR(255) NOT NULL,
                                         founding_date DATETIME NOT NULL,
                                         description TEXT NOT NULL,
                                         company_id INT NOT NULL
);

SET @json_companies = LOAD_FILE('/docker-entrypoint-initdb.d/challenge_companies.json');
INSERT INTO companies(name, country, founding_date, description, company_id)
SELECT
    name, country, founding_date, description, company_id
FROM
    JSON_TABLE(@json_companies, '$.*' COLUMNS (
        name VARCHAR(255) PATH '$.name',
        country VARCHAR(255) PATH '$.country',
        founding_date DATETIME PATH '$.founding_date',
        description TEXT PATH '$.description',
        company_id INT PATH '$.company_id'
        )) AS jt;

CREATE TABLE IF NOT EXISTS deals (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     date DATETIME NOT NULL,
                                     funding_amount FLOAT NOT NULL,
                                     funding_round VARCHAR(255) NOT NULL,
                                     company_id INT NOT NULL,
                                     FOREIGN KEY (company_id) REFERENCES companies(id)
);

SET @json_deals = LOAD_FILE('/docker-entrypoint-initdb.d/challenge_deals.json');
INSERT INTO deals(date, funding_amount, funding_round, company_id)
SELECT
    FROM_UNIXTIME(date/1000), funding_amount, funding_round, company_id
FROM
    JSON_TABLE(@json_deals, '$.*' COLUMNS (
        date INT PATH '$.date',
        funding_amount FLOAT PATH '$.funding_amount',
        funding_round VARCHAR(255) PATH '$.funding_round',
        company_id INT PATH '$.company_id'
        )) AS jt;
