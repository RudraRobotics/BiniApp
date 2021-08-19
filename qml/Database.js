
// Initialize local sqllite database
function dbInit()
{
    var db = LocalStorage.openDatabaseSync("BINI_APP_DB", "", "Local Sql database for Bini app", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('PRAGMA foreign_keys = ON')
            tx.executeSql('DROP TABLE IF EXISTS  robot')
            tx.executeSql('CREATE TABLE IF NOT EXISTS robot (robot_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,connection TEXT NOT NULL)')
            tx.executeSql('DROP TABLE IF EXISTS mission')
            tx.executeSql('CREATE TABLE IF NOT EXISTS mission (mission_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)')
            tx.executeSql('DROP TABLE IF EXISTS mission_points')
            tx.executeSql('CREATE TABLE IF NOT EXISTS mission_points (mission_pnt_id INTEGER PRIMARY KEY AUTOINCREMENT, mission_id INTEGER NOT NULL, name TEXT NOT NULL, x INTEGER NOT NULL, y INTEGER NOT NULL, FOREIGN KEY (mission_id) REFERENCES mission (mission_id))')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

// Get the object handler of local sqllite database
function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("BINI_APP_DB", "", "Local Sql database for Bini app", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsertMission(name)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO mission (name) VALUES(?)', [name])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
//    var loc_id = dbInsertMissionPnts(rowid, 'loc1', 1.1, 3.3)
    areaListModel.append({
                        mission_name: name
                     })
//    return rowid;
}

function dbInsertMissionPnts(mission_id, name, x, y)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO mission_points (mission_id, name, x, y) VALUES(?, ?, ?, ?)', [mission_id, name, x, y])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

function dbUpdateListView() {
//    var db = dbGetHandle()
//    areaListModel.clear()
//    db.transaction(function (tx) {
//        const query = 'SELECT mission.mission_id, mission_points.mission_pnt_id, mission.name as mission_name, mission_points.name as loc_name, mission_points.x, mission_points.y FROM mission, mission_points WHERE mission.mission_id = mission_points.mission_id';
//        var results = tx.executeSql(query)
//        for (var i = 0; i < results.rows.length; i++) {
//            areaListModel.append({
//                                mission_id: results.rows.item(i).mission_id,
//                                loc_id: results.rows.item(i).mission_pnt_id,
//                                mission_name: results.rows.item(i).mission_name,
//                                loc_name: results.rows.item(i).loc_name,
//                                x: results.rows.item(i).x,
//                                y: results.rows.item(i).y
//                             })
//        }
//    })
}

function dbReadMissions()
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        const query = 'SELECT name FROM mission';
        var results = tx.executeSql(query)
        for (var i = 0; i < results.rows.length; i++) {
            areaListModel.append({
                                  mission_name: results.rows.item(i).name
                                })
        }
    })
}

function dbReadAll()
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        const query = 'SELECT mission.mission_id, mission_points.mission_pnt_id, mission.name as mission_name, mission_points.name as loc_name, mission_points.x, mission_points.y FROM mission, mission_points WHERE mission.mission_id = mission_points.mission_id';
        var results = tx.executeSql(query)
        for (var i = 0; i < results.rows.length; i++) {
            areaListModel.append({
                                 mission_id: results.rows.item(i).mission_id,
                                 loc_id: results.rows.item(i).mission_pnt_id,
                                 mission_name: results.rows.item(i).mission_name,
                                 loc_name: results.rows.item(i).loc_name,
                                 x: results.rows.item(i).x,
                                 y: results.rows.item(i).y
                             })
        }
    })
}

function dbUpdate(Pdate, Pdesc, Pdistance, Prowid)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql(
                    'update trip_log set date=?, trip_desc=?, distance=? where rowid = ?', [Pdate, Pdesc, Pdistance, Prowid])
    })
}

function dbDeleteRow(Prowid)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('delete from trip_log where rowid = ?', [Prowid])
    })
}
