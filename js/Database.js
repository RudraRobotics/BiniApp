function dbInit()
{
    var db = LocalStorage.openDatabaseSync("BINI_APP_DB", "", "Local Sql database for Bini app", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('PRAGMA foreign_keys = OFF')
            tx.executeSql('DROP TABLE IF EXISTS  robot')
            tx.executeSql('DROP TABLE IF EXISTS mission')
            tx.executeSql('DROP TABLE IF EXISTS mission_points')
            tx.executeSql('CREATE TABLE IF NOT EXISTS robot (robot_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,connection TEXT NOT NULL)')
            tx.executeSql('CREATE TABLE IF NOT EXISTS mission (mission_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)')
            tx.executeSql('CREATE TABLE IF NOT EXISTS mission_points (mission_pnt_id INTEGER PRIMARY KEY AUTOINCREMENT, mission_id INTEGER NOT NULL, name TEXT NOT NULL, x INTEGER NOT NULL, y INTEGER NOT NULL, FOREIGN KEY (mission_id) REFERENCES mission (mission_id))')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("BINI_APP_DB", "", "Local Sql database for Bini app", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsertMission(name, wayPntListArray)
{
    var db = dbGetHandle()
    var mission_id = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO mission (name) VALUES(?)', [name])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        mission_id = result.insertId
    })
    db.transaction(function (tx) {
        for (var i = 0; i < wayPntListArray.length; i++) {
            tx.executeSql('INSERT INTO mission_points (mission_id, name, x, y) VALUES(?, ?, ?, ?)',
                          [mission_id,
                           wayPntListArray[i].name,
                           wayPntListArray[i].x,
                           wayPntListArray[i].y
                          ])
        }
    })
    return mission_id;
}

function dbInsertRobot(name, address)
{
    var db = dbGetHandle()
    var robot_id = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO robot (name, connection) VALUES(?, ?)', [name, address])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        robot_id = result.insertId
    })
    return robot_id;
}

function dbReadMissions()
{
    var db = dbGetHandle()
    var results
    db.transaction(function (tx) {
        const query = 'SELECT mission_id, name FROM mission';
        results = tx.executeSql(query)
    })
    return results
}

function dbReadRobots()
{
    var db = dbGetHandle()
    var results
    db.transaction(function (tx) {
        results = tx.executeSql('SELECT robot_id, name, connection FROM robot')
    })
    return results
}

function dbReadWayPnts(mission_id)
{
    var db = dbGetHandle()
    var results
    db.transaction(function (tx) {
        results = tx.executeSql('SELECT mission_pnt_id, name, x, y FROM mission_points WHERE mission_id=?', [mission_id])
    })
    return results
}

function dbRemoveRobot(robot_id)
{
    var db = dbGetHandle()
    var results
    db.transaction(function (tx) {
        results = tx.executeSql('DELETE FROM robot WHERE robot_id = ?', [robot_id])
    })
    return results
}

function dbRemoveMission(mission_id)
{
    var db = dbGetHandle()
    var results
    db.transaction(function (tx) {
        results = tx.executeSql('DELETE FROM mission_points WHERE mission_id = ?', [mission_id])
    })
    db.transaction(function (tx) {
        results = tx.executeSql('DELETE FROM mission WHERE mission_id = ?', [mission_id])
    })
    return results
}

function dbRemoveWayPnt(waypnt_id)
{
    var db = dbGetHandle()
    var results
    try {
        db.transaction(function (tx) {
            results = tx.executeSql('DELETE FROM mission_points WHERE mission_pnt_id = ?', [waypnt_id])
        })
        return results
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
    return results
}
