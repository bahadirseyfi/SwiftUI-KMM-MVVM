@file:OptIn(ExperimentalSerializationApi::class)

package network

import network.AppConstant.API_KEY
import network.AppConstant.BASE_URL

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.get
import io.ktor.http.ContentType
import io.ktor.http.contentType
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.json.Json

class JedlixAPI {
    private val httpClient = HttpClient {
        install(ContentNegotiation) {
            json(Json {
                explicitNulls = false
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            })
        }
        install(HttpTimeout) {
            val timeout = 15000L
            connectTimeoutMillis = timeout
            requestTimeoutMillis = timeout
            socketTimeoutMillis = timeout
        }
    }
    suspend fun getChargeStations(): List<ChargePoint>? {
        return httpClient.get("${BASE_URL}?key=${API_KEY}&maxresults=2&camelcase=true"){
            contentType(ContentType.Application.Json)
        }.body()
    }
}
