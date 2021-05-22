.mode columns
.headers on
.nullvalue NULL


Select id as idOfFirstAppointment, cc1 as cc, name1 as name, hospital1 as hospital, dateOfFirstAppointment, dateOfLastAppointment, followUpLenght1 as followUpLenght FROM (
    Select id, cc as cc1, name as name1, hospital as hospital1, date as dateOfFirstAppointment, followUpLenght as followUpLenght1 from (
    Select * from Person join (   
        SELECT id, date, patient as cc, hospital, max(lenght) as followUpLenght 
        FROM (
            SELECT *
            FROM Ocurrence join (
                select firstID as id, currentID, lenght 
                from FollowUpTable) 
            using(id) 
            WHERE followUp NOT NULL) 
        group by(hospital))
    using(cc)
    )
) join (
    Select firstID as id, id as currentID, name, date as dateOfLastAppointment, cc, hospital, followUpLenght from (
        select * From person join (
            SELECT firstID, id, date, patient as cc, hospital, lenght as followUpLenght
            FROM (
                SELECT * from Ocurrence join (
                    select firstID, currentID as id, lenght
                    from FollowUpTable
                ) using (id)
                )
        ) using(cc)
    )
) using(id) ;
