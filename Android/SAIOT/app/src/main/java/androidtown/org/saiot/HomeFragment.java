package androidtown.org.saiot;


import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.components.Legend;
import com.github.mikephil.charting.components.XAxis;
import com.github.mikephil.charting.components.YAxis;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.interfaces.datasets.ILineDataSet;
import com.github.mikephil.charting.utils.ColorTemplate;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;


/**
 * A simple {@link Fragment} subclass.
 */
public class HomeFragment extends Fragment  {

    MainActivity activity;

    private static final String ARG_PARAM1="param1";
    private static final String ARG_PARAM2="param2";


    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private Button huebtn;



    private OnFragmentInteractionListener mListener;



    //꺽은선 그래프
    LineChart tempchart;
    LineChart cdschart;
    LineChart gaschart;
    LineChart noisechart;

    int X_RANGE = 100;
    int DATA_RANGE = 30;

    ArrayList<Entry> xVal,xVal2,xVal3,xVal4;
    LineDataSet setXcomp,setXcomp2,setXcomp3,setXcomp4;
    ArrayList<String> xVals,xVals2,xVals3,xVals4;
    ArrayList<ILineDataSet> lineDataSets,lineDataSets2,lineDataSets3,lineDataSets4;
    LineData lineData,lineData2,lineData3,lineData4;

    //json추가
    TextView txtView;
    phpDown task;
    ArrayList<ListItem> listItem= new ArrayList<ListItem>();
    ListItem Item;


    public HomeFragment() {
        // Required empty public constructor
    }


    public static HomeFragment newInstance(String param1, String param2) {
        HomeFragment fragment = new HomeFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
        //init();
       // threadStart();
    }



    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        activity = (MainActivity)getActivity();
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_home,container,false);


        //json
        task = new phpDown();


        //imView = (ImageView) findViewById(R.id.imageView1);

        task.execute("http://yeop9657.duckdns.org/select.php");

        tempchart = (LineChart)view.findViewById(R.id.chart2);
        tempchart.setAutoScaleMinMaxEnabled(true);
        tempchart.setDescription("");
        tempchart.setNoDataTextDescription("No data for the moment");
        //하이라이팅
        tempchart.setHighlightPerDragEnabled(true);
        tempchart.setTouchEnabled(true);
        tempchart.setDragEnabled(true);
        tempchart.setDrawGridBackground(false);
        //chart.setPinchZoom(true);
        tempchart.setBackgroundColor(Color.GRAY);

        xVal = new ArrayList<Entry>();
        setXcomp = new LineDataSet(xVal, "TEMPERATURE");
        setXcomp.setDrawCubic(true);
        setXcomp.setCubicIntensity(0.2f);
        setXcomp.setAxisDependency(YAxis.AxisDependency.LEFT);
        setXcomp.setColor(ColorTemplate.getHoloBlue());
        setXcomp.setCircleColor(ColorTemplate.getHoloBlue());
        setXcomp.setLineWidth(2f);
        setXcomp.setCircleRadius(2f);
        setXcomp.setFillAlpha(65);
        setXcomp.setFillColor(ColorTemplate.getHoloBlue());
        setXcomp.setHighLightColor(Color.rgb(244,117,177));
        setXcomp.setDrawValues(false);
        setXcomp.setAxisDependency(YAxis.AxisDependency.LEFT);
        lineDataSets = new ArrayList<ILineDataSet>();
        lineDataSets.add(setXcomp);

        Legend l = tempchart.getLegend();

        l.setForm(Legend.LegendForm.LINE);
        l.setTextColor(Color.WHITE);

        XAxis x1 = tempchart.getXAxis();
        x1.setTextColor(Color.WHITE);
        x1.setDrawGridLines(false);
        x1.setAvoidFirstLastClipping(true);

        YAxis y1=tempchart.getAxisLeft();
        y1.setTextColor(Color.WHITE);
        y1.setDrawGridLines(true);

        YAxis y12=tempchart.getAxisRight();
        y12.setEnabled(false);

        tempchart.invalidate();



        //CDS그래프


        cdschart = (LineChart)view.findViewById(R.id.chart3);
        cdschart.setAutoScaleMinMaxEnabled(true);
        cdschart.setDescription("");
        cdschart.setNoDataTextDescription("No data for the moment");
        //하이라이팅
        cdschart.setHighlightPerDragEnabled(true);
        cdschart.setTouchEnabled(true);
        cdschart.setDragEnabled(true);
        cdschart.setDrawGridBackground(false);
        //chart.setPinchZoom(true);
        cdschart.setBackgroundColor(Color.GRAY);

        xVal2 = new ArrayList<Entry>();
        setXcomp2 = new LineDataSet(xVal2, "CDS");
        setXcomp2.setDrawCubic(true);
        setXcomp2.setCubicIntensity(0.2f);
        setXcomp2.setAxisDependency(YAxis.AxisDependency.LEFT);
        setXcomp2.setColor(ColorTemplate.getHoloBlue());
        setXcomp2.setCircleColor(ColorTemplate.getHoloBlue());
        setXcomp2.setLineWidth(2f);
        setXcomp2.setCircleRadius(2f);
        setXcomp2.setFillAlpha(65);
        setXcomp2.setFillColor(ColorTemplate.getHoloBlue());
        setXcomp2.setHighLightColor(Color.rgb(244,117,177));
        setXcomp2.setDrawValues(false);
        setXcomp2.setAxisDependency(YAxis.AxisDependency.LEFT);
        lineDataSets2 = new ArrayList<ILineDataSet>();
        lineDataSets2.add(setXcomp2);

        Legend l2 = cdschart.getLegend();

        l2.setForm(Legend.LegendForm.LINE);
        l2.setTextColor(Color.WHITE);

        XAxis x2 = cdschart.getXAxis();
        x2.setTextColor(Color.WHITE);
        x2.setDrawGridLines(false);
        x2.setAvoidFirstLastClipping(true);

        YAxis y2=cdschart.getAxisLeft();
        y2.setTextColor(Color.WHITE);
        y2.setDrawGridLines(true);

        YAxis y22=cdschart.getAxisRight();
        y22.setEnabled(false);

        cdschart.invalidate();



        //GAS 그래프


        gaschart = (LineChart)view.findViewById(R.id.chart4);
        gaschart.setAutoScaleMinMaxEnabled(true);
        gaschart.setDescription("");
        gaschart.setNoDataTextDescription("No data for the moment");
        //하이라이팅
        gaschart.setHighlightPerDragEnabled(true);
        gaschart.setTouchEnabled(true);
        gaschart.setDragEnabled(true);
        gaschart.setDrawGridBackground(false);
        //chart.setPinchZoom(true);
        gaschart.setBackgroundColor(Color.GRAY);

        xVal3 = new ArrayList<Entry>();
        setXcomp3 = new LineDataSet(xVal3, "GAS");
        setXcomp3.setDrawCubic(true);
        setXcomp3.setCubicIntensity(0.2f);
        setXcomp3.setAxisDependency(YAxis.AxisDependency.LEFT);
        setXcomp3.setColor(ColorTemplate.getHoloBlue());
        setXcomp3.setCircleColor(ColorTemplate.getHoloBlue());
        setXcomp3.setLineWidth(2f);
        setXcomp3.setCircleRadius(2f);
        setXcomp3.setFillAlpha(65);
        setXcomp3.setFillColor(ColorTemplate.getHoloBlue());
        setXcomp3.setHighLightColor(Color.rgb(244,117,177));
        setXcomp3.setDrawValues(false);
        setXcomp3.setAxisDependency(YAxis.AxisDependency.LEFT);
        lineDataSets3 = new ArrayList<ILineDataSet>();
        lineDataSets3.add(setXcomp3);

        Legend l3 = gaschart.getLegend();

        l3.setForm(Legend.LegendForm.LINE);
        l3.setTextColor(Color.WHITE);

        XAxis x3 = gaschart.getXAxis();
        x3.setTextColor(Color.WHITE);
        x3.setDrawGridLines(false);
        x3.setAvoidFirstLastClipping(true);

        YAxis y3=gaschart.getAxisLeft();
        y3.setTextColor(Color.WHITE);
        y3.setDrawGridLines(true);

        YAxis y33=gaschart.getAxisRight();
        y33.setEnabled(false);

        gaschart.invalidate();


        //NOISE 그래프


        noisechart = (LineChart)view.findViewById(R.id.chart5);
        noisechart.setAutoScaleMinMaxEnabled(true);
        noisechart.setDescription("");
        noisechart.setNoDataTextDescription("No data for the moment");
        //하이라이팅
        noisechart.setHighlightPerDragEnabled(true);
        noisechart.setTouchEnabled(true);
        noisechart.setDragEnabled(true);
        noisechart.setDrawGridBackground(false);
        //chart.setPinchZoom(true);
        noisechart.setBackgroundColor(Color.GRAY);

        xVal4 = new ArrayList<Entry>();
        setXcomp4 = new LineDataSet(xVal4, "NOISE");
        setXcomp4.setDrawCubic(true);
        setXcomp4.setCubicIntensity(0.2f);
        setXcomp4.setAxisDependency(YAxis.AxisDependency.LEFT);
        setXcomp4.setColor(ColorTemplate.getHoloBlue());
        setXcomp4.setCircleColor(ColorTemplate.getHoloBlue());
        setXcomp4.setLineWidth(2f);
        setXcomp4.setCircleRadius(2f);
        setXcomp4.setFillAlpha(65);
        setXcomp4.setFillColor(ColorTemplate.getHoloBlue());
        setXcomp4.setHighLightColor(Color.rgb(244,117,177));
        setXcomp4.setDrawValues(false);
        setXcomp4.setAxisDependency(YAxis.AxisDependency.LEFT);
        lineDataSets4= new ArrayList<ILineDataSet>();
        lineDataSets4.add(setXcomp4);

        Legend l4 = noisechart.getLegend();

        l4.setForm(Legend.LegendForm.LINE);
        l4.setTextColor(Color.WHITE);

        XAxis x4 = noisechart.getXAxis();
        x4.setTextColor(Color.WHITE);
        x4.setDrawGridLines(false);
        x4.setAvoidFirstLastClipping(true);

        YAxis y4=noisechart.getAxisLeft();
        y4.setTextColor(Color.WHITE);
        y4.setDrawGridLines(true);

        YAxis y44=noisechart.getAxisRight();
        y44.setEnabled(false);

        noisechart.invalidate();
        //init();
        //threadStart();

        //데이터 입력
//        if (xVal.size() > DATA_RANGE) {
//            xVal.remove(0);
//            for (int i = 0; i < DATA_RANGE; i++) {
//                xVal.get(i).setXIndex(i);
//            }
//        }


//        xVal.add(new Entry(Integer.parseInt(listItem.get(0).getData(1)), xVal.size()));
//        setXcomp.notifyDataSetChanged();
//        chart.notifyDataSetChanged();
//        chart.invalidate();

        //buttonoutside=(Button) getActivity().findViewById(R.id.buttonoutside);

        //휴 버튼
        huebtn = (Button) view.findViewById(R.id.huebtn);
        huebtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                new Handler().postDelayed(new Runnable() {//1초후 실행
                    @Override
                    public void run() {
                        //1초후 실행할
                        Activity root = getActivity(); //이 클래스가 프레그먼트이기 때문에 액티비티 정보를 얻는다.

                        Toast.makeText(root, "토스트 사용!", Toast.LENGTH_SHORT).show();


                        Intent intent1 = new Intent(getActivity(), CustomDialogActivity.class);
                        startActivity(intent1);
                    }
                },1000);

                // view.startAnimation(animation);
                //return view;

            }
        });

        return view;

        // Inflate the layout for this fragment
        //return inflater.inflate(R.layout.fragment_home, container, false);

    }


    private class phpDown extends AsyncTask<String, Integer,String> {


        @Override
        protected String doInBackground(String... urls) {
            StringBuilder jsonHtml = new StringBuilder();
            try{
                // 연결 url 설정
                URL url = new URL(urls[0]);
                // 커넥션 객체 생성
                HttpURLConnection conn = (HttpURLConnection)url.openConnection();
                // 연결되었으면.
                if(conn != null){
                    conn.setConnectTimeout(10000);
                    conn.setUseCaches(false);
                    // 연결되었음 코드가 리턴되면.
                    if(conn.getResponseCode() == HttpURLConnection.HTTP_OK){
                        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
                        for(;;){
                            // 웹상에 보여지는 텍스트를 라인단위로 읽어 저장.
                            String line = br.readLine();
                            if(line == null) break;
                            // 저장된 텍스트 라인을 jsonHtml에 붙여넣음
                            jsonHtml.append(line + "\n");
                        }
                        br.close();
                    }
                    conn.disconnect();
                }
            } catch(Exception ex){
                ex.printStackTrace();
            }
            return jsonHtml.toString();

        }

        protected void onPostExecute(String str){

            String datetime;
            String temp;
            String cmd;
            String noise;
            String gas;



            int num=0;

            try{

                JSONObject root = new JSONObject(str);
                JSONArray ja=root.getJSONArray("SensorDatas");
                num= ja.length();
                for(int i=0; i<ja.length();i++){
                    JSONObject jo = ja.getJSONObject(i);
                    datetime = jo.getString("Insert_DT");
                    temp = jo.getString("Temp_NO");
                    cmd = jo.getString("Cmd_NO");
                    noise = jo.getString("Noise_NO");
                    gas = jo.getString("Gas_FL");
                    listItem.add(new ListItem(datetime,temp,cmd,noise,gas));

                }

            }catch (JSONException e){
                e.printStackTrace();
            }

//            if (xVal.size() > DATA_RANGE) {
//                xVal.remove(0);
//                for (int i = 0; i < DATA_RANGE; i++) {
//                    xVal.get(i).setXIndex(i);
//                }
//            }

            int a;


            //온도 그래프차트
            //날짜 데이터 시간만 표시
            xVals = new ArrayList<String>();
            for (int i = 0; i < num; i++) {
               // xVals.add(listItem.get(i).getData(0));
                String oldstring = listItem.get(i).getData(0);
                try {

                    Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(oldstring);
                    String newstring = new SimpleDateFormat("HH:mm").format(date);
                    xVals.add(newstring);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            lineData = new LineData(xVals, lineDataSets);
            tempchart.setData(lineData);

            for(int i=0; i<num; i++) {
                xVal.add(new Entry(Integer.parseInt(listItem.get(i).getData(1)), xVal.size()));
                setXcomp.notifyDataSetChanged();
                tempchart.notifyDataSetChanged();
            }
            tempchart.invalidate();

            //CDS그래프 차트
            xVals2 = new ArrayList<String>();

            for (int i = 0; i < num; i++) {
                // xVals.add(listItem.get(i).getData(0));
                String oldstring = listItem.get(i).getData(0);
                try {

                    Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(oldstring);
                    String newstring = new SimpleDateFormat("HH:mm").format(date);
                    xVals2.add(newstring);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            lineData2 = new LineData(xVals2, lineDataSets2);
            cdschart.setData(lineData2);

            for(int i=0; i<num; i++) {
                xVal2.add(new Entry(Integer.parseInt(listItem.get(i).getData(2)), xVal2.size()));
                setXcomp2.notifyDataSetChanged();
                cdschart.notifyDataSetChanged();
            }
            cdschart.invalidate();


            //GAS그래프 차트
            xVals3 = new ArrayList<String>();

            for (int i = 0; i < num; i++) {
                // xVals.add(listItem.get(i).getData(0));
                String oldstring = listItem.get(i).getData(0);
                try {

                    Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(oldstring);
                    String newstring = new SimpleDateFormat("HH:mm").format(date);
                    xVals3.add(newstring);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            lineData3 = new LineData(xVals3, lineDataSets3);
            gaschart.setData(lineData3);

            for(int i=0; i<num; i++) {
                xVal3.add(new Entry(Integer.parseInt(listItem.get(i).getData(3)), xVal3.size()));
                setXcomp3.notifyDataSetChanged();
                gaschart.notifyDataSetChanged();
            }
            gaschart.invalidate();


            //noise그래프 차트
            xVals4 = new ArrayList<String>();

            for (int i = 0; i < num; i++) {
                // xVals.add(listItem.get(i).getData(0));
                String oldstring = listItem.get(i).getData(0);
                try {

                    Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(oldstring);
                    String newstring = new SimpleDateFormat("HH:mm").format(date);
                    xVals4.add(newstring);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            lineData4 = new LineData(xVals4, lineDataSets4);
            noisechart.setData(lineData4);

            for(int i=0; i<num; i++) {
                xVal4.add(new Entry(Integer.parseInt(listItem.get(i).getData(4)), xVal4.size()));
                setXcomp4.notifyDataSetChanged();
                noisechart.notifyDataSetChanged();
            }
            noisechart.invalidate();








        }

    }
/*

    private void init() {
        chart = (LineChart)getActivity().findViewById(R.id.chart2);


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

    }*/
/*
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
*/
//    public void chartUpdate(int x) {
//
//        if (xVal.size() > DATA_RANGE) {
//            xVal.remove(0);
//            for (int i = 0; i < DATA_RANGE; i++) {
//                xVal.get(i).setXIndex(i);
//            }
//        }
//        xVal.add(new Entry(x, xVal.size()));
//        setXcomp.notifyDataSetChanged();
//        chart.notifyDataSetChanged();
//        chart.invalidate();
//
//
//
//
//    }
//
//
//    Handler handler = new Handler() {
//        @Override
//        public void handleMessage(Message msg) {
//            if (msg.what == 0) { // Message id 가 0 이면
//                int a = 0;
//                a = (int) (Math.random() * 200);
//                chartUpdate(a);
//            }
//        }
//    };
//
//    class MyThread extends Thread {
//        @Override
//        public void run() {
//            while (true) {
//                handler.sendEmptyMessage(0);
//                try {
//                    Thread.sleep(500);
//                } catch (InterruptedException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }
//
//    private void threadStart() {
//        MyThread thread = new MyThread();
//        thread.setDaemon(true);
//        thread.start();
//    }

    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }
}
