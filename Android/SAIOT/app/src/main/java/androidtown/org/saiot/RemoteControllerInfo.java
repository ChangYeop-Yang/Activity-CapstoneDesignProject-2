package androidtown.org.saiot;
import java.util.Date;
import io.realm.RealmObject;

/**
 * Created by Ei Seok on 2018-04-24.
 */

public class RemoteControllerInfo extends RealmObject {
    //Integer Value
    private int channelType;




    //String Value

    private String name;




    //Date Value
    private Date createTime=new Date();


}
