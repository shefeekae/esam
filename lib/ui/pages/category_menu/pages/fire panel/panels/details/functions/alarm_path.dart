String getShortAlarmPath(List<dynamic> data) =>
    ['ResidentialTower', 'Floor', 'CommonArea', 'MSFD']
        .map((key) => data
            .where((entry) => entry['type'] == key && entry['name'] != null)
            .map((entry) => entry['name'])
            .join(' '))
        .where((result) => result.isNotEmpty) // Filter out empty strings
        .join(' - ');

