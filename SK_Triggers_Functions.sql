use synthea;
show tables;

CREATE TABLE sayedakhan_patients (
id INT AUTO_INCREMENT PRIMARY KEY,
patientUID INT NOT NULL,
lastname VARCHAR(50) NOT NULL,
zipcode INT NOT NULL,
SSN INT NOT NULL);


INSERT INTO synthea.sayedakhan_patients (patientUID, lastname, zipcode, SSN) VALUES (0001, 'Chong', 10465, 3678);
INSERT INTO synthea.sayedakhan_patients (patientUID, lastname, zipcode, SSN) VALUES (0002, 'Lamond', 11042, 1997);
INSERT INTO synthea.sayedakhan_patients (patientUID, lastname, zipcode, SSN) VALUES (0003, 'Scott', 11790, 5633);
INSERT INTO synthea.sayedakhan_patients (patientUID, lastname, zipcode, SSN) VALUES (0004, 'Uriarte', 11428, 8991);
INSERT INTO synthea.sayedakhan_patients (patientUID, lastname, zipcode, SSN) VALUES (0005, 'Williams', 11790, 1121);

SELECT * FROM sayedakhan_patients

delimiter $$
CREATE TRIGGER foreignzipcode BEFORE INSERT ON synthea.sayedakhan_patients
FOR EACH ROW
BEGIN
	IF NEW.zipcode > 11697 THEN
	   SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'ERROR: Zipcode must be in NYC!';
    END IF;
END; $$
delimiter ;

INSERT INTO synthea.sayedakhan_patients
(patientUID, lastname, zipcode, ssn) VALUES (0010, 'Chavez', 11698, 7772);

Error Code: 1644. ERROR: Zipcode must be in NYC!

SELECT * FROM patients;

DELIMITER $$
CREATE FUNCTION TotalPatientCost(cost DECIMAL(10,2))
RETURNS VARCHAR(20)
BEGIN
DECLARE patientCost VARCHAR(20);
IF cost>=10000 THEN
SET patientCost = 'high';
ELSEIF cost < 10000 THEN
SET patientCost = 'low';
END IF;
RETURN (patientCost);
END
$$
DELIMITER;


SELECT
Id,
BIRTHDATE,
LAST, 
HEALTHCARE_EXPENSES,
TotalPatientCost(HEALTHCARE_EXPENSES)
FROM
patients;