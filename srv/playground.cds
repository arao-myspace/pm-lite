using { pm as db } from '../db/data-model';

service PlaygroundService {
    entity Equipment as projection on db.Equipment;
    entity Notifications as projection on db.Notifications;
    entity Location as projection on db.Location;

    action runExercise(exNumber: Integer) returns String;
}