package com.quanticheart.test_flutter_plugin

//
// Created by Jonn Alves on 07/01/23.
//
// AppUsageApi.kt
data class UsedApp(val id: String, val name: String, val minutesUsed: Int) {
    fun toJson(): Map<String, Any> {
        return mapOf("id" to id, "name" to name, "minutesUsed" to minutesUsed)
    }
}

class AppUsageApi {
    val usedApps: List<UsedApp> = listOf(
        UsedApp("com.reddit.app", "Reddit", 75),
        UsedApp("dev.hashnode.app", "Hashnode", 37),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
        UsedApp("link.timelog.app", "Timelog", 25),
    )

    fun setTimeLimit(id: String, durationInMinutes: Int): String {
        return "Timer of $durationInMinutes minutes set for app ID $id";
    }
}
