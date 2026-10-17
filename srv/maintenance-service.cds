using { pm as db } from '../db/data-model';

service MaintenanceService {
    entity EquipmentService as projection on db.Equipment;

    entity NotificationsService as projection on db.Notifications
        actions {
            //annotation defined before the action is required to make it work in Fiori Elements
            @(
                Common.SideEffects: {
                    TargetProperties: ['_it/technician', '_it/status']
                },
                // `_it` names the implicit bound Notification; targets above refresh its properties - technician and status - after the action is executed
                cds.odata.bindingparameter.name: '_it'
            )
            action assignTechnician(technician: String) returns NotificationsService;
        }
}