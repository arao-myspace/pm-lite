import cds from '@sap/cds';

export default class MaintenanceService extends cds.ApplicationService {
    async init() {

        // 1. Wyciągamy encję z definicji usługi w pliku .cds
        const { NotificationsService, EquipmentService } = this.entities;

        // Sprawdzamy czy obie encje istnieją w modelu
        if (!NotificationsService || !EquipmentService) {
            throw new Error('Wymagane encje nie zostały znalezione w modelu CDS');
        }
        this.before('CREATE', NotificationsService, async (req: cds.Request) => {

            // W zmiennej 'payload' mamy obiekt JSON, który przysłał użytkownik
            const payload = req.data;

            if (payload.priority === 3) {
                payload.faultDescription = '[PILNE]' + payload.faultDescription;
            }

            const result = await SELECT.one.from(EquipmentService).where({ ID: payload.equipment_ID });
            if (!result) {
                req.error(400, 'Podana maszyna nie istnieje w systemie!', payload.equipment_ID);
            }
        });

        return super.init(); // To zawsze musi być na końcu metody init!
    }
}
