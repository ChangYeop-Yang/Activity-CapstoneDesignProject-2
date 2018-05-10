package androidtown.org.saiot;

/**
 * Created by Ei Seok on 2018-05-07.
 */

public class ListItem {

    private String[] mData;

    public ListItem(String[] data){

        mData = data;
    }

    public ListItem(String datetime, String temp, String cmd, String noise, String gas){
        mData = new String[5];
        mData[0] = datetime;
        mData[1]=temp;
        mData[2]=cmd;
        mData[3]=noise;
        mData[4]=gas;


    }

    public String[] getData(){
        return mData;

    }

    public String getData(int index){
        return mData[index];
    }

    public void setmData(String[] data){
        mData = data;
    }


}
