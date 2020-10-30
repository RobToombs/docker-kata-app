SET ROLE postgres;

CREATE TABLE dog
(
    id                  BIGSERIAL    PRIMARY KEY      NOT NULL,
    url                 TEXT         DEFAULT ''       NOT NULL,
    breed               TEXT         DEFAULT ''       NOT NULL,
    liked               BOOLEAN      DEFAULT NULL,
    create_date_time    TIMESTAMP    DEFAULT now(),
    update_date_time    TIMESTAMP    DEFAULT now(),
    UNIQUE (id, url)
);