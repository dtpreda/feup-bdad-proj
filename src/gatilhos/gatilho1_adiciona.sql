CREATE TRIGGER IF NOT EXISTS followUpFirstInsert
AFTER INSERT ON Ocurrence
WHEN NEW.followUp IS NULL
BEGIN
    INSERT INTO FollowUpTable(firstID, currentID, lenght) values (NEW.id, NEW.id, 1);
END;

CREATE TRIGGER IF NOT EXISTS followUpInsert
AFTER INSERT ON Ocurrence
WHEN NEW.followUp NOT NULL
BEGIN
    INSERT INTO FollowUpTable(firstID, currentID, lenght) values (NEW.id, NEW.followUp, 2);
    UPDATE FollowUpTable
    SET currentID = NEW.followUp, lenght = lenght + 1
    WHERE currentID = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS followUpUpdate
AFTER UPDATE ON Ocurrence
WHEN NEW.followUp NOT NULL
BEGIN
    UPDATE FollowUpTable
    SET currentID = NEW.followUp, lenght = lenght + 1
    WHERE currentID = NEW.id;
END;