package androidtown.org.saiot;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;


/**
 * A simple {@link Fragment} subclass.
 */
public class OutsideFragment extends Fragment {

    Button btn_server;


    public OutsideFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_outside,null);
        //buttonoutside=(Button) getActivity().findViewById(R.id.buttonoutside);

        //버튼누를 시 애니메이션효과
        btn_server = (Button) view.findViewById(R.id.buttonoutside);
        btn_server.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Animation animation = AnimationUtils.loadAnimation(getActivity().getApplicationContext(), R.anim.alpha);
                btn_server.startAnimation(animation);
                // view.startAnimation(animation);
                //return view;

            }
        });

        // Inflate the layout for this fragment





        return view;
         //return inflater.inflate(R.layout.fragment_outside, container, false);
    }

}
