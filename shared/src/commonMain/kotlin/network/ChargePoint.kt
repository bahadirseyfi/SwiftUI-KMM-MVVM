package network

@kotlinx.serialization.Serializable
data class ChargePoint(
//    val dataProvider: DataProvider,
//    val operatorInfo: OperatorInfo?,
//    val usageType: UsageType,
//    val statusType: StatusType,
//    val submissionStatus: SubmissionStatus,
//    val userComments: String?, // Change type accordingly if needed
//    val percentageSimilarity: String?, // Change type accordingly if needed
//    val mediaItems: String?, // Change type accordingly if needed
//    val isRecentlyVerified: Boolean?,
//    val dateLastVerified: String?,
    val isRecentlyVerified: Boolean?,
    val dateLastVerified: String?,
    val id: Int?,
    val uuid: String?
//    val uuid: String?,
//    val parentChargePointID: String?, // Change type accordingly if needed
//    val dataProviderID: Int,
//    val dataProvidersReference: String?, // Change type accordingly if needed
//    val operatorID: Int,
//    val operatorsReference: String?, // Change type accordingly if needed
//    val usageTypeID: Int,
//    val usageCost: String,
//    val addressInfo: AddressInfo?,
//    val connections: List<Connection>,
//    val numberOfPoints: Int,
//    val generalComments: String?, // Change type accordingly if needed
//    val datePlanned: String?, // Change type accordingly if needed
//    val dateLastConfirmed: String?, // Change type accordingly if needed
//    val statusTypeID: Int,
//    val dateLastStatusUpdate: String,
//    val metadataValues: String?, // Change type accordingly if needed
//    val dataQualityLevel: Int,
//    val dateCreated: String,
//    val submissionStatusTypeID: Int
)

@kotlinx.serialization.Serializable
data class DataProvider(
    val websiteURL: String,
    val comments: String?, // Change type accordingly if needed
    val dataProviderStatusType: DataProviderStatusType,
    val isRestrictedEdit: Boolean,
    val isOpenDataLicensed: Boolean,
    val isApprovedImport: Boolean,
    val license: String,
    val dateLastImported: String?, // Change type accordingly if needed
    val id: Int,
    val title: String
)

@kotlinx.serialization.Serializable
data class DataProviderStatusType(
    val isProviderEnabled: Boolean,
    val id: Int,
    val title: String
)

@kotlinx.serialization.Serializable
data class OperatorInfo(
    val websiteURL: String?,
    val id: Int?,
    val title: String?
)

@kotlinx.serialization.Serializable
data class UsageType(
    val isPayAtLocation: Boolean,
    val isMembershipRequired: Boolean,
    val isAccessKeyRequired: Boolean,
    val id: Int,
    val title: String
)

@kotlinx.serialization.Serializable
data class StatusType(
    val isOperational: Boolean,
    val isUserSelectable: Boolean,
    val id: Int,
    val title: String
)

@kotlinx.serialization.Serializable
data class SubmissionStatus(
    val isLive: Boolean,
    val id: Int,
    val title: String
)

@kotlinx.serialization.Serializable
data class AddressInfo(
    val id: Int?,
    val title: String?,
    val addressLine1: String?,
    val addressLine2: String?,
    val town: String?,
    val stateOrProvince: String?,
    val country: Country?,
    val latitude: Double?,
    val longitude: Double?,
)

@kotlinx.serialization.Serializable
data class Country(
    val iSOCode: String?,
    val continentCode: String?,
    val id: Int?,
    val title: String?
)

@kotlinx.serialization.Serializable
data class Connection(
    val id: Int,
    val connectionTypeID: Int,
    val connectionType: ConnectionType,
    val reference: String?, // Change type accordingly if needed
    val statusTypeID: Int,
    val statusType: StatusTypeX,
    val levelID: Int,
    val level: Level,
    val amps: Int,
    val voltage: Int,
    val powerKW: Int,
    val currentTypeID: Int,
    val currentType: CurrentType,
    val quantity: Int,
    val comments: String
)

@kotlinx.serialization.Serializable
data class ConnectionType(
    val formalName: String,
    val isDiscontinued: Boolean,
    val isObsolete: Boolean,
    val id: Int,
    val title: String
)

@kotlinx.serialization.Serializable
data class StatusTypeX(
    val isOperational: Boolean,
    val isUserSelectable: Boolean,
    val id: Int,
    val title: String
)

@kotlinx.serialization.Serializable
data class Level(
    val comments: String,
    val isFastChargeCapable: Boolean,
    val id: Int,
    val title: String
)

@kotlinx.serialization.Serializable
data class CurrentType(
    val description: String,
    val id: Int,
    val title: String
)
