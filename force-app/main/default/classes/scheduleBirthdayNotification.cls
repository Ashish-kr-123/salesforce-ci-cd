public class scheduleBirthdayNotification implements schedulable {
    public void execute(schedulableContext sc){
        BirthdayNotificationBatch birthNotify = new BirthdayNotificationBatch();
        Database.executeBatch(birthNotify);
    }
}