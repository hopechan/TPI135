/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ues.edu.sv.mantenimientotpi.acceso;

import javax.ejb.Local;
import ues.edu.sv.mantenimientolib.Area;

/**
 *
 * @author esperanza
 */
@Local
public interface AreaFacadeLocal extends AbstractFacadeInterface<Area>{
    public Area create(Area entity);

}
