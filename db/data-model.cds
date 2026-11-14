namespace pm;
using { managed, cuid } from '@sap/cds/common';

entity Equipment: managed {
    key ID: Integer;
    name: String;
    location: association to Location;
    to_Notifications: Association to many Notifications on to_Notifications.equipment = $self;
}

entity Notifications: managed, cuid {
    @title : 'Fault Description'
    faultDescription: String;
    @title : 'Status'
    status: Integer enum {
        submitted = 0;
        shipped = 1;
        canceled = 2;
    };
    @title : 'Priority'
    priority: Integer @assert.range: [0, 3];
    @title : 'Technician'
    technician: String;
    equipment: Association to Equipment;
}
@cds.odata.valuelist
entity Location: managed, cuid {
    @title : 'Location Name'
    name: String;
    @title : 'Address'
    address: String;
    @title : 'City'
    city: String;
    @title : 'Country'
    country: String;
}
