entity Equipment {
    key id: Integer;
    name: String;
    location: String;
}
entity Notifications {
    key id: UUID;
    faultDescription: String;
    status : Integer enum {
    submitted =  0;
    shipped   =  1;
    canceled  = 2;
  };
    priority: Integer @assert.range: [ 0, 3 ];
    equipment: Association to Equipment;
}

service MaintenanceService {
    entity EquipmentService as projection on Equipment;
    entity NotificationsService as projection on Notifications;
}