/* SpagoBI, the Open Source Business Intelligence suite

 * Copyright (C) 2012 Engineering Ingegneria Informatica S.p.A. - SpagoBI Competency Center
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0, without the "Incompatible With Secondary Licenses" notice.
 * If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/. */
package it.eng.spagobi.behaviouralmodel.analyticaldriver.metadata;

import it.eng.spagobi.behaviouralmodel.lov.metadata.SbiLov;
import it.eng.spagobi.commons.metadata.SbiHibernateModel;

import java.util.Set;

/**
 * SbiParuse generated by hbm2java
 */
public class SbiParuse extends SbiHibernateModel {

	// Fields

	private Integer useId;
	private SbiParameters sbiParameters;
	private SbiLov sbiLov;
	private SbiLov sbiLovForDefault;
	private String label;
	private String name;
	private String descr;
	private Set sbiParuseDets;
	private Set sbiParuseCks;
	private String selectionType;
	private Integer multivalue;
	private Integer manualInput;
	private Boolean maximizerEnabled;
	private String defaultFormula;
	private String valueSelection;
//	private String selectedLayer;
//	private String selectedLayerProp;
	private String options;

	// Constructors

	/**
	 * default constructor.
	 */
	public SbiParuse() {
		this.useId = -1;

	}

	public String getValueSelection() {
		return valueSelection;
	}

	public void setValueSelection(String valueSelection) {
		this.valueSelection = valueSelection;
	}

	/**
	 * Gets the selected layer property.
	 *
	 * @return Returns the selectedLayerProp.
	 */
//	public String getSelectedLayerProp() {
//		return selectedLayerProp;
//	}

	/**
	 * Sets the selected layer property.
	 *
	 * @param selectedLayerProp
	 *            The layer property to set.
	 */
//	public void setSelectedLayerProp(String selectedLayerProp) {
//		this.selectedLayerProp = selectedLayerProp;
//	}

	/**
	 * Gets the selected layer.
	 *
	 * @return Returns the selectedLayer.
	 */
//	public String getSelectedLayer() {
//		return selectedLayer;
//	}

	/**
	 * Sets the selected layer.
	 *
	 * @param selectedLayer
	 *            The layer to set.
	 */
//	public void setSelectedLayer(String selectedLayer) {
//		this.selectedLayer = selectedLayer;
//	}

	
	/**
	 * constructor with id.
	 * 
	 * @param useId
	 *            the use id
	 */
	public SbiParuse(Integer useId) {
		this.useId = useId;
	}

	// Property accessors

	/**
	 * Gets the use id.
	 * 
	 * @return the use id
	 */
	public Integer getUseId() {
		return this.useId;
	}

	/**
	 * Sets the use id.
	 * 
	 * @param useId
	 *            the new use id
	 */
	public void setUseId(Integer useId) {
		this.useId = useId;
	}

	/**
	 * Gets the sbi parameters.
	 * 
	 * @return the sbi parameters
	 */
	public SbiParameters getSbiParameters() {
		return this.sbiParameters;
	}

	/**
	 * Sets the sbi parameters.
	 * 
	 * @param sbiParameters
	 *            the new sbi parameters
	 */
	public void setSbiParameters(SbiParameters sbiParameters) {
		this.sbiParameters = sbiParameters;
	}

	/**
	 * Gets the sbi lov.
	 * 
	 * @return the sbi lov
	 */
	public SbiLov getSbiLov() {
		return this.sbiLov;
	}

	/**
	 * Sets the sbi lov.
	 * 
	 * @param sbiLov
	 *            the new sbi lov
	 */
	public void setSbiLov(SbiLov sbiLov) {
		this.sbiLov = sbiLov;
	}

	public SbiLov getSbiLovForDefault() {
		return this.sbiLovForDefault;
	}

	public void setSbiLovForDefault(SbiLov sbiLovForDefault) {
		this.sbiLovForDefault = sbiLovForDefault;
	}

	/**
	 * Gets the label.
	 * 
	 * @return the label
	 */
	public String getLabel() {
		return this.label;
	}

	/**
	 * Sets the label.
	 * 
	 * @param label
	 *            the new label
	 */
	public void setLabel(String label) {
		this.label = label;
	}

	/**
	 * Gets the descr.
	 * 
	 * @return the descr
	 */
	public String getDescr() {
		return this.descr;
	}

	/**
	 * Sets the descr.
	 * 
	 * @param descr
	 *            the new descr
	 */
	public void setDescr(String descr) {
		this.descr = descr;
	}

	/**
	 * Gets the sbi paruse dets.
	 * 
	 * @return the sbi paruse dets
	 */
	public Set getSbiParuseDets() {
		return this.sbiParuseDets;
	}

	/**
	 * Sets the sbi paruse dets.
	 * 
	 * @param sbiParuseDets
	 *            the new sbi paruse dets
	 */
	public void setSbiParuseDets(Set sbiParuseDets) {
		this.sbiParuseDets = sbiParuseDets;
	}

	/**
	 * Gets the sbi paruse cks.
	 * 
	 * @return the sbi paruse cks
	 */
	public Set getSbiParuseCks() {
		return this.sbiParuseCks;
	}

	/**
	 * Sets the sbi paruse cks.
	 * 
	 * @param sbiParuseCks
	 *            the new sbi paruse cks
	 */
	public void setSbiParuseCks(Set sbiParuseCks) {
		this.sbiParuseCks = sbiParuseCks;
	}

	/**
	 * Gets the name.
	 *
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Sets the name.
	 *
	 * @param name
	 *            the new name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * Gets the manual input.
	 *
	 * @return the manual input
	 */
	public Integer getManualInput() {
		return manualInput;
	}

	/**
	 * Sets the manual input.
	 *
	 * @param manualInput
	 *            The manualInput to set.
	 */
	public void setManualInput(Integer manualInput) {
		this.manualInput = manualInput;
	}

	/**
	 * Gets the selection type.
	 *
	 * @return the selection type
	 */
	public String getSelectionType() {
		return selectionType;
	}

	/**
	 * Sets the selection type.
	 *
	 * @param selectionType
	 *            the new selection type
	 */
	public void setSelectionType(String selectionType) {
		this.selectionType = selectionType;
	}

	/**
	 * Gets the multivalue.
	 *
	 * @return the multivalue
	 */
	public Integer getMultivalue() {
		return multivalue;
	}

	/**
	 * Sets the multivalue.
	 *
	 * @param multivalue
	 *            the new multivalue
	 */
	public void setMultivalue(Integer multivalue) {
		this.multivalue = multivalue;
	}

	public Boolean getMaximizerEnabled() {
		return maximizerEnabled;
	}

	public void setMaximizerEnabled(Boolean maximizerEnabled) {
		this.maximizerEnabled = maximizerEnabled;
	}

	public String getDefaultFormula() {
		return defaultFormula;
	}

	public void setDefaultFormula(String defaultFormula) {
		this.defaultFormula = defaultFormula;
	}

	public String getOptions() {
		return options;
	}

	public void setOptions(String options) {
		this.options = options;
	}

}