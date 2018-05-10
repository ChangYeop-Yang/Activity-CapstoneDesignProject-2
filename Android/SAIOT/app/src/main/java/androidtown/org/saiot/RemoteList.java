package androidtown.org.saiot;

import java.util.Date;

import io.realm.RealmObject;

/**
 * Created by Ei Seok on 2018-04-24.
 */

public class RemoteList extends RealmObject {

    //Date Value
    private Date usedDate= new Date();

    //Integer Value
    private int hue;
    private int colors;

    //String Value
    private String hueBridgeID;
    private String hueBridgeIP;
    private String hueBridgeName;

    //List

    //let controllerList = List<RemoteControllerInfo>()





}
