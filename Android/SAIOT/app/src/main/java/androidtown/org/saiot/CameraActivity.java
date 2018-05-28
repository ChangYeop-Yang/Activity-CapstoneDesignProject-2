package androidtown.org.saiot;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class CameraActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_camera);

        String uri="http://20.20.3.17:8080/stream";

        WebView webView = (WebView)findViewById(R.id.vidioweb);
        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setPluginState(WebSettings.PluginState.ON);
        webView.getSettings().setSupportMultipleWindows(true);
        // set the font size

        webView.getSettings().setDefaultFontSize(8);
        webView.setHorizontalScrollBarEnabled(false); // 세로 스크롤 제거
        webView.setVerticalScrollBarEnabled(false); // 가로 세로 제거

        webView.getSettings().setDefaultZoom(WebSettings.ZoomDensity.MEDIUM); // 화면을 유지

// set the scale
        webView.setInitialScale(50); // 35%


        webView.getSettings().setUseWideViewPort(true);


        webView.loadUrl(uri);

        webView.setWebChromeClient(new WebChromeClient());
        webView.setWebViewClient(new WebViewClient());

    }
}
