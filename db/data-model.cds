namespace pm;

entity Equipment {
    key ID: Integer;
    name: String;
    location: String;
}

entity Notifications {
    key ID: UUID;
    faultDescription: String;
    status: Integer enum {
        submitted = 0;
        shipped = 1;
        canceled = 2;
    };
    priority: Integer @assert.range: [0, 3];
    equipment: Association to Equipment;
}
