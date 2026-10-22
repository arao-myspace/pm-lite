import cds from '@sap/cds';

export default class PlygroundService extends cds.ApplicationService {
    async init() {
         const { Notifications, Equipment } = this.entities;

        if (!Notifications || !Equipment) {
            throw new Error('Wymagane encje nie zostały znalezione w modelu CDS');
        }
        this.on('runExercise', async (req) => {
            const { exNumber } = req.data;
            console.log(`Running exercise number: ${exNumber}`);
            let result;
            switch (exNumber) {
                case 1:
                  result = await SELECT.from(Notifications).where({priority: 3}).orderBy('createdAt desc').columns('ID', 'faultDescription');
                case 2:
                    
                default:
                    
            }
            console.log('Exercise result:', result);
            return result;
        });
        
        await super.init();
    }
}