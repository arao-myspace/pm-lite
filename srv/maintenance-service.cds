using { pm as db } from '../db/data-model';

service MaintenanceService {
    entity EquipmentService as projection on db.Equipment;

    entity NotificationsService as projection on db.Notifications
        actions {
            @(
                Common.SideEffects: {
                    TargetProperties: ['_it/technician', '_it/status']
                },
                cds.odata.bindingparameter.name: '_it'
            )
            action assignTechnician(technician: String) returns NotificationsService;
        }
}