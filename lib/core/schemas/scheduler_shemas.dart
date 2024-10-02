class SchedulerSchema {
  static const getSchedulerList = '''
query getSchedulerList(\$data: ScheduleListInput) {
  getSchedulerList(data: \$data) {
    id
    name
    description
    startDay
    endDay
    startTime
    endTime
    recurring
    rrule
    startCron
    endCron
    color
    eventId
    domain
    status
  }
}
''';

  static const String getSchedulerListPaged = '''
query getSchedulerListPaged(\$pageObj: SchedulerPaginationInput, \$data: ScheduleListInput) {
  getSchedulerListPaged(pageObj: \$pageObj, data: \$data) {
    totalItems
    items {
      id
      name
      description
      startDay
      endDay
      startTime
      endTime
      recurring
      rrule
      startCron
      endCron
      color
      eventId
      domain
      status
    }
  }
}
''';

  static const findSchedule = '''
query findSchedule(\$id: Int) {
  findSchedule(id: \$id) {
    id
    name
    description
    startDay
    endDay
    startTime
    endTime
    recurring
    rrule
    startCron
    endCron
    color
    eventId
    domain
    filter
    source {
      equipment {
        type
        data
      }
      points
    }
    status
    overrideDuration
  }
}
''';
}
