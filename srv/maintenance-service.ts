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

            if (!req.user.is('Kierownik')) {
                req.error(403, 'Brak uprawnień do tworzenia zgłoszeń!', 'Użytkownik nie jest Kierownikiem');
            }

            const result = await SELECT.one.from(EquipmentService).where({ ID: payload.equipment_ID });
            if (!result) {
                req.error(400, `Podana maszyna o ID = ${payload.equipment_ID} nie istnieje w systemie!`, payload.equipment_ID);
            }
        });

        return super.init(); // To zawsze musi być na końcu metody init!
    }
    async assignTechnician(_entity: unknown, keys: { ID: string }, technician: string) {
        const { NotificationsService } = this.entities;

        // Sprawdzamy czy encja istnieje w modelu
        if (!NotificationsService) {
            throw new Error('Encja NotificationsService nie została znaleziona w modelu CDS');
        }
        const notificationId = keys.ID;

        // Aktualizujemy pole technician w zgłoszeniu o podanym ID
        const result = await UPDATE(NotificationsService)
            .set({ technician })
            .where({ ID: notificationId });
        if (result === 0) {
            throw cds.error(404, `Nie znaleziono zgłoszenia o ID = ${notificationId}`);
        }

        // Pobieramy zaktualizowane zgłoszenie i zwracamy je jako wynik akcji
        const updatedNotification = await SELECT.one.from(NotificationsService).where({ ID: notificationId });
        return updatedNotification;
    }
}
