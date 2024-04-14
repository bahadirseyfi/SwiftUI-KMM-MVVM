package network

@kotlinx.serialization.Serializable
data class ChargePoint(
    val id: Int?,
    val uuid: String?,
    val usageCost: String?,
    val operatorInfo: OperatorInfo?,
    val addressInfo: AddressInfo?
)

@kotlinx.serialization.Serializable
data class OperatorInfo(
    val title: String?,
    val websiteURL: String?
)

@kotlinx.serialization.Serializable
data class AddressInfo(
    val title: String?,
    val addressLine1: String?,
    val stateOrProvince: String?,
    val country: Country?,
    val latitude: Double?,
    val longitude: Double?,
)

@kotlinx.serialization.Serializable
data class Country(
    val title: String?
)

