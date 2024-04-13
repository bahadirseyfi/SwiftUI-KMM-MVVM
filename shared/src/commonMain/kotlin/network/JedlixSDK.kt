package network

class JedlixSDK {
    private val jedlixAPI = JedlixAPI()

    @Throws(Exception::class)
    suspend fun getChargeStations(): List<ChargePoint> {
        val chargeStationsResponse = jedlixAPI.getChargeStations()
        return if (chargeStationsResponse != null) {
            chargeStationsResponse
        } else {
            throw NullPointerException()
        }
    }
}
