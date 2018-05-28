package androidtown.org.saiot;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.Socket;

/**
 * Created by Ei Seok on 2018-05-22.
 */

public class ConnectServer extends AsyncTask<Void, Void, Void> {
    NotificationManager Notifi_M;
    Notification Notifi;

    //Uri path = Uri.parse("android.resource://[package]/"+[R.raw.]);

    //notification.sound= Uri.parse("android.resource://com.tp.t114/" + R.raw.i_love_u);


    private String linkURL = null;
    private int port = 0;

    private OutputStream mOutputStream = null;
    private InputStream mInputStream = null;
    private Activity mActivity = null;

    public ConnectServer(final String url, final int port, final Activity mActivity) {

        this.linkURL = url;
        this.port = port;
        this.mActivity = mActivity;
    }

    @Override
    protected Void doInBackground(Void... voids) {


        try {
            /*
            private OutputStream mOutputStream = null;
            private InputStream mInputStream = null;
          private Activity mActivity = null;

            final Socket mSocket = new Socket(InetAddress.getByName("coldy24.iptime.org"), 0890);
            mOutputStream = mSocket.getOutputStream();
            mOutputStream.write("MOBILE:TV".getBytes());



*/
            Notifi_M = (NotificationManager) mActivity.getSystemService(Context.NOTIFICATION_SERVICE);
            final Socket mSocket = new Socket(InetAddress.getByName(linkURL), port);
            mOutputStream = mSocket.getOutputStream();
            mInputStream = mSocket.getInputStream();

            mOutputStream.write("aaaaaaa".getBytes());

            int size = 0;
            byte[] mByte = new byte[1024];
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();

            while ( (size = mInputStream.read(mByte, 0, mByte.length)) != -1 ) {
                final String result = new String(mByte, 0, size, "utf-8");
                final String[] splits = result.split(":");

                switch (splits[1]) {
                    case "KITCHEN": {



                        showToastMessage(splits[0], splits[1], splits[2], splits[3]);



                        break;
                    }
                    case "LIVINGROOM": { showToastMessage(splits[0], splits[1], splits[2], splits[3]); break; }
                    case "OUTSIDE": { showToastMessage(splits[0], splits[1], splits[2], splits[3]); break; }
                }
            }


        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        super.onPostExecute(aVoid);

        try {
            mInputStream.close();
            mOutputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void showToastMessage(final String str1, final String str2, final String str3, final String str4) {
        //final Uri soundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);

        final Intent intent = new Intent(mActivity.getApplicationContext(), MainActivity.class);
        final PendingIntent pendingIntent = PendingIntent.getActivity(mActivity.getApplicationContext(),0,intent,PendingIntent.FLAG_UPDATE_CURRENT);

        mActivity.runOnUiThread(new Runnable() {
            @Override
            public void run() {


                Notifi = new Notification.Builder(mActivity.getApplicationContext())
                        .setContentTitle("<<<< 긴급상황 >>>>")
                        .setContentText(String.format("%s %s %s %s", str1, str2, str3, str4))
                        .setSmallIcon(R.drawable.icons8_gas_industry_64)
                        .setTicker("긴급상황이 도착했습니다")
                        .setFullScreenIntent(pendingIntent,true)
                        .setContentIntent(pendingIntent)
                        //.setSound(soundUri)
                        .build();


                //소리추가
                Notifi.defaults = Notification.DEFAULT_SOUND;

                Notifi.sound= Uri.parse("android.resource://androidtown.org.saiot/" + R.raw.sarang);


                //알림 소리를 한번만 내도록
                Notifi.flags = Notification.FLAG_ONLY_ALERT_ONCE;

                //확인하면 자동으로 알림이 제거 되도록
                Notifi.flags = Notification.FLAG_AUTO_CANCEL;

                Notifi_M.notify( 777 , Notifi);
                //Toast.makeText(mActivity, String.format("%s %s %s %s", str1, str2, str3, str4), Toast.LENGTH_SHORT).show();
            }
        });
    }
}
