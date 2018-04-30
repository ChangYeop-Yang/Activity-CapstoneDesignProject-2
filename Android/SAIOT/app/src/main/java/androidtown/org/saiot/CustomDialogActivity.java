package androidtown.org.saiot;

import android.app.Activity;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.SeekBar;

public class CustomDialogActivity extends Activity implements View.OnClickListener {


    SeekBar rSeekBar;
    SeekBar gSeekBar;
    SeekBar bSeekBar;
    SeekBar aSeekBar;


    private Button mConfirm, mCancel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_custom_dialog);

        setContent();

        rSeekBar = (SeekBar)findViewById(R.id.seekBarr);
        gSeekBar = (SeekBar)findViewById(R.id.seekBarg);
        bSeekBar = (SeekBar)findViewById(R.id.seekBarb);
        aSeekBar = (SeekBar)findViewById(R.id.seekBara);

        rSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {

            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });



        //getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));

    }

    //팝업 액티비티 테두리 삭제
    protected void onApplyThemeResource(Resources.Theme theme, int resid, boolean first) {



        super.onApplyThemeResource(theme, resid, first);


        theme.applyStyle(android.R.style.Theme_Panel,true);

    }


    private void setContent() {
        mConfirm = (Button) findViewById(R.id.btnConfirm);


        mConfirm.setOnClickListener(this);
//        mCancel.setOnClickListener(this);
    }

    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btnConfirm:
                this.finish();
                break;
            default:
                break;
        }
    }


}
