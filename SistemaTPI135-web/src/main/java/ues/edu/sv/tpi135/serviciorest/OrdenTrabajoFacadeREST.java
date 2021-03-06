/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ues.edu.sv.tpi135.serviciorest;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ws.rs.Path;
import ues.edu.sv.mantenimientolib.OrdenTrabajo;
import ues.edu.sv.mantenimientotpi.acceso.AbstractFacadeInterface;
import ues.edu.sv.mantenimientotpi.acceso.OrdenTrabajoFacadeLocal;

/**
 *
 * @author mateo
 */
@Stateless
@Path("ordenTrabajo")
public class OrdenTrabajoFacadeREST extends AbstractRest<OrdenTrabajo> {

    @EJB
    protected OrdenTrabajoFacadeLocal ordenEJB;

    @Override
    protected AbstractFacadeInterface<OrdenTrabajo> entity() {
        return ordenEJB;
    }

    @Override
    protected OrdenTrabajo nuevo() {
        return new OrdenTrabajo();
    }

    
}
