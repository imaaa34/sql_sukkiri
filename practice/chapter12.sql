-- 12-2(2)
CREATE TABLE DEPT (
  DEPTNO CHAR(2) PRIMARY KEY,
  DEPTNAME VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE MEMBER (
  DEPTNO CHAR(2) NOT NULL REFERENCES DEPT(DEPTNO),
  EMPNO CHAR(5) NOT NULL REFERENCES EMP(EMPNO),
  PRIMARY KEY(DEPNO, EMPNO)
);

CREATE TABLE EMP (
  EMPNO CHAR(5) PRIMARY KEY,
  EMPNAME VARCHAR(40) NOT NULL,
  POSNO CHAR(1) NOT NULL REFERENCES POS(POSNO),
  AGE INTEGER CHECK(AGE >= 0)
);

CREATE TABLE POS (
  POSNO CHAR(1) PRIMARY KEY,
  POSNAME VARCHAR(10) UNIQUE NOT NULL
);