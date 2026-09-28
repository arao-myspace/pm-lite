using { pm as db } from '../db/data-model';

service MaintenanceService {
    entity EquipmentService as projection on db.Equipment;

    entity NotificationsService as projection on db.Notifications
        actions {
            action assignTechnician(technician: String) returns NotificationsService;
        }
}