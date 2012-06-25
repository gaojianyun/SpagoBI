/* SpagoBI, the Open Source Business Intelligence suite

* � 2012 Engineering Ingegneria Informatica S.p.A. - SpagoBI Competency Center
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this file,
* You can obtain one at http://mozilla.org/MPL/2.0/. */
package it.eng.spagobi.kpi.ou.metadata;
// Generated 21-set-2010 12.29.29 by Hibernate Tools 3.1.0 beta3

import it.eng.spagobi.commons.metadata.SbiHibernateModel;

import java.util.HashSet;
import java.util.Set;


/**
 * SbiOrgUnitNodes generated by hbm2java
 */

public class SbiOrgUnitNodes  extends SbiHibernateModel {


    // Fields    

     private Integer nodeId;
     private SbiOrgUnit sbiOrgUnit;
     private SbiOrgUnitHierarchies sbiOrgUnitHierarchies;
     private SbiOrgUnitNodes sbiOrgUnitNodes;
     private String path;
     private Set sbiOrgUnitNodeses = new HashSet(0);
     private Set sbiOrgUnitGrantNodeses = new HashSet(0);


    // Constructors

    /** default constructor */
    public SbiOrgUnitNodes() {
    }

	/** minimal constructor */
    public SbiOrgUnitNodes(Integer nodeId, SbiOrgUnit sbiOrgUnit, SbiOrgUnitHierarchies sbiOrgUnitHierarchies, String path) {
        this.nodeId = nodeId;
        this.sbiOrgUnit = sbiOrgUnit;
        this.sbiOrgUnitHierarchies = sbiOrgUnitHierarchies;
        this.path = path;
    }
    
    /** full constructor */
    public SbiOrgUnitNodes(Integer nodeId, SbiOrgUnit sbiOrgUnit, SbiOrgUnitHierarchies sbiOrgUnitHierarchies, SbiOrgUnitNodes sbiOrgUnitNodes, String path, Set sbiOrgUnitNodeses, Set sbiOrgUnitGrantNodeses) {
        this.nodeId = nodeId;
        this.sbiOrgUnit = sbiOrgUnit;
        this.sbiOrgUnitHierarchies = sbiOrgUnitHierarchies;
        this.sbiOrgUnitNodes = sbiOrgUnitNodes;
        this.path = path;
        this.sbiOrgUnitNodeses = sbiOrgUnitNodeses;
        this.sbiOrgUnitGrantNodeses = sbiOrgUnitGrantNodeses;
    }
    

   
    // Property accessors

    public Integer getNodeId() {
        return this.nodeId;
    }
    
    public void setNodeId(Integer nodeId) {
        this.nodeId = nodeId;
    }

    public SbiOrgUnit getSbiOrgUnit() {
        return this.sbiOrgUnit;
    }
    
    public void setSbiOrgUnit(SbiOrgUnit sbiOrgUnit) {
        this.sbiOrgUnit = sbiOrgUnit;
    }

    public SbiOrgUnitHierarchies getSbiOrgUnitHierarchies() {
        return this.sbiOrgUnitHierarchies;
    }
    
    public void setSbiOrgUnitHierarchies(SbiOrgUnitHierarchies sbiOrgUnitHierarchies) {
        this.sbiOrgUnitHierarchies = sbiOrgUnitHierarchies;
    }

    public SbiOrgUnitNodes getSbiOrgUnitNodes() {
        return this.sbiOrgUnitNodes;
    }
    
    public void setSbiOrgUnitNodes(SbiOrgUnitNodes sbiOrgUnitNodes) {
        this.sbiOrgUnitNodes = sbiOrgUnitNodes;
    }

    public String getPath() {
        return this.path;
    }
    
    public void setPath(String path) {
        this.path = path;
    }

    public Set getSbiOrgUnitNodeses() {
        return this.sbiOrgUnitNodeses;
    }
    
    public void setSbiOrgUnitNodeses(Set sbiOrgUnitNodeses) {
        this.sbiOrgUnitNodeses = sbiOrgUnitNodeses;
    }

    public Set getSbiOrgUnitGrantNodeses() {
        return this.sbiOrgUnitGrantNodeses;
    }
    
    public void setSbiOrgUnitGrantNodeses(Set sbiOrgUnitGrantNodeses) {
        this.sbiOrgUnitGrantNodeses = sbiOrgUnitGrantNodeses;
    }
   








}
