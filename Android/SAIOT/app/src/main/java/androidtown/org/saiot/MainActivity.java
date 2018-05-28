package androidtown.org.saiot;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.IdRes;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.interfaces.datasets.ILineDataSet;
import com.roughike.bottombar.BottomBar;
import com.roughike.bottombar.OnTabSelectListener;

import java.net.Socket;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    //tcp socket
    Socket socket = null;


    LineChart chart;
    int X_RANGE = 50;
    int DATA_RANGE = 40;

    ArrayList<Entry> xVal;
    LineDataSet setXcomp;
    ArrayList<String> xVals;
    ArrayList<ILineDataSet> lineDataSets;
    LineData lineData;

    //json 형식으로 받아오기
   // String imgUrl="http://yeop9657.duckdns.org/select.php";
    //phpDown task;
    TextView txtView;







    //bottom tab 4.4 14:00
    private HomeFragment homeFragment;
    private RmoteFragment rmoteFragment;
    private OutsideFragment outsideFragment;
    private SettingActivity settingActivity;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //init();
        //threadStart();

        //json 형식으로 받아오기0506 update
//        task = new phpDown();
//        txtView=(TextView)findViewById(R.id.textView26);
//        task.execute("http://yeop9657.duckdns.org/select.php");

        //4.4 하단바
        homeFragment = new HomeFragment();
        rmoteFragment = new RmoteFragment();
        outsideFragment = new OutsideFragment();
        settingActivity = new SettingActivity();


        //5.26
        final String addr = "coldy24.iptime.org";
        //new ConnectServer(addr, 8090, MainActivity.this).execute();
        //hue버튼
       // huebtn=(Button)findViewById(R.id.huebtn);
       // huebtn.setOnClickListener((View.OnClickListener) this);


        BottomBar bottomBar = (BottomBar) findViewById(R.id.bottomBar);
        bottomBar.setOnTabSelectListener(new OnTabSelectListener() {
            @Override
            public void onTabSelected(@IdRes int tabId) {
                FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();

                if(tabId == R.id.tab_home){
                    transaction.replace(R.id.contentContainer, homeFragment).commit();
                }
                else if(tabId == R.id.tab_remote){
                    transaction.replace(R.id.contentContainer, rmoteFragment).commit();
                }
                else if(tabId ==R.id.tab_outside){
                    transaction.replace(R.id.contentContainer, outsideFragment).commit();
                }
                else if (tabId == R.id.tab_setting){
                    Intent intent4=new Intent(MainActivity.this,SettingActivity.class);
                    startActivity(intent4);
                }
            }
        });

/*
        //button click listener
        Button.OnClickListener onClickListener = new Button.OnClickListener() {
            @Override
            public void onClick(View view) {

                switch (view.getId()) {
                    case R.id.homebtn :
                        Intent intent1=new Intent(MainActivity.this,MainActivity.class);
                        startActivity(intent1);
                        break ;
                    case R.id.remotebtn :
                        Intent intent2=new Intent(MainActivity.this,RemoteActivity.class);
                        startActivity(intent2);
                        break ;
                    case R.id.outsidebtn :
                        Intent intent3=new Intent(MainActivity.this,OutsideActivity.class);
                        startActivity(intent3);
                        break ;
                    case R.id.settingbtn :
                        Intent intent4=new Intent(MainActivity.this,SettingActivity.class);
                        startActivity(intent4);
                        break ;
                }
            }
        } ;
        Button homebtn = (Button) findViewById(R.id.homebtn) ;
        homebtn.setOnClickListener(onClickListener) ;
        Button remotebtn = (Button) findViewById(R.id.remotebtn) ;
        remotebtn.setOnClickListener(onClickListener) ;
        Button outsidebtn = (Button) findViewById(R.id.outsidebtn) ;
        outsidebtn.setOnClickListener(onClickListener) ;
        Button settingbtn = (Button) findViewById(R.id.settingbtn) ;
        settingbtn.setOnClickListener(onClickListener);

*/
    }
/*
    public void onClick(View v){
        switch (v.getId()){
            case R.id.huebtn:
                startActivity(new Intent(this,CustomDialogActivity.class));
                break;

        }


    }*/


    public void initFragment(){
        FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
        transaction.add(R.id.contentContainer, homeFragment);
        transaction.addToBackStack(null);
        transaction.commit();
    }


    // json으로 값받아오기위해
/*
    private class phpDown extends AsyncTask<String,Integer,String>{


        @Override
        protected String doInBackground(String... urls) {
            StringBuilder jsonHtml = new StringBuilder();
            try{
                //연결 url설정
                URL url = new URL(urls[0]);

                //커넥션 객체 생성
                HttpURLConnection conn = (HttpURLConnection)url.openConnection();

                //연결 되었으면
                if(conn !=null){
                    conn.setConnectTimeout(10000);
                    conn.setUseCaches(false);
                    //연결되었다는 코드가 리턴되면
                        if(conn.getResponseCode()==HttpURLConnection.HTTP_OK){
                            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
                            for(;;){
                                //웹의 텍스트를 라인단위로 읽어저장
                                String line = br.readLine();
                                if(line==null) break;

                                //저장된 텍스트 라인을 jsonHtml에 넣음
                                jsonHtml.append(line+"\n");
                            }
                            br.close();





                    }
                    conn.disconnect();
                }

            }catch (Exception ex){
                ex.printStackTrace();
            }

            return jsonHtml.toString();
        }

        protected void onPostExecute(String str){
            txtView.setText(str);
        }
    }
*/
/*
    private void init() {
        chart = (LineChart) findViewById(R.id.chart2);
        chartInit();

    }

    private void chartInit() {

        chart.setAutoScaleMinMaxEnabled(true);
        xVal = new ArrayList<Entry>();
        setXcomp = new LineDataSet(xVal, "TEMPERATURE");
        setXcomp.setColor(Color.RED);
        setXcomp.setDrawValues(false);
        setXcomp.setDrawCircles(false);
        setXcomp.setAxisDependency(YAxis.AxisDependency.LEFT);
        lineDataSets = new ArrayList<ILineDataSet>();
        lineDataSets.add(setXcomp);

        xVals = new ArrayList<String>();
        for (int i = 0; i < X_RANGE; i++) {
            xVals.add("");
        }
        lineData = new LineData(xVals, lineDataSets);
        chart.setData(lineData);
        chart.invalidate();
    }

    public void chartUpdate(int x) {

        if (xVal.size() > DATA_RANGE) {
            xVal.remove(0);
            for (int i = 0; i < DATA_RANGE; i++) {
                xVal.get(i).setXIndex(i);
            }
        }
        xVal.add(new Entry(x, xVal.size()));
        setXcomp.notifyDataSetChanged();
        chart.notifyDataSetChanged();
        chart.invalidate();

    }


    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            if (msg.what == 0) { // Message id 가 0 이면
                int a = 0;
                a = (int) (Math.random() * 50);
                chartUpdate(a);
            }
        }
    };

    class MyThread extends Thread {
        @Override
        public void run() {
            while (true) {
                handler.sendEmptyMessage(0);
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void threadStart() {
        MyThread thread = new MyThread();
        thread.setDaemon(true);
        thread.start();
    }
    */

    @Override
    protected void onStart() {
        super.onStart();
        //충돌때문에 여기로 5.26
        final String addr = "coldy24.iptime.org";
       new ConnectServer(addr, 8090, MainActivity.this).execute();
    }


}
