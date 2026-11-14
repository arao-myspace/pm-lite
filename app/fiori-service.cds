using {MaintenanceService} from '../srv/maintenance-service';

annotate MaintenanceService.EquipmentService with @(
    odata.draft.enabled,
    Capabilities: {
        InsertRestrictions: {Insertable: true},
        UpdateRestrictions: {Updatable: true},
        DeleteRestrictions: {Deletable: true}
    },
    UI          : {
        LineItem           : [
            {Value: ID},
            {Value: name},
            {Value: location.name, Label: 'Location Name'},
        ],
        SelectionFields    : ['name'],
        HeaderInfo         : {
            TypeName      : 'Equipment',
            TypeNamePlural: 'Equipment',
            Title         : {Value: name}
        },
        FieldGroup #Details: {Data: [
            {Value: name},
            {Value: location_ID, Label: 'Location'}
        ]},
        Facets             : [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Details',
                Target: '@UI.FieldGroup#Details'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Notifications',
                Target: 'to_Notifications/@UI.LineItem'
            }
        ]
    }
);

annotate MaintenanceService.EquipmentService with {
    ID       @title: 'ID';
    name     @title: 'Name';
    location @title: 'Location';
};

annotate MaintenanceService.NotificationsService with @(
    odata.draft.enabled,
    Capabilities: {
        InsertRestrictions: {Insertable: true},
        UpdateRestrictions: {Updatable: true},
        DeleteRestrictions: {Deletable: true}
    },
    UI          : {
        LineItem           : [
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'MaintenanceService.assignTechnician',
                Label : 'Assign Technician'
            },
            {Value: ID},
            {Value: faultDescription},
            {Value: status},
            {Value: priority},
            {Value: technician},
            {
                Value: equipment_ID,
                Label: 'Equipment ID'
            }
        ],
        SelectionFields    : [
            'faultDescription',
            'status'
        ],
        HeaderInfo         : {
            TypeName      : 'Notification',
            TypeNamePlural: 'Notifications',
            Title         : {Value: faultDescription}
        },
        Identification     : [
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'MaintenanceService.assignTechnician',
                Label : 'Assign Technician'
            },
            {Value: 'ID'},
            {Value: 'faultDescription'},
            {Value: 'status'},
            {Value: 'priority'},
            {Value: 'technician'},
            {Value: 'equipment_ID'}
        ],
        FieldGroup #Details: {Data: [
            {Value: faultDescription},
            {Value: status},
            {Value: priority},
            {Value: technician},
            {
                Value: equipment_ID,
                Label: 'Equipment ID'
            }
        ]},
        Facets             : [{
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            Target: '@UI.FieldGroup#Details'
        }]
    },

    restrict    : [
        {
            grant: 'DELETE',
            to   : 'Kierownik'
        },
        {grant: 'CREATE'},
        {grant: 'UPDATE'},
        {grant: 'READ'},
        {grant: 'assignTechnician'}
    ]
);

annotate MaintenanceService.NotificationsService with {
    technician @Common.FieldControl: #ReadOnly;
};
