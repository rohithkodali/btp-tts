package com.mslabiitm.iitmflitehtshindi;

import android.content.Context;
import android.content.Intent;
import android.content.res.AssetManager;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Environment;
import android.preference.PreferenceManager;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;
import android.os.Handler;

import com.mslabiitm.iitmflitehtshindi.R;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.concurrent.TimeUnit;






public class MainActivity extends ActionBarActivity {

    private String inuser;

    private MediaPlayer mediaPlayer ;//= new MediaPlayer();
    private double startTime = 0;
    private double finalTime = 0;
    private int forwardTime = 5000;
    private int backwardTime = 5000;
    private SeekBar seekbar;
    private TextView tx1,tx2,tx3;
    public static int oneTimeOnly = 0;

//    private Button pauseButton;
    private Button playButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (!PreferenceManager.getDefaultSharedPreferences(
                getApplicationContext())
                .getBoolean("installed", false)) {
            PreferenceManager.getDefaultSharedPreferences(
                    getApplicationContext())
                    .edit().putBoolean("installed", true).commit();
            copyAssests();
        }
        setContentView(R.layout.activity_main);
        Intent intent = getIntent();
        Bundle extras = intent.getExtras();
        String action = intent.getAction();
        String msg = "";
        if (Intent.ACTION_SEND.equals(action)) {
            msg = intent.getStringExtra(Intent.EXTRA_TEXT);
            if (msg != null) {
                displayText(msg);
                try {
                    synthesisWavInBackground(msg);
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        }
//        pauseButton=(Button) findViewById(R.id.pause_button);
//        pauseButton.setEnabled(false);
        playButton=(Button) findViewById(R.id.play_button);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
    public void synthesisWav(View view) throws IOException {// from normal app
        //MainActivity me = new MainActivity();
        EditText obj1 = (EditText)findViewById(R.id.inputText);
        Spinner spk = (Spinner)findViewById(R.id.speaker);
        String speaker_name = String.valueOf(spk.getSelectedItem());
        String inputtext = obj1.getText().toString().trim();
        inputtext=inputtext.replace("|",".");
        inputtext=inputtext.replace(" . ", " .");
        inputtext=inputtext.replaceAll("\\s+", " ");
        inputtext=inputtext.trim();
        if(inputtext.endsWith( " ." )){
            inputtext = inputtext.substring(0, inputtext.length() - 2);
        }else if(inputtext.endsWith( " . " )){
            inputtext = inputtext.substring(0, inputtext.length() - 3);
        }
        inputtext = inputtext.trim();
        String foldername = Environment.getExternalStorageDirectory().getPath()+"/Android/data/"+getPackageName().toString()+"/";
        String filename = foldername+speaker_name+".htsvoice";
        String wavname = foldername+"1.wav";
        playButton.setEnabled(false);
        Toast.makeText(MainActivity.this,mainfn(inputtext,filename,wavname),Toast.LENGTH_SHORT).show();
        /////////////////////////////////////////////////////////////////////////////////
        //String url = "/sdcard/voice/1.wav";
       mediaPlayer = new MediaPlayer();
        //pause_button = (Button) findViewById(R.id.pause_button);
//        seekbar=(SeekBar)findViewById(R.id.seekBar);
//        seekbar.setClickable(false);

//        pauseButton.setEnabled(true);
         mediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC);
        try {
            mediaPlayer.setDataSource(wavname);
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            mediaPlayer.prepare();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
        mediaPlayer.start();
//        finalTime = mediaPlayer.getDuration();
//        startTime = mediaPlayer.getCurrentPosition();
//
//        if (oneTimeOnly == 0) {
//            seekbar.setMax((int) finalTime);
//            oneTimeOnly = 1;
//        }
//        seekbar.setProgress((int) startTime);
//       // myHandler.postDelayed(UpdateSongTime, 100);
//        //b2.setEnabled(true);
//        pauseButton.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                Toast.makeText(getApplicationContext(), "Pausing sound", Toast.LENGTH_SHORT).show();
//                mediaPlayer.pause();
//                pauseButton.setEnabled(false);
//                playButton.setEnabled(true);
//            }
//        });
        mediaPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
            public void onCompletion(MediaPlayer mp) {
                playButton.setEnabled(true);
//                pauseButton.setEnabled(false);
            }
        });
     //  b3.setEnabled(false);

    }


    public void synthesisWavInBackground(String msg) throws IOException {// from share
        //MainActivity me = new MainActivity();
        EditText obj1 = (EditText)findViewById(R.id.inputText);
        Spinner spk = (Spinner)findViewById(R.id.speaker);
        String speaker_name = String.valueOf(spk.getSelectedItem());
        String inputtext = msg.trim();
        inputtext=inputtext.replace("|",".");
        inputtext=inputtext.replace(" . ", " .");
        inputtext=inputtext.replaceAll("\\s+", " ");
        inputtext=inputtext.trim();
        if(inputtext.endsWith( " ." )){
            inputtext = inputtext.substring(0, inputtext.length() - 2);
        }else if(inputtext.endsWith( " . " )){
            inputtext = inputtext.substring(0, inputtext.length() - 3);
        }
        inputtext = inputtext.trim();
        String foldername = Environment.getExternalStorageDirectory().getPath()+"/Android/data/"+getPackageName().toString()+"/";
        String filename = foldername+speaker_name+".htsvoice";
        String wavname = foldername+"1.wav";
        Toast.makeText(MainActivity.this,mainfn(inputtext,filename,wavname),Toast.LENGTH_SHORT).show();
        /////////////////////////////////////////////////////////////////////////////////
        mediaPlayer = new MediaPlayer();
        mediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC);
        try {
            mediaPlayer.setDataSource(wavname);
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            mediaPlayer.prepare();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
        mediaPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
            public void onCompletion(MediaPlayer mp) {
                System.exit(0);
            }
        });
        mediaPlayer.start();
        /*finalTime = mediaPlayer.getDuration();
        startTime = mediaPlayer.getCurrentPosition();

        if (oneTimeOnly == 0) {
            seekbar.setMax((int) finalTime);
            oneTimeOnly = 1;
        }
        seekbar.setProgress((int) startTime);
        // myHandler.postDelayed(UpdateSongTime, 100);
        b2.setEnabled(true);
        b2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(getApplicationContext(), "Pausing sound", Toast.LENGTH_SHORT).show();
                mediaPlayer.pause();
                b2.setEnabled(false);
                // b3.setEnabled(true);
            }
        });*/

    }
    public void setUsertext(String temp)
    {
        inuser = temp;
    }
    public String getUsertext()
    {
        return inuser;
    }
    public native String mainfn(String s, String inputtext, String wavname);
    static
    {
        System.loadLibrary("mainfn");
    }
    public void copyAssests()
    {
        AssetManager assetManager = getAssets();
        String[] files = null;
        try {
            files = assetManager.list("");
        } catch (IOException e) {
            e.printStackTrace();
        }
        for (String filename : files)
        {
            System.out.println("In CopyAssets"+filename);
            InputStream in = null;
            OutputStream out = null;
            try {
                in = assetManager.open(filename);
                String foldername= Environment.getExternalStorageDirectory().getPath()+"/Android/data/"+getPackageName().toString()+"/";
                File folder = new File(foldername);
                folder.mkdirs();
                File outfile = new File(foldername+filename);
                out = new FileOutputStream(outfile);
                copyFile(in, out);
                System.out.println("In copyAssets Entire Path"+foldername+filename);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    private void copyFile(InputStream in, OutputStream out) throws IOException {
        byte[] buffer = new byte[1024];
        int read;
        while((read = in.read(buffer)) != -1){
            out.write(buffer, 0, read);
        }
    }
    private void displayText(String msg) {
        TextView inputTextView = (TextView) findViewById(
                R.id.inputText);
        inputTextView.setText("" + msg);
    }


}