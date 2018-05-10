package androidtown.org.saiot;

import java.util.Date;
import io.realm.RealmObject;

/**
 * Created by Ei Seok on 2018-04-24.
 */

public class LivingSensor extends RealmObject {

    //Date Value
    private Date collectDate = new Date();
    private Date occurSparkDate = new Date();

    //Integer Value
    private int temputure;
    private int humidity;
    private int noize;
    private int gas;

    //public String getName() { return name; }
    //public void   setName(String name) { this.name = name; }
    public int    getTemputure() { return temputure; }
    public void   setTemputure(int temputure) { this.temputure = temputure; }
    public int    getHumidity() { return humidity; }
    public void   setHumidity(int humidity) { this.humidity = humidity; }

    public int getNoize() {return noize;}
    public void setNoize(int noize){
        this.noize=noize;
    }

    public int getGas() {return gas;}
    public void setGas(int gas){
        this.gas=gas;
    }


}
