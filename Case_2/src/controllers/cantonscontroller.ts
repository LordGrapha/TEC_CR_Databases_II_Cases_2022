import { cantons_data } from '../repositories/cantons_data'
import { Logger } from '../common'


export class CantonController {
    private static instance: CantonController = new CantonController();
    private log: Logger;

    private constructor()
    {
        this.log = new Logger();
    }

    public static getInstance() : CantonController
    {
        if (!this.instance)
        {
            this.instance = new CantonController();
        }
        return this.instance;
    }

    public listCantons()
    {
        const sqlServerData = new cantons_data();
        return sqlServerData.getAllCantons();
    }
}