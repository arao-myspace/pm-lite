using { MaintenanceService } from '../srv/maintenance-service';

annotate MaintenanceService.EquipmentService with @(
    odata.draft.enabled,
    Capabilities: {
        InsertRestrictions: { Insertable: true },
        UpdateRestrictions: { Updatable: true },
        DeleteRestrictions: { Deletable: true }
    },
    UI: { 
        LineItem: [ 
            { Value: ID }, 
            { Value: name}, 
            { Value: location } 
        ],
        SelectionFields: [ 
            'name' 
        ],
        HeaderInfo: { 
            TypeName: 'Equipment', 
            TypeNamePlural: 'Equipment',
            Title: { Value: 'name' }
        },
        Identification: [ 
            { Value: 'name', Label: 'Name' },
            { Value: 'location', Label: 'Location' }
        ],
        FieldGroup #Details: {
            Data: [
                { Value: name },
                { Value: location }
            ]
        },
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Details',
                Target: '@UI.FieldGroup#Details'
            }
        ]
    }
);

annotate MaintenanceService.EquipmentService with {
    ID @title: 'ID';
    name @title: 'Name';
    location @title: 'Location';
};