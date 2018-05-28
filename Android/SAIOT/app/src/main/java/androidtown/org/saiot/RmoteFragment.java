package androidtown.org.saiot;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;


/**
 * A simple {@link Fragment} subclass.
 */
public class RmoteFragment extends Fragment {


    public RmoteFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {


        Button.OnClickListener onClickListener = new Button.OnClickListener(){


            @Override
            public void onClick(View view) {
                switch (view.getId()){
                    case R.id.powerbtn:
            /*
                         private OutputStream mOutputStream = null;
                         private InputStream mInputStream = null;
                         private Activity mActivity = null;

                         final Socket mSocket = new Socket(InetAddress.getByName("coldy24.iptime.org"), 0890);
                         mOutputStream = mSocket.getOutputStream();
                         mOutputStream.write("MOBILE:TV".getBytes());



*/
                        break;
                    case R.id.upbtn:
                                    /*
                         private OutputStream mOutputStream = null;
                         private InputStream mInputStream = null;
                         private Activity mActivity = null;

                         final Socket mSocket = new Socket(InetAddress.getByName("coldy24.iptime.org"), 0890);
                         mOutputStream = mSocket.getOutputStream();
                         mOutputStream.write("MOBILE:UP".getBytes());



*/

                        break;

                    case R.id.downbtn:
                                    /*
                         private OutputStream mOutputStream = null;
                         private InputStream mInputStream = null;
                         private Activity mActivity = null;

                         final Socket mSocket = new Socket(InetAddress.getByName("coldy24.iptime.org"), 0890);
                         mOutputStream = mSocket.getOutputStream();
                         mOutputStream.write("MOBILE:DOWN".getBytes());



*/

                        break;

                }
            }
        };
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_rmote, container, false);
    }

}
