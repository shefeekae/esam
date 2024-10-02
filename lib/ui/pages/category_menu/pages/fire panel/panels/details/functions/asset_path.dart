String getAssetShortPath(List<dynamic> data) =>
    ['SubCommunity', 'ResidentialTower', 'Room', 'Floor']
        .map((key) => data
            .where((entry) => entry['entity']['type'] == key)
            .map((entry) => entry['name'])
            .join(' '))
        .join(' - ');
