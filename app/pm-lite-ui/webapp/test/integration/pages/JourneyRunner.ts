import JourneyRunner from "sap/fe/test/JourneyRunner";
import ListReport from "sap/fe/test/ListReport";
import ObjectPage from "sap/fe/test/ObjectPage";
import CustomNotificationsServiceListGenerated from "./NotificationsServiceList.gen";
import CustomNotificationsServiceObjectPageGenerated from "./NotificationsServiceObjectPage.gen";

const runner = new JourneyRunner({
    launchUrl: sap.ui.require.toUrl("pm/lite/pmliteui") + "/test/flp.html#app-preview",
    pages: {
        onTheNotificationsServiceListGenerated: new ListReport(
            {
                appId: "pm.lite.pmliteui",
                componentId: "NotificationsServiceList",
                entitySet: "",
                contextPath: "/NotificationsService"
            },
            CustomNotificationsServiceListGenerated
        ),
        onTheNotificationsServiceObjectPageGenerated: new ObjectPage(
            {
                appId: "pm.lite.pmliteui",
                componentId: "NotificationsServiceObjectPage",
                entitySet: "",
                contextPath: "/NotificationsService"
            },
            CustomNotificationsServiceObjectPageGenerated
        )
    },
    async: true
});

export default runner;
