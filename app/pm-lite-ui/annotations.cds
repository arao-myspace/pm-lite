using MaintenanceService as service from '../../srv/maintenance-service';
annotate service.NotificationsService with {
    equipment @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'EquipmentService',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : equipment_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'location_ID',
            },
        ],
    }
};
annotate service.EquipmentService with {
    location @Common.Text: location.name
        @Common.TextArrangement: #TextOnly
        @Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'LocationService',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: location_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'address',
                },
            ],
        }
};
