SELECT * 
FROM FollowUpTable
WHERE firstID <> currentID
order by currentID;