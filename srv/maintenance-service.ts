import cds from '@sap/cds';

export default class MaintenanceService extends cds.ApplicationService {
    async init() {

        // 1. Wyciągamy encję z definicji usługi w pliku .cds
        const { NotificationsService } = this.entities;

        if (!NotificationsService) {
            throw new Error('NotificationsService entity was not found');
        }
        this.before('CREATE', NotificationsService, async (req: cds.Request) => {

            // W zmiennej 'payload' mamy obiekt JSON, który przysłał użytkownik
            const payload = req.data;

            if (payload.priority === 3) {
                payload.faultDescription = '[PILNE]' + payload.faultDescription;
            }

        });

        return super.init(); // To zawsze musi być na końcu metody init!
    }
}
