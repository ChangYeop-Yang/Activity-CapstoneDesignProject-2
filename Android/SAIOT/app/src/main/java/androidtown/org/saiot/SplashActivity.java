package androidtown.org.saiot;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

/**
 * Created by Ei Seok on 2018-05-24.
 */

public class SplashActivity extends Activity {

    protected void onCreate(Bundle saveInstanceState){
        super.onCreate(saveInstanceState);

        try{

            Thread.sleep(3000);
        }catch (InterruptedException e){
            e.printStackTrace();
        }

        startActivity(new Intent(this,MainActivity.class));
        finish();
    }




}
