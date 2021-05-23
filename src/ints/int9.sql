.mode columns
.headers on
.nullvalue NULL

-- What is the longest chain of occurrences per hospital of first occurrence?

SELECT id AS idOfFirstAppointment, cc1 AS cc, name1 AS name, hospital1 AS hospitalOfFirstAppointment, dateOfFirstAppointment, dateOfLastAppointment, followUpLenght1 AS followUpLenght FROM (
    SELECT id, cc AS cc1, name AS name1, hospital AS hospital1, date AS dateOfFirstAppointment, followUpLenght AS followUpLenght1 FROM (
    SELECT * FROM Person JOIN (   
        SELECT id, date, patient AS cc, hospital, MAX(lenght) AS followUpLenght 
        FROM (
            SELECT *
            FROM Ocurrence JOIN (
                SELECT firstID AS id, currentID, lenght 
                FROM FollowUpTable) 
            USING(id) 
            WHERE followUp NOT NULL) 
        GROUP BY(hospital))
    USING(cc)
    )
) JOIN (
    SELECT firstID AS id, id AS currentID, name, date AS dateOfLastAppointment, cc, hospital, followUpLenght FROM (
        SELECT * FROM person JOIN (
            SELECT firstID, id, date, patient AS cc, hospital, lenght AS followUpLenght
            FROM (
                SELECT * FROM Ocurrence JOIN (
                    SELECT firstID, currentID AS id, lenght
                    FROM FollowUpTable
                ) USING (id)
            )
        ) USING(cc)
    )
) USING(id);
