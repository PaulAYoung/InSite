function DataManager(connector, controller){
    /**
     * Understands a data set
     *
     * params:
     * connector - connector object that has a get(query) method that can be used to retrieve data from server. 
     * controller - event management object, should be riotjs observable class or similar
     */

    this._connector = connector;
    this._controller = controller;
}

DataManager.prototype = {
    
}
