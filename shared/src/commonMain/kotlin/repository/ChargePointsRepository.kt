package repository

import network.JedlixAPI

class ChargePointsRepository() {
    private val api: JedlixAPI = JedlixAPI()
    suspend fun getChargePoints() = api.getChargeStations()
}