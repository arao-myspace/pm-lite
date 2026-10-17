import cds from '@sap/cds';

type EntityKey = { ID: string | number };

const isEntityKey = (value: unknown): value is EntityKey =>
    typeof value === 'object' &&
    value !== null &&
    'ID' in value &&
    (typeof value.ID === 'string' || typeof value.ID === 'number');

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

            if (!req.user.is('Kierownik')) {
                req.error(403, 'Brak uprawnień do tworzenia zgłoszeń!', 'Użytkownik nie jest Kierownikiem');
            }

            const result = await SELECT.one.from(EquipmentService).where({ ID: payload.equipment_ID });
            if (!result) {
                req.error(400, `Podana maszyna o ID = ${payload.equipment_ID} nie istnieje w systemie!`, payload.equipment_ID);
            }
        });

        this.on('assignTechnician', NotificationsService, async (req: cds.Request) => {
            const notificationKey = req.params.at(-1);
            const technician = req.data.technician;
            if (!isEntityKey(notificationKey) || typeof technician !== 'string') {
                throw cds.error(400, 'Nieprawidłowe parametry akcji assignTechnician');
            }
            const notificationId = notificationKey.ID;

            const result = await UPDATE(NotificationsService)
                .set({ technician, status: 1 })
                .where({ ID: notificationId });
            if (result === 0) {
                throw cds.error(404, `Nie znaleziono zgłoszenia o ID = ${notificationId}`);
            }

            return SELECT.one.from(NotificationsService).where({ ID: notificationId });
        });

        return super.init(); // To zawsze musi być na końcu metody init!
    }
}
