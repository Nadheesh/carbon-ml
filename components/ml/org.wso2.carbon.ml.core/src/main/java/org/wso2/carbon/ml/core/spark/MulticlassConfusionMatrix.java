/*
 * Copyright (c) 2015, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.wso2.carbon.ml.core.spark;

import java.io.Serializable;
import java.util.Arrays;

/**
 * DTO class to store multiclass confusion matrix
 */
public class MulticlassConfusionMatrix implements Serializable {
    private double[][] matrix;
    private double[] labels;
    private int size;

    /**
     *
     * @return Returns the confusion matrix
     */
    public double[][] getMatrix() {
        return matrix;
    }

    /**
     *
     * @param matrix Matrix containing the values of confusion matrix
     */
    public void setMatrix(double[][] matrix) {
        if (matrix == null) {
            this.matrix = new double[0][0];
        }
        else {
            this.matrix = Arrays.copyOf(matrix, matrix.length);
        }
    }

    /**
     *
     * @return Returns the sequence of labels in ascending order
     */
    public double[] getLabels() {
        return labels;
    }

    /**
     *
     * @param labels Set labels
     */
    public void setLabels(double[] labels) {
        if (labels == null) {
            this.labels = new double[0];
        }
        else {
            this.labels = Arrays.copyOf(labels, labels.length);
        }
    }

    /**
     *
     * @return Returns size of the confusion matrix
     */
    public int getSize() {
        return size;
    }

    /**
     *
     * @return Set the size of the confusion matrix
     */
    public void setSize(int size) {
        this.size = size;
    }

    @Override
    public String toString() {
        return "Confusion Matrix " + Arrays.deepToString(matrix);
    }
    
}
