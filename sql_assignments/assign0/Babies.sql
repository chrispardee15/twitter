use cpardee;

CREATE TABLE Babies (
        Name varchar(30) NOT NULL,
        Sex varchar(1) NOT NULL,
	Count int NOT NULL,
       	RowID int AUTO_INCREMENT,
        PRIMARY KEY (RowID)     );

/*mysqlimport --yob2013.txt'
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES;*/



