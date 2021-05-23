.mode columns
.headers on
.nullvalue NULL

-- What is the longest chain of occurrences per hospital of first occurrence?

SELECT id AS idOfFirstAppointment, cc1 AS cc, name1 AS name, hospital1 AS hospitalOfFirstAppointment, dateOfFirstAppointment, dateOfLastAppointment, followUpLength1 AS followUpLength FROM (
    SELECT id, cc AS cc1, name AS name1, hospital AS hospital1, date AS dateOfFirstAppointment, followUpLength AS followUpLength1 FROM (
    SELECT * FROM Person JOIN (   
        SELECT id, date, patient AS cc, hospital, MAX(length) AS followUpLength 
        FROM (
            SELECT *
            FROM Ocurrence JOIN (
                SELECT firstID AS id, currentID, length 
                FROM FollowUpTable) 
            USING(id) 
            WHERE followUp NOT NULL) 
        GROUP BY(hospital))
    USING(cc)
    )
) JOIN (
    SELECT firstID AS id, id AS currentID, name, date AS dateOfLastAppointment, cc, hospital, followUpLength FROM (
        SELECT * FROM person JOIN (
            SELECT firstID, id, date, patient AS cc, hospital, length AS followUpLength
            FROM (
                SELECT * FROM Ocurrence JOIN (
                    SELECT firstID, currentID AS id, length
                    FROM FollowUpTable
                ) USING (id)
            )
        ) USING(cc)
    )
) USING(id)
ORDER BY followUpLength DESC;
