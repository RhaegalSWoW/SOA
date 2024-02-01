-- DB update 2020_08_19_02 -> 2020_08_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_19_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_19_02 2020_08_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1595112699414325989'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595112699414325989');

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE guid IN (36738, 182011, 142088, 176484, 176485, 176486, 176487);
UPDATE `gameobject` SET `spawntimesecs`=180 WHERE guid IN (182199, 176249, 177287);
UPDATE `gameobject` SET `spawntimesecs`=300 WHERE guid IN (20726, 19284, 19283, 103664, 142477, 13949, 177964, 91138, 113757, 125477);
UPDATE `gameobject` SET `spawntimesecs`=7200 WHERE guid = 179545;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;