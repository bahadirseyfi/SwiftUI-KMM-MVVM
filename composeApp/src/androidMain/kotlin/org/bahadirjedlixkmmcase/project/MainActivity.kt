package org.bahadirjedlixkmmcase.project

import App
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch
import network.JedlixSDK

class MainActivity : ComponentActivity() {

    private val movieSDK: JedlixSDK = JedlixSDK()
    private val mainScope = MainScope()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            App()
        }
        mainScope.launch {
            kotlin.runCatching {
                movieSDK.getChargeStations()
            }.onSuccess { movieResponse ->
                Log.d("onSuccess", movieResponse.toString())
            }.onFailure {
                Log.d("onFailure", it.localizedMessage?.toString().toString())
                Toast.makeText(this@MainActivity, it.localizedMessage, Toast.LENGTH_SHORT).show()
            }
        }
    }
}

@Preview
@Composable
fun AppAndroidPreview() {
    App()
}