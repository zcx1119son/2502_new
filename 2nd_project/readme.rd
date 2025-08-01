CREATE TABLE tb_calendar (
    event_id            number              GENERATED ALWAYS AS IDENTITY NOT NULL,
    event_title         varchar2(60)        NOT NULL,
    member_name         varchar2(20)        NOT NULL,
    event_content       varchar2(500)       NOT NULL,
    company_name        varchar2(10)        NOT NULL,
    client_note         varchar2(200)       ,
    event_start_date    date                DEFAULT SYSDATE,
    event_end_date      date                DEFAULT SYSDATE,
    product_id          number              NOT NULL,
    product_name        varchar2(60)        NOT NULL,
    created_date        date                DEFAULT SYSDATE,
    created_id          varchar2(100)       ,
    updated_date        date                DEFAULT SYSDATE,
    updated_id          varchar2(100)       ,
    priority            varchar2(10)        ,
    CONSTRAINT tb_calendar_pk PRIMARY KEY(event_id)
);

CREATE TABLE tb_client(
    client_id           NUMBER          GENERATED ALWAYS AS IDENTITY    NOT NULL,
    client_name         VARCHAR2(40)    NOT NULL,
    client_address      VARCHAR2(60)    NOT NULL,
    client_phone        VARCHAR2(13)    NOT NULL,
    member_id           NUMBER          ,
    client_note         VARCHAR2(200)   ,
    created_date        DATE            DEFAULT SYSDATE,
    created_id          VARCHAR2(100)   ,
    updated_data        DATE            DEFAULT SYSDATE,
    updated_id          VARCHAR2(100)   ,
    CONSTRAINT tb_client_pk PRIMARY KEY(client_id)
);

CREATE TABLE tb_company(
    company_code        VARCHAR2(10)    NOT NULL,
    company_name        VARCHAR2(40)    NOT NULL,
    company_email       VARCHAR2(40)    NOT NULL,
    company_pwd         VARCHAR2(50)    NOT NULL,
    company_ownername   VARCHAR2(40)    NOT NULL,
    company_phone       VARCHAR2(13)    NOT NULL,
    created_date        DATE            DEFAULT SYSDATE,
    created_id          VARCHAR2(100)   ,
    updated_data        DATE            DEFAULT SYSDATE,
    updated_id          VARCHAR2(100)   ,
    CONSTRAINT tb_company_pk PRIMARY KEY(company_code)
);

create table tb_member(
    member_id       NUMBER          GENERATED ALWAYS AS IDENTITY    NOT NULL,
    member_email    VARCHAR2(40)    NOT NULL,
    member_pwd      VARCHAR2(20)    NOT NULL,
    company_code    VARCHAR2(10)    NOT NULL,
    member_phone    VARCHAR2(13)    NOT NULL,
    member_name     VARCHAR2(12)    NOT NULL,
    emp_id          NUMBER          ,
    created_date    DATE            DEFAULT SYSDATE,
    created_id      VARCHAR2(100)   ,
    updated_data    DATE            DEFAULT SYSDATE,
    updated_id      VARCHAR2(100)   ,
    CONSTRAINT tb_member_pk PRIMARY KEY(member_id)
);

CREATE TABLE tb_product (
    product_id          NUMBER          GENERATED ALWAYS AS IDENTITY,
    product_name        VARCHAR2(64)    NOT NULL,
    client_id           NUMBER          NOT NULL,
    product_count       NUMBER          NOT NULL,
    product_status      NUMBER(2)       DEFAULT 0,
    created_date        DATE            DEFAULT SYSDATE,
    created_id          VARCHAR2(100)   ,
    updated_data        DATE            DEFAULT SYSDATE,
    updated_id          VARCHAR2(100)   ,
    CONSTRAINT  tb_product_pk PRIMARY KEY(product_id)
);

CREATE TABLE tb_receiving (
    receiving_id        NUMBER          GENERATED ALWAYS AS IDENTITY    NOT NULL,
    product_id          NUMBER          NOT NULL,
    client_id           NUMBER          NOT NULL,
    member_id           NUMBER          ,
    receiving_count     NUMBER          NOT NULL,
    receiving_status    NUMBER(2)       DEFAULT 0, --0은 입고전 1은 입고 완료 입고가 완료되면 receiving_count에 tb_product product_count에 가산됨
    receiving_delay     NUMBER          ,
    created_date        DATE            DEFAULT SYSDATE,
    created_id          VARCHAR2(100)   ,
    updated_data        DATE            DEFAULT SYSDATE,
    updated_id          VARCHAR2(100)   ,
    CONSTRAINT tb_receiving_pk PRIMARY KEY(receiving_id)
);

CREATE TABLE tb_shipping (
    shipping_id         NUMBER          GENERATED ALWAYS AS IDENTITY NOCACHE NOCYCLE,
    product_id          NUMBER          NOT NULL,
    client_id           NUMBER          NOT NULL,
    member_id           NUMBER          ,
    shipping_count      NUMBER          NOT NULL,
    shipping_state      NUMBER(2)       DEFAULT 0,
    created_date        DATE            DEFAULT SYSDATE,
    created_id          VARCHAR2(100)   ,
    updated_data        DATE            DEFAULT SYSDATE,
    updated_id          VARCHAR2(100)   ,
    CONSTRAINT tb_shipping_pk PRIMARY KEY(shipping_id)
);

CREATE TABLE tb_emp (
    emp_id      NUMBER      GENERATED ALWAYS AS IDENTITY NOCACHE NOCYCLE,
    member_id   NUMBER      NOT NULL,
    CONSTRAINT tb_emp_pk PRIMARY KEY(emp_id)
);

CREATE TABLE tb_department (
    department_id       NUMBER          GENERATED ALWAYS AS IDENTITY NOCACHE NOCYCLE,
    department_name     VARCHAR2(20)    NOT NULL,
    CONSTRAINT tb_department_pk PRIMARY KEY(department_id)
);

CREATE TABLE tb_audit (
    aidit_id        NUMBER      GENERATED ALWAYS AS IDENTITY NOCACHE NOCYCLE,
    company_name    NUMBER,
    CONSTRAINT tb_audit_pk PRIMARY KEY(aidit_id)
);

